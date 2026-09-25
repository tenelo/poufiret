import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stockage chiffré (Keystore Android / Keychain iOS) des tokens JWT et des
/// éléments de reconnexion.
///
/// Politique retenue : le PIN est stocké chiffré pour permettre le
/// déverrouillage par empreinte OU PIN après déconnexion volontaire ou
/// expiration de session (l'empreinte lit le PIN stocké et rejoue
/// /auth/connexion/). Tant que la session JWT est vivante, aucun verrou
/// n'est demandé : l'app s'ouvre directement.
///
/// Les deux tokens sont gardés EN MÉMOIRE après la première lecture : le
/// stockage sécurisé (canal natif + déchiffrement) n'est plus interrogé à
/// chaque requête HTTP, seulement écrit lors d'une connexion/rotation.
class TokenStorage {
  static const _kAccess = 'poufiret_access';
  static const _kRefresh = 'poufiret_refresh';
  static const _kTelephone = 'poufiret_telephone';
  static const _kPin = 'poufiret_pin';
  static const _kBiometrie = 'poufiret_biometrie';

  final FlutterSecureStorage _storage;

  TokenStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  // ── Cache mémoire des tokens ───────────────────────────────────────────
  String? _access;
  String? _refresh;
  Future<void>? _chargement;
  // Incrémenté à chaque écriture : une lecture initiale encore en vol ne doit
  // jamais écraser une valeur écrite entre-temps.
  int _version = 0;

  Future<void> _charger() => _chargement ??= _lireStockage();

  Future<void> _lireStockage() async {
    final version = _version;
    try {
      final lus = await Future.wait([
        _storage.read(key: _kAccess),
        _storage.read(key: _kRefresh),
      ]);
      if (version == _version) {
        _access = lus[0];
        _refresh = lus[1];
      }
    } catch (_) {
      _chargement = null; // permet de réessayer à la prochaine lecture
      rethrow;
    }
  }

  Future<String?> get accessToken async {
    await _charger();
    return _access;
  }

  Future<String?> get refreshToken async {
    await _charger();
    return _refresh;
  }

  /// Écrit les deux tokens. Le refresh est réécrit à chaque rotation.
  ///
  /// La mémoire est mise à jour immédiatement (les requêtes concurrentes
  /// voient tout de suite le nouveau token) ; le refresh est persisté AVANT
  /// l'access : si l'app est tuée entre les deux, il reste un refresh valide
  /// (l'ancien access expiré sera simplement renouvelé au lancement suivant).
  Future<void> sauvegarder({
    required String access,
    required String refresh,
  }) async {
    _version++;
    _access = access;
    _refresh = refresh;
    _chargement = Future.value();
    await _storage.write(key: _kRefresh, value: refresh);
    await _storage.write(key: _kAccess, value: access);
  }

  /// Met à jour le seul access (cas du refresh qui ne renvoie pas de refresh).
  Future<void> majAccess(String access) async {
    await _charger();
    _version++;
    _access = access;
    await _storage.write(key: _kAccess, value: access);
  }

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
    _oublierTokens();
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }

  /// Purge complète : tokens + téléphone + PIN + biométrie.
  /// À utiliser pour un changement de compte ou un reset total.
  Future<void> effacerTout() async {
    _oublierTokens();
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kTelephone);
    await _storage.delete(key: _kPin);
    await _storage.delete(key: _kBiometrie);
  }

  void _oublierTokens() {
    _version++;
    _access = null;
    _refresh = null;
    _chargement = Future.value();
  }

  Future<bool> get aSession async => (await refreshToken) != null;
}
