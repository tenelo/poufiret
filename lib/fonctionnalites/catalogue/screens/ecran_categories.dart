import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/cache/contexte_cache.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/squelette.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/aiguillage_categorie.dart';
import 'package:poufiret/global/config/config.dart';
import 'package:poufiret/global/widgets/barre_onglets.dart';
import 'package:poufiret/fonctionnalites/catalogue/widgets/tuile_categorie.dart';
import 'package:poufiret/global/widgets/texte_defilant.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_panier.dart';
import 'package:poufiret/global/navigation/app_drawer.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/grid_mode.dart';

class EcranCategories extends ConsumerStatefulWidget {
  const EcranCategories({super.key});

  @override
  ConsumerState<EcranCategories> createState() => _EcranCategoriesState();
}

class _EcranCategoriesState extends ConsumerState<EcranCategories> {
  /// Onglet courant : 0 = « Tous », puis une catégorie non grisée par onglet.
  int _index = 0;
  final _pages = PageController();

  /// Vrai pendant une animation déclenchée par un tap sur un onglet : évite
  /// que les pages traversées fassent « sauter » la sélection.
  bool _defilementParTap = false;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _allerA(int index) async {
    setState(() => _index = index);
    _defilementParTap = true;
    await _pages.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    _defilementParTap = false;
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final modeGrille = ref.watch(modeGrilleProvider);
    // Nombre d'articles dans tous les paniers, pour le badge.
    final nbPanier = ref
        .watch(paniersProvider)
        .maybeWhen(
          data: (paniers) =>
              paniers.fold<int>(0, (n, p) => n + p.lignes.length),
          orElse: () => 0,
        );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        leadingWidth: 70,
        leading: Builder(
          builder: (context) => Center(
            child: _BoutonCarre(
              icone: Icons.menu_rounded,
              tooltip: 'Menu',
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: const Text('Poufiret'),
        actions: [
          _BoutonCarre(
            icone: Icons.shopping_cart_outlined,
            tooltip: 'Mon panier',
            badge: nbPanier,
            onTap: () => ouvrirPanier(context),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: const _BoutonModeGrille(),
      body: Column(
        children: [
          const _BarreRecherche(),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(26)),
              child: CarrouselPublicites(),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: categoriesAsync.when(
              // Rechargement (tirer pour rafraichir, reessayer) : la grille
              // reste affichee, pas de retour au squelette.
              skipLoadingOnReload: true,
              loading: () => const SqueletteGrille(),
              error: (err, _) {
                final message = err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.';
                return _MessageErreur(
                  message: message,
                  onReessayer: () => ref.invalidate(categoriesProvider),
                );
              },
              data: (categories) {
                if (categories.isEmpty) {
                  return const Center(
                    child: Text('Aucune catégorie pour le moment.'),
                  );
                }
                // « Tous » = toutes les catégories (les vides restent
                // grisées). Les autres onglets = uniquement les catégories
                // NON grisées (actives avec au moins un partenaire).
                // Catégories racines : une parente ouvre ses
                // sous-catégories (pastilles ou grille).
                final toutes = categories;
                final actives = toutes.where((c) => c.aDesPartenaires).toList();
                final nbOnglets = actives.length + 1;
                final index = _index.clamp(0, nbOnglets - 1);
                return Column(
                  children: [
                    if (actives.isNotEmpty) ...[
                      BarreOnglets(
                        libelles: ['Tous', ...actives.map((c) => c.nom)],
                        selectionIndex: index,
                        onChoisir: _allerA,
                      ),
                      const SizedBox(height: 8),
                    ],
                    // Glisser à gauche/droite change d'onglet.
                    Expanded(
                      child: PageView.builder(
                        controller: _pages,
                        itemCount: nbOnglets,
                        onPageChanged: (i) {
                          if (_defilementParTap) return;
                          setState(() => _index = i);
                        },
                        // « Tous » : la grille du menu principal. Un onglet de
                        // categorie : directement son contenu (l'annuaire),
                        // pas une grille a un seul element.
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return GrilleCategories(
                              categories: toutes,
                              avecImages: modeGrille == ModeGrille.images,
                              onTap: (c) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ecranCategorie(c),
                                ),
                              ),
                              onRefresh: () =>
                                  rafraichir(ref, categoriesProvider),
                            );
                          }
                          return contenuCategorie(actives[i - 1]);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Barre de recherche de l'accueil, sous le carrousel. Purement visuelle :
/// un tap ouvre l'écran de recherche existant ([EcranRecherche]).
class _BarreRecherche extends StatelessWidget {
  const _BarreRecherche();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void ouvrir() => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EcranRecherche()));

    final forme = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: Config.ombre,
        ),
        child: Material(
          color: theme.colorScheme.surface,
          shape: forme,
          child: InkWell(
            customBorder: forme,
            onTap: ouvrir,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    // L'invite defile si elle ne tient pas en entier.
                    child: TexteDefilant(
                      'Un plat, une pharmacie, une boutique…',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bouton flottant : bascule la grille des catégories entre images et
/// icônes (choix mémorisé sur l'appareil). Son icône montre le mode vers
/// lequel on bascule.
class _BoutonModeGrille extends ConsumerWidget {
  const _BoutonModeGrille();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enImages = ref.watch(modeGrilleProvider) == ModeGrille.images;
    final libelle = enImages
        ? 'Afficher les icônes des catégories'
        : 'Afficher les images des catégories';
    return SizedBox(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        onPressed: () => ref.read(modeGrilleProvider.notifier).basculer(),
        tooltip: libelle,
        // L'infobulle sert aussi de libellé d'accessibilité.
        child: Icon(enImages ? Icons.grid_view_rounded : Icons.image_outlined),
      ),
    );
  }
}

/// Bouton carré arrondi de la barre du haut (menu, panier) : surface,
/// ombre douce, pastille soleil pour un compteur.
class _BoutonCarre extends StatelessWidget {
  const _BoutonCarre({
    required this.icone,
    required this.tooltip,
    required this.onTap,
    this.badge = 0,
  });

  final IconData icone;
  final String tooltip;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    final forme = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    final bouton = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: Config.ombre,
      ),
      child: Material(
        color: Config.couleurSurface,
        shape: forme,
        child: InkWell(
          customBorder: forme,
          onTap: onTap,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(icone, size: 21, color: Config.couleurTexte),
          ),
        ),
      ),
    );
    return Tooltip(
      message: tooltip,
      child: badge > 0
          ? Badge(
              label: Text('$badge'),
              offset: const Offset(4, -4),
              child: bouton,
            )
          : bouton,
    );
  }
}

class _MessageErreur extends StatelessWidget {
  final String message;
  final VoidCallback onReessayer;
  const _MessageErreur({required this.message, required this.onReessayer});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onReessayer,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
