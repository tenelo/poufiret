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
/// POST /auth/inscription/ → crée un compte client + renvoie tokens + profil.
  /// Le username est dérivé du téléphone (invisible pour l'utilisateur).
  Future<Utilisateur> inscription({
    required String prenom,
    required String nom,
    required String telephone, // déjà au format +225...
    required String password,
    int? departement,
    String? trancheAge,
    String? sexe,
  }) async {
    // Username technique unique, adossé au téléphone (déjà unique).
    final username = 'user_${telephone.replaceAll('+', '')}';

    final r = await _dio.post(
      '${Env.apiPrefix}/auth/inscription/',
      data: {
        'telephone': telephone,
        'username': username,
        'first_name': prenom,
        'last_name': nom,
        'password': password,
        if (departement != null) 'departement': departement,
        if (trancheAge != null && trancheAge.isNotEmpty)
          'tranche_age': trancheAge,
        if (sexe != null && sexe.isNotEmpty) 'sexe': sexe,
      },
    );
    final data = r.data as Map<String, dynamic>;

    await _tokens.sauvegarder(
      access: data['access'] as String,
      refresh: data['refresh'] as String,
    );

    return Utilisateur.fromJson(data['utilisateur'] as Map<String, dynamic>);
  }
  /// PATCH /auth/moi/ → modifie le profil (champs éditables uniquement).
  Future<Utilisateur> modifierProfil(Map<String, dynamic> donnees) async {
    final r = await _dio.patch('${Env.apiPrefix}/auth/moi/', data: donnees);
    return Utilisateur.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /auth/appareils/ → sessions appareils de l'utilisateur.
  Future<List<Map<String, dynamic>>> appareils() async {
    final r = await _dio.get(
      '${Env.apiPrefix}/auth/appareils/',
      queryParameters: {'page_size': 100},
    );
    final data = r.data;
    // L'API peut renvoyer une liste brute OU une reponse paginee DRF.
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  /// POST /auth/appareils/<id>/revoquer/ → désactive une session.
  Future<void> revoquerAppareil(String id) async {
    await _dio.post('${Env.apiPrefix}/auth/appareils/$id/revoquer/');
  }

  /// POST /auth/devenir-partenaire/ → crée le profil partenaire (en attente).
  Future<void> devenirPartenaire(Map<String, dynamic> donnees) async {
    await _dio.post('${Env.apiPrefix}/auth/devenir-partenaire/', data: donnees);
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
