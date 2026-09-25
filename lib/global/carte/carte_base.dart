import 'package:flutter/material.dart';

import 'modeles_carte.dart';

/// Contrat commun des deux implementations (Google / OpenStreetMap).
abstract class CarteBase extends StatefulWidget {
  const CarteBase({
    super.key,
    required this.centreInitial,
    this.zoomInitial = 14,
    this.marqueurs = const [],
    this.polylignes = const [],
    this.controleur,
    this.onTap,
    this.onPrete,
    this.afficherPosition = false,
    this.positionUtilisateur,
    this.boutonsZoom = false,
    this.satellite = false,
  });

  final PointCarte centreInitial;
  final double zoomInitial;
  final List<MarqueurCarte> marqueurs;
  final List<PolyligneCarte> polylignes;
  final ControleurCarte? controleur;

  /// Tap sur la carte (hors marqueur) : point touche.
  final ValueChanged<PointCarte>? onTap;

  /// Carte affichee et camera commandable (une fois).
  final VoidCallback? onPrete;

  /// Montre la position de l'utilisateur. Google : point bleu natif ;
  /// OSM : point bleu place sur [positionUtilisateur].
  final bool afficherPosition;
  final PointCarte? positionUtilisateur;

  /// Boutons +/- integres a la carte.
  final bool boutonsZoom;

  /// Vue satellite : Google seulement (OSM n'en a pas).
  final bool satellite;
}
