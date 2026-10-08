import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/feuille_demande_visite.dart';
import '../widgets/visite_immersive.dart';

/// Fiche d'un logement : galerie, visite immersive, caractéristiques,
/// conditions, équipements, puis la demande de visite.
class EcranLogement extends ConsumerWidget {
  const EcranLogement({super.key, required this.logementId, this.titre = ''});

  final int logementId;

  /// Titre déjà connu de l'écran précédent, affiché pendant le chargement.
  final String titre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = logementDetailProvider(id: logementId);
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
                repli: 'Impossible de charger ce logement.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
          ),
          data: (logement) => _Fiche(logement: logement),
        );
  }
}

class _Fiche extends ConsumerWidget {
  const _Fiche({required this.logement});

  final Logement logement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l = logement;
    final meta = ref.watch(metaLocationsProvider).value;
    final panoramas = l.panoramasActifs;

    return Scaffold(
      appBar: AppBar(title: Text(l.titre)),
      bottomNavigationBar: BarreActionsFiche(
        latitude: l.latitude,
        longitude: l.longitude,
        titreCarte: l.localisation.isEmpty ? 'Localisation' : l.localisation,
        nomMarqueur: l.titre,
        action: FilledButton.icon(
          onPressed: () =>
              demanderVisite(context, ref, logementId: l.id, titre: l.titre),
          icon: const Icon(Icons.event_available_outlined),
          label: const Text('Demander une visite'),
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
                    rafraichir(ref, logementDetailProvider(id: l.id)),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CarrouselImages(
                        images: l.galerie,
                        titre: l.titre,
                        constructeurVide: (_) => ColoredBox(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.home_outlined,
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
                            l.titre,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (l.localisation.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  size: 16,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    l.localisation,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (l.typeLogementLibelle.isNotEmpty)
                                PuceLogement(l.typeLogementLibelle),
                              const Spacer(),
                              Text(
                                formatLoyer(l.loyer),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          if (!l.estDisponible && l.disponibilite.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                _libelleDisponibilite(meta, l),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Config.couleurErreur,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (panoramas.isNotEmpty)
                      SectionFiche(
                        titre: 'Visite immersive',
                        child: VisiteImmersive(panoramas: panoramas),
                      ),
                    SectionFiche(
                      titre: 'Caractéristiques',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (l.nbChambres > 0)
                            CaracteristiqueFiche(
                              Icons.bed_outlined,
                              pluriel(l.nbChambres, 'chambre'),
                            ),
                          if (l.nbSalons > 0)
                            CaracteristiqueFiche(
                              Icons.weekend_outlined,
                              pluriel(l.nbSalons, 'salon'),
                            ),
                          if (l.nbSallesDeBain > 0)
                            CaracteristiqueFiche(
                              Icons.bathtub_outlined,
                              pluriel(
                                l.nbSallesDeBain,
                                'salle de bain',
                                'salles de bain',
                              ),
                            ),
                          if (l.surfaceM2 != null && l.surfaceM2! > 0)
                            CaracteristiqueFiche(
                              Icons.square_foot,
                              '${l.surfaceM2} m²',
                            ),
                          CaracteristiqueFiche(
                            Icons.chair_outlined,
                            l.meuble ? 'Meublé' : 'Non meublé',
                          ),
                        ],
                      ),
                    ),
                    SectionFiche(
                      titre: 'Conditions',
                      child: Column(
                        children: [
                          LigneFiche('Loyer', formatLoyer(l.loyer)),
                          if (l.cautionMois != null)
                            LigneFiche('Caution', '${l.cautionMois} mois'),
                          if (l.avanceMois != null)
                            LigneFiche('Avance', '${l.avanceMois} mois'),
                          if (l.fraisAgence != null)
                            LigneFiche(
                              "Frais d'agence",
                              l.fraisAgence == 0
                                  ? 'Aucun'
                                  : formatMontant(l.fraisAgence!),
                            ),
                          LigneFiche(
                            "Compteur d'eau individuel",
                            l.compteurEauIndividuel ? 'Oui' : 'Non',
                          ),
                          LigneFiche(
                            "Compteur d'électricité individuel",
                            l.compteurElectriciteIndividuel ? 'Oui' : 'Non',
                          ),
                          if ((l.disponibleAPartirDu ?? '').isNotEmpty)
                            LigneFiche(
                              'Disponible à partir du',
                              formatDateCourte(l.disponibleAPartirDu),
                            ),
                        ],
                      ),
                    ),
                    if (l.equipements.isNotEmpty)
                      SectionFiche(
                        titre: 'Équipements',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final e in l.equipements)
                              PuceLogement(meta?.libelleEquipement(e) ?? e),
                          ],
                        ),
                      ),
                    if (l.description.isNotEmpty)
                      SectionFiche(
                        titre: 'Description',
                        child: Text(l.description),
                      ),
                    if (l.adresseReperes.isNotEmpty)
                      SectionFiche(
                        titre: 'Repères',
                        child: Text(l.adresseReperes),
                      ),
                    if (l.autresLogements.isNotEmpty)
                      SectionFiche(
                        titre: 'Autres logements de ce loueur',
                        child: Column(
                          children: [
                            for (final autre in l.autresLogements)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CarteLogement(logement: autre),
                              ),
                          ],
                        ),
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

  static String _libelleDisponibilite(MetaLocations? meta, Logement l) =>
      meta?.disponibilites
          .where((d) => d.valeur == l.disponibilite)
          .firstOrNull
          ?.libelle ??
      l.disponibilite;
}
