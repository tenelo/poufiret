import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/normalisation.dart';
import '../metier_domaine/restaurant_models.dart';

class RestaurantsRepository {
  RestaurantsRepository(this._dio);

  final Dio _dio;

  // Comme dans le catalogue : `xxxBrut` (appel réseau, JSON stocké tel quel
  // sur disque) et `xxxDepuis` (décodage, appliqué aussi au JSON du cache).

  /// `GET /restaurants/<id>/` — fiche, menus du jour et carte, en une requête.
  Future<Object?> detailBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/restaurants/$id/')).data;

  Restaurant detailDepuis(Object? json) =>
      Restaurant.fromJson(normaliserFiche(json));

  /// Fiche telle que le serveur la connaît MAINTENANT (sans cache) : pour
  /// revalider le menu du jour et le stock juste avant l'ajout au panier.
  Future<Restaurant> detailFrais(int id) async =>
      detailDepuis(await detailBrut(id));
}
