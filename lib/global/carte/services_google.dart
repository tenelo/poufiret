import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config_carte.dart';

const _canal = MethodChannel('cloud.tenelo.poufiret/services');

/// Vrai si Google Maps peut s'afficher sur cet appareil.
///
/// Sur Android, on interroge GoogleApiAvailability (cote natif) : seul le code
/// SUCCESS compte (absent, desactive, a mettre a jour... => faux). Verifie une
/// seule fois (provider en memoire pour la session) et lance au demarrage, sans
/// bloquer : la carte n'attend que si l'ecran est ouvert avant la reponse (un
/// appel natif de quelques millisecondes).
final servicesGoogleProvider = FutureProvider<bool>((ref) async {
  if (ConfigCarte.forcerOsm) return false; // test : jamais actif en release
  if (!Platform.isAndroid) return true; // iOS : Google Maps toujours dispo
  try {
    return await _canal.invokeMethod<bool>('googlePlayDisponible') ?? false;
  } on MissingPluginException {
    // Le code natif de detection n'est pas dans l'APK (installation ancienne,
    // ou hot restart sans recompilation) : on ne peut rien conclure sur
    // l'appareil, on garde le comportement historique (Google Maps).
    return true;
  } catch (_) {
    // Erreur native pendant la verification : on prefere une carte qui marche
    // (OSM) a une carte grise.
    return false;
  }
});
