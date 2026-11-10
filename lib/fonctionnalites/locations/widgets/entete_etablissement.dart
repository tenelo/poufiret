import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import 'carte_logement.dart';
import 'elements_fiche.dart';
import 'visite_immersive.dart';

/// Page d'un établissement (hôtel, résidence) : galerie, nom, étoiles,
/// type, localisation ; contacts et position ; [sectionHebergements] (les
/// chambres, tout de suite visibles) ; présentation, vue 360°, équipements,
/// informations pratiques ; annulation et conditions repliables.
class EnteteEtablissement extends ConsumerWidget {
  const EnteteEtablissement({
    super.key,
    required this.etablissement,
    this.sectionHebergements,
  });

  final Etablissement etablissement;

  /// Section « Nos chambres », placée juste après les contacts.
  final Widget? sectionHebergements;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final e = etablissement;
    final meta = ref.watch(metaLocationsProvider).value;
    final panoramas = e.panoramasActifs;
    final images = e.galerie.isNotEmpty
        ? e.galerie
        : [if (e.couverture.isNotEmpty) e.couverture];
    final infos = <Widget>[
      if (e.heureArrivee.isNotEmpty)
        LigneFiche('Arrivée', 'à partir de ${formatHeure(e.heureArrivee)}'),
      if (e.heureDepart.isNotEmpty)
        LigneFiche('Départ', 'avant ${formatHeure(e.heureDepart)}'),
      if (e.petitDejeunerLisible.isNotEmpty)
        LigneFiche('Petit-déjeuner', e.petitDejeunerLisible),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: CarrouselImages(
            images: images,
            titre: e.nom,
            constructeurVide: (_) => ColoredBox(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.hotel_outlined,
                size: 48,
                color: theme.colorScheme.outline,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.nom,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (e.nbEtoiles > 0 || e.typeEtablissementLibelle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      if (e.nbEtoiles > 0) ...[
                        Semantics(
                          label: '${e.nbEtoiles} étoiles',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var i = 0; i < e.nbEtoiles; i++)
                                const Icon(
                                  Icons.star_rounded,
                                  size: 18,
                                  color: Color(0xFFF5A623),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (e.typeEtablissementLibelle.isNotEmpty)
                        PuceLogement(e.typeEtablissementLibelle),
                    ],
                  ),
                ),
              if (e.localisationTexte.isNotEmpty) ...[
                const SizedBox(height: 6),
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
                        e.localisationTexte,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              LigneContactLoueur(
                telephone: e.telephonePro,
                whatsapp: e.whatsappExterne,
                partenaireId: e.id,
                nom: e.nom,
              ),
              if (e.aPosition) ...[
                const SizedBox(height: 8),
                BoutonsPosition(
                  partenaireId: e.id,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  titreCarte: e.localisationTexte.isEmpty
                      ? e.nom
                      : e.localisationTexte,
                  nomMarqueur: e.nom,
                ),
              ],
            ],
          ),
        ),
        ?sectionHebergements,
        if (e.description.isNotEmpty)
          SectionFiche(titre: 'Présentation', child: Text(e.description)),
        if (panoramas.isNotEmpty)
          SectionFiche(
            titre: 'Vue 360°',
            child: VisiteImmersive(panoramas: panoramas),
          ),
        if (e.equipements.isNotEmpty)
          SectionFiche(
            titre: 'Équipements',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final eq in e.equipements)
                  PuceLogement(meta?.libelleEquipementHotel(eq) ?? lisible(eq)),
              ],
            ),
          ),
        if (infos.isNotEmpty)
          SectionFiche(
            titre: 'Informations pratiques',
            child: Column(children: infos),
          ),
        if (e.politiqueAnnulationLisible.isNotEmpty || e.conditions.isNotEmpty)
          const SizedBox(height: 12),
        if (e.politiqueAnnulationLisible.isNotEmpty)
          SectionRepliable(
            titre: "Politique d'annulation",
            child: Text(e.politiqueAnnulationLisible),
          ),
        if (e.conditions.isNotEmpty)
          SectionRepliable(
            titre: 'Conditions',
            child: Text(
              e.conditions,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ),
        const Divider(height: 32),
      ],
    );
  }
}

/// Section titrée repliable, fermée par défaut.
class SectionRepliable extends StatelessWidget {
  const SectionRepliable({super.key, required this.titre, required this.child});

  final String titre;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        titre,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: const Border(),
      collapsedShape: const Border(),
      children: [child],
    );
  }
}
