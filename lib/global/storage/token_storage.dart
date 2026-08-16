import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stockage chiffré (Keystore Android / Keychain iOS) des tokens JWT et des
/// éléments de reconnexion.
///
/// Politique retenue : le PIN est stocké chiffré pour permettre le
/// déverrouillage par empreinte OU PIN après déconnexion volontaire ou
/// expiration de session (l'empreinte lit le PIN stocké et rejoue
/// /auth/connexion/). Tant que la session JWT est vivante, aucun verrou
/// n'est demandé : l'app s'ouvre directement.
class TokenStorage {
  static const _kAccess = 'poufiret_access';
  static const _kRefresh = 'poufiret_refresh';
  static const _kTelephone = 'poufiret_telephone';
  static const _kPin = 'poufiret_pin';
  static const _kBiometrie = 'poufiret_biometrie';

  final FlutterSecureStorage _storage;

  TokenStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

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

  // ── Téléphone du dernier compte (pour rejouer la connexion) ────────────
  Future<String?> get telephone => _storage.read(key: _kTelephone);

  Future<void> memoriserTelephone(String telephone) =>
      _storage.write(key: _kTelephone, value: telephone);

  // ── PIN chiffré (déverrouillage empreinte/PIN) ─────────────────────────
  Future<String?> get pin => _storage.read(key: _kPin);

  Future<void> memoriserPin(String pin) =>
      _storage.write(key: _kPin, value: pin);

  Future<bool> get aPinMemorise async =>
      (await _storage.read(key: _kPin)) != null;

  // ── Biométrie activée (empreinte) ──────────────────────────────────────
  Future<bool> get biometrieActivee async =>
      (await _storage.read(key: _kBiometrie)) == 'true';

  Future<void> definirBiometrie(bool activee) =>
      _storage.write(key: _kBiometrie, value: activee ? 'true' : 'false');

  /// Vrai si l'utilisateur a déjà répondu à la proposition d'empreinte
  /// (peu importe la réponse). Sert à ne proposer qu'une seule fois.
  Future<bool> get biometrieDefinie async =>
      (await _storage.read(key: _kBiometrie)) != null;

  /// Efface les seuls TOKENS (déconnexion / expiration de session).
  /// Conserve téléphone + PIN + biométrie pour permettre la reconnexion
  /// par empreinte ou PIN sur le même appareil.
  Future<void> effacer() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }

  /// Purge complète : tokens + téléphone + PIN + biométrie.
  /// À utiliser pour un changement de compte ou un reset total.
  Future<void> effacerTout() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kTelephone);
    await _storage.delete(key: _kPin);
    await _storage.delete(key: _kBiometrie);
  }

  Future<bool> get aSession async => (await refreshToken) != null;
}
