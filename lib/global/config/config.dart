import 'package:flutter/material.dart';

/// Source unique des couleurs de Poufiret.
///
/// Toute l'application référence ces couleurs : ne jamais écrire une couleur
/// en dur dans un écran. Pour changer l'identité visuelle, modifier ici.
///
/// Chaque couleur existe en version claire et sombre (maquette Figma
/// « Poufiret clair / sombre »). Les getters renvoient la version du thème
/// actif : [sombre] est tenu à jour par `PoufiretApp` (voir main.dart), qui
/// force aussi la reconstruction de tout l'arbre quand il change.
class Config {
  Config._();

  /// Vrai quand le thème sombre est affiché. Écrit uniquement par main.dart.
  static bool sombre = false;

  static Color _c(Color clair, Color fonce) => sombre ? fonce : clair;

  // ── Couleurs de marque ───────────────────────────────────────────
  /// Couleur principale (boutons, accents, éléments actifs).
  static Color get couleurPrimaire =>
      _c(const Color(0xFF1D4FA3), const Color(0xFF6EA2F0));

  /// Texte/icônes posés sur [couleurPrimaire].
  static Color get couleurSurPrimaire =>
      _c(Colors.white, const Color(0xFF0F2038));

  /// Variante foncée (dégradés, en-têtes).
  static const Color couleurPrimaireFoncee = Color(0xFF0E2F5E);

  /// Couleur secondaire (liens, accents complémentaires).
  static Color get couleurSecondaire =>
      _c(const Color(0xFF2563C0), const Color(0xFF4F8DE8));

  /// Variante claire (fonds de survol, badges doux, pastille active).
  static Color get couleurClaire =>
      _c(const Color(0xFFE7EFFA), const Color(0xFF173052));

  /// Accent chaud : étiquettes « Publicité », badges, appels à l'action
  /// secondaires (bouton « Appeler »). Texte foncé dessus.
  static const Color couleurSoleil = Color(0xFFF5A623);

  /// Fond général de l'application.
  static Color get couleurFond =>
      _c(const Color(0xFFF3F7FB), const Color(0xFF0A1626));

  /// Surfaces (cartes, feuilles, champs, barre de navigation).
  static Color get couleurSurface =>
      _c(Colors.white, const Color(0xFF122238));

  /// Bordure/séparateur neutre et discret (cartes, champs, listes).
  static Color get couleurBordure =>
      _c(const Color(0xFFE1E9F2), const Color(0xFF1E3350));

  /// Ombre portée douce des cartes et boutons ronds.
  static List<BoxShadow> get ombre => [
    BoxShadow(
      color: sombre
          ? const Color(0x73000000)
          : const Color(0x1A143C78),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // ── Texte ────────────────────────────────────────────────────────
  static Color get couleurTexte =>
      _c(const Color(0xFF0F2038), const Color(0xFFEAF1FA));
  static Color get couleurTexteSecondaire =>
      _c(const Color(0xFF6B7C93), const Color(0xFF8FA3BC));
  static Color get couleurTitre => couleurTexte;

  // ── Actions sociales ─────────────────────────────────────────────
  /// Cœur de like (articles, partenaires, commentaires).
  static Color get couleurLike => _c(const Color(0xFFE5484D), const Color(0xFFFF6B6F));

  /// Marque-page de favori.
  static Color get couleurFavori => couleurSoleil;

  // ── États ────────────────────────────────────────────────────────
  static Color get couleurSucces =>
      _c(const Color(0xFF2F9E44), const Color(0xFF4CC266));
  static Color get couleurErreur =>
      _c(const Color(0xFFC62828), const Color(0xFFFF6B6B));
  static const Color couleurAvertissement = couleurSoleil;

  // ── Tuiles « Explorer » de l'accueil ─────────────────────────────
  /// Couples (fond, texte) pastel, utilisés en rotation : bleu, vert, ambre,
  /// sarcelle.
  static List<(Color, Color)> get pastels => sombre
      ? const [
          (Color(0xFF13305C), Color(0xFFCFE0FB)),
          (Color(0xFF123A29), Color(0xFFC9EFD4)),
          (Color(0xFF43310F), Color(0xFFFCE3B0)),
          (Color(0xFF0F3B3D), Color(0xFFC6ECEC)),
        ]
      : const [
          (Color(0xFFDCE8FA), Color(0xFF13366F)),
          (Color(0xFFDDF1E2), Color(0xFF175C2A)),
          (Color(0xFFFDEBCB), Color(0xFF7A4A06)),
          (Color(0xFFD5ECEC), Color(0xFF0B4A4D)),
        ];
}
