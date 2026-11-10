import 'package:flutter/material.dart';

import '../../../global/widgets/puces_filtre.dart';
import '../metier_domaine/categorie.dart';
import '../widgets/tuile_categorie.dart';
import 'aiguillage_categorie.dart';
import 'ecran_prestataires.dart';

// Catégorie parente : ses sous-catégories s'affichent selon son réglage
// `affichage_enfants`.
//  - pastilles (défaut) : « Tous | enfant 1 | enfant 2… » au-dessus de
//    l'annuaire, partenaires en grille de 2 colonnes ;
//  - grille : tuiles des sous-catégories ; une tuile ouvre l'annuaire avec
//    les pastilles des sœurs.
// Une sous-catégorie qui a elle-même des enfants suit la même règle.

/// Ouvre l'écran d'une sous-catégorie touchée dans la grille de [parent] :
/// ses propres sous-catégories si elle en a, sinon l'annuaire avec les
/// pastilles de ses sœurs.
void ouvrirSousCategorie(
  BuildContext context,
  Categorie parent,
  Categorie enfant,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => enfant.enfants.isNotEmpty
          ? ecranCategorie(enfant)
          : EcranSousCategories(
              parent: parent,
              initiale: enfant,
              avecTous: false,
            ),
    ),
  );
}

/// Écran d'annuaire à pastilles de sous-catégories (titre : la
/// sous-catégorie choisie, sinon la parente).
class EcranSousCategories extends StatefulWidget {
  const EcranSousCategories({
    super.key,
    required this.parent,
    this.initiale,
    this.avecTous = true,
  });

  final Categorie parent;
  final Categorie? initiale;
  final bool avecTous;

  @override
  State<EcranSousCategories> createState() => _EcranSousCategoriesState();
}

class _EcranSousCategoriesState extends State<EcranSousCategories> {
  late Categorie? _choisie = widget.initiale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text((_choisie ?? widget.parent).nom)),
      body: ContenuSousCategories(
        parent: widget.parent,
        initiale: widget.initiale,
        avecTous: widget.avecTous,
        onChoix: (c) => setState(() => _choisie = c),
      ),
    );
  }
}

/// Pastilles des sous-catégories de [parent] puis l'annuaire : « Tous » =
/// annuaire agrégé ; une pastille = `?sous_categorie=<id>`.
class ContenuSousCategories extends StatefulWidget {
  const ContenuSousCategories({
    super.key,
    required this.parent,
    this.initiale,
    this.avecTous = true,
    this.onChoix,
  });

  final Categorie parent;

  /// Sous-catégorie choisie au départ (null : « Tous »).
  final Categorie? initiale;

  /// Pastille « Tous » (mode pastilles) ; absente pour les sœurs (mode
  /// grille).
  final bool avecTous;
  final ValueChanged<Categorie?>? onChoix;

  @override
  State<ContenuSousCategories> createState() => _ContenuSousCategoriesState();
}

class _ContenuSousCategoriesState extends State<ContenuSousCategories> {
  late Categorie? _choisie = widget.initiale;

  @override
  Widget build(BuildContext context) {
    final parent = widget.parent;
    final choisie = _choisie;
    final c = choisie ?? parent;
    return ContenuPrestataires(
      categorieId: c.id,
      categorieNom: c.nom,
      categorieSlug: parent.slug,
      sousCategorieId: choisie?.id,
      modeTransaction: c.modeTransaction,
      afficheCatalogue: c.afficheCatalogue,
      typesPartenaire: c.typesPartenaireAgreges,
      deuxColonnes: true,
      entete: PucesFiltre<Categorie?>(
        key: const ValueKey('pastilles-sous-categories'),
        options: [
          if (widget.avecTous) (null, 'Tous'),
          for (final e in parent.enfants) (e, e.nom),
        ],
        valeur: choisie,
        onChange: (e) {
          setState(() => _choisie = e);
          widget.onChoix?.call(e);
        },
      ),
    );
  }
}

/// Écran en grille des sous-catégories de [parent].
class EcranGrilleSousCategories extends StatelessWidget {
  const EcranGrilleSousCategories({super.key, required this.parent});

  final Categorie parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parent.nom)),
      body: GrilleSousCategories(parent: parent),
    );
  }
}

/// Grille des sous-catégories de [parent], mêmes tuiles que l'accueil.
class GrilleSousCategories extends StatelessWidget {
  const GrilleSousCategories({super.key, required this.parent});

  final Categorie parent;

  @override
  Widget build(BuildContext context) {
    return GrilleCategories(
      categories: parent.enfants,
      onTap: (enfant) => ouvrirSousCategorie(context, parent, enfant),
    );
  }
}
