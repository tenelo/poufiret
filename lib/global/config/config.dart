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

  /// Fond général de l'application : blanc cassé très clair, style « feed ».
  static const Color couleurFond = Color(0xFFF5F6F7);

  /// Surfaces (cartes, feuilles, champs) : blanc pur, pour trancher sur
  /// le fond légèrement gris de [couleurFond].
  static const Color couleurSurface = Color(0xFFFFFFFF);

  /// Bordure/séparateur neutre et discret (cartes, champs, listes).
  static const Color couleurBordure = Color(0xFFE4E6EB);

  // ── Texte ────────────────────────────────────────────────────────
  static const Color couleurTexte = Color(0xFF1C1E21);
  static const Color couleurTexteSecondaire = Color(0xFF65676B);
  static const Color couleurTitre = Color(0xFF1C1E21);

  // ── Actions sociales ─────────────────────────────────────────────
  /// Cœur de like (articles, partenaires, commentaires).
  static const Color couleurLike = couleurPrimaire;

  /// Marque-page de favori.
  static const Color couleurFavori = couleurPrimaire;

  // ── États ────────────────────────────────────────────────────────
  static const Color couleurSucces = Color(0xFF2E7D32);
  static const Color couleurErreur = Color(0xFFC62828);
  static const Color couleurAvertissement = Color(0xFFF9A825);
}
