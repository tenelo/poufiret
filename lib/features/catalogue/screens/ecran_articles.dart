import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/analytics/data/analytics_providers.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/article_liste.dart';
import 'package:poufiret/features/catalogue/screens/ecran_article_detail.dart';

class EcranArticles extends ConsumerWidget {
  final int categorieId;
  final String categorieNom;
  final String modeTransaction;
  final int? partenaireId;
  const EcranArticles({
    super.key,
    required this.categorieId,
    required this.categorieNom,
    this.modeTransaction = '',
    this.partenaireId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider(categorieId: categorieId, partenaireId: partenaireId));
    // Ouverture du catalogue d un partenaire = une vue catalogue.
    if (partenaireId != null) {
      ref.watch(vueVitrineProvider(
          partenaireId: partenaireId!, source: 'annuaire'));
    }

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
                ref.invalidate(articlesProvider(categorieId: categorieId, partenaireId: partenaireId)),
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
                itemBuilder: (context, i) => _VignetteArticle(
                  article: articles[i],
                  modeTransaction: modeTransaction,
                ),
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
  final String modeTransaction;
  const _VignetteArticle({
    required this.article,
    required this.modeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EcranArticleDetail(
                slug: article.slug,
                modeTransaction: modeTransaction,
              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (modeTransaction != 'demande_intervention')
                        Flexible(
                          child: Text(
                            '${article.prixEffectif.toStringAsFixed(0)} FCFA',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Voir détails',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 11,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
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
