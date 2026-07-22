import 'package:dio/dio.dart';

import '../../../core/config/env.dart';

/// Accès aux endpoints de tracking de session.
///
/// Le backend mesure la durée réelle par heartbeat : on démarre une session
/// à l'ouverture de l'app, puis on envoie un ping toutes les 60 secondes.
///
/// Toutes les erreurs sont avalées : le tracking ne doit jamais interrompre
/// le parcours utilisateur, et l'intercepteur global convertit déjà les
/// DioException en ApiException.
class AnalyticsRepository {
  AnalyticsRepository(this._dio);

  final Dio _dio;

  /// Démarre une session et renvoie son identifiant, ou null en cas d'échec.
  Future<String?> demarrerSession({String source = 'mobile'}) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/demarrer/',
        data: {'source': source},
      );
      return reponse.data?['session_id'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Envoie un ping et renvoie la minute courante de session, ou null.
  Future<int?> pinguer(String sessionId) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/ping/',
        data: {'session_id': sessionId},
      );
      return reponse.data?['minute_session'] as int?;
    } catch (_) {
      return null;
    }
  }

  /// Enregistre l'entree dans le catalogue d'une categorie.
  ///
  /// Une visite = +1, quel que soit le nombre d'articles ouverts ensuite.
  Future<void> enregistrerVisiteCategorie(int categorieId) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/categorie/visite/',
        data: {'categorie_id': categorieId},
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation de la vitrine d'un partenaire.
  ///
  /// Seul signal disponible pour les metiers de service, ou le client
  /// ne consulte aucun article.
  Future<void> enregistrerVueVitrine(int partenaireId,
      {String source = 'annuaire', bool avecCatalogue = true}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/vitrine/vue/',
        data: {
          'partenaire': partenaireId,
          'source': source,
          'avec_catalogue': avecCatalogue,
        },
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation d'un article (alimente le profil de navigation).
  Future<void> enregistrerVueArticle(String slug, {String source = 'liste'}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/catalogue/articles/$slug/vue/',
        data: {'source': source},
      );
    } catch (_) {
      // Silencieux : une vue perdue ne doit jamais bloquer l'affichage.
    }
  }
}
