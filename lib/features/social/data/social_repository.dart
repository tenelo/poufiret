import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/commentaire.dart';

/// Résultat d'un toggle : état (allumé/éteint) + compteur à jour.
class ResultatToggle {
  final bool actif;
  final int total;
  const ResultatToggle({required this.actif, required this.total});

  factory ResultatToggle.fromJson(Map<String, dynamic> json) => ResultatToggle(
    actif: json['actif'] as bool? ?? false,
    total: json['total'] as int? ?? 0,
  );
}

class SocialRepository {
  final Dio _dio;
  SocialRepository({required Dio dio}) : _dio = dio;

  /// POST /social/articles/<id>/like/ — toggle like ❤️.
  Future<ResultatToggle> toggleLikeArticle(int articleId) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/social/articles/$articleId/like/',
    );
    return ResultatToggle.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST /social/articles/<id>/favori/ — toggle favori 🔖.
  Future<ResultatToggle> toggleFavoriArticle(int articleId) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/social/articles/$articleId/favori/',
    );
    return ResultatToggle.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /social/commentaires/articles/?article=<id> — liste racines + réponses.
  Future<List<Commentaire>> commentairesArticle(int articleId) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/social/commentaires/articles/',
      queryParameters: {'article': articleId},
    );
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(Commentaire.fromJson).toList();
  }

  /// POST /social/commentaires/articles/ — poster (parent=null) ou répondre.
  Future<Commentaire> posterCommentaire({
    required int articleId,
    required String contenu,
    int? parentId,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/social/commentaires/articles/',
      data: {
        'article': articleId,
        'contenu': contenu,
        if (parentId != null) 'parent': parentId,
      },
    );
    return Commentaire.fromJson(r.data as Map<String, dynamic>);
  }

  /// DELETE /social/commentaires/articles/<id>/ — supprimer son commentaire.
  Future<void> supprimerCommentaire(int commentaireId) async {
    await _dio.delete(
      '${Env.apiPrefix}/social/commentaires/articles/$commentaireId/',
    );
  }

  /// POST /social/commentaires/article/<id>/like/ — toggle like commentaire.
  Future<ResultatToggle> toggleLikeCommentaire(int commentaireId) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/social/commentaires/article/$commentaireId/like/',
    );
    return ResultatToggle.fromJson(r.data as Map<String, dynamic>);
  }
}
