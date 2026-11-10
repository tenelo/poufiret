import 'package:flutter/material.dart';

import '../config/config.dart';

/// Design system de Poufiret (maquette Figma « Poufiret clair / sombre ») :
/// fond bleuté très clair (ou bleu nuit), cartes blanches (ou bleu ardoise)
/// aux grands rayons et à l'ombre douce, bleu de marque pour les actions,
/// accent soleil pour les étiquettes.
///
/// Appliqué via `MaterialApp.theme` / `darkTheme` dans main.dart. Tous les
/// écrans qui s'appuient sur `Theme.of(context)` (couleurs de texte, `Card`,
/// boutons, champs, barres de navigation…) en héritent automatiquement.

/// Police unique de l'application : Inter, embarquée dans assets/fonts
/// (graisses 400 à 700).
const String police = 'Inter';

class ThemePoufiret {
  ThemePoufiret._();

  static const double rayonCarte = 22;
  static const double rayonBouton = 16;

  static ThemeData get clair => _avecPalette(false);
  static ThemeData get sombre => _avecPalette(true);

  /// Les couleurs de [Config] suivent le thème affiché : on bascule la
  /// palette le temps de construire le ThemeData demandé.
  static ThemeData _avecPalette(bool sombre) {
    final avant = Config.sombre;
    Config.sombre = sombre;
    try {
      return _construire(sombre ? Brightness.dark : Brightness.light);
    } finally {
      Config.sombre = avant;
    }
  }

  static TextTheme _texte() {
    final texte = Config.couleurTexte;
    final secondaire = Config.couleurTexteSecondaire;
    TextStyle s(
      double taille,
      FontWeight graisse,
      double hauteur, {
      Color? couleur,
      double espacement = 0,
    }) => TextStyle(
      fontFamily: police,
      fontSize: taille,
      fontWeight: graisse,
      height: hauteur,
      letterSpacing: espacement,
      color: couleur ?? texte,
    );
    // Style léger : titres en semi-gras (w600), texte courant en normal
    // (w400), étiquettes en medium (w500) ; échelle limitée à
    // 11 · 12 · 14 · 16 · 18 · 20 · 24 · 28 ; texte courant aéré (1,5) ;
    // grands titres légèrement resserrés, petites étiquettes espacées.
    return TextTheme(
      headlineLarge: s(28, FontWeight.w600, 1.2, espacement: -0.6),
      headlineMedium: s(24, FontWeight.w600, 1.25, espacement: -0.5),
      headlineSmall: s(20, FontWeight.w600, 1.3, espacement: -0.4),
      titleLarge: s(18, FontWeight.w600, 1.35, espacement: -0.3),
      titleMedium: s(16, FontWeight.w600, 1.4, espacement: -0.2),
      titleSmall: s(14, FontWeight.w600, 1.4, espacement: -0.1),
      bodyLarge: s(16, FontWeight.w400, 1.5),
      bodyMedium: s(14, FontWeight.w400, 1.5),
      bodySmall: s(12, FontWeight.w400, 1.45, couleur: secondaire),
      labelLarge: s(14, FontWeight.w600, 1.3),
      labelMedium: s(12, FontWeight.w500, 1.3, espacement: 0.1),
      labelSmall: s(
        11,
        FontWeight.w500,
        1.3,
        couleur: secondaire,
        espacement: 0.3,
      ),
    );
  }

  static ThemeData _construire(Brightness luminosite) {
    final primaire = Config.couleurPrimaire;
    final surPrimaire = Config.couleurSurPrimaire;
    final fond = Config.couleurFond;
    final surface = Config.couleurSurface;
    final bordure = Config.couleurBordure;
    final texte = Config.couleurTexte;
    final secondaire = Config.couleurTexteSecondaire;
    final erreur = Config.couleurErreur;
    final ombre = Config.ombre.first.color;
    final textes = _texte();

    /// Séparateurs : la bordure existante, adoucie (opacité 70 %).
    final bordureLegere = bordure.withValues(alpha: 0.7);

    final schema = ColorScheme(
      brightness: luminosite,
      primary: primaire,
      onPrimary: surPrimaire,
      primaryContainer: Config.couleurClaire,
      onPrimaryContainer: texte,
      secondary: Config.couleurSecondaire,
      onSecondary: surPrimaire,
      tertiary: Config.couleurSoleil,
      onTertiary: const Color(0xFF0F2038),
      surface: surface,
      onSurface: texte,
      onSurfaceVariant: secondaire,
      surfaceContainerLowest: surface,
      surfaceContainerLow: surface,
      surfaceContainer: surface,
      surfaceContainerHigh: Config.couleurClaire,
      surfaceContainerHighest: fond,
      outline: bordure,
      outlineVariant: bordure,
      error: erreur,
      onError: luminosite == Brightness.dark
          ? const Color(0xFF0F2038)
          : Colors.white,
      shadow: ombre,
    );

    final formeBouton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(rayonBouton),
    );
    const paddingBouton = EdgeInsets.symmetric(horizontal: 22, vertical: 15);
    final texteBouton = textes.labelLarge;

    OutlineInputBorder bordureChamp(Color couleur, [double largeur = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(rayonBouton),
          borderSide: BorderSide(color: couleur, width: largeur),
        );

    final base = ThemeData(
      useMaterial3: true,
      brightness: luminosite,
      colorScheme: schema,
      fontFamily: police,
      textTheme: textes,
      scaffoldBackgroundColor: fond,
      canvasColor: fond,
      dividerColor: bordureLegere,
      shadowColor: ombre,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      // ── Barre du haut : fondue dans le fond, titre semi-gras ────────
      appBarTheme: AppBarTheme(
        backgroundColor: fond,
        foregroundColor: texte,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textes.titleLarge?.copyWith(fontSize: 20),
        // Pas d'iconTheme ici : il primerait sur le `foregroundColor` des
        // barres qui le fixent (visionneuse d'images sur fond noir…).
      ),

      // ── Cartes : grands rayons, ombre diffuse et basse, sans bordure ─
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: ombre,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rayonCarte),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: bordureLegere,
        thickness: 0.8,
        space: 1,
      ),

      // ── Boutons pleins : bleu de marque, rayon 16 ───────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaire,
          foregroundColor: surPrimaire,
          padding: paddingBouton,
          shape: formeBouton,
          textStyle: texteBouton,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaire,
          foregroundColor: surPrimaire,
          elevation: 0,
          padding: paddingBouton,
          shape: formeBouton,
          textStyle: texteBouton,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: texte,
          backgroundColor: surface,
          side: BorderSide(color: bordure),
          padding: paddingBouton,
          shape: formeBouton,
          textStyle: texteBouton,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Config.couleurSecondaire,
          textStyle: textes.labelLarge,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaire,
        foregroundColor: surPrimaire,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rayonBouton),
        ),
      ),

      // ── Champs : surface, bordure fine (1), focus bleu ──────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: bordureChamp(bordure),
        enabledBorder: bordureChamp(bordure),
        focusedBorder: bordureChamp(Config.couleurSecondaire),
        errorBorder: bordureChamp(erreur),
        focusedErrorBorder: bordureChamp(erreur),
        labelStyle: TextStyle(color: secondaire, fontWeight: FontWeight.w400),
        hintStyle: TextStyle(color: secondaire, fontWeight: FontWeight.w400),
      ),

      // ── Puces : pilule, surface ; sélection pleine bleue ────────────
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primaire,
        checkmarkColor: surPrimaire,
        side: BorderSide(color: bordure, width: 0.8),
        labelStyle: textes.labelLarge?.copyWith(fontWeight: FontWeight.w500),
        secondaryLabelStyle: textes.labelLarge?.copyWith(
          color: surPrimaire,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: const StadiumBorder(),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: Config.couleurClaire,
          foregroundColor: secondaire,
          selectedBackgroundColor: surface,
          selectedForegroundColor: texte,
          side: BorderSide.none,
          textStyle: textes.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      badgeTheme: const BadgeThemeData(
        backgroundColor: Config.couleurSoleil,
        textColor: Color(0xFF0F2038),
      ),

      // ── Barre de navigation basse : pastille active bleue pleine ────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: primaire,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        height: 66,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textes.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? primaire
                : secondaire,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected)
                ? surPrimaire
                : secondaire,
          ),
        ),
      ),

      // ── Rail latéral (tablette/web) : même logique ──────────────────
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: primaire,
        selectedIconTheme: IconThemeData(color: surPrimaire),
        unselectedIconTheme: IconThemeData(color: secondaire),
        selectedLabelTextStyle: textes.labelMedium?.copyWith(color: primaire),
        unselectedLabelTextStyle: textes.labelMedium?.copyWith(
          color: secondaire,
        ),
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: fond,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
        ),
      ),

      // ── Divers ───────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: fond,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rayonBouton),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: texte,
        contentTextStyle: textes.bodyMedium?.copyWith(
          color: fond,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primaire,
        unselectedLabelColor: secondaire,
        indicatorColor: primaire,
        dividerColor: bordureLegere,
        labelStyle: textes.titleSmall,
        unselectedLabelStyle: textes.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: secondaire,
        textColor: texte,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? surPrimaire : secondaire,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? primaire : bordure,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaire),
    );
  }
}
