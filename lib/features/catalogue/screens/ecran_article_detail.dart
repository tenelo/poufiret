import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/article_detail.dart';

import 'package:poufiret/features/social/data/social_providers.dart';
import 'package:poufiret/features/social/widgets/bouton_social.dart';
import 'package:poufiret/features/social/widgets/section_commentaires.dart';

class EcranArticleDetail extends ConsumerWidget {
  final String slug;
  final String modeTransaction;

  const EcranArticleDetail({
    super.key,
    required this.slug,
    this.modeTransaction = '',
  });

  // Libellé du bouton d'action selon le mode de la catégorie.
  String get _libelleAction {
    switch (modeTransaction) {
      case 'panier_commande':
        return 'Commander';
      case 'demande_intervention':
        return 'Demander une intervention';
      default:
        return 'Contacter';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(articleDetailProvider(slug: slug));

    return Scaffold(
      body: detailAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, _) {
          final message = err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.';
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () =>
                          ref.invalidate(articleDetailProvider(slug: slug)),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        data: (article) =>
            _Contenu(article: article, libelleAction: _libelleAction),
      ),
    );
  }
}

class _Contenu extends ConsumerWidget {
  final ArticleDetail article;
  final String libelleAction;
  const _Contenu({required this.article, required this.libelleAction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(article.nom)),
      // Bouton d'action ancré en bas, toujours visible.
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: article.estDisponible
                ? () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$libelleAction — bientôt disponible'),
                    ),
                  )
                : null,
            child: Text(article.estDisponible ? libelleAction : 'Indisponible'),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          // Sur grand écran, on borne la largeur du contenu pour la lisibilité.
          final largeurMax = contraintes.maxWidth > 700
              ? 700.0
              : double.infinity;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: largeurMax),
              child: ListView(
                children: [
                  // Image principale ou placeholder.
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: article.images.isNotEmpty
                        ? Image.network(
                            article.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _placeholder(theme),
                          )
                        : _placeholder(theme),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.nom, style: theme.textTheme.headlineSmall),
                        const SizedBox(height: 8),
                        // Prix (+ prix barré si promo).
                        Row(
                          children: [
                            Text(
                              '${article.prixEffectif.toStringAsFixed(0)} FCFA',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (article.estEnPromotion) ...[
                              const SizedBox(width: 8),
                              Text(
                                '${article.prix} FCFA',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vendu par ${article.partenaireNom}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        // Compteurs.
                        // Réactions : like ❤️ et favori 🔖 cliquables ;
                        // vues et commentaires en simple affichage.
                        Wrap(
                          spacing: 16,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _Compteur(
                              icone: Icons.visibility,
                              valeur: article.nbVues,
                            ),
                            BoutonSocial(
                              actifInitial: article.estLikeParMoi,
                              totalInitial: article.nbLikes,
                              iconeActive: Icons.favorite,
                              iconeInactive: Icons.favorite_border,
                              couleurActive: Colors.red,
                              onToggle: () async {
                                final res = await ref
                                    .read(socialRepositoryProvider)
                                    .toggleLikeArticle(article.id);
                                return (actif: res.actif, total: res.total);
                              },
                            ),
                            BoutonSocial(
                              actifInitial: article.estFavoriParMoi,
                              totalInitial: article.nbFavoris,
                              iconeActive: Icons.bookmark,
                              iconeInactive: Icons.bookmark_border,
                              couleurActive: Colors.brown,
                              afficherTotal: false,
                              onToggle: () async {
                                final res = await ref
                                    .read(socialRepositoryProvider)
                                    .toggleFavoriArticle(article.id);
                                return (actif: res.actif, total: res.total);
                              },
                            ),
                            // Compteur de commentaires calculé depuis la liste réelle.
                            ref
                                .watch(
                                  commentairesArticleProvider(
                                    articleId: article.id,
                                  ),
                                )
                                .maybeWhen(
                                  data: (liste) {
                                    final total =
                                        liste.length +
                                        liste.fold<int>(
                                          0,
                                          (s, c) => s + c.reponses.length,
                                        );
                                    return _Compteur(
                                      icone: Icons.comment,
                                      valeur: total,
                                    );
                                  },
                                  orElse: () => const _Compteur(
                                    icone: Icons.comment,
                                    valeur: 0,
                                  ),
                                ),
                          ],
                        ),
                        if (article.description.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Description',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(article.description),
                        ],
                        // Variantes.
                        if (article.variantes.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text('Options', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          ...article.variantes.map(
                            (v) => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(v.nom),
                              trailing: Text(
                                '+${v.supplement.toStringAsFixed(0)} FCFA',
                              ),
                            ),
                          ),
                        ],
                        // Suppléments.
                        if (article.supplements.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Suppléments',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          ...article.supplements.map(
                            (s) => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(s.nom),
                              trailing: Text(
                                '+${s.montant.toStringAsFixed(0)} FCFA',
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        SectionCommentaires(articleId: article.id),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _placeholder(ThemeData theme) => Container(
    color: theme.colorScheme.surfaceContainerHighest,
    child: Icon(
      Icons.image_outlined,
      size: 64,
      color: theme.colorScheme.outline,
    ),
  );
}

class _Compteur extends StatelessWidget {
  final IconData icone;
  final int valeur;
  const _Compteur({required this.icone, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 16, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 4),
        Text('$valeur'),
      ],
    );
  }
}
