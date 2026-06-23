import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stockage chiffré des tokens JWT (Keystore Android / Keychain iOS).
class TokenStorage {
  static const _kAccess = 'poufiret_access';
  static const _kRefresh = 'poufiret_refresh';

  final FlutterSecureStorage _storage;

  TokenStorage([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  Future<String?> get accessToken => _storage.read(key: _kAccess);
  Future<String?> get refreshToken => _storage.read(key: _kRefresh);

  /// Écrit les deux tokens. Le refresh est réécrit à chaque rotation.
  Future<void> sauvegarder({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  /// Met à jour le seul access (cas du refresh qui ne renvoie pas de refresh).
  Future<void> majAccess(String access) =>
      _storage.write(key: _kAccess, value: access);

  Future<void> effacer() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }

  Future<bool> get aSession async => (await refreshToken) != null;
}
