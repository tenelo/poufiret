import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// En-têtes `X-Plateforme` et `X-Version-App`, joints à toutes les requêtes
/// (le serveur s'en sert pour ses statistiques d'usage).
class EntetesApp {
  EntetesApp._();

  /// android | ios | web | autre.
  static String get plateforme {
    if (kIsWeb) return 'web';
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      _ => 'autre',
    };
  }

  static Future<String>? _version;

  /// Version de l'app (lue une seule fois, puis gardée en mémoire).
  static Future<String> get version => _version ??= _lireVersion();

  static Future<String> _lireVersion() async {
    try {
      return (await PackageInfo.fromPlatform()).version;
    } catch (_) {
      return 'inconnue';
    }
  }

  /// Fixe la version (tests).
  @visibleForTesting
  static void definirVersion(String version) =>
      _version = Future.value(version);
}

/// Ajoute les en-têtes de [EntetesApp] à chaque requête.
class IntercepteurEntetesApp extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-Plateforme'] = EntetesApp.plateforme;
    options.headers['X-Version-App'] = await EntetesApp.version;
    handler.next(options);
  }
}
