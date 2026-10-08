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
import '../metier_domaine/vehicule_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/carte_vehicule.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/feuille_reservation_vehicule.dart';
import '../widgets/visite_immersive.dart';

/// Fiche d'un véhicule : galerie, caractéristiques, tarifs, vue intérieure
/// 360°, équipements, autres véhicules du loueur, puis « Réserver ».
class EcranVehicule extends ConsumerWidget {
  const EcranVehicule({super.key, required this.vehiculeId, this.titre = ''});

  final int vehiculeId;

  /// Titre déjà connu de l'écran précédent, affiché pendant le chargement.
  final String titre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = vehiculeDetailProvider(id: vehiculeId);
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
                repli: 'Impossible de charger ce véhicule.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
          ),
          data: (vehicule) => _Fiche(vehicule: vehicule),
        );
  }
}

class _Fiche extends ConsumerWidget {
  const _Fiche({required this.vehicule});

  final Vehicule vehicule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final v = vehicule;
    final meta = ref.watch(metaLocationsProvider).value;
    final panoramas = v.panoramasActifs;

    return Scaffold(
      appBar: AppBar(title: Text(v.nomComplet)),
      bottomNavigationBar: BarreActionsFiche(
        latitude: v.latitude,
        longitude: v.longitude,
        titreCarte: v.localisationTexte.isEmpty
            ? 'Point de prise en charge'
            : 'Point de prise en charge · ${v.localisationTexte}',
        nomMarqueur: v.nomComplet,
        action: FilledButton.icon(
          onPressed: () => reserverVehicule(context, ref, vehicule: v),
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
                    rafraichir(ref, vehiculeDetailProvider(id: v.id)),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CarrouselImages(
                        images: v.galerie,
                        titre: v.nomComplet,
                        constructeurVide: (_) => ColoredBox(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.directions_car_outlined,
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
                            v.nomComplet,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (v.titre.isNotEmpty && v.titre != v.nomComplet)
                            Text(
                              v.titre,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Config.couleurTexteSecondaire,
                              ),
                            ),
                          if (v.localisationTexte.isNotEmpty) ...[
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
                                    v.localisationTexte,
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
                              if (v.categorieLibelle.isNotEmpty)
                                PuceLogement(v.categorieLibelle),
                              const Spacer(),
                              Text(
                                formatPrixJour(
                                  v.prixJourPour(
                                    avecChauffeur: v.chauffeurObligatoire,
                                  ),
                                ),
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
                    SectionFiche(
                      titre: 'Caractéristiques',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _caracteristiques(v),
                      ),
                    ),
                    SectionFiche(
                      titre: 'Tarifs et conditions',
                      child: Column(children: _tarifs(v)),
                    ),
                    if (v.zone.isNotEmpty)
                      SectionFiche(
                        titre: 'Zone de circulation',
                        child: Row(
                          children: [
                            Icon(
                              Icons.route_outlined,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(v.zone)),
                          ],
                        ),
                      ),
                    if (v.equipements.isNotEmpty)
                      SectionFiche(
                        titre: 'Équipements',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final e in v.equipements)
                              PuceLogement(
                                meta?.libelleEquipementVehicule(e) ?? e,
                              ),
                          ],
                        ),
                      ),
                    if (panoramas.isNotEmpty)
                      SectionFiche(
                        titre: 'Vue intérieure 360°',
                        child: VisiteImmersive(panoramas: panoramas),
                      ),
                    if (v.description.isNotEmpty)
                      SectionFiche(
                        titre: 'Description',
                        child: Text(v.description),
                      ),
                    if (v.autresVehicules.isNotEmpty)
                      SectionFiche(
                        titre: 'Autres véhicules de ce loueur',
                        child: Column(
                          children: [
                            for (final autre in v.autresVehicules)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CarteVehicule(
                                  key: ValueKey(autre.id),
                                  vehicule: autre,
                                ),
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

  static List<Widget> _caracteristiques(Vehicule v) => [
    if (v.nbPlaces > 0)
      CaracteristiqueFiche(
        Icons.airline_seat_recline_normal,
        pluriel(v.nbPlaces, 'place'),
      ),
    if (v.boiteLibelle.isNotEmpty)
      CaracteristiqueFiche(Icons.settings_outlined, v.boiteLibelle),
    if (v.carburantLibelle.isNotEmpty)
      CaracteristiqueFiche(
        Icons.local_gas_station_outlined,
        v.carburantLibelle,
      ),
    CaracteristiqueFiche(
      Icons.ac_unit,
      v.climatisation ? 'Climatisé' : 'Sans climatisation',
    ),
    if (v.annee != null && v.annee! > 0)
      CaracteristiqueFiche(Icons.calendar_today_outlined, '${v.annee}'),
    if (v.couleur.isNotEmpty)
      CaracteristiqueFiche(Icons.palette_outlined, v.couleur),
  ];

  static List<Widget> _tarifs(Vehicule v) => [
    if (!v.chauffeurObligatoire)
      LigneFiche('Sans chauffeur', formatPrixJour(v.prixJour)),
    if (v.chauffeurDisponible || v.chauffeurObligatoire)
      LigneFiche(
        v.chauffeurObligatoire
            ? 'Avec chauffeur (obligatoire)'
            : 'Avec chauffeur',
        formatPrixJour(v.prixJourPour(avecChauffeur: true)),
      ),
    if (v.caution != null && v.caution! > 0)
      LigneFiche('Caution', formatMontant(v.caution!)),
    LigneFiche(
      'Kilométrage',
      v.kmIllimite
          ? 'Kilométrage illimité'
          : '${v.kmInclusParJour} km/jour inclus',
    ),
    if (!v.kmIllimite &&
        v.prixKmSupplementaire != null &&
        v.prixKmSupplementaire! > 0)
      LigneFiche(
        'Km supplémentaire',
        '${formatMontant(v.prixKmSupplementaire!)}/km',
      ),
    LigneFiche('Carburant', v.carburantInclus ? 'Inclus' : 'Non inclus'),
    LigneFiche('Durée minimale', pluriel(v.dureeMin, 'jour')),
  ];
}
