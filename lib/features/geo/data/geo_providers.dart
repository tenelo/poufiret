import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/departement.dart';
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
