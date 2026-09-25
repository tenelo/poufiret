import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/publicites_providers.dart';
import '../donnees/publicites_repository.dart';
import '../metier_domaine/publicite_liste.dart';
import 'ecran_publicite_detail.dart';
import '../../../global/widgets/image_reseau.dart';

/// Onglet Publicites : toutes les campagnes en cours de diffusion.
class EcranPublicites extends ConsumerWidget {
  const EcranPublicites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pagePublicitesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Publicités')),
      body: RefreshIndicator(
        onRefresh: () => rafraichir(ref, pagePublicitesProvider),
        child: async.when(
          skipLoadingOnReload: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => _Etat(
            icone: Icons.wifi_off_outlined,
            message: err is ApiException
                ? err.messageLisible
                : 'Erreur de chargement.',
            onReessayer: () => ref.invalidate(pagePublicitesProvider),
          ),
          data: (donnees) {
            // Jamais de pub dont la diffusion est terminee, meme en cache.
            final pubs = donnees.affichables();
            if (pubs.isEmpty) {
              return const _Etat(
                icone: Icons.campaign_outlined,
                message: 'Aucune publicité en cours pour le moment.',
              );
            }
            return LayoutBuilder(
              builder: (context, contraintes) {
                final largeur = contraintes.maxWidth;
                // ~240px par affiche : 1 colonne sur tel, plus sur grand ecran.
                final nbColonnes = (largeur / 240).floor().clamp(1, 4);
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: nbColonnes,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    // Les flyers sont en portrait.
                    childAspectRatio: 0.68,
                  ),
                  itemCount: pubs.length,
                  itemBuilder: (context, i) => _CarteAffiche(
                    pub: pubs[i],
                    confirmee: donnees.confirmeReseau,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CarteAffiche extends ConsumerStatefulWidget {
  const _CarteAffiche({required this.pub, required this.confirmee});
  final PubliciteListe pub;

  /// Vrai si la pub est confirmee par une reponse reseau fraiche (et non
  /// seulement lue dans le cache) : condition pour compter une impression.
  final bool confirmee;

  @override
  ConsumerState<_CarteAffiche> createState() => _CarteAfficheState();
}

class _CarteAfficheState extends ConsumerState<_CarteAffiche> {
  bool _impressionTracee = false;

  @override
  void initState() {
    super.initState();
    _tracerSiConfirmee();
  }

  @override
  void didUpdateWidget(_CarteAffiche ancien) {
    super.didUpdateWidget(ancien);
    // Affichee d'abord depuis le cache, puis confirmee par le reseau.
    _tracerSiConfirmee();
  }

  /// Impression tracee une seule fois, et seulement pour une pub confirmee
  /// par le serveur : une pub arretee entre-temps ne doit pas etre comptee.
  void _tracerSiConfirmee() {
    if (_impressionTracee || !widget.confirmee) return;
    _impressionTracee = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(publicitesRepositoryProvider).enregistrerImpression(
            widget.pub.id,
            typeAffichage: TypeAffichage.pagePublicites,
            sessionId: ref.read(sessionAnalyticsProvider).sessionId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final url = widget.pub.imageCouverture ?? '';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EcranPubliciteDetail(
              id: widget.pub.id,
              typeAffichageSource: TypeAffichage.pagePublicites,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: url.isEmpty
                  ? Container(
                      color: Config.couleurFond,
                      child: const Icon(Icons.image_outlined,
                          color: Config.couleurTexteSecondaire),
                    )
                  : ImageReseau(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, e, s) => Container(
                        color: Config.couleurFond,
                        child: const Icon(Icons.image_not_supported_outlined,
                            color: Config.couleurTexteSecondaire),
                      ),
                      loadingBuilder: (_, enfant, progres) => progres == null
                          ? enfant
                          : const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.pub.titre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Etat extends StatelessWidget {
  const _Etat({required this.icone, required this.message, this.onReessayer});
  final IconData icone;
  final String message;
  final VoidCallback? onReessayer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ListView pour que le RefreshIndicator reste actionnable.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
        Icon(icone, size: 56, color: Config.couleurTexteSecondaire),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: Config.couleurTexteSecondaire),
          ),
        ),
        if (onReessayer != null) ...[
          const SizedBox(height: 16),
          Center(
            child: FilledButton(
              onPressed: onReessayer,
              child: const Text('Réessayer'),
            ),
          ),
        ],
      ],
    );
  }
}
