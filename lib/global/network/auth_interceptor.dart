import 'dart:async';

import 'package:dio/dio.dart';

import '../config/env.dart';
import '../storage/token_storage.dart';
import 'jwt.dart';

/// Issue d'une tentative de renouvellement du token.
enum _IssueRefresh {
  /// Nouveaux tokens en mémoire et persistés.
  reussi,

  /// Le serveur a refusé le refresh token (expiré / blacklisté) : session morte.
  refuse,

  /// Échec sans verdict du serveur (réseau, timeout, 5xx) : on ne coupe PAS la
  /// session, un prochain essai peut réussir.
  indisponible,
}

/// Intercepteur d'authentification.
///
/// - Le token d'accès vient de la mémoire (pas de lecture du stockage
///   sécurisé à chaque requête) et n'est jamais envoyé sur les routes
///   publiques.
/// - Renouvellement PROACTIF : si l'access expire dans moins de 60 s (lu dans
///   son `exp`), on le renouvelle AVANT d'envoyer la requête.
/// - Renouvellement UNIQUE (single-flight) : toutes les requêtes concurrentes
///   — celles qui partent avec un token périmé comme celles qui reçoivent un
///   401 — attendent le même Future, puis repartent avec le nouveau token.
///   Indispensable car le backend fait tourner (rotation + blacklist) les
///   refresh tokens : un second refresh avec l'ancien token serait refusé.
/// - Refresh définitivement refusé => UNE seule déconnexion propre.
///
/// Intercepteur non sérialisé (pas de QueuedInterceptor) : les requêtes ne
/// s'attendent pas les unes les autres, seul le refresh est mutualisé.
class AuthInterceptor extends Interceptor {
  /// [clientNu] : Dio SANS cet intercepteur (évite la récursion), utilisé pour
  /// /auth/rafraichir/ et pour rejouer les requêtes ayant reçu un 401. Il doit
  /// partager le pool de connexions du Dio principal.
  AuthInterceptor({
    required this._tokens,
    required this._clientNu,
    required this.onSessionExpiree,
  });

  final TokenStorage _tokens;
  final Dio _clientNu;
  final void Function() onSessionExpiree;

  /// Refresh en cours, partagé par tous les appelants.
  Future<_IssueRefresh>? _refreshEnCours;

  static const _clefRejoue = '_rejoue';

  /// Routes qui ne portent jamais de token (connexion, inscription, OTP,
  /// Firebase, refresh, version).
  static const _routesPubliques = [
    '/auth/connexion',
    '/auth/inscription',
    '/auth/rafraichir',
    '/auth/otp/',
    '/auth/pin/definir',
    '/auth/firebase/',
    '/version/verifier',
  ];

  static bool _estRoutePublique(String chemin) =>
      _routesPubliques.any(chemin.contains);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_estRoutePublique(options.path)) {
      try {
        var access = await _tokens.accessToken;
        if ((access == null || expireBientot(access)) &&
            await _tokens.aSession) {
          // Token absent ou sur le point d'expirer : on renouvelle d'abord.
          // En cas d'échec, la requête part avec ce qu'on a ; le 401
          // éventuel sera traité dans onError.
          await _rafraichirUnique();
          access = await _tokens.accessToken;
        }
        if (access != null) {
          options.headers['Authorization'] = 'Bearer $access';
        }
      } catch (_) {
        // Stockage illisible : la requête part sans token.
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final estUn401 = err.response?.statusCode == 401;
    final dejaRejoue = options.extra[_clefRejoue] == true;

    // Seul un vrai 401, sur une route protégée, jamais encore rejoué.
    if (!estUn401 || dejaRejoue || _estRoutePublique(options.path)) {
      return handler.next(err);
    }

    try {
      // Visiteur (aucune session) : un 401 est normal sur une route protégée,
      // il n'y a rien à renouveler ni à couper.
      if (!await _tokens.aSession) return handler.next(err);

      // Si le token en mémoire n'est plus celui de la requête, un refresh a
      // déjà eu lieu depuis son envoi : inutile d'en lancer un autre.
      final courant = await _tokens.accessToken;
      final utilise = options.headers['Authorization'];
      if (courant == null || utilise == 'Bearer $courant') {
        if (await _rafraichirUnique() != _IssueRefresh.reussi) {
          return handler.next(err);
        }
      }

      final nouveau = await _tokens.accessToken;
      if (nouveau == null) return handler.next(err);

      options.headers['Authorization'] = 'Bearer $nouveau';
      options.extra[_clefRejoue] = true; // garde-fou anti-boucle
      handler.resolve(await _clientNu.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e); // vraie erreur de la requête rejouée (400, 404, ...)
    } catch (_) {
      handler.next(err);
    }
  }

  /// Point d'entrée unique du renouvellement : tous les appelants concurrents
  /// reçoivent le MÊME Future.
  Future<_IssueRefresh> _rafraichirUnique() {
    final enCours = _refreshEnCours;
    if (enCours != null) return enCours;
    final nouveau = _rafraichir().whenComplete(() => _refreshEnCours = null);
    return _refreshEnCours = nouveau;
  }

  /// Appelle /auth/rafraichir/ et persiste les nouveaux tokens (rotation).
  Future<_IssueRefresh> _rafraichir() async {
    final refresh = await _tokens.refreshToken;
    if (refresh == null) return _IssueRefresh.refuse;

    try {
      final r = await _clientNu.post<dynamic>(
        '${Env.apiPrefix}/auth/rafraichir/',
        data: {'refresh': refresh},
      );
      final data = r.data;
      final access = data is Map ? data['access'] as String? : null;
      if (access == null) return _IssueRefresh.indisponible;

      final nouveauRefresh = data['refresh'] as String?; // rotation
      if (nouveauRefresh != null) {
        // Rotation active : les DEUX tokens sont posés d'un coup (mémoire
        // immédiate, persistance dans la foulée).
        await _tokens.sauvegarder(access: access, refresh: nouveauRefresh);
      } else {
        await _tokens.majAccess(access);
      }
      return _IssueRefresh.reussi;
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      if (code != 401 && code != 403) return _IssueRefresh.indisponible;

      // Refresh refusé : la session est morte. Sauf si une reconnexion a posé
      // d'autres tokens pendant l'appel (alors on n'y touche pas).
      if (await _tokens.refreshToken == refresh) {
        await _tokens.effacer();
        onSessionExpiree(); // une seule fois : le refresh est mutualisé
      }
      return _IssueRefresh.refuse;
    } catch (_) {
      return _IssueRefresh.indisponible;
    }
  }
}
