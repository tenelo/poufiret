import '../domain/partenaire_categorie.dart';
import 'package:dio/dio.dart';
import 'package:poufiret/features/catalogue/domain/article_liste.dart';

import '../../../core/config/env.dart';
import '../domain/categorie.dart';
import '../domain/article_detail.dart';

class CatalogueRepository {
  final Dio _dio;

  CatalogueRepository({required Dio dio}) : _dio = dio;

  /// GET /catalogue/categories/ — liste des catégories racines (public).
  Future<List<Categorie>> categories() async {
    final r = await _dio.get('${Env.apiPrefix}/catalogue/categories/');
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(Categorie.fromJson).toList();
  }

/// GET /catalogue/articles/ — articles filtrés (catégorie et/ou recherche).
  Future<List<ArticleListe>> articles({
    int? categorie,
    String? recherche,
  int? partenaire,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/articles/',
      queryParameters: {
        if (partenaire != null) 'partenaire': partenaire,
        if (categorie != null) 'categorie': categorie,
        if (recherche != null && recherche.isNotEmpty) 'recherche': recherche,
      },
    );
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(ArticleListe.fromJson).toList();
  }
  
  /// GET /catalogue/categories/<slug>/partenaires/ — annuaire d'une catégorie.
  Future<List<PartenaireCategorie>> partenairesParCategorie(String slug) async {
    final r = await _dio
        .get('${Env.apiPrefix}/catalogue/categories/$slug/partenaires/');
    return (r.data as List)
        .map((e) => PartenaireCategorie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /catalogue/articles/<slug>/ — fiche détail (public).
  Future<ArticleDetail> articleDetail(String slug) async {
    final r = await _dio.get('${Env.apiPrefix}/catalogue/articles/$slug/');
    return ArticleDetail.fromJson(r.data as Map<String, dynamic>);
  }
}
