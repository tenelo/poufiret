import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/ui/squelette.dart';
import '../../restaurants/metier_domaine/types_restauration.dart';
import '../../restaurants/screens/ecran_restaurants.dart';
import '../donnees/catalogue_providers.dart';
import '../metier_domaine/categorie.dart';
import '../metier_domaine/resultats_recherche.dart';
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

/// Écran d'une catégorie connue par un résultat de recherche. La recherche
/// ne donne pas les types de partenaire : la catégorie complète est relue
/// dans la liste des catégories, et l'écran ATTEND cette liste (squelette)
/// au lieu d'ouvrir l'annuaire générique par défaut.
class EcranCategorieTrouvee extends ConsumerWidget {
  const EcranCategorieTrouvee({super.key, required this.categorie});

  final CategorieTrouvee categorie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final complete = categories.value?.feuilles
        .where((c) => c.id == categorie.id)
        .firstOrNull;
    if (complete != null) return ecranCategorie(complete);
    if (categories.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(categorie.nom)),
        body: const SqueletteListePartenaires(),
      );
    }
    // Catégorie absente de la liste, ou liste indisponible : annuaire
    // générique, avec ce que la recherche en sait.
    return EcranPrestataires(
      categorieId: categorie.id,
      categorieNom: categorie.nom,
      categorieSlug: categorie.slug,
      modeTransaction: categorie.modeTransaction,
      afficheCatalogue: categorie.afficheCatalogue,
    );
  }
}
