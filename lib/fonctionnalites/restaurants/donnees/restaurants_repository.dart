import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/normalisation.dart';
import '../metier_domaine/restaurant_models.dart';

class RestaurantsRepository {
  RestaurantsRepository(this._dio);

  final Dio _dio;

  // Comme dans le catalogue : `xxxBrut` (appel réseau, JSON stocké tel quel
  // sur disque) et `xxxDepuis` (décodage, appliqué aussi au JSON du cache).

  Map<String, dynamic> _parDepartement(int departement) => {
    // 0 = visiteur sans département : le serveur applique sa portée.
    if (departement > 0) 'departement': departement,
  };

  /// `GET /restaurants/?departement=<id>` — restaurants du département.
  Future<Object?> listeBrut({required int departement}) async =>
      (await _dio.get(
        '${Env.apiPrefix}/restaurants/',
        queryParameters: _parDepartement(departement),
      )).data;

  List<Restaurant> listeDepuis(Object? json) => [
    for (final e in elementsDeListe(json))
      Restaurant.fromJson(normaliserResume(e)),
  ];

  /// `GET /restaurants/menus-du-jour/?departement=<id>` — flux de l'accueil.
  Future<Object?> menusDuJourBrut({required int departement}) async =>
      (await _dio.get(
        '${Env.apiPrefix}/restaurants/menus-du-jour/',
        queryParameters: _parDepartement(departement),
      )).data;

  List<MenuDuJourAccueil> menusDuJourDepuis(Object? json) => [
    for (final e in elementsDeListe(json))
      MenuDuJourAccueil.fromJson(normaliserMenuAccueil(e)),
  ];

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
