import '../../prestations/screens/ecran_demande_intervention.dart';
import 'package:poufiret/global/config/config.dart';
import 'package:flutter/material.dart';

import '../widgets/prix_promo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_detail.dart';
import 'package:poufiret/fonctionnalites/chat/donnees/chat_providers.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_discussion.dart';
import 'package:poufiret/fonctionnalites/partenaire/screens/ecran_vitrine_partenaire.dart';

import 'package:poufiret/fonctionnalites/social/donnees/social_providers.dart';
import 'package:poufiret/fonctionnalites/social/widgets/bouton_social.dart';
import 'package:poufiret/fonctionnalites/social/widgets/section_commentaires.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/widgets/carrousel_images.dart';

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
                          Notificateur.snackSucces('Ajouté au panier.'),
                        );
                      } catch (_) {
                        messenger.showSnackBar(
                          Notificateur.snackErreur(
                              'Impossible d\'ajouter au panier.'),
                        );
                      }
                      return;
                    }

                    // Mode intervention : ouvrir le formulaire de demande.
                    if (modeTransaction == 'demande_intervention') {
                      if (article.partenaire == null) {
                        messenger.showSnackBar(
                          Notificateur.snackErreur('Prestataire indisponible.'),
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
                        Notificateur.snackErreur(
                          'Impossible de démarrer la conversation.',
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
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CarrouselImages(
                        images: article.images,
                        titre: article.nom,
                        constructeurVide: (_) => _placeholder(theme),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Carte principale : nom, prix, vendeur, reactions ──
                        _CarteSection(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.nom,
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 8),
                              // Prix (+ prix barré si promo) — masqué pour les prestations.
                              if (modeTransaction != 'demande_intervention')
                                PrixPromo(
                                  prixNormal: article.prixNormal,
                                  prixEffectif: article.prixEffectif,
                                  pourcentageReduction:
                                      article.pourcentageReduction,
                                  taillePrix: 22,
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        _Compteur(
                                          icone: Icons.visibility,
                                          valeur: article.nbVues,
                                        ),
                                        BoutonSocial(
                                          actifInitial: article.estLikeParMoi,
                                          totalInitial: article.nbLikes,
                                          iconeActive: Icons.favorite,
                                          iconeInactive:
                                              Icons.favorite_border,
                                          couleurActive: Config.couleurLike,
                                          onToggle: () async {
                                            final res = await ref
                                                .read(socialRepositoryProvider)
                                                .toggleLikeArticle(
                                                    article.id);
                                            return (
                                              actif: res.actif,
                                              total: res.total
                                            );
                                          },
                                        ),
                                        BoutonSocial(
                                          actifInitial:
                                              article.estFavoriParMoi,
                                          totalInitial: article.nbFavoris,
                                          iconeActive: Icons.bookmark,
                                          iconeInactive:
                                              Icons.bookmark_border,
                                          couleurActive: Config.couleurFavori,
                                          afficherTotal: false,
                                          onToggle: () async {
                                            final res = await ref
                                                .read(socialRepositoryProvider)
                                                .toggleFavoriArticle(
                                                    article.id);
                                            return (
                                              actif: res.actif,
                                              total: res.total
                                            );
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
                                                final total = liste.length +
                                                    liste.fold<int>(
                                                      0,
                                                      (s, c) =>
                                                          s + c.reponses.length,
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
                                        messenger.showSnackBar(
                                            Notificateur.snackAvertissement(
                                                'Connexion requise pour discuter.'));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        if (article.description.isNotEmpty)
                          _CarteSection(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description',
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 6),
                                Text(article.description,
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),

                        // Variantes + suppléments regroupés dans une carte.
                        if (article.variantes.isNotEmpty ||
                            article.supplements.isNotEmpty)
                          _CarteSection(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (article.variantes.isNotEmpty) ...[
                                  Text('Options',
                                      style: theme.textTheme.titleMedium),
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
                                if (article.supplements.isNotEmpty) ...[
                                  if (article.variantes.isNotEmpty)
                                    const SizedBox(height: 8),
                                  Text('Suppléments',
                                      style: theme.textTheme.titleMedium),
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
                              ],
                            ),
                          ),

                        _CarteSection(
                          child: SectionCommentaires(articleId: article.id),
                        ),
                        const SizedBox(height: 8),
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

/// Bloc « carte » de la fiche article : fond blanc, coins arrondis, espace
/// genereux, separe du bloc suivant — l'essence du style « feed ».
class _CarteSection extends StatelessWidget {
  const _CarteSection({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      );
}
