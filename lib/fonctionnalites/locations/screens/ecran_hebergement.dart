import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/feuille_reservation_hebergement.dart';
import '../widgets/visite_immersive.dart';

/// Fiche d'un hébergement (chambre, suite, appartement) : galerie, vue
/// 360°, capacité, équipements, tarifs, heures d'arrivée et de départ, puis
/// « Réserver ».
class EcranHebergement extends ConsumerWidget {
  const EcranHebergement({
    super.key,
    required this.hebergementId,
    this.titre = '',
  });

  final int hebergementId;

  /// Titre déjà connu de l'écran précédent, affiché pendant le chargement.
  final String titre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = hebergementDetailProvider(id: hebergementId);
    return ref
        .watch(provider)
        .when(
          skipLoadingOnReload: true,
          loading: () => Scaffold(
            appBar: AppBar(title: Text(titre)),
            body: const SqueletteDetailArticle(),
          ),
          error: (err, _) => Scaffold(
            appBar: AppBar(title: Text(titre)),
            body: MessageErreur(
              message: messageErreurApi(
                err,
                repli: 'Impossible de charger cet hébergement.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
          ),
          data: (hebergement) => _Fiche(hebergement: hebergement),
        );
  }
}

class _Fiche extends ConsumerWidget {
  const _Fiche({required this.hebergement});

  final Hebergement hebergement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final h = hebergement;
    final meta = ref.watch(metaLocationsProvider).value;
    final panoramas = h.panoramasActifs;

    return Scaffold(
      appBar: AppBar(title: Text(h.titre)),
      bottomNavigationBar: BarreActionsFiche(
        // La position est celle de l'établissement, sur sa page.
        latitude: null,
        longitude: null,
        titreCarte: h.titre,
        nomMarqueur: h.titre,
        action: FilledButton.icon(
          onPressed: () => reserverHebergement(context, ref, hebergement: h),
          icon: const Icon(Icons.event_available_outlined),
          label: const Text('Réserver'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: RefreshIndicator(
                onRefresh: () =>
                    rafraichir(ref, hebergementDetailProvider(id: h.id)),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CarrouselImages(
                        images: h.galerie,
                        titre: h.titre,
                        constructeurVide: (_) => ColoredBox(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.hotel_outlined,
                            size: 56,
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            h.titre,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if ((h.etablissement?.nom ?? '').isNotEmpty)
                            Text(
                              h.etablissement!.nom,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (h.type.isNotEmpty) PuceLogement(h.type),
                              const Spacer(),
                              Text(
                                formatPrixNuit(h.prixNuit),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (panoramas.isNotEmpty)
                      SectionFiche(
                        titre: 'Vue 360°',
                        child: VisiteImmersive(panoramas: panoramas),
                      ),
                    SectionFiche(
                      titre: 'Caractéristiques',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (h.capacite.isNotEmpty)
                            CaracteristiqueFiche(
                              Icons.people_outline,
                              h.capacite,
                            ),
                          if (h.lits.isNotEmpty)
                            CaracteristiqueFiche(Icons.bed_outlined, h.lits),
                          if (h.surfaceM2 != null && h.surfaceM2! > 0)
                            CaracteristiqueFiche(
                              Icons.square_foot,
                              '${h.surfaceM2} m²',
                            ),
                        ],
                      ),
                    ),
                    if (h.equipements.isNotEmpty)
                      SectionFiche(
                        titre: 'Équipements',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final e in h.equipements)
                              PuceLogement(
                                meta?.libelleEquipementHotel(e) ?? lisible(e),
                              ),
                          ],
                        ),
                      ),
                    SectionFiche(
                      titre: 'Tarifs',
                      child: Column(
                        children: [
                          LigneFiche('Nuit', formatPrixNuit(h.prixNuit)),
                          if ((h.prixSemaine ?? 0) > 0)
                            LigneFiche(
                              'Semaine',
                              '${formatMontant(h.prixSemaine!)}/semaine',
                            ),
                          if ((h.prixMois ?? 0) > 0)
                            LigneFiche(
                              'Mois',
                              '${formatMontant(h.prixMois!)}/mois',
                            ),
                          LigneFiche(
                            'Durée minimale',
                            pluriel(h.dureeMin, 'nuit'),
                          ),
                        ],
                      ),
                    ),
                    if (h.arrivee.isNotEmpty || h.depart.isNotEmpty)
                      SectionFiche(
                        titre: 'Arrivée et départ',
                        child: Column(
                          children: [
                            if (h.arrivee.isNotEmpty)
                              LigneFiche(
                                'Arrivée',
                                'à partir de ${formatHeure(h.arrivee)}',
                              ),
                            if (h.depart.isNotEmpty)
                              LigneFiche(
                                'Départ',
                                'avant ${formatHeure(h.depart)}',
                              ),
                          ],
                        ),
                      ),
                    if (h.description.isNotEmpty)
                      SectionFiche(
                        titre: 'Description',
                        child: Text(h.description),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
