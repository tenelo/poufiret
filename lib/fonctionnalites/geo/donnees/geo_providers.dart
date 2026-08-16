import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/departement.dart';
import '../metier_domaine/quartier.dart';
import 'geo_repository.dart';

part 'geo_providers.g.dart';

@riverpod
GeoRepository geoRepository(Ref ref) {
  return GeoRepository(dio: ref.watch(dioProvider));
}

/// Departements disponibles. keepAlive : la liste est stable, on evite
/// de la recharger a chaque ouverture d'un formulaire.
@Riverpod(keepAlive: true)
Future<List<Departement>> departements(Ref ref) {
  return ref.watch(geoRepositoryProvider).departements();
}

/// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
/// depend du departement choisi.
@riverpod
Future<List<Quartier>> quartiers(Ref ref, {required int departementId}) {
  return ref.watch(geoRepositoryProvider).quartiers(departementId);
}
