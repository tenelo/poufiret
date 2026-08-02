import 'package:flutter/material.dart';
import 'package:poufiret/core/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poufiret/features/analytics/data/analytics_providers.dart';
import 'package:poufiret/features/social/data/social_providers.dart';
import 'package:poufiret/features/social/widgets/bouton_social.dart';
import 'package:poufiret/features/social/widgets/section_commentaires.dart';
import 'package:poufiret/features/chat/data/chat_providers.dart';
import 'package:poufiret/features/chat/screens/ecran_discussion.dart';
import 'package:poufiret/features/prestations/screens/ecran_demande_intervention.dart';

import '../data/partenaire_providers.dart';
import '../domain/partenaire_vitrine.dart';
import '../../../core/widgets/image_reseau.dart';

/// Vitrine publique d'un partenaire (côté client).
/// Affiche couverture, logo, infos, localisation, contacts.
class EcranVitrinePartenaire extends ConsumerWidget {
  const EcranVitrinePartenaire({
    super.key,
    required this.partenaireId,
    this.modeTransaction = '',
  });

  /// Mode de la categorie d'ou vient le client : determine l'action principale.
  final String modeTransaction;

  final int partenaireId;

  /// Vrai si la categorie d'origine fonctionne par demande d'intervention
  /// (plomberie, electricite, maconnerie, mecanique...).
  bool get _estIntervention => modeTransaction == 'demande_intervention';

  /// Demande d'intervention pour les metiers de service, chat sinon.
  Future<void> _actionPrincipale(
      BuildContext context, WidgetRef ref, PartenaireVitrine p) async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (_estIntervention) {
      nav.push(MaterialPageRoute(
        builder: (_) => EcranDemandeIntervention(
          artisanId: partenaireId,
          artisanNom: p.nomCommerce,
        ),
      ));
      return;
    }
    try {
      final conv = await ref
          .read(chatRepositoryProvider)
          .contacter(partenaireId: partenaireId);
      nav.push(MaterialPageRoute(
        builder: (_) => EcranDiscussion(
          conversationId: conv.id,
          titre: p.nomCommerce,
        ),
      ));
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Connexion requise pour discuter.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(partenaireVitrineProvider(id: partenaireId));
    // Une ouverture de fiche = une vue de vitrine.
    ref.watch(vueVitrineProvider(partenaireId: partenaireId, avecCatalogue: false));

    return Scaffold(
      body: async.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Erreur(
          onRetry: () => ref.invalidate(
              partenaireVitrineProvider(id: partenaireId)),
        ),
        data: (p) => _Contenu(partenaire: p),
      ),
      bottomNavigationBar: async.maybeWhen(
        data: (p) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton.icon(
              onPressed: () => _actionPrincipale(context, ref, p),
              icon: Icon(_estIntervention
                  ? Icons.handyman_outlined
                  : Icons.chat_bubble_outline),
              label: Text(_estIntervention
                  ? 'Demande d\'intervention'
                  : 'Contacter'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ),
        ),
        orElse: () => null,
      ),
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu({required this.partenaire});
  final PartenaireVitrine partenaire;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Contenu plafonné sur grand écran, comme le reste de l'app.
        final maxWidth =
            constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: _Couverture(partenaire: partenaire, theme: theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _Infos(partenaire: partenaire, theme: theme),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Couverture extends StatelessWidget {
  const _Couverture({required this.partenaire, required this.theme});
  final PartenaireVitrine partenaire;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final couv = partenaire.photoCouverture;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (couv != null && couv.isNotEmpty)
          ImageReseau(
            couv,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: theme.colorScheme.surfaceContainerHighest),
          )
        else
          Container(color: theme.colorScheme.surfaceContainerHighest),
        // Voile sombre pour lisibilité du logo/titre.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54],
            ),
          ),
        ),
      ],
    );
  }
}

class _Infos extends ConsumerWidget {
  const _Infos({required this.partenaire, required this.theme});
  final PartenaireVitrine partenaire;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = partenaire;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête : logo + nom + type.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Logo(logo: p.logo, theme: theme),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.nomCommerce,
                      style: theme.textTheme.headlineSmall),
                  if (p.typeLibelle.isNotEmpty)
                    Text(p.typeLibelle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Stats sociales.
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Compteur(icone: Icons.visibility, valeur: p.nbVues),
            const SizedBox(width: 16),
            BoutonSocial(
              actifInitial: p.estLikeParMoi,
              totalInitial: p.nombreLikes,
              iconeActive: Icons.favorite,
              iconeInactive: Icons.favorite_border,
              couleurActive: Config.couleurLike,
              onToggle: () async {
                final res = await ref
                    .read(socialRepositoryProvider)
                    .toggleLikePartenaire(p.id);
                return (actif: res.actif, total: res.total);
              },
            ),
            BoutonSocial(
              actifInitial: p.estFavoriParMoi,
              totalInitial: 0,
              iconeActive: Icons.bookmark,
              iconeInactive: Icons.bookmark_border,
              couleurActive: Config.couleurFavori,
              afficherTotal: false,
              onToggle: () async {
                final res = await ref
                    .read(socialRepositoryProvider)
                    .toggleFavoriPartenaire(p.id);
                return (actif: res.actif, total: res.total);
              },
            ),
            const Spacer(),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.whatsapp,
                  color: theme.colorScheme.primary),
              tooltip: 'Discuter',
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final nav = Navigator.of(context);
                try {
                  final conv = await ref
                      .read(chatRepositoryProvider)
                      .contacter(partenaireId: p.id);
                  nav.push(MaterialPageRoute(
                    builder: (_) => EcranDiscussion(
                      conversationId: conv.id,
                      titre: p.nomCommerce,
                    ),
                  ));
                } catch (_) {
                  messenger.showSnackBar(const SnackBar(
                      content: Text('Connexion requise pour discuter.')));
                }
              },
            ),
          ],
        ),

        if (p.description.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('À propos', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(p.description),
        ],

        if (p.localisationGeo.isNotEmpty ||
            p.localisationLisible.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Localisation', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          // Ancrage administratif (Departement (Region)), mis en avant.
          if (p.localisationGeo.isNotEmpty)
            Row(
              children: [
                Icon(Icons.place, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    p.localisationGeo,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          // Adresse fine (quartier / secteur / ville), en complement.
          if (p.localisationLisible.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.place_outlined, size: 18),
                const SizedBox(width: 4),
                Expanded(child: Text(p.localisationLisible)),
              ],
            ),
          ],
          if (p.descriptionAcces.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(p.descriptionAcces,
                style: theme.textTheme.bodySmall),
          ],
        ],

        if (p.telephonePro.isNotEmpty || p.whatsapp.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Contact', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          if (p.telephonePro.isNotEmpty)
            Row(children: [
              const Icon(Icons.phone_outlined, size: 18),
              const SizedBox(width: 4),
              Text(p.telephonePro),
            ]),
          if (p.whatsapp.isNotEmpty)
            Row(children: [
              const Icon(Icons.chat_outlined, size: 18),
              const SizedBox(width: 4),
              Text(p.whatsapp),
            ]),
        ],

        const SizedBox(height: 24),
        SectionCommentaires(partenaireId: p.id),
        const SizedBox(height: 80), // espace sous le bouton Contacter
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.logo, required this.theme});
  final String? logo;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const size = 64.0;
    if (logo == null || logo!.isEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.storefront_outlined),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: ImageReseau(
        logo!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => CircleAvatar(
          radius: size / 2,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.storefront_outlined),
        ),
      ),
    );
  }
}

class _Erreur extends StatelessWidget {
  const _Erreur({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Impossible de charger ce partenaire.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}


/// Petit compteur icone + valeur, aligne sur la fiche article.
class _Compteur extends StatelessWidget {
  const _Compteur({required this.icone, required this.valeur});

  final IconData icone;
  final int valeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 18, color: theme.colorScheme.outline),
        const SizedBox(width: 4),
        Text('$valeur', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
