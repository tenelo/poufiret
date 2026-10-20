import 'package:flutter/material.dart';

import '../../restaurants/screens/ecran_restaurant.dart';
import '../metier_domaine/gabarits.dart';
import 'ecran_catalogue.dart';

/// Page dédiée d'un commerce selon son gabarit : la page restaurant (en
/// grille pour une boulangerie) ou la page catalogue. [siIntrouvable] est
/// affiché si le serveur ne connaît pas ce commerce (404).
Widget pageGabarit(
  Gabarit gabarit, {
  required int commerceId,
  String nom = '',
  Widget? siIntrouvable,
}) => switch (gabarit) {
  Gabarit.restaurant => EcranRestaurant(
    restaurantId: commerceId,
    nom: nom,
    siIntrouvable: siIntrouvable,
  ),
  Gabarit.boulangerie => EcranRestaurant(
    restaurantId: commerceId,
    nom: nom,
    siIntrouvable: siIntrouvable,
    grille: true,
  ),
  Gabarit.pharmacie || Gabarit.mode || Gabarit.librairie => EcranCatalogue(
    commerceId: commerceId,
    gabarit: gabarit,
    nom: nom,
    siIntrouvable: siIntrouvable,
  ),
};
