import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../donnees/publicites_providers.dart';
import '../donnees/publicites_repository.dart';
import '../metier_domaine/publicite_detail.dart';
import '../../../global/widgets/image_reseau.dart';

/// Page detail d'une publicite : affiche le flyer en entier + description.
class EcranPubliciteDetail extends ConsumerStatefulWidget {
  const EcranPubliciteDetail({
    super.key,
    required this.id,
    this.typeAffichageSource = TypeAffichage.pagePublicites,
  });

  final String id;

  /// D'ou vient le clic (carrousel, page_publicites, bandeau_bas...).
  final String typeAffichageSource;

  @override
  ConsumerState<EcranPubliciteDetail> createState() =>
      _EcranPubliciteDetailState();
}

class _EcranPubliciteDetailState extends ConsumerState<EcranPubliciteDetail> {
  @override
  void initState() {
    super.initState();
    // Un clic ayant mene ici : on le trace (best-effort, non bloquant).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(publicitesRepositoryProvider).enregistrerImpression(
            widget.id,
            typeAffichage: widget.typeAffichageSource,
            cliquee: true,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(publiciteDetailProvider(id: widget.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Publicité')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => _Erreur(
          message: err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.',
          onReessayer: () =>
              ref.invalidate(publiciteDetailProvider(id: widget.id)),
        ),
        data: (pub) => _Contenu(pub: pub),
      ),
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu({required this.pub});
  final PubliciteDetail pub;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur =
            contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: largeur),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if ((pub.imageCouverture ?? '').isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageReseau(
                      pub.imageCouverture!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, e, s) => _ImageIndisponible(),
                      loadingBuilder: (_, enfant, progres) => progres == null
                          ? enfant
                          : const SizedBox(
                              height: 240,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(pub.titre, style: theme.textTheme.headlineSmall),
                if (pub.nomPartenaire.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.storefront_outlined, size: 16,
                          color: Config.couleurTexteSecondaire),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          pub.nomPartenaire,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Config.couleurTexteSecondaire,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (pub.description.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(pub.description, style: theme.textTheme.bodyLarge),
                ],
                if (pub.aUneVideo) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Config.couleurFond,
                    child: const ListTile(
                      leading: Icon(Icons.videocam_outlined),
                      title: Text('Cette publicité contient une vidéo'),
                      subtitle: Text('Lecture disponible prochainement.'),
                    ),
                  ),
                ],
                if (pub.images.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text('Galerie', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: pub.images.length,
                      separatorBuilder: (_, i) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final url = pub.images[i].image ?? '';
                        if (url.isEmpty) return const SizedBox.shrink();
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageReseau(url, fit: BoxFit.cover,
                              errorBuilder: (_, e, s) => _ImageIndisponible()),
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImageIndisponible extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        height: 200,
        color: Config.couleurFond,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined,
              size: 40, color: Config.couleurTexteSecondaire),
        ),
      );
}

class _Erreur extends StatelessWidget {
  const _Erreur({required this.message, required this.onReessayer});
  final String message;
  final VoidCallback onReessayer;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(onPressed: onReessayer, child: const Text('Réessayer')),
            ],
          ),
        ),
      );
}
