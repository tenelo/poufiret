import 'dart:async';
import 'package:dio/dio.dart';
import 'package:poufiret/core/config/env.dart';
import 'package:poufiret/core/storage/token_storage.dart';

/// Intercepteur d'authentification :
/// - injecte le token d'accès sur chaque requête
/// - sur 401, déclenche UN SEUL refresh partagé (sérialisé), puis rejoue
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokens;
  final Dio _refreshDio; // Dio séparé : ne passe PAS par cet intercepteur
  final void Function() onSessionExpiree;

  AuthInterceptor({required this._tokens, required this.onSessionExpiree})
    : _refreshDio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl));

  // Verrou partagé : si un refresh est en cours, les autres l'attendent.
  Future<bool>? _refreshEnCours;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // On ne met pas de token sur les routes publiques d'auth.
    final estRouteAuthPublique =
        options.path.contains('/auth/connexion') ||
        options.path.contains('/auth/inscription') ||
        options.path.contains('/auth/rafraichir');

    if (!estRouteAuthPublique) {
      final access = await _tokens.accessToken;
      if (access != null) {
        options.headers['Authorization'] = 'Bearer $access';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final reponse = err.response;
    final estUn401 = reponse?.statusCode == 401;
    final dejaRejoue = err.requestOptions.extra['_rejoue'] == true;

    // On ne tente le refresh que sur un vrai 401 jamais encore rejoué.
    if (!estUn401 || dejaRejoue) {
      return handler.next(err);
    }

    // Démarre le refresh partagé s'il n'y en a pas déjà un en cours.
    _refreshEnCours ??= _rafraichir();
    final succes = await _refreshEnCours!;
    _refreshEnCours = null;

    if (!succes) {
      onSessionExpiree(); // refresh échoué → on coupe la session
      return handler.next(err);
    }

    // Rejoue la requête initiale avec le nouveau token.
    try {
      final nouvelAccess = await _tokens.accessToken;
      final opts = err.requestOptions
        ..headers['Authorization'] = 'Bearer $nouvelAccess'
        ..extra['_rejoue'] = true; // garde-fou anti-boucle

      final reponseRejouee = await _refreshDio.fetch(opts);
      return handler.resolve(reponseRejouee);
    } catch (e) {
      return handler.next(err);
    }
  }

  /// Appelle /auth/rafraichir/, persiste les nouveaux tokens.
  /// Gère ta rotation : le backend renvoie un nouveau refresh à persister.
  Future<bool> _rafraichir() async {
    try {
      final refresh = await _tokens.refreshToken;
      if (refresh == null) return false;

      final r = await _refreshDio.post(
        '${Env.apiPrefix}/auth/rafraichir/',
        data: {'refresh': refresh},
      );

      final data = r.data as Map<String, dynamic>;
      final nouvelAccess = data['access'] as String?;
      final nouveauRefresh = data['refresh'] as String?; // rotation

      if (nouvelAccess == null) return false;

      if (nouveauRefresh != null) {
        // Rotation active : on persiste les DEUX immédiatement.
        await _tokens.sauvegarder(
          access: nouvelAccess,
          refresh: nouveauRefresh,
        );
      } else {
        await _tokens.majAccess(nouvelAccess);
      }
      return true;
    } catch (_) {
      return false; // refresh blacklisté/expiré → session morte
    }
  }
}
