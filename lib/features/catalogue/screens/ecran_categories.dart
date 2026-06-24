import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/categorie.dart';

class EcranCategories extends ConsumerWidget {
  const EcranCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Poufiret')),
      body: categoriesAsync.when(
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
    );
  }
}

class _TuileCategorie extends StatelessWidget {
  final Categorie categorie;
  const _TuileCategorie({required this.categorie});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Étape suivante : naviguer vers la liste d'articles de la catégorie.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Catégorie : ${categorie.nom}')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  categorie.icone.isNotEmpty ? categorie.icone : '📦',
                  style: const TextStyle(fontSize: 48),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categorie.nom,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
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
