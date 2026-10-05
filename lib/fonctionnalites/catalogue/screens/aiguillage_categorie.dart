import 'package:flutter/material.dart';

import '../../restaurants/metier_domaine/types_restauration.dart';
import '../../restaurants/screens/ecran_restaurants.dart';
import '../metier_domaine/categorie.dart';
import 'ecran_prestataires.dart';

// Quel écran ouvre une catégorie : l'expérience dédiée à son type de
// partenaire quand il en existe une (restauration), l'annuaire générique
// sinon. Seul endroit à compléter pour brancher un nouveau type.

/// Écran complet d'une catégorie (ouvert depuis la grille ou la recherche).
Widget ecranCategorie(Categorie c) => estRestauration(c.typesPartenaire)
    ? EcranRestaurants(titre: c.nom, categorieId: c.id)
    : EcranPrestataires(
        categorieId: c.id,
        categorieNom: c.nom,
        categorieSlug: c.slug,
        modeTransaction: c.modeTransaction,
        afficheCatalogue: c.afficheCatalogue,
      );

/// Contenu d'une catégorie sans barre ni Scaffold (onglet de l'accueil).
Widget contenuCategorie(Categorie c) => estRestauration(c.typesPartenaire)
    ? ContenuRestaurants(key: ValueKey('onglet_${c.id}'), categorieId: c.id)
    : ContenuPrestataires(
        key: ValueKey('onglet_${c.id}'),
        categorieId: c.id,
        categorieNom: c.nom,
        categorieSlug: c.slug,
        modeTransaction: c.modeTransaction,
        afficheCatalogue: c.afficheCatalogue,
      );
