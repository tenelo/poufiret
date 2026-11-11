import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;

import '../../../global/cache/contexte_cache.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/couverture_nommee.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';
import '../metier_domaine/vente_models.dart';
import '../widgets/carte_hebergement.dart';
import '../widgets/carte_logement.dart';
import '../widgets/carte_vehicule.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/page_etablissement.dart';
import '../widgets/feuille_filtre_hebergements.dart';
import '../widgets/feuille_filtre_logements.dart';
import '../widgets/feuille_filtre_vehicules.dart';
import '../widgets/feuille_sejour.dart';
import '../metier_domaine/sejour.dart';

/// Page d'un loueur : en-tête (couverture, logo, nom, appel, WhatsApp) puis
/// ses biens disponibles, filtrables. La page est la même pour tous les
/// loueurs ; seuls la liste, son filtre et la fiche ouverte dépendent de ce
/// qu'il loue ([type]).
class EcranLoueur extends ConsumerStatefulWidget {
  const EcranLoueur({
    super.key,
    required this.partenaireId,
    this.type = TypeLocation.logement,
    this.nom = '',
    this.siIntrouvable,
    this.listeSeule = false,
    this.sejour,
  });

  final int partenaireId;
  final TypeLocation type;

  /// Nom déjà connu de l'écran précédent, affiché pendant le chargement.
  final String nom;

  /// Écran affiché à la place si le serveur ne connaît pas ce loueur (404) :
  /// partenaire rangé dans la catégorie sans page loueur.
  final Widget? siIntrouvable;

  /// Établissement : seulement la liste complète et son filtre (« Voir
  /// tout » de la page établissement), sans l'en-tête.
  final bool listeSeule;

  /// Établissement, liste seule : séjour cherché (dates, voyageurs). La
  /// liste ne garde que les hébergements assez grands, avec leur statut à
  /// ces dates ; null : la liste complète.
  final Sejour? sejour;

  @override
  ConsumerState<EcranLoueur> createState() => _EcranLoueurState();
}

/// Ce que la page affiche, une fois la liste du type choisie.
class _Liste {
  const _Liste({
    required this.async,
    required this.provider,
    required this.loueur,
    required this.cartes,
    required this.nombreFiltres,
    required this.filtrer,
    required this.textes,
    this.avecSelecteur = false,
    this.page,
  });

  final AsyncValue<Object?> async;
  final ProviderOrFamily provider;
  final Loueur? loueur;

  /// Cartes des biens ; null tant que la liste n'est pas arrivée.
  final List<Widget>? cartes;
  final int nombreFiltres;
  final VoidCallback filtrer;
  final _Textes textes;

  /// Sélecteur « Louer | Acheter » : le loueur a des annonces des deux types.
  final bool avecSelecteur;

  /// Établissement reçu (hôtel, résidence).
  final PageEtablissement? page;
}

/// Le loueur a-t-il des annonces à louer et des annonces à vendre ?
/// Calculé sur sa liste complète (sans filtre de mode).
bool aLesDeuxModes(Iterable<InfosVente> annonces) =>
    annonces.any((a) => a.mode.aLouer) && annonces.any((a) => a.mode.aVendre);

/// Libellés propres à un type de location.
class _Textes {
  const _Textes({
    required this.singulier,
    required this.pluriel,
    required this.titre,
    required this.vide,
    required this.videFiltre,
    required this.erreur,
    required this.icone,
  });

  final String singulier;
  final String pluriel;
  final String titre;
  final String vide;
  final String videFiltre;
  final String erreur;
  final IconData icone;

  static const logements = _Textes(
    singulier: 'logement disponible',
    pluriel: 'logements disponibles',
    titre: 'Logements disponibles',
    vide: 'Aucun logement disponible pour le moment.',
    videFiltre: 'Aucun logement ne correspond à ces critères.',
    erreur: 'Impossible de charger les logements.',
    icone: Icons.home_work_outlined,
  );

  static const vehicules = _Textes(
    singulier: 'véhicule disponible',
    pluriel: 'véhicules disponibles',
    titre: 'Véhicules disponibles',
    vide: 'Aucun véhicule disponible pour le moment.',
    videFiltre: 'Aucun véhicule ne correspond à ces critères.',
    erreur: 'Impossible de charger les véhicules.',
    icone: Icons.car_rental_outlined,
  );

  /// Mode « Acheter » : mêmes libellés, « à vendre ».
  _Textes aVendre(String nom) => _Textes(
    singulier: '$nom à vendre',
    pluriel: '${nom}s à vendre',
    titre: '${nom[0].toUpperCase()}${nom.substring(1)}s à vendre',
    vide: 'Aucun $nom à vendre pour le moment.',
    videFiltre: videFiltre,
    erreur: erreur,
    icone: icone,
  );

  static const hebergements = _Textes(
    singulier: 'hébergement disponible',
    pluriel: 'hébergements disponibles',
    titre: 'Hébergements disponibles',
    vide: 'Aucun hébergement disponible pour le moment.',
    videFiltre: 'Aucun hébergement ne correspond à ces critères.',
    erreur: 'Impossible de charger cet établissement.',
    icone: Icons.hotel_outlined,
  );
}

class _EcranLoueurState extends ConsumerState<EcranLoueur> {
  FiltreLogements _filtreLogements = const FiltreLogements();
  FiltreVehicules _filtreVehicules = const FiltreVehicules();
  FiltreHebergements _filtreHebergements = const FiltreHebergements();

  /// Séjour cherché (liste des hébergements d'un établissement).
  late Sejour? _sejour = widget.sejour;

  /// Dernier loueur reçu : l'en-tête reste affiché pendant qu'un nouveau
  /// filtre charge.
  Loueur? _loueur;

  /// « Louer » (location) ou « Acheter » (vente), si le sélecteur est là.
  String _mode = ModeAnnonce.location.valeur;

  bool get _achat => _mode == ModeAnnonce.vente.valeur;

  _Liste _logements() {
    // Liste complète (sans mode) : décide de l'affichage du sélecteur.
    final tout = ref
        .watch(pageLoueurProvider(partenaireId: widget.partenaireId))
        .value
        ?.resultats;
    final selecteur = aLesDeuxModes([...?tout?.map((l) => l.vente)]);
    final provider = pageLoueurProvider(
      partenaireId: widget.partenaireId,
      filtre: _filtreLogements.avecMode(selecteur ? _mode : null),
    );
    final async = ref.watch(provider);
    return _Liste(
      async: async,
      provider: provider,
      loueur: async.value?.loueur,
      cartes: async.value?.resultats
          .map((l) => CarteLogement(key: ValueKey(l.id), logement: l))
          .toList(),
      nombreFiltres: _filtreLogements.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreLogements(context, _filtreLogements);
        if (choisi != null && mounted) {
          setState(() => _filtreLogements = choisi);
        }
      },
      textes: selecteur && _achat
          ? _Textes.logements.aVendre('logement')
          : _Textes.logements,
      avecSelecteur: selecteur,
    );
  }

  _Liste _vehicules() {
    // Liste complète (sans mode) : décide de l'affichage du sélecteur.
    final tout = ref
        .watch(pageLoueurVehiculesProvider(partenaireId: widget.partenaireId))
        .value
        ?.resultats;
    final selecteur = aLesDeuxModes([...?tout?.map((v) => v.vente)]);
    // Seul le type d'annonce (Louer | Acheter) part au serveur ; les autres
    // critères filtrent ici la liste complète reçue.
    final provider = pageLoueurVehiculesProvider(
      partenaireId: widget.partenaireId,
      filtre: FiltreVehicules(mode: selecteur ? _mode : null),
    );
    final async = ref.watch(provider);
    final annonces = async.value?.resultats;
    // Prix de vente en « Acheter », ou chez un loueur qui ne fait que vendre.
    final achat = selecteur
        ? _achat
        : annonces != null &&
              annonces.isNotEmpty &&
              annonces.every((v) => !v.vente.mode.aLouer);
    return _Liste(
      async: async,
      provider: provider,
      loueur: async.value?.loueur,
      cartes: annonces == null
          ? null
          : [
              for (final v in _filtreVehicules.appliquer(
                annonces,
                achat: achat,
              ))
                CarteVehicule(key: ValueKey(v.id), vehicule: v),
            ],
      nombreFiltres: _filtreVehicules.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreVehicules(
          context,
          _filtreVehicules,
          // Options : ce que le loueur propose dans le type affiché.
          options: OptionsFiltreVehicules.depuis(
            annonces ?? const [],
            achat: achat,
          ),
          achat: achat,
        );
        if (choisi != null && mounted) {
          setState(() => _filtreVehicules = choisi);
        }
      },
      textes: selecteur && _achat
          ? _Textes.vehicules.aVendre('véhicule')
          : _Textes.vehicules,
      avecSelecteur: selecteur,
    );
  }

  /// Filtre véhicules au passage à [mode] (Louer ↔ Acheter) : prix remis à
  /// « Tous » (non comparables), critères absents des annonces du nouveau
  /// type retirés. Ces annonces sont prises dans la liste complète déjà
  /// chargée, comme le serveur (location + vente compte dans les deux).
  FiltreVehicules _filtreVehiculesPour(String mode) {
    final filtre = _filtreVehicules.sansPrix();
    if (widget.type != TypeLocation.vehicule) return filtre;
    final tout =
        ref
            .read(
              pageLoueurVehiculesProvider(partenaireId: widget.partenaireId),
            )
            .value
            ?.resultats ??
        const <VehiculeResume>[];
    final vente = mode == ModeAnnonce.vente.valeur;
    return filtre.limiteA([
      for (final v in tout)
        if (vente ? v.vente.mode.aVendre : v.vente.mode.aLouer) v,
    ]);
  }

  /// Établissement (hôtel, résidence) : son en-tête détaillé, puis ses
  /// hébergements disponibles, filtrés sur place.
  _Liste _hebergements() {
    final provider = pageEtablissementProvider(
      partenaireId: widget.partenaireId,
    );
    final async = ref.watch(provider);
    final page = async.value;
    final disponibles = page?.disponibles;
    return _Liste(
      async: async,
      provider: provider,
      loueur: page?.etablissement.loueur,
      page: page,
      cartes: disponibles == null
          ? null
          : _cartesHebergements(_filtreHebergements.appliquer(disponibles)),
      nombreFiltres: _filtreHebergements.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreHebergements(
          context,
          _filtreHebergements,
          hebergements: disponibles ?? const [],
        );
        if (choisi != null && mounted) {
          setState(() => _filtreHebergements = choisi);
        }
      },
      textes: _Textes.hebergements,
    );
  }

  /// Cartes des hébergements ; avec un séjour : capacité suffisante,
  /// statut « Disponible » / « Complet à ces dates », complets en fin.
  List<Widget> _cartesHebergements(List<HebergementResume> hebergements) {
    final sejour = _sejour;
    if (sejour == null) {
      return [
        for (final h in hebergements)
          CarteHebergement(key: ValueKey(h.id), hebergement: h),
      ];
    }
    final complets = <int, bool>{
      // Statut pas encore connu : entrée absente.
      for (final h in hebergements.where(sejour.capaciteSuffisante))
        h.id: ?ref
            .watch(completSejourProvider((h.id, sejour.arrivee, sejour.depart)))
            .value,
    };
    return [
      for (final h in hebergementsPourSejour(hebergements, sejour, complets))
        CarteHebergement(
          key: ValueKey(h.id),
          hebergement: h,
          sejour: sejour,
          complet: complets[h.id],
        ),
    ];
  }

  /// « Voir tout » / « Voir les chambres » : les dates d'abord, puis la
  /// liste (complète si « Passer »).
  Future<void> _voirHebergements(PageEtablissement page, String nom) async {
    final choix = await choisirSejour(context, hebergements: page.disponibles);
    if (choix == null || !mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EcranLoueur(
          partenaireId: widget.partenaireId,
          type: TypeLocation.hebergement,
          nom: nom,
          listeSeule: true,
          sejour: choix.sejour,
        ),
      ),
    );
  }

  /// Rappel des dates : « Modifier » rouvre la feuille.
  Future<void> _modifierSejour(PageEtablissement page) async {
    final choix = await choisirSejour(
      context,
      hebergements: page.disponibles,
      initial: _sejour,
    );
    if (choix != null && mounted) setState(() => _sejour = choix.sejour);
  }

  @override
  Widget build(BuildContext context) {
    // L'ouverture de la page = une consultation de la fiche du partenaire.
    ref.watch(vueVitrineProvider(partenaireId: widget.partenaireId));
    final liste = switch (widget.type) {
      TypeLocation.logement => _logements(),
      TypeLocation.vehicule => _vehicules(),
      TypeLocation.hebergement => _hebergements(),
    };
    final async = liste.async;
    final textes = liste.textes;
    final loueur = liste.loueur ?? _loueur;
    _loueur = loueur;

    if (loueur == null) {
      if (async.hasError && !async.isLoading) {
        final introuvable = exceptionApi(async.error!)?.code == 404;
        if (introuvable && widget.siIntrouvable != null) {
          return widget.siIntrouvable!;
        }
        return Scaffold(
          appBar: AppBar(title: Text(widget.nom)),
          body: MessageErreur(
            message: messageErreurApi(
              async.error!,
              repli: 'Impossible de charger ce loueur.',
            ),
            onReessayer: () => ref.invalidate(liste.provider),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(title: Text(widget.nom)),
        body: const SqueletteCartes(),
      );
    }

    // Établissement : chambres en carrousel juste après les contacts.
    final page = liste.page;
    if (page != null && !widget.listeSeule) {
      return Scaffold(
        appBar: AppBar(title: Text(loueur.nom)),
        body: VuePageEtablissement(
          etablissement: page.etablissement,
          disponibles: page.disponibles,
          onRefresh: () => rafraichir(ref, liste.provider),
          voirTout: () => _voirHebergements(page, loueur.nom),
        ),
      );
    }

    final cartes = liste.cartes;
    return Scaffold(
      appBar: AppBar(title: Text(loueur.nom)),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: RefreshIndicator(
                onRefresh: () => rafraichir(ref, liste.provider),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    if (!widget.listeSeule)
                      _Entete(
                        loueur: loueur,
                        largeur: largeur,
                        icone: textes.icone,
                      ),
                    if (widget.listeSeule && page != null && _sejour != null)
                      RappelSejour(
                        sejour: _sejour!,
                        onModifier: () => _modifierSejour(page),
                      ),
                    if (liste.avecSelecteur)
                      SelecteurLouerAcheter(
                        mode: _mode,
                        onChange: (mode) => setState(() {
                          _mode = mode;
                          _filtreVehicules = _filtreVehiculesPour(mode);
                        }),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              cartes == null
                                  ? textes.titre
                                  : pluriel(
                                      cartes.length,
                                      textes.singulier,
                                      textes.pluriel,
                                    ),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: liste.filtrer,
                            icon: const Icon(Icons.tune, size: 18),
                            label: Text(
                              liste.nombreFiltres == 0
                                  ? 'Filtrer'
                                  : 'Filtrer (${liste.nombreFiltres})',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cartes == null)
                      async.hasError && !async.isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(24),
                              child: MessageErreur(
                                message: messageErreurApi(
                                  async.error!,
                                  repli: textes.erreur,
                                ),
                                onReessayer: () =>
                                    ref.invalidate(liste.provider),
                              ),
                            )
                          : const _SqueletteBiens()
                    else if (cartes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          liste.nombreFiltres == 0
                              ? textes.vide
                              : textes.videFiltre,
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      for (final carte in cartes)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          child: carte,
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

/// Couverture, logo, nom et boutons de contact du loueur.
class _Entete extends StatelessWidget {
  const _Entete({
    required this.loueur,
    required this.largeur,
    required this.icone,
  });

  final Loueur loueur;
  final double largeur;

  /// Couverture absente : icône du type de location.
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    final l = loueur;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CouvertureNommee(
          couverture: l.couverture,
          logo: l.logo,
          nom: l.nom,
          iconeVide: icone,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          child: LigneContactLoueur(
            telephone: l.telephonePro,
            whatsapp: l.whatsappExterne,
            partenaireId: l.id,
            nom: l.nom,
          ),
        ),
        const Divider(height: 16),
      ],
    );
  }
}

/// Cartes de biens en attente (photo à gauche, lignes à droite).
class _SqueletteBiens extends StatelessWidget {
  const _SqueletteBiens();

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: Column(
        children: [
          for (var i = 0; i < 3; i++)
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Row(
                children: [
                  Squelette(largeur: 108, hauteur: 108, rayon: 12),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Squelette(hauteur: 16),
                        SizedBox(height: 8),
                        Squelette(largeur: 140, hauteur: 12),
                        SizedBox(height: 8),
                        Squelette(largeur: 100, hauteur: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Sélecteur « Louer | Acheter » (même style que les pastilles de
/// localisation) : envoie `?mode=location` ou `?mode=vente`.
class SelecteurLouerAcheter extends StatelessWidget {
  const SelecteurLouerAcheter({
    super.key,
    required this.mode,
    required this.onChange,
  });

  final String mode;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget puce(String libelle, String valeur, IconData icone) {
      final actif = mode == valeur;
      return ChoiceChip(
        avatar: Icon(
          icone,
          size: 16,
          color: actif
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.primary,
        ),
        label: Text(libelle, style: const TextStyle(fontSize: 12)),
        selected: actif,
        onSelected: (_) => onChange(valeur),
        visualDensity: VisualDensity.compact,
        showCheckmark: false,
        selectedColor: theme.colorScheme.primary,
        labelStyle: TextStyle(
          color: actif
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      child: Row(
        children: [
          puce('Louer', ModeAnnonce.location.valeur, Icons.key_outlined),
          const SizedBox(width: 6),
          puce('Acheter', ModeAnnonce.vente.valeur, Icons.sell_outlined),
        ],
      ),
    );
  }
}
