import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/ui/squelette.dart';
import '../donnees/catalogue_providers.dart';
import '../metier_domaine/categorie.dart';
import '../metier_domaine/resultats_recherche.dart';
import 'ecran_prestataires.dart';

// Toutes les catégories s'affichent de la même façon : l'annuaire (filtre
// de localités + grille des partenaires). Les types de partenaire de la
// catégorie lui sont transmis ; ils ne changent que l'écran ouvert par une
// tuile.

/// Écran complet d'une catégorie (ouvert depuis la grille ou la recherche).
Widget ecranCategorie(Categorie c) => EcranPrestataires(
  categorieId: c.id,
  categorieNom: c.nom,
  categorieSlug: c.slug,
  modeTransaction: c.modeTransaction,
  afficheCatalogue: c.afficheCatalogue,
  typesPartenaire: c.typesPartenaire,
);

/// Contenu d'une catégorie sans barre ni Scaffold (onglet de l'accueil).
Widget contenuCategorie(Categorie c) => ContenuPrestataires(
  key: ValueKey('onglet_${c.id}'),
  categorieId: c.id,
  categorieNom: c.nom,
  categorieSlug: c.slug,
  modeTransaction: c.modeTransaction,
  afficheCatalogue: c.afficheCatalogue,
  typesPartenaire: c.typesPartenaire,
);

/// Écran d'une catégorie connue par un résultat de recherche. La recherche
/// ne donne pas les types de partenaire : la catégorie complète est relue
/// dans la liste des catégories, et l'écran attend cette liste (squelette)
/// pour savoir quoi ouvrir au toucher d'une tuile.
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
    // Catégorie absente de la liste, ou liste indisponible : l'annuaire,
    // avec ce que la recherche en sait.
    return EcranPrestataires(
      categorieId: categorie.id,
      categorieNom: categorie.nom,
      categorieSlug: categorie.slug,
      modeTransaction: categorie.modeTransaction,
      afficheCatalogue: categorie.afficheCatalogue,
    );
  }
}
