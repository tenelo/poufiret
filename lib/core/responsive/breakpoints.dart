import 'package:flutter/widgets.dart';

/// Catégories de largeur d'écran.
enum FormatEcran { compact, moyen, etendu }

/// Seuils centralisés (largeur logique en dp).
/// - compact : téléphones en portrait (< 600)
/// - moyen   : grands téléphones paysage / petites tablettes (600–1023)
/// - etendu  : tablettes / desktop (≥ 1024)
abstract class Breakpoints {
  static const double moyen = 600;
  static const double etendu = 1024;

  static FormatEcran depuisLargeur(double largeur) {
    if (largeur >= etendu) return FormatEcran.etendu;
    if (largeur >= moyen) return FormatEcran.moyen;
    return FormatEcran.compact;
  }

  /// Largeur max confortable pour un contenu en colonne (formulaire, texte).
  /// Au-delà, le contenu est borné et centré au lieu de s'étirer.
  static const double largeurContenu = 480;
}

/// Extension pratique : `context.format` et `context.estCompact`.
extension FormatEcranContext on BuildContext {
  FormatEcran get format =>
      Breakpoints.depuisLargeur(MediaQuery.sizeOf(this).width);

  bool get estCompact => format == FormatEcran.compact;
  bool get estEtendu => format == FormatEcran.etendu;
}
