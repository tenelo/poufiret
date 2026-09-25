import 'package:flutter/foundation.dart';

/// Reglages de la carte de repli OpenStreetMap.
class ConfigCarte {
  ConfigCarte._();

  /// Gabarit d'URL des tuiles. Surchargeable a la compilation
  /// (`--dart-define=URL_TUILES_OSM=https://.../{z}/{x}/{y}.png`) pour passer
  /// plus tard a un fournisseur avec cle, sans toucher au code.
  ///
  /// Le serveur public d'OpenStreetMap convient a un usage modere ; sa
  /// politique d'usage interdit une forte charge : prevoir un fournisseur
  /// dedie si l'app grossit.
  static const urlTuilesOsm = String.fromEnvironment(
    'URL_TUILES_OSM',
    defaultValue: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  );

  /// Identifiant de l'app (User-Agent des requetes de tuiles, exige par la
  /// politique d'OpenStreetMap). Meme valeur que l'applicationId Android.
  static const identifiantApp = 'cloud.tenelo.poufiret';

  /// Mention legale obligatoire, toujours affichee sur la carte.
  static const attribution = 'OpenStreetMap contributors';
  static const urlAttribution = 'https://www.openstreetmap.org/copyright';

  /// Zoom minimal / maximal de la carte OSM.
  static const zoomMin = 3.0;
  static const zoomMax = 19.0;

  /// Pour tester le repli sur un appareil AVEC services Google :
  /// `flutter run --dart-define=FORCER_CARTE_OSM=true`.
  /// Ignore en release : impossible d'y forcer OSM par erreur.
  static const _forcerOsm = bool.fromEnvironment('FORCER_CARTE_OSM');
  static bool get forcerOsm => _forcerOsm && !kReleaseMode;
}
