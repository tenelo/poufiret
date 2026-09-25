import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/departement.dart';
import '../metier_domaine/quartier.dart';
import 'geo_repository.dart';

part 'geo_providers.g.dart';

@riverpod
GeoRepository geoRepository(Ref ref) {
  return GeoRepository(dio: ref.watch(dioProvider));
}

/// Departements disponibles. Liste quasi statique : cache disque 7 jours,
/// gardee en memoire pour la session (pas de rechargement a chaque
/// ouverture d'un formulaire).
@Riverpod(keepAlive: true)
Stream<List<Departement>> departements(Ref ref) {
  final repo = ref.watch(geoRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'departements',
    politique: PolitiqueCache.departements,
    reseau: repo.departementsBrut,
    decoder: repo.departementsDepuis,
  );
}

/// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
/// depend du departement choisi.
@riverpod
Future<List<Quartier>> quartiers(Ref ref, {required int departementId}) {
  return ref.watch(geoRepositoryProvider).quartiers(departementId);
}
