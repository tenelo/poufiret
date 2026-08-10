import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stockage chiffré des tokens JWT et des préférences de session
/// (Keystore Android / Keychain iOS).
///
/// Politique de sécurité (option A) : le PIN n'est JAMAIS stocké.
/// Le déverrouillage local rejoue /auth/connexion/ (téléphone mémorisé
/// + PIN saisi). Seuls sont persistés : les tokens, le téléphone du
/// dernier compte connecté, et le flag d'activation de la biométrie.
class TokenStorage {
  static const _kAccess = 'poufiret_access';
  static const _kRefresh = 'poufiret_refresh';
  static const _kTelephone = 'poufiret_telephone';
  static const _kBiometrie = 'poufiret_biometrie';

  final FlutterSecureStorage _storage;

  TokenStorage([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
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

  // ── Téléphone du dernier compte (pour rejouer la connexion au verrou) ──
  Future<String?> get telephone => _storage.read(key: _kTelephone);

  Future<void> memoriserTelephone(String telephone) =>
      _storage.write(key: _kTelephone, value: telephone);

  // ── Biométrie activée (empreinte) ─────────────────────────────────────
  Future<bool> get biometrieActivee async =>
      (await _storage.read(key: _kBiometrie)) == 'true';

  Future<void> definirBiometrie(bool activee) =>
      _storage.write(key: _kBiometrie, value: activee ? 'true' : 'false');

  /// Efface tokens + téléphone. Conserve volontairement le flag biométrie
  /// pour ne pas redemander l'activation à chaque reconnexion sur le même
  /// appareil. (Utiliser effacerTout() pour une purge complète.)
  Future<void> effacer() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kTelephone);
  }

  /// Purge complète, y compris la préférence biométrie.
  Future<void> effacerTout() async {
    await effacer();
    await _storage.delete(key: _kBiometrie);
  }

  Future<bool> get aSession async => (await refreshToken) != null;
}
