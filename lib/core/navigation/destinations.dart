import 'package:flutter/material.dart';

/// Décrit un onglet de la navigation principale.
class AppDestination {
  const AppDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Source unique de vérité pour les onglets.
/// L'ordre ici DOIT correspondre à l'ordre des branches dans app_router.dart.
const List<AppDestination> kDestinations = [
  AppDestination(
    label: 'Accueil',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  AppDestination(
    label: 'Recherche',
    icon: Icons.search_outlined,
    selectedIcon: Icons.search,
  ),
  AppDestination(
    label: 'Favoris',
    icon: Icons.favorite_outline,
    selectedIcon: Icons.favorite,
  ),
  AppDestination(
    label: 'Messages',
    icon: Icons.chat_bubble_outline,
    selectedIcon: Icons.chat_bubble,
  ),
  AppDestination(
    label: 'Compte',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
  ),
];
