import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/carte/carte_poufiret.dart';
import '../../../global/carte/modeles_carte.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/liens_externes.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../widgets/carte_logement.dart';
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
      bottomNavigationBar: _Actions(logement: l),
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
                      _Section(
                        titre: 'Visite immersive',
                        child: VisiteImmersive(panoramas: panoramas),
                      ),
                    _Section(
                      titre: 'Caractéristiques',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (l.nbChambres > 0)
                            _Caracteristique(
                              Icons.bed_outlined,
                              pluriel(l.nbChambres, 'chambre'),
                            ),
                          if (l.nbSalons > 0)
                            _Caracteristique(
                              Icons.weekend_outlined,
                              pluriel(l.nbSalons, 'salon'),
                            ),
                          if (l.nbSallesDeBain > 0)
                            _Caracteristique(
                              Icons.bathtub_outlined,
                              pluriel(
                                l.nbSallesDeBain,
                                'salle de bain',
                                'salles de bain',
                              ),
                            ),
                          if (l.surfaceM2 != null && l.surfaceM2! > 0)
                            _Caracteristique(
                              Icons.square_foot,
                              '${l.surfaceM2} m²',
                            ),
                          _Caracteristique(
                            Icons.chair_outlined,
                            l.meuble ? 'Meublé' : 'Non meublé',
                          ),
                        ],
                      ),
                    ),
                    _Section(
                      titre: 'Conditions',
                      child: Column(
                        children: [
                          _Ligne('Loyer', formatLoyer(l.loyer)),
                          if (l.cautionMois != null)
                            _Ligne('Caution', '${l.cautionMois} mois'),
                          if (l.avanceMois != null)
                            _Ligne('Avance', '${l.avanceMois} mois'),
                          if (l.fraisAgence != null)
                            _Ligne(
                              "Frais d'agence",
                              l.fraisAgence == 0
                                  ? 'Aucun'
                                  : formatMontant(l.fraisAgence!),
                            ),
                          _Ligne(
                            "Compteur d'eau individuel",
                            l.compteurEauIndividuel ? 'Oui' : 'Non',
                          ),
                          _Ligne(
                            "Compteur d'électricité individuel",
                            l.compteurElectriciteIndividuel ? 'Oui' : 'Non',
                          ),
                          if ((l.disponibleAPartirDu ?? '').isNotEmpty)
                            _Ligne(
                              'Disponible à partir du',
                              formatDateCourte(l.disponibleAPartirDu),
                            ),
                        ],
                      ),
                    ),
                    if (l.equipements.isNotEmpty)
                      _Section(
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
                      _Section(
                        titre: 'Description',
                        child: Text(l.description),
                      ),
                    if (l.adresseReperes.isNotEmpty)
                      _Section(titre: 'Repères', child: Text(l.adresseReperes)),
                    if (l.autresLogements.isNotEmpty)
                      _Section(
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

/// Boutons du bas : Itinéraire et Localisation (si le logement a des
/// coordonnées), puis « Demander une visite ».
class _Actions extends ConsumerWidget {
  const _Actions({required this.logement});

  final Logement logement;

  void _montrerCarte(BuildContext context) {
    final point = PointCarte(logement.latitude!, logement.longitude!);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              logement.localisation.isEmpty
                  ? 'Localisation'
                  : logement.localisation,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: CartePoufiret(
                  centreInitial: point,
                  zoomInitial: 15,
                  boutonsZoom: true,
                  marqueurs: [
                    MarqueurCarte(
                      id: 'logement',
                      position: point,
                      titre: logement.titre,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = logement;
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (l.aPosition) ...[
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => ouvrirLien(
                            context,
                            uriItineraire(l.latitude!, l.longitude!),
                          ),
                          icon: const Icon(Icons.directions_outlined, size: 18),
                          label: const Text('Itinéraire'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _montrerCarte(context),
                          icon: const Icon(Icons.map_outlined, size: 18),
                          label: const Text('Localisation'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                FilledButton.icon(
                  onPressed: () => demanderVisite(
                    context,
                    ref,
                    logementId: l.id,
                    titre: l.titre,
                  ),
                  icon: const Icon(Icons.event_available_outlined),
                  label: const Text('Demander une visite'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.titre, required this.child});

  final String titre;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Caracteristique extends StatelessWidget {
  const _Caracteristique(this.icone, this.texte);

  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Config.couleurSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(texte, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _Ligne extends StatelessWidget {
  const _Ligne(this.libelle, this.valeur);

  final String libelle;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              libelle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            valeur,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
