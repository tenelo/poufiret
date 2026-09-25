import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../global/config/env.dart';
import '../../../global/network/dio_client.dart';
import '../metier_domaine/info_version.dart';

/// Interroge l'endpoint public /version/verifier/ au démarrage.
///
/// Utilise un Dio NU (sans intercepteur d'auth) : l'appel est public et se
/// fait avant toute connexion ; il ne doit jamais déclencher de refresh de
/// token ni de file d'attente 401. Il partage en revanche le pool de
/// connexions de l'API : la connexion TLS ouverte ici sert ensuite aux
/// premières requêtes de l'app.
class VersionRepository {
  VersionRepository([Dio? dio])
    : _dio =
          dio ??
          DioClient.creerNu(
            connexion: const Duration(seconds: 8),
            reception: const Duration(seconds: 8),
          );

  final Dio _dio;

  String get _plateforme {
    if (Platform.isIOS) return 'ios';
    return 'android';
  }

  Future<InfoVersion> verifier() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final r = await _dio.get(
        '${Env.apiPrefix}/version/verifier/',
        queryParameters: {
          'version': info.version,
          'plateforme': _plateforme,
        },
      );
      final data = Map<String, dynamic>.from(r.data as Map);
      return InfoVersion.fromJson(data);
    } catch (_) {
      // Serveur injoignable, timeout, réponse inattendue : on NE bloque pas.
      return InfoVersion.aJourParDefaut;
    }
  }
}
