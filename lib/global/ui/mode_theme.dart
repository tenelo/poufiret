import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Apparence choisie par l'utilisateur (menu latéral > Apparence) :
/// automatique (réglage du téléphone), clair ou sombre. Mémorisée sur
/// l'appareil.
final modeThemeProvider =
    NotifierProvider<ModeThemeNotifier, ThemeMode>(ModeThemeNotifier.new);

/// Valeur lue au démarrage par main.dart avant le premier rendu, pour ne pas
/// afficher un écran clair qui bascule aussitôt en sombre.
final modeThemeInitialProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

class ModeThemeNotifier extends Notifier<ThemeMode> {
  static const _cle = 'poufiret_mode_theme';
  static const _stockage = FlutterSecureStorage();

  /// Lit le mode mémorisé (système par défaut, ou en cas d'erreur).
  static Future<ThemeMode> lire() async {
    try {
      final valeur = await _stockage.read(key: _cle);
      return ThemeMode.values.firstWhere(
        (m) => m.name == valeur,
        orElse: () => ThemeMode.system,
      );
    } catch (_) {
      return ThemeMode.system;
    }
  }

  @override
  ThemeMode build() => ref.read(modeThemeInitialProvider);

  Future<void> choisir(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    try {
      await _stockage.write(key: _cle, value: mode.name);
    } catch (_) {
      // Non mémorisé : le choix vaut pour la session en cours.
    }
  }
}
