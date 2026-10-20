import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/catalogue_commerce.dart';

/// Catalogues des commerces (pharmacie, mode, librairie...) servis par
/// l'API restaurants. La fiche du commerce elle-même passe par
/// `RestaurantsRepository.detailBrut`.
class CommercesRepository {
  CommercesRepository(this._dio);

  final Dio _dio;

  /// `GET /restaurants/<id>/produits/?section=&q=&page=&page_size=20`.
  Future<PageProduits> produits(RequeteProduits requete, {int page = 1}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/restaurants/${requete.commerceId}/produits/',
      queryParameters: requete.parametres(page),
    );
    return PageProduits.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  /// `GET /restaurants/produits/<id>/` — produit, images, autres produits.
  Future<Object?> produitBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/restaurants/produits/$id/')).data;

  ProduitDetail produitDepuis(Object? json) =>
      ProduitDetail.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /restaurants/meta/gabarits/` — gabarits et listes de choix.
  Future<Object?> metaGabaritsBrut() async =>
      (await _dio.get('${Env.apiPrefix}/restaurants/meta/gabarits/')).data;
}
