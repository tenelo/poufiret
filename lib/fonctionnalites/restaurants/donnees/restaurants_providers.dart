import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/restaurant_models.dart';
import 'restaurants_repository.dart';

part 'restaurants_providers.g.dart';

@riverpod
RestaurantsRepository restaurantsRepository(Ref ref) {
  return RestaurantsRepository(ref.watch(dioProvider));
}

// Lecture « cache d'abord » (voir fluxCache).

/// Page d'un restaurant : fiche, menus du jour et carte.
@riverpod
Stream<Restaurant> restaurantDetail(Ref ref, {required int id}) {
  final repo = ref.watch(restaurantsRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'restaurants/$id',
    politique: PolitiqueCache.restaurantDetail,
    reseau: () => repo.detailBrut(id),
    decoder: repo.detailDepuis,
  );
}
