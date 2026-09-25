import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/cache/contexte_cache.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/squelette.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
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
        title: const Text('Poufiret'),
        actions: [
          IconButton(
            icon: nbPanier > 0
                ? Badge(
                    label: Text('$nbPanier'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  )
                : const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Mon panier',
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const EcranPanier())),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: const _BoutonRecherche(),
      body: Column(
        children: [
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: CarrouselPublicites(),
            ),
          ),
          const SizedBox(height: 8),
          const _BarreRecherche(),
          const SizedBox(height: 8),
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
                      _BarreOnglets(
                        categories: actives,
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
                          final c = actives[i - 1];
                          return ContenuPrestataires(
                            key: ValueKey('onglet_${c.id}'),
                            categorieId: c.id,
                            categorieNom: c.nom,
                            categorieSlug: c.slug,
                            modeTransaction: c.modeTransaction,
                            afficheCatalogue: c.afficheCatalogue,
                          );
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

/// Barre d'onglets horizontale : « Tous » + un onglet par catégorie non
/// grisée. L'onglet actif est en couleur d'accent avec un court trait
/// dessous ; les autres sont en gris.
class _BarreOnglets extends StatefulWidget {
  const _BarreOnglets({
    required this.categories,
    required this.selectionIndex,
    required this.onChoisir,
  });

  final List<Categorie> categories;

  /// 0 = « Tous », puis 1..n = categories[index - 1].
  final int selectionIndex;
  final ValueChanged<int> onChoisir;

  @override
  State<_BarreOnglets> createState() => _BarreOngletsState();
}

class _BarreOngletsState extends State<_BarreOnglets> {
  final _cles = <int, GlobalKey>{};

  GlobalKey _cle(int i) => _cles.putIfAbsent(i, GlobalKey.new);

  @override
  void didUpdateWidget(_BarreOnglets ancien) {
    super.didUpdateWidget(ancien);
    // Quand on glisse la grille, l'onglet actif doit rester visible.
    if (ancien.selectionIndex != widget.selectionIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _cle(widget.selectionIndex).currentContext;
        if (ctx == null) return;
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.5,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final libelles = ['Tous', ...widget.categories.map((c) => c.nom)];
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (var i = 0; i < libelles.length; i++)
            _Onglet(
              key: _cle(i),
              libelle: libelles[i],
              actif: widget.selectionIndex == i,
              onTap: () => widget.onChoisir(i),
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: nbColonnes,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) =>
                _TuileCategorie(categorie: categories[i]),
          ),
        );
      },
    );
  }
}

class _Onglet extends StatelessWidget {
  const _Onglet({
    super.key,
    required this.libelle,
    required this.actif,
    required this.onTap,
  });

  final String libelle;
  final bool actif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur = actif
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              libelle,
              style: theme.textTheme.titleSmall?.copyWith(
                color: couleur,
                fontWeight: actif ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: 28,
              decoration: BoxDecoration(
                color: actif ? theme.colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: theme.colorScheme.surface,
        shape: StadiumBorder(
          side: BorderSide(color: theme.colorScheme.outline),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: ouvrir,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 2, 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Que recherchez-vous ? (ex: pharmacie, restaurant…)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  //backgroundColor: theme.colorScheme.primary,
                  child: Icon(Icons.search, size: 20, color: Colors.white),
                ),
              ],
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

class _TuileCategorie extends StatelessWidget {
  final Categorie categorie;
  const _TuileCategorie({required this.categorie});

  /// Grisée si désactivée par l'admin OU si aucun partenaire enregistré.
  bool get _bientot =>
      !categorie.estActive ||
      (categorie.nbPartenaires != null && categorie.nbPartenaires == 0);

  @override
  Widget build(BuildContext context) {
    final bientot = _bientot;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: bientot
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EcranPrestataires(
                      categorieId: categorie.id,
                      categorieNom: categorie.nom,
                      categorieSlug: categorie.slug,
                      modeTransaction: categorie.modeTransaction,
                      afficheCatalogue: categorie.afficheCatalogue,
                    ),
                  ),
                );
              },
        child: Opacity(
          opacity: bientot ? 0.45 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      categorie.icone.isNotEmpty ? categorie.icone : '📦',
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  bientot
                      ? '${categorie.nom}\nBientôt disponible'
                      : categorie.nom,
                  textAlign: TextAlign.center,
                  maxLines: bientot ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
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
