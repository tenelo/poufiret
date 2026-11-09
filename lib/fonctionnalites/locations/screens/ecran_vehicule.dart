import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/elements_vente.dart';
import '../widgets/feuille_demande_achat.dart';
import '../widgets/feuille_reservation_vehicule.dart';
import '../widgets/visite_immersive.dart';

/// Fiche d'un véhicule : galerie, caractéristiques, tarifs, vue intérieure
/// 360°, équipements, autres véhicules du loueur, puis « Réserver ».
/// Hauteur du carrousel : largeur / hauteur. Plus le nombre est grand,
/// plus le carrousel est bas (4 / 3 avant, 16 / 9 encore plus bas).
const double ratioCarrouselVehicule = 16 / 10;

class EcranVehicule extends ConsumerStatefulWidget {
  const EcranVehicule({super.key, required this.vehiculeId, this.titre = ''});

  final int vehiculeId;

  /// Titre déjà connu de l'écran précédent, affiché pendant le chargement.
  final String titre;

  @override
  ConsumerState<EcranVehicule> createState() => _EcranVehiculeState();
}

class _EcranVehiculeState extends ConsumerState<EcranVehicule> {
  late int vehiculeId = widget.vehiculeId;
  late String titre = widget.titre;

  /// Un autre véhicule du loueur touché : sa fiche remplace celle-ci.
  void _afficher(VehiculeResume autre) => setState(() {
    vehiculeId = autre.id;
    titre = autre.nomComplet;
  });

  @override
  Widget build(BuildContext context) {
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
          // La clé remet la fiche en haut quand un autre véhicule s'affiche.
          data: (vehicule) => _Fiche(
            key: ValueKey(vehicule.id),
            vehicule: vehicule,
            onAutre: _afficher,
          ),
        );
  }
}

class _Fiche extends ConsumerWidget {
  const _Fiche({super.key, required this.vehicule, required this.onAutre});

  final Vehicule vehicule;
  final ValueChanged<VehiculeResume> onAutre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final v = vehicule;
    final meta = ref.watch(metaLocationsProvider).value;
    final panoramas = v.panoramasActifs;
    final flotte = _flotte(ref, v);

    return Scaffold(
      appBar: AppBar(title: Text(v.nomComplet)),
      bottomNavigationBar: BarreActionsFiche(
        partenaireId: v.loueur?.id,
        latitude: v.latitude,
        longitude: v.longitude,
        titreCarte: v.localisationTexte.isEmpty
            ? 'Point de prise en charge'
            : 'Point de prise en charge · ${v.localisationTexte}',
        nomMarqueur: v.nomComplet,
        // Réserver (location), « Je suis intéressé » (vente), les deux,
        // ou le bandeau « Vendu ».
        action: ActionsFicheVente(
          actions: v.vente.actions,
          louer: FilledButton.icon(
            onPressed: () => reserverVehicule(context, ref, vehicule: v),
            icon: const Icon(Icons.event_available_outlined),
            label: const Text('Réserver'),
          ),
          onInteresse: () => demanderAchat(
            context,
            ref,
            objetId: v.id,
            titre: v.nomComplet,
            prix: v.vente.prixVenteLisible,
          ),
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
                      aspectRatio: ratioCarrouselVehicule,
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
                              fontWeight: FontWeight.w600,
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
                              if (v.vente.aVendre) ...[
                                const SizedBox(width: 6),
                                const BadgeAVendre(),
                              ],
                              const Spacer(),
                              if (v.vente.mode.aLouer)
                                Text(
                                  formatPrixJour(
                                    v.prixJourPour(
                                      avecChauffeur: v.chauffeurObligatoire,
                                    ),
                                  ),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                          if (v.vente.aVendre && v.vente.prixVente != null)
                            Align(
                              alignment: Alignment.centerRight,
                              child: PrixVente(infos: v.vente, grand: true),
                            ),
                        ],
                      ),
                    ),
                    if (flotte.length > 1)
                      _AutresVehicules(
                        vehicules: flotte,
                        selectionId: v.id,
                        loueurNom: v.loueur?.nom ?? '',
                        onTap: onAutre,
                      ),
                    SectionFiche(
                      titre: 'Caractéristiques',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _caracteristiques(v),
                      ),
                    ),
                    if (v.vente.aVendre)
                      SectionVente(
                        infos: v.vente,
                        lignes: v.vente.lignesVehicule,
                      ),
                    if (v.vente.mode.aLouer)
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Tous les véhicules du loueur, celui-ci compris. En attendant la
  /// liste complète, celui-ci suivi des « autres véhicules » de la fiche.
  static List<VehiculeResume> _flotte(WidgetRef ref, Vehicule v) {
    final loueurId = v.loueur?.id;
    final complete = loueurId == null
        ? null
        : ref
              .watch(pageLoueurVehiculesProvider(partenaireId: loueurId))
              .value
              ?.resultats;
    if (complete != null && complete.any((x) => x.id == v.id)) {
      return complete;
    }
    return [
      VehiculeResume(
        id: v.id,
        titre: v.titre,
        photo: v.galerie.isEmpty ? '' : v.galerie.first,
        marque: v.marque,
        modele: v.modele,
        annee: v.annee,
      ),
      ...v.autresVehicules.where((x) => x.id != v.id),
    ];
  }

  static List<Widget> _caracteristiques(Vehicule v) => [
    if (v.nbPlaces > 0)
      CaracteristiqueFiche(
        Icons.airline_seat_recline_normal_outlined,
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

/// Véhicules du loueur : vignettes arrondies défilant à l'horizontale, le
/// nom dessous. Celle du véhicule affiché est encadrée et cochée, son nom
/// en couleur, et la bande défile pour la montrer.
class _AutresVehicules extends StatefulWidget {
  const _AutresVehicules({
    required this.vehicules,
    required this.selectionId,
    required this.loueurNom,
    required this.onTap,
  });

  final List<VehiculeResume> vehicules;

  /// Véhicule actuellement affiché.
  final int selectionId;

  /// Nom du loueur ; vide : « Autres véhicules de ce loueur ».
  final String loueurNom;
  final ValueChanged<VehiculeResume> onTap;

  @override
  State<_AutresVehicules> createState() => _AutresVehiculesState();
}

class _AutresVehiculesState extends State<_AutresVehicules> {
  static const double _largeur = 112;
  static const double _hauteurPhoto = 76;
  static const double _ecart = 10;

  final _defilement = ScrollController();

  @override
  void initState() {
    super.initState();
    _montrerSelection();
  }

  @override
  void didUpdateWidget(_AutresVehicules ancien) {
    super.didUpdateWidget(ancien);
    // Liste complète arrivée : la sélection a pu changer de place.
    if (ancien.vehicules.length != widget.vehicules.length) {
      _montrerSelection();
    }
  }

  @override
  void dispose() {
    _defilement.dispose();
    super.dispose();
  }

  /// Centre la vignette sélectionnée dans la bande.
  void _montrerSelection() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_defilement.hasClients) return;
      final i = widget.vehicules.indexWhere((x) => x.id == widget.selectionId);
      if (i < 0) return;
      final position = _defilement.position;
      final cible =
          16 +
          i * (_largeur + _ecart) -
          (position.viewportDimension - _largeur) / 2;
      _defilement.jumpTo(
        cible.clamp(position.minScrollExtent, position.maxScrollExtent),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaire = theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.loueurNom.isEmpty
                  ? 'Autres véhicules de ce loueur'
                  : 'Autres véhicules de ${widget.loueurNom}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: _hauteurPhoto + 28,
            child: ListView.separated(
              controller: _defilement,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.vehicules.length,
              separatorBuilder: (_, _) => const SizedBox(width: _ecart),
              itemBuilder: (context, i) {
                final autre = widget.vehicules[i];
                final choisi = autre.id == widget.selectionId;
                return SizedBox(
                  width: _largeur,
                  child: Semantics(
                    selected: choisi,
                    button: true,
                    child: InkWell(
                      key: ValueKey(autre.id),
                      borderRadius: BorderRadius.circular(12),
                      onTap: choisi ? null : () => widget.onTap(autre),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: _largeur,
                            height: _hauteurPhoto,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: choisi ? primaire : Colors.transparent,
                                width: 2.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (autre.photo.isEmpty)
                                    ColoredBox(
                                      color: theme
                                          .colorScheme
                                          .surfaceContainerHighest,
                                      child: Icon(
                                        Icons.directions_car_outlined,
                                        color: theme.colorScheme.outline,
                                      ),
                                    )
                                  else
                                    ImageReseau(
                                      autre.photo,
                                      fit: BoxFit.cover,
                                      largeurAffichee: _largeur,
                                    ),
                                  if (choisi)
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: primaire,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check_rounded,
                                          size: 14,
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            autre.nomComplet,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: choisi
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: choisi ? primaire : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
