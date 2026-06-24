import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/article_liste.dart';
import 'package:poufiret/features/catalogue/screens/ecran_article_detail.dart';

class EcranArticles extends ConsumerWidget {
  final int categorieId;
  final String categorieNom;

  const EcranArticles({
    super.key,
    required this.categorieId,
    required this.categorieNom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider(categorieId: categorieId));

    return Scaffold(
      appBar: AppBar(title: Text(categorieNom)),
      body: articlesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final message = err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.';
          return _MessageErreur(
            message: message,
            onReessayer: () =>
                ref.invalidate(articlesProvider(categorieId: categorieId)),
          );
        },
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(
              child: Text('Aucun article dans cette catégorie.'),
            );
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth;
              // ~220px par vignette d'article (un peu plus large qu'une catégorie).
              final nbColonnes = (largeur / 220).floor().clamp(1, 5);
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: nbColonnes,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75, // vignette plus haute que large
                ),
                itemCount: articles.length,
                itemBuilder: (context, i) =>
                    _VignetteArticle(article: articles[i]),
              );
            },
          );
        },
      ),
    );
  }
}

class _VignetteArticle extends StatelessWidget {
  final ArticleListe article;
  const _VignetteArticle({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EcranArticleDetail(slug: article.slug),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Zone image : photo si dispo, sinon placeholder.
            Expanded(
              child: article.imagePrincipale != null
                  ? Image.network(
                      article.imagePrincipale!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _PlaceholderImage(),
                    )
                  : const _PlaceholderImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    article.nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${article.prixEffectif.toStringAsFixed(0)} FCFA',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_outlined,
        size: 48,
        color: Theme.of(context).colorScheme.outline,
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
