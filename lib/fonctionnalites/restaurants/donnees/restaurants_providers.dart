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

// Lectures « cache d'abord » (voir fluxCache). Le département de
// l'utilisateur fait partie du contexte de cache : changer de compte ou de
// département recharge ces listes.

/// Restaurants du département de l'utilisateur (accueil + écran Restaurants).
@riverpod
Stream<List<Restaurant>> restaurants(Ref ref) {
  final repo = ref.watch(restaurantsRepositoryProvider);
  final departement = ref.watch(contexteCacheProvider).departement;
  return fluxCache(
    ref,
    cle: 'restaurants/liste',
    politique: PolitiqueCache.restaurants,
    reseau: () => repo.listeBrut(departement: departement),
    decoder: repo.listeDepuis,
  );
}

/// Flux « menus du jour » du département (carrousel de l'accueil).
@riverpod
Stream<List<MenuDuJourAccueil>> menusDuJourAccueil(Ref ref) {
  final repo = ref.watch(restaurantsRepositoryProvider);
  final departement = ref.watch(contexteCacheProvider).departement;
  return fluxCache(
    ref,
    cle: 'restaurants/menus-du-jour',
    politique: PolitiqueCache.restaurants,
    reseau: () => repo.menusDuJourBrut(departement: departement),
    decoder: repo.menusDuJourDepuis,
  );
}

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
