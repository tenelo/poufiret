import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/utilisateur.dart';

/// Accès aux endpoints d'authentification du backend Poufiret.
class AuthRepository {
  final Dio _dio;
  final TokenStorage _tokens;

  AuthRepository({required Dio dio, required TokenStorage tokens})
    : _dio = dio,
      _tokens = tokens;

  /// POST /auth/connexion/ → tokens + profil.
  /// Persiste les deux tokens et renvoie l'utilisateur.
  Future<Utilisateur> connexion({
    required String telephone,
    required String password,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/auth/connexion/',
      data: {'telephone': telephone, 'password': password},
    );
    final data = r.data as Map<String, dynamic>;

    await _tokens.sauvegarder(
      access: data['access'] as String,
      refresh: data['refresh'] as String,
    );

    return Utilisateur.fromJson(data['utilisateur'] as Map<String, dynamic>);
  }

  /// GET /auth/moi/ → profil de l'utilisateur courant (token déjà injecté).
  Future<Utilisateur> moi() async {
    final r = await _dio.get('${Env.apiPrefix}/auth/moi/');
    return Utilisateur.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST /auth/deconnexion/ → blackliste le refresh, puis efface localement.
  Future<void> deconnexion() async {
    final refresh = await _tokens.refreshToken;
    try {
      if (refresh != null) {
        await _dio.post(
          '${Env.apiPrefix}/auth/deconnexion/',
          data: {'refresh': refresh},
        );
      }
    } finally {
      // On efface localement même si l'appel réseau échoue.
      await _tokens.effacer();
    }
  }
}
