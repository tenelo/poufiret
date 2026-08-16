import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_panier.dart';
import 'package:poufiret/global/navigation/app_drawer.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/favoris/screens/ecran_favoris.dart';

class EcranCategories extends ConsumerWidget {
  const EcranCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const CarrouselPublicites(),
          const SizedBox(height: 2),
          Expanded(
            child: categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
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
                // Grille responsive : largeur cible par tuile, le nb de colonnes
                // s'ajuste automatiquement selon la largeur disponible.
                return LayoutBuilder(
                  builder: (context, contraintes) {
                    final largeur = contraintes.maxWidth;
                    // ~180px par tuile : 2 colonnes sur petit tel, plus sur grand écran.
                    final nbColonnes = (largeur / 180).floor().clamp(2, 5);
                    return GridView.builder(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: nbColonnes,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, i) =>
                          _TuileCategorie(categorie: categories[i]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Bouton flottant en eventail : deroule Favoris et Recherche au tap.
///
/// Ferme par defaut : un seul FAB (icone menu). Ouvert : deux mini-boutons
/// apparaissent au-dessus (Favoris, Recherche) avec une animation.
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
          index: 1,
          icone: Icons.favorite,
          label: 'Favoris',
          onTap: () => _ouvrir(const EcranFavoris()),
        ),
        _ActionEventail(
          visible: _ouvert,
          index: 0,
          icone: Icons.search,
          label: 'Rechercher',
          onTap: () => _ouvrir(const EcranRecherche()),
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
