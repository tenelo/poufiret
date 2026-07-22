import 'package:flutter/material.dart';

/// Source unique des couleurs de Poufiret.
///
/// Toute l'application référence ces constantes : ne jamais écrire une couleur
/// en dur dans un écran. Pour changer l'identité visuelle, modifier ici.
class Config {
  Config._();

  // ── Couleurs de marque ───────────────────────────────────────────
  /// Couleur principale (boutons, accents, éléments actifs).
  static const Color couleurPrimaire = Color(0xFF8A4B34);

  /// Variante foncée (états pressés, en-têtes).
  static const Color couleurPrimaireFoncee = Color(0xFF5E3122);

  /// Couleur secondaire (accents complémentaires).
  static const Color couleurSecondaire = Color(0xFFB0674A);

  /// Variante claire (fonds de survol, badges doux).
  static const Color couleurClaire = Color(0xFFD9A184);

  /// Fond général de l'application.
  static const Color couleurFond = Color(0xFFFBEDE6);

  // ── Texte ────────────────────────────────────────────────────────
  static const Color couleurTexte = Color(0xFF2A211D);
  static const Color couleurTexteSecondaire = Color(0xFF7A6A62);
  static const Color couleurTitre = Color(0xFF2A211D);

  // ── Actions sociales ─────────────────────────────────────────────
  /// Cœur de like (articles, partenaires, commentaires).
  static const Color couleurLike = couleurPrimaire;

  /// Marque-page de favori.
  static const Color couleurFavori = couleurPrimaire;

  // ── États ────────────────────────────────────────────────────────
  static const Color couleurSucces = Color(0xFF2E7D32);
  static const Color couleurErreur = Color(0xFFC62828);
  static const Color couleurAvertissement = Color(0xFFF9A825);

  // ── Thème global ─────────────────────────────────────────────────
  /// ColorScheme dérivé de la couleur primaire, pour MaterialApp.
  static ColorScheme get schemaCouleurs => ColorScheme.fromSeed(
        seedColor: couleurPrimaire,
        primary: couleurPrimaire,
        secondary: couleurSecondaire,
      );
}
