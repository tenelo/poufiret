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
    label: 'Publicités',
    icon: Icons.campaign_outlined,
    selectedIcon: Icons.campaign,
  ),
  AppDestination(
    label: 'Messages',
    icon: Icons.chat_bubble_outline,
    selectedIcon: Icons.chat_bubble,
  ),
  AppDestination(
    label: 'Livraison',
    icon: Icons.local_shipping_outlined,
    selectedIcon: Icons.local_shipping,
  ),
  AppDestination(
    label: 'Map',
    icon: Icons.location_on_outlined,
    selectedIcon: Icons.location_on,
  ),
];
