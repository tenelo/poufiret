import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/analytics/data/analytics_providers.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/article_liste.dart';
import 'package:poufiret/features/catalogue/screens/ecran_article_detail.dart';
import '../../../core/widgets/image_reseau.dart';
import 'package:poufiret/features/catalogue/widgets/lecteur_video.dart';
import 'package:poufiret/features/catalogue/domain/video_article.dart';

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

    // Onglets Images/Videos uniquement sur la vitrine d'UN partenaire :
    // par categorie (tous partenaires confondus), un onglet Videos
    // melangerait les videos de tout le monde.
    if (partenaireId != null) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(categorieNom),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Images'),
                Tab(text: 'Vidéos'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _OngletArticles(
                categorieId: categorieId,
                partenaireId: partenaireId,
                modeTransaction: modeTransaction,
              ),
              _OngletVideos(partenaireId: partenaireId!),
            ],
          ),
        ),
      );
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

/// Onglet Images : la grille d'articles du partenaire.
class _OngletArticles extends ConsumerWidget {
  const _OngletArticles({
    required this.categorieId,
    required this.partenaireId,
    required this.modeTransaction,
  });

  final int categorieId;
  final int? partenaireId;
  final String modeTransaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(
        articlesProvider(categorieId: categorieId, partenaireId: partenaireId));
    return articlesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) {
        final message =
            err is ApiException ? err.messageLisible : 'Erreur de chargement.';
        return _MessageErreur(
          message: message,
          onReessayer: () => ref.invalidate(articlesProvider(
              categorieId: categorieId, partenaireId: partenaireId)),
        );
      },
      data: (articles) {
        if (articles.isEmpty) {
          return const Center(child: Text('Aucun article pour l\'instant.'));
        }
        return LayoutBuilder(
          builder: (context, contraintes) {
            final nbColonnes = (contraintes.maxWidth / 220).floor().clamp(1, 5);
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: nbColonnes,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
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
    );
  }
}

/// Onglet Videos : les videos de tous les articles du partenaire.
class _OngletVideos extends ConsumerWidget {
  const _OngletVideos({required this.partenaireId});
  final int partenaireId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async =
        ref.watch(videosPartenaireProvider(partenaireId: partenaireId));
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _MessageErreur(
        message: err is ApiException
            ? err.messageLisible
            : 'Erreur de chargement.',
        onReessayer: () => ref
            .invalidate(videosPartenaireProvider(partenaireId: partenaireId)),
      ),
      data: (videos) {
        if (videos.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.videocam_off_outlined,
                      size: 48, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 12),
                  const Text('Aucune vidéo pour le moment.',
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        }
        return LayoutBuilder(
          builder: (context, contraintes) {
            final largeur =
                contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
            return Center(
              child: SizedBox(
                width: largeur,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: videos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final VideoArticle v = videos[i];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LecteurVideo(
                            url: v.video,
                            miniature: v.miniature,
                            titre: v.titre,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v.titre.isNotEmpty ? v.titre : v.articleNom,
                                  style:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                                if (v.articleNom.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(v.articleNom,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
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
                  ? ImageReseau(
                      article.imagePrincipale!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const _PlaceholderImage(),
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
