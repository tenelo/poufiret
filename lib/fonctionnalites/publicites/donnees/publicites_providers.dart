import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/credit_formule.dart';
import '../metier_domaine/formule_publicite.dart';
import '../metier_domaine/publicite_detail.dart';
import '../metier_domaine/publicite_liste.dart';
import '../metier_domaine/stats_publicite.dart';
import 'publicites_repository.dart';

part 'publicites_providers.g.dart';

@riverpod
PublicitesRepository publicitesRepository(Ref ref) {
  return PublicitesRepository(dio: ref.watch(dioProvider));
}

/// Pubs du carrousel d'accueil.
@riverpod
Future<List<PubliciteListe>> carrouselPublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).carrousel();
}

/// Pubs de l'onglet Publicites.
@riverpod
Future<List<PubliciteListe>> pagePublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).pagePublicites();
}

/// Pub du bandeau bas (peut etre nulle).
///
/// keepAlive : le bandeau est affiche globalement et disparait sur
/// certains ecrans. Sans cela, Riverpod detruirait le provider des qu'il
/// n'est plus ecoute, et le bandeau repasserait par un etat de
/// chargement — donc invisible — a chaque navigation.
@Riverpod(keepAlive: true)
Future<PubliciteListe?> bandeauBasPublicite(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).bandeauBas();
}

/// Forfaits proposes au partenaire.
@riverpod
Future<List<FormulePublicite>> formulesPublicite(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).formules();
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