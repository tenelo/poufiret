import '../../prestations/screens/ecran_demande_intervention.dart';
import 'package:poufiret/core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/analytics/data/analytics_providers.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/article_detail.dart';
import 'package:poufiret/features/chat/data/chat_providers.dart';
import 'package:poufiret/features/chat/screens/ecran_discussion.dart';
import 'package:poufiret/features/partenaire/screens/ecran_vitrine_partenaire.dart';

import 'package:poufiret/features/social/data/social_providers.dart';
import 'package:poufiret/features/social/widgets/bouton_social.dart';
import 'package:poufiret/features/social/widgets/section_commentaires.dart';
import 'package:poufiret/features/orders/data/orders_providers.dart';
import '../../../core/widgets/carrousel_images.dart';

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
    // Enregistre la consultation (alimente stats partenaire et profil de navigation).
    ref.watch(vueArticleProvider(slug: slug));

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
        data: (article) => _Contenu(
          article: article,
          libelleAction: _libelleAction,
          modeTransaction: modeTransaction,
        ),
      ),
    );
  }
}

class _Contenu extends ConsumerWidget {
  final ArticleDetail article;
  final String libelleAction;
  final String modeTransaction;
  const _Contenu({
    required this.article,
    required this.libelleAction,
    required this.modeTransaction,
  });

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
                ? () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);

                    // Mode panier : ajouter au panier, rester sur la fiche.
                    if (modeTransaction == 'panier_commande') {
                      try {
                        await ref
                            .read(ordersRepositoryProvider)
                            .ajouterLigne(articleId: article.id, quantite: 1);
                        ref.invalidate(paniersProvider);
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Ajouté au panier.')),
                        );
                      } catch (_) {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Impossible d\'ajouter au panier.'),
                          ),
                        );
                      }
                      return;
                    }

                    // Mode intervention : ouvrir le formulaire de demande.
                    if (modeTransaction == 'demande_intervention') {
                      if (article.partenaire == null) {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Prestataire indisponible.'),
                          ),
                        );
                        return;
                      }
                      navigator.push(
                        MaterialPageRoute(
                          builder: (_) => EcranDemandeIntervention(
                            artisanId: article.partenaire!,
                            artisanNom: article.partenaireNom,
                          ),
                        ),
                      );
                      return;
                    }
                    // Autres modes : ouvrir la conversation (chat).
                    try {
                      final conv = await ref
                          .read(chatRepositoryProvider)
                          .contacter(articleId: article.id);
                      navigator.push(
                        MaterialPageRoute(
                          builder: (_) => EcranDiscussion(
                            conversationId: conv.id,
                            titre: conv.partenaireNom.isEmpty
                                ? 'Conversation'
                                : conv.partenaireNom,
                          ),
                        ),
                      );
                    } catch (_) {
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Impossible de démarrer la conversation.',
                          ),
                        ),
                      );
                    }
                  }
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
                  // Images : carrousel automatique s'il y en a
                  // plusieurs, sinon simple photo. Le clic ouvre la
                  // visionneuse zoomable sur l'image courante.
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CarrouselImages(
                      images: article.images,
                      titre: article.nom,
                      constructeurVide: (_) => _placeholder(theme),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.nom, style: theme.textTheme.headlineSmall),
                        const SizedBox(height: 8),
                        // Prix (+ prix barré si promo) — masqué pour les prestations.
                        if (modeTransaction != 'demande_intervention')
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
                        if (article.partenaire != null)
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EcranVitrinePartenaire(
                                  partenaireId: article.partenaire!,
                                ),
                              ),
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Vendu par '),
                                  TextSpan(
                                    text: article.partenaireNom,
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        else
                          Text(
                            'Vendu par ${article.partenaireNom}',
                            style: theme.textTheme.bodyMedium,
                          ),
                        const SizedBox(height: 16),
                        // Compteurs.
                        // Réactions : like ❤️ et favori 🔖 cliquables ;
                        // vues et commentaires en simple affichage.
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Wrap(
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
                              couleurActive: Config.couleurLike,
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
                              couleurActive: Config.couleurFavori,
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
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.whatsapp,
                                  color: theme.colorScheme.primary),
                              tooltip: 'Discuter',
                              onPressed: () async {
                                final messenger =
                                    ScaffoldMessenger.of(context);
                                final navigator = Navigator.of(context);
                                try {
                                  final conv = await ref
                                      .read(chatRepositoryProvider)
                                      .contacter(articleId: article.id);
                                  navigator.push(
                                    MaterialPageRoute(
                                      builder: (_) => EcranDiscussion(
                                        conversationId: conv.id,
                                        titre: conv.partenaireNom.isEmpty
                                            ? 'Conversation'
                                            : conv.partenaireNom,
                                      ),
                                    ),
                                  );
                                } catch (_) {
                                  messenger.showSnackBar(const SnackBar(
                                      content: Text(
                                          'Connexion requise pour discuter.')));
                                }
                              },
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
