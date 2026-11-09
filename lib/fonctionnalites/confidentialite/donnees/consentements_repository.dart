import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/env.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/consentements.dart';

/// `GET / PATCH /auth/moi/consentements/`.
class ConsentementsRepository {
  ConsentementsRepository(this._dio);

  final Dio _dio;

  static const _chemin = '/auth/moi/consentements/';

  Future<Consentements> lire() async {
    final r = await _dio.get('${Env.apiPrefix}$_chemin');
    return Consentements.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  /// Enregistre les deux choix pour la version en vigueur.
  Future<Consentements> enregistrer({
    required bool statistiques,
    required bool ia,
  }) async {
    final r = await _dio.patch(
      '${Env.apiPrefix}$_chemin',
      data: {
        'consentement_statistiques': statistiques,
        'consentement_ia': ia,
        'consentement_version': versionConsentement,
      },
    );
    final data = r.data;
    return data is Map
        ? Consentements.fromJson(Map<String, dynamic>.from(data))
        : Consentements(
            statistiques: statistiques,
            ia: ia,
            version: versionConsentement,
          );
  }
}

final consentementsRepositoryProvider = Provider<ConsentementsRepository>(
  (ref) => ConsentementsRepository(ref.watch(dioProvider)),
);

/// Choix actuels de l'utilisateur connecté (écran Confidentialité).
final consentementsProvider = FutureProvider.autoDispose<Consentements>(
  (ref) => ref.watch(consentementsRepositoryProvider).lire(),
);
