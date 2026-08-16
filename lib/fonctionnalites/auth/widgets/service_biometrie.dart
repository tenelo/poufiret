import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

/// Wrapper autour de `local_auth`.
///
/// Rôle : servir de PORTAIL LOCAL (rouvrir l'app sans retaper le PIN) tant
/// que la session serveur (refresh JWT) est vivante. La biométrie ne prouve
/// rien au backend — elle ne remplace jamais la connexion. Toutes les
/// exceptions plateforme sont avalées et converties en `bool`.
class ServiceBiometrie {
  ServiceBiometrie([LocalAuthentication? auth])
    : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  /// Vrai si l'appareil a du matériel biométrique utilisable ET au moins
  /// une empreinte/visage enrôlé.
  Future<bool> estDisponible() async {
    try {
      if (!await _auth.isDeviceSupported()) return false;
      if (!await _auth.canCheckBiometrics) return false;
      final dispo = await _auth.getAvailableBiometrics();
      return dispo.isNotEmpty;
    } on PlatformException {
      return false;
    }
  }

  /// Lance l'invite biométrique. Renvoie vrai si l'utilisateur s'est
  /// authentifié, faux sinon (annulation, échec, indisponibilité).
  Future<bool> authentifier({
    String raison = 'Confirmez votre identité pour accéder à Poufiret',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: raison,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
