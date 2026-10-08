import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';
import 'locations_repository.dart';

part 'locations_providers.g.dart';

@riverpod
LocationsRepository locationsRepository(Ref ref) {
  return LocationsRepository(ref.watch(dioProvider));
}

// Lectures « cache d'abord » (voir fluxCache).

/// Listes de référence (libellés des équipements, types pour le filtre) :
/// quasi statiques, gardées comme la géographie.
@Riverpod(keepAlive: true)
Stream<MetaLocations> metaLocations(Ref ref) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/meta',
    politique: PolitiqueCache.geographie,
    reseau: repo.metaBrut,
    decoder: repo.metaDepuis,
  );
}

/// Page d'un loueur : lui-même et ses logements disponibles, filtrés.
@riverpod
Stream<PageLoueur> pageLoueur(
  Ref ref, {
  required int partenaireId,
  FiltreLogements filtre = const FiltreLogements(),
}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/loueur/$partenaireId?${filtre.cle}',
    politique: PolitiqueCache.logements,
    reseau: () => repo.logementsBrut(partenaireId, filtre),
    decoder: repo.pageLoueurDepuis,
  );
}

/// Fiche d'un logement.
@riverpod
Stream<Logement> logementDetail(Ref ref, {required int id}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/logement/$id',
    politique: PolitiqueCache.logementDetail,
    reseau: () => repo.logementBrut(id),
    decoder: repo.logementDepuis,
  );
}

/// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
/// filtrés.
@riverpod
Stream<PageLoueurVehicules> pageLoueurVehicules(
  Ref ref, {
  required int partenaireId,
  FiltreVehicules filtre = const FiltreVehicules(),
}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/loueur-vehicules/$partenaireId?${filtre.cle}',
    politique: PolitiqueCache.vehicules,
    reseau: () => repo.vehiculesBrut(partenaireId, filtre),
    decoder: repo.pageVehiculesDepuis,
  );
}

/// Fiche d'un véhicule (avec ses périodes déjà réservées).
@riverpod
Stream<Vehicule> vehiculeDetail(Ref ref, {required int id}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/vehicule/$id',
    politique: PolitiqueCache.vehiculeDetail,
    reseau: () => repo.vehiculeBrut(id),
    decoder: repo.vehiculeDepuis,
  );
}

/// Page d'un établissement (hôtel, résidence) : lui-même et ses
/// hébergements. Les filtres s'appliquent à la liste reçue.
@riverpod
Stream<PageEtablissement> pageEtablissement(
  Ref ref, {
  required int partenaireId,
}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/etablissement/$partenaireId',
    politique: PolitiqueCache.etablissement,
    reseau: () => repo.etablissementBrut(partenaireId),
    decoder: repo.pageEtablissementDepuis,
  );
}

/// Fiche d'un hébergement.
@riverpod
Stream<Hebergement> hebergementDetail(Ref ref, {required int id}) {
  final repo = ref.watch(locationsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'locations/hebergement/$id',
    politique: PolitiqueCache.hebergementDetail,
    reseau: () => repo.hebergementBrut(id),
    decoder: repo.hebergementDepuis,
  );
}

/// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
/// Toujours lu sur le réseau : la disponibilité change vite.
@riverpod
Future<int> disponibiliteHebergement(
  Ref ref, {
  required int id,
  required String arrivee,
  required String depart,
}) {
  return ref
      .watch(locationsRepositoryProvider)
      .disponibiliteHebergement(
        id,
        arrivee: DateTime.parse(arrivee),
        depart: DateTime.parse(depart),
      );
}

/// Mes demandes (visites et réservations). Rechargées après chaque envoi
/// ou annulation.
@riverpod
Future<List<DemandeReservation>> mesDemandesReservation(Ref ref) {
  return ref.watch(locationsRepositoryProvider).mesDemandes();
}
