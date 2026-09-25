import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/credit_formule.dart';
import '../metier_domaine/formule_publicite.dart';
import '../metier_domaine/publicite_detail.dart';
import '../metier_domaine/publicite_liste.dart';
import '../metier_domaine/pubs_affichees.dart';
import '../metier_domaine/stats_publicite.dart';
import 'publicites_repository.dart';

part 'publicites_providers.g.dart';

@riverpod
PublicitesRepository publicitesRepository(Ref ref) {
  return PublicitesRepository(dio: ref.watch(dioProvider));
}

/// Flux d'une liste de pubs : cache disque d'abord (affichage instantane),
/// puis reseau. Le reseau est TOUJOURS consulte au premier chargement du
/// processus (revalider) : c'est lui qui confirme les pubs et autorise les
/// impressions. [PolitiqueCache.publicites] : 5 min de vie en memoire, 1 h
/// maximum d'affichage depuis le disque.
Stream<PubsAffichees> _fluxPubs(
  Ref ref, {
  required String cle,
  required Future<Object?> Function() reseau,
  required List<PubliciteListe> Function(Object? json) decoder,
}) {
  return fluxCacheSource<List<PubliciteListe>>(
    ref,
    cle: cle,
    politique: PolitiqueCache.publicites,
    reseau: reseau,
    decoder: decoder,
    revalider: true,
  ).map(
    (s) => PubsAffichees(s.valeur, confirmeReseau: s.depuisReseau),
  );
}

/// Pubs du carrousel d'accueil.
@riverpod
Stream<PubsAffichees> carrouselPublicites(Ref ref) {
  final repo = ref.watch(publicitesRepositoryProvider);
  return _fluxPubs(
    ref,
    cle: 'pubs/carrousel',
    reseau: repo.carrouselBrut,
    decoder: repo.carrouselDepuis,
  );
}

/// Pubs de l'onglet Publicites.
@riverpod
Stream<PubsAffichees> pagePublicites(Ref ref) {
  final repo = ref.watch(publicitesRepositoryProvider);
  return _fluxPubs(
    ref,
    cle: 'pubs/page',
    reseau: repo.pagePublicitesBrut,
    decoder: repo.pagePublicitesDepuis,
  );
}

/// Pub du bandeau bas (liste vide = aucune pub).
///
/// keepAlive : le bandeau est affiche globalement et disparait sur
/// certains ecrans. Sans cela, Riverpod detruirait le provider des qu'il
/// n'est plus ecoute, et le bandeau repasserait par un etat de
/// chargement — donc invisible — a chaque navigation.
@Riverpod(keepAlive: true)
Stream<PubsAffichees> bandeauBasPublicite(Ref ref) {
  final repo = ref.watch(publicitesRepositoryProvider);
  return _fluxPubs(
    ref,
    cle: 'pubs/bandeau',
    reseau: repo.bandeauBasBrut,
    decoder: repo.bandeauBasDepuis,
  );
}

/// Forfaits proposes au partenaire.
@riverpod
Stream<List<FormulePublicite>> formulesPublicite(Ref ref) {
  final repo = ref.watch(publicitesRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'formules-pub',
    politique: PolitiqueCache.formulesPub,
    reseau: repo.formulesBrut,
    decoder: repo.formulesDepuis,
  );
}

/// Fiche detail d'une publicite.
@riverpod
Future<PubliciteDetail> publiciteDetail(Ref ref, {required String id}) {
  return ref.watch(publicitesRepositoryProvider).detail(id);
}

/// Campagnes du partenaire connecte.
@riverpod
Future<List<Map<String, dynamic>>> mesPublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).mesPublicites();
}

/// Resultats des campagnes du partenaire connecte.
@riverpod
Future<List<StatsPublicite>> mesStatsPublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).mesStats();
}

/// Credits de formule disponibles du partenaire connecte.
@riverpod
Future<List<CreditFormule>> mesCreditsDisponibles(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).mesCredits(statut: 'disponible');
}

/// Toutes les faveurs publicitaires du partenaire connecte (disponibles et
/// consommees), pour l'ecran recapitulatif "Mes faveurs pub".
@riverpod
Future<List<CreditFormule>> mesCredits(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).mesCredits();
}