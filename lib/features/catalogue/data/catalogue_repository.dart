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

  /// GET /catalogue/articles/?categorie=<id> — articles d'une catégorie (public, paginé).
  Future<List<ArticleListe>> articles({int? categorie}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/articles/',
      queryParameters: {if (categorie != null) 'categorie': categorie},
    );
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(ArticleListe.fromJson).toList();
  }

  /// GET /catalogue/articles/<slug>/ — fiche détail (public).
  Future<ArticleDetail> articleDetail(String slug) async {
    final r = await _dio.get('${Env.apiPrefix}/catalogue/articles/$slug/');
    return ArticleDetail.fromJson(r.data as Map<String, dynamic>);
  }
}
