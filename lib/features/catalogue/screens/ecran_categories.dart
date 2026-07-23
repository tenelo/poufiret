import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/categorie.dart';
import 'package:poufiret/features/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/features/orders/screens/ecran_panier.dart';
import 'package:poufiret/core/navigation/app_drawer.dart';
import 'package:poufiret/features/orders/data/orders_providers.dart';
import 'package:poufiret/features/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/features/catalogue/screens/ecran_recherche.dart';

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
          const SizedBox(height: 12),
          const CarrouselPublicites(),
          const SizedBox(height: 12),
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
                padding: const EdgeInsets.all(16),
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

/// Bouton flottant de recherche : ouvre l'ecran Recherche au tap.
class _BoutonRecherche extends StatelessWidget {
  const _BoutonRecherche();

  @override
  Widget build(BuildContext context) {
    // Etendu sur grand ecran (place disponible), compact sur mobile.
    final large = MediaQuery.sizeOf(context).width >= 600;
    void ouvrir() => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EcranRecherche()),
        );

    if (large) {
      return FloatingActionButton.extended(
        onPressed: ouvrir,
        icon: const Icon(Icons.search),
        label: const Text('Rechercher'),
        tooltip: 'Rechercher sur Poufiret',
      );
    }
    return FloatingActionButton(
      onPressed: ouvrir,
      tooltip: 'Rechercher sur Poufiret',
      child: const Icon(Icons.search),
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
