import 'package:dio/dio.dart';

import '../config/env.dart';
import '../errors/api_exception.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';
import 'pool_http.dart';

/// Fabrique les clients HTTP de l'app. Tous partagent le MÊME pool de
/// connexions (voir [adaptateurPartage]).
class DioClient {
  /// Dio « nu » : baseUrl + timeouts, aucun intercepteur. Sert aux appels
  /// publics (contrôle de version) et au refresh de token.
  static Dio creerNu({
    Duration connexion = const Duration(seconds: 15),
    Duration reception = const Duration(seconds: 15),
    HttpClientAdapter? adaptateur,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: connexion,
        receiveTimeout: reception,
        contentType: 'application/json',
      ),
    );
    dio.httpClientAdapter = adaptateur ?? adaptateurPartage();
    return dio;
  }

  /// Client principal (avec authentification).
  ///
  /// [adaptateur] : à ne fournir que dans les tests ; il est alors utilisé par
  /// le client principal ET par celui du refresh.
  static Dio creer({
    required TokenStorage tokens,
    required void Function() onSessionExpiree,
    void Function(bool horsLigne)? onEtatReseau,
    HttpClientAdapter? adaptateur,
  }) {
    final dio = creerNu(adaptateur: adaptateur);

    dio.interceptors.add(
      AuthInterceptor(
        tokens: tokens,
        clientNu: creerNu(
          connexion: const Duration(seconds: 10),
          reception: const Duration(seconds: 10),
          adaptateur: adaptateur,
        ),
        onSessionExpiree: onSessionExpiree,
      ),
    );

    // Convertit toute DioException en ApiException (ton format uniforme) et
    // renseigne l'état réseau (bandeau « Hors connexion »).
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (reponse, handler) {
          onEtatReseau?.call(false);
          handler.next(reponse);
        },
        onError: (err, handler) {
          final reponse = err.response;
          if (err.type != DioExceptionType.cancel) {
            const passerelle = {502, 503, 504};
            onEtatReseau?.call(
              reponse == null || passerelle.contains(reponse.statusCode),
            );
          }
          if (reponse != null) {
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ApiException.fromResponse(
                  reponse.statusCode,
                  reponse.data,
                ),
                response: reponse,
              ),
            );
          } else {
            // Pas de réponse du tout : timeout, DNS, pas de réseau.
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ApiException.reseau(),
              ),
            );
          }
        },
      ),
    );

    return dio;
  }
}
