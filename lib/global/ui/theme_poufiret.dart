import 'package:flutter/material.dart';

import '../config/config.dart';

/// Design system clair et aéré de Poufiret, façon « feed » (Facebook/
/// Instagram) : fond gris très clair, cartes blanches, bordures fines,
/// typographie nette. La couleur de marque (terracotta) reste l'accent
/// unique — boutons d'action, états actifs, liens — mais s'utilise avec
/// parcimonie sur cette base claire.
///
/// Thème unique de l'app : appliqué via `MaterialApp.theme` dans main.dart.
/// Tous les écrans qui s'appuient sur `Theme.of(context)` (couleurs de
/// texte, `Card`, boutons, champs, barres de navigation…) en héritent
/// automatiquement, sans modification écran par écran.
class ThemePoufiret {
  ThemePoufiret._();

  static const double _rayon = 14;
  static const double _rayonChamps = 10;

  static const ColorScheme _schema = ColorScheme.light(
    brightness: Brightness.light,
    primary: Config.couleurPrimaire,
    onPrimary: Colors.white,
    primaryContainer: Config.couleurClaire,
    onPrimaryContainer: Config.couleurPrimaireFoncee,
    secondary: Config.couleurSecondaire,
    onSecondary: Colors.white,
    surface: Config.couleurSurface,
    onSurface: Config.couleurTexte,
    onSurfaceVariant: Config.couleurTexteSecondaire,
    surfaceContainerHighest: Config.couleurFond,
    outline: Config.couleurBordure,
    outlineVariant: Config.couleurBordure,
    error: Config.couleurErreur,
    onError: Colors.white,
  );

  static const TextTheme _texte = TextTheme(
    headlineLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w700, color: Config.couleurTexte, height: 1.25),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: Config.couleurTexte, height: 1.25),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: Config.couleurTexte, height: 1.3),
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w700, color: Config.couleurTexte, height: 1.3),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Config.couleurTexte, height: 1.35),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: Config.couleurTexte, height: 1.35),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Config.couleurTexte, height: 1.45),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Config.couleurTexte, height: 1.45),
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Config.couleurTexteSecondaire,
        height: 1.4),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: Config.couleurTexte, height: 1.3),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w600, color: Config.couleurTexte, height: 1.3),
    labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Config.couleurTexteSecondaire,
        height: 1.3),
  );

  /// Thème clair unique de l'application.
  static ThemeData get clair {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: _schema,
      textTheme: _texte,
      scaffoldBackgroundColor: Config.couleurFond,
      dividerColor: Config.couleurBordure,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      // ── Barre du haut : plate, blanche, texte foncé ─────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: Config.couleurSurface,
        foregroundColor: Config.couleurTexte,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: _texte.titleLarge,
        iconTheme: const IconThemeData(color: Config.couleurTexte),
      ),

      // ── Cartes : blanches, coins arrondis, bordure fine, plates ─────
      cardTheme: CardThemeData(
        color: Config.couleurSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_rayon),
          side: const BorderSide(color: Config.couleurBordure),
        ),
      ),

      // ── Separateurs fins ─────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: Config.couleurBordure,
        thickness: 1,
        space: 1,
      ),

      // ── Boutons pleins : accent, coins arrondis ─────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Config.couleurPrimaire,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_rayonChamps),
          ),
          textStyle: _texte.labelLarge,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Config.couleurPrimaire,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_rayonChamps),
          ),
          textStyle: _texte.labelLarge,
        ),
      ),
      // ── Boutons contour : discrets, bordure neutre ──────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Config.couleurTexte,
          side: const BorderSide(color: Config.couleurBordure),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_rayonChamps),
          ),
          textStyle: _texte.labelLarge,
        ),
      ),
      // ── Boutons texte : couleur d'accent, façon lien ────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Config.couleurPrimaire,
          textStyle: _texte.labelLarge,
        ),
      ),

      // ── Champs de formulaire : fond clair, bordure fine, focus accent ─
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Config.couleurFond,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_rayonChamps),
          borderSide: const BorderSide(color: Config.couleurBordure),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_rayonChamps),
          borderSide: const BorderSide(color: Config.couleurBordure),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_rayonChamps),
          borderSide: const BorderSide(color: Config.couleurPrimaire, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_rayonChamps),
          borderSide: const BorderSide(color: Config.couleurErreur),
        ),
        labelStyle: const TextStyle(color: Config.couleurTexteSecondaire),
        hintStyle: const TextStyle(color: Config.couleurTexteSecondaire),
      ),

      // ── Puces (Chip) : fond clair, bordure fine ─────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: Config.couleurFond,
        side: const BorderSide(color: Config.couleurBordure),
        labelStyle: _texte.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ── Barre de navigation basse : blanche, icone active en accent ─
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Config.couleurSurface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Config.couleurPrimaire.withValues(alpha: 0.12),
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => _texte.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? Config.couleurPrimaire
                : Config.couleurTexteSecondaire,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w600,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? Config.couleurPrimaire
                : Config.couleurTexteSecondaire,
          ),
        ),
      ),

      // ── Rail lateral (tablette/web) : meme logique que la barre basse ─
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Config.couleurSurface,
        indicatorColor: Config.couleurPrimaire.withValues(alpha: 0.12),
        selectedIconTheme: const IconThemeData(color: Config.couleurPrimaire),
        unselectedIconTheme:
            const IconThemeData(color: Config.couleurTexteSecondaire),
        selectedLabelTextStyle:
            _texte.labelMedium?.copyWith(color: Config.couleurPrimaire),
        unselectedLabelTextStyle: _texte.labelMedium,
      ),

      // ── Divers ───────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: Config.couleurSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_rayon),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Config.couleurSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_rayon)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Config.couleurTexteSecondaire,
        textColor: Config.couleurTexte,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Config.couleurPrimaire,
      ),
    );
  }
}
