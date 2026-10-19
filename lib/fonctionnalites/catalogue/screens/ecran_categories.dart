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
import 'package:poufiret/global/widgets/image_reseau.dart';
import 'package:poufiret/global/widgets/texte_defilant.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_panier.dart';
import 'package:poufiret/global/navigation/app_drawer.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/favoris/screens/ecran_favoris.dart';

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
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const EcranPanier())),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: const _BoutonRecherche(),
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
                final toutes = categories.feuilles;
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
                            return _GrilleCategories(
                              categories: toutes,
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

/// Grille responsive de tuiles : le nombre de colonnes s'ajuste selon la
/// largeur disponible (~180 px par tuile).
class _GrilleCategories extends StatelessWidget {
  const _GrilleCategories({required this.categories, required this.onRefresh});
  final List<Categorie> categories;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        final nbColonnes = (contraintes.maxWidth / 180).floor().clamp(2, 5);
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: nbColonnes,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) =>
                _TuileCategorie(categorie: categories[i], rang: i),
          ),
        );
      },
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

/// Bouton flottant en eventail : deroule Favoris au tap.
///
/// Ferme par defaut : un seul FAB. Ouvert : un mini-bouton (Favoris)
/// apparait au-dessus avec une animation. La recherche a ete deplacee dans
/// la barre [_BarreRecherche].
class _BoutonRecherche extends StatefulWidget {
  const _BoutonRecherche();
  @override
  State<_BoutonRecherche> createState() => _BoutonRechercheState();
}

class _BoutonRechercheState extends State<_BoutonRecherche> {
  bool _ouvert = false;

  void _basculer() => setState(() => _ouvert = !_ouvert);

  void _ouvrir(Widget ecran) {
    setState(() => _ouvert = false);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ecran));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _ActionEventail(
          visible: _ouvert,
          index: 0,
          icone: Icons.favorite,
          label: 'Favoris',
          onTap: () => _ouvrir(const EcranFavoris()),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 45,
          height: 45,
          child: FloatingActionButton(
            onPressed: _basculer,
            tooltip: _ouvert ? 'Fermer' : 'Actions',
            child: AnimatedRotation(
              turns: _ouvert ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(_ouvert ? Icons.close : Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

/// Une action de l'eventail : mini-bouton + etiquette, anime en apparition.
class _ActionEventail extends StatelessWidget {
  const _ActionEventail({
    required this.visible,
    required this.index,
    required this.icone,
    required this.label,
    required this.onTap,
  });
  final bool visible;
  final int index;
  final IconData icone;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 0.3),
      duration: Duration(milliseconds: 180 + index * 40),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(milliseconds: 180 + index * 40),
        child: IgnorePointer(
          ignoring: !visible,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: theme.colorScheme.surface,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(label, style: theme.textTheme.labelLarge),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton.small(
                  heroTag: 'fab_$label',
                  onPressed: onTap,
                  child: Icon(icone),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Tuile « Explorer » : fond pastel (bleu, vert, ambre, sarcelle en
/// rotation selon [rang]), emoji ou image en haut, nom en bas à gauche.
class _TuileCategorie extends StatelessWidget {
  final Categorie categorie;
  final int rang;
  const _TuileCategorie({required this.categorie, required this.rang});

  /// Grisée si désactivée par l'admin OU si aucun partenaire enregistré.
  bool get _bientot =>
      !categorie.estActive ||
      (categorie.nbPartenaires != null && categorie.nbPartenaires == 0);

  @override
  Widget build(BuildContext context) {
    final bientot = _bientot;
    final image = categorie.imageTuile;
    final pastels = Config.pastels;
    final (fond, encre) = pastels[rang % pastels.length];
    final emoji = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topLeft,
      child: Text(
        categorie.icone.isNotEmpty ? categorie.icone : '📦',
        style: const TextStyle(fontSize: 60, height: 1),
      ),
    );
    return Material(
      color: fond,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: bientot
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ecranCategorie(categorie)),
                );
              },
        child: Opacity(
          opacity: bientot ? 0.45 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image.isEmpty)
                  Expanded(child: emoji)
                else
                  // Image reelle : elle remplit la zone visuelle. L'emoji
                  // la remplace pendant le chargement et en cas d'erreur.
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: LayoutBuilder(
                        builder: (context, contraintes) => ImageReseau(
                          image,
                          fit: BoxFit.cover,
                          width: contraintes.maxWidth,
                          height: contraintes.maxHeight,
                          largeurAffichee: contraintes.maxWidth,
                          attente: categorie.icone.isNotEmpty
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  child: emoji,
                                )
                              : const SizedBox.shrink(),
                          errorBuilder: (_, _, _) =>
                              Align(alignment: Alignment.topLeft, child: emoji),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Text(
                  categorie.nom,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: encre,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
                if (bientot)
                  Text(
                    'Bientôt disponible',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: encre.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
        ),
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
