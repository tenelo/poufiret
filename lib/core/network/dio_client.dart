import 'package:dio/dio.dart';

import '../config/env.dart';
import '../errors/api_exception.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';

/// Fabrique le client HTTP partagé de l'app.
class DioClient {
  static Dio creer({
    required TokenStorage tokens,
    required void Function() onSessionExpiree,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(tokens: tokens, onSessionExpiree: onSessionExpiree),
    );

    // Convertit toute DioException en ApiException (ton format uniforme).
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (err, handler) {
          final reponse = err.response;
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
