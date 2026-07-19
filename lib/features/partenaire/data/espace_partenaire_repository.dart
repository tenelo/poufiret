import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/stats_vues.dart';

class EspacePartenaireRepository {
  EspacePartenaireRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  static const _articles = '${Env.apiPrefix}/catalogue/articles/';

  /// Stats de vues du partenaire connecté.
  Future<StatsVues> statsVues() async {
    final r = await _dio
        .get('${Env.apiPrefix}/catalogue/partenaire/stats-vues/');
    return StatsVues.fromJson(r.data as Map<String, dynamic>);
  }

  /// Crée un article. Retourne le JSON complet (avec slug).
  Future<Map<String, dynamic>> creerArticle(Map<String, dynamic> donnees) async {
    final r = await _dio.post(_articles, data: donnees);
    return r.data as Map<String, dynamic>;
  }

  /// Modifie un article (PATCH partiel par slug).
  Future<Map<String, dynamic>> modifierArticle(
      String slug, Map<String, dynamic> donnees) async {
    final r = await _dio.patch('$_articles$slug/', data: donnees);
    return r.data as Map<String, dynamic>;
  }

  /// Supprime un article.
  Future<void> supprimerArticle(String slug) async {
    await _dio.delete('$_articles$slug/');
  }

  /// Ajoute une photo à un article (multipart).
  Future<void> ajouterImage(
    int articleId, {
    required String cheminFichier,
    bool estPrincipale = false,
    int ordre = 0,
  }) async {
    final form = FormData.fromMap({
      'article': articleId,
      'image': await MultipartFile.fromFile(cheminFichier),
      'est_principale': estPrincipale,
      'ordre': ordre,
    });
    await _dio.post('${Env.apiPrefix}/catalogue/images/', data: form);
  }
}
