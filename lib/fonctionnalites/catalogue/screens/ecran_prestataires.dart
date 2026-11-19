import 'dart:async';

import 'package:dio/dio.dart' show CancelToken;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poufiret/global/cache/contexte_cache.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/squelette.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_articles.dart';
import 'package:poufiret/fonctionnalites/partenaire/screens/ecran_vitrine_partenaire.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/chat/donnees/chat_providers.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_discussion.dart';
import '../../../global/widgets/champ_recherche.dart';
import '../../../global/widgets/puces_filtre.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../../global/ui/notificateur.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../../commerces/metier_domaine/gabarits.dart';
import '../../commerces/screens/page_gabarit.dart';
import '../../geo/widgets/filtre_localites.dart';
import '../../locations/metier_domaine/location_models.dart';
import '../../locations/screens/ecran_loueur.dart';
import '../../restaurants/metier_domaine/types_restauration.dart';
import '../../restaurants/screens/ecran_restaurant.dart';
import '../../avis/widgets/widgets_avis.dart';
import '../../../global/widgets/bouton_whatsapp.dart';

/// Annuaire d'une catégorie : les prestataires/commerces (couverture + nom).
/// Le client choisit un commerce avant de voir ses articles.
class EcranPrestataires extends ConsumerWidget {
  const EcranPrestataires({
    super.key,
    required this.categorieId,
    required this.categorieNom,
    required this.categorieSlug,
    this.modeTransaction = '',
    this.afficheCatalogue = true,
    this.typesPartenaire = const [],
  });

  /// Faux pour les metiers de service pur : on va droit a la fiche partenaire.
  final bool afficheCatalogue;

  /// Types de partenaire de la categorie (voir [ContenuPrestataires]).
  final List<String> typesPartenaire;

  final int categorieId;
  final String categorieNom;
  final String categorieSlug;
  final String modeTransaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(categorieNom)),
      body: ContenuPrestataires(
        categorieId: categorieId,
        categorieNom: categorieNom,
        categorieSlug: categorieSlug,
        modeTransaction: modeTransaction,
        afficheCatalogue: afficheCatalogue,
        typesPartenaire: typesPartenaire,
      ),
    );
  }
}

/// Contenu de l'annuaire d'une categorie (filtre de localites + liste), sans
/// barre ni Scaffold : partage entre l'ecran ouvert depuis la grille et les
/// onglets de l'accueil, qui affichent directement ce contenu.
class ContenuPrestataires extends ConsumerStatefulWidget {
  const ContenuPrestataires({
    super.key,
    required this.categorieId,
    required this.categorieNom,
    required this.categorieSlug,
    this.modeTransaction = '',
    this.afficheCatalogue = true,
    this.typesPartenaire = const [],
    this.sousCategorieId,
    this.entete,
    this.deuxColonnes = false,
  });

  final bool afficheCatalogue;

  /// Catégorie parente : une seule de ses sous-catégories
  /// (`?sous_categorie=`) ; null : annuaire agrégé.
  final int? sousCategorieId;

  /// Ligne placée sous les pastilles de localisation (sous-catégories).
  final Widget? entete;

  /// Partenaires en grille de 2 colonnes (sous-catégories).
  final bool deuxColonnes;

  /// Types de partenaire de la categorie. L'affichage est le meme pour
  /// toutes ; seul l'ecran ouvert par une tuile en depend (un restaurant
  /// ouvre sa page avec menu du jour et carte, une pharmacie son catalogue,
  /// un loueur ses logements ou ses vehicules).
  final List<String> typesPartenaire;
  final int categorieId;
  final String categorieNom;
  final String categorieSlug;
  final String modeTransaction;

  @override
  ConsumerState<ContenuPrestataires> createState() =>
      _ContenuPrestatairesState();
}

/// Pastilles « Tous | Hôtels | Résidences » (catégorie d'hôteliers).
const typesEtablissement = <(String?, String)>[
  (null, 'Tous'),
  ('hotel', 'Hôtels'),
  ('residence_meublee', 'Résidences'),
];

class _ContenuPrestatairesState extends ConsumerState<ContenuPrestataires> {
  /// Type d'établissement choisi (null : tous).
  String? _typeEtablissement;

  /// « Rechercher un partenaire » : saisie, et terme envoyé au serveur
  /// après une pause de frappe.
  final _champ = TextEditingController();
  Timer? _attente;
  String _recherche = '';

  /// Pages suivantes (2, 3...) chargées au défilement, pour la requête
  /// [_cleSuite] et la première page [_premiere].
  String _cleSuite = '';
  List<PartenaireCategorie>? _premiere;
  final _suite = <PartenaireCategorie>[];
  int _pagesChargees = 1;
  bool _aSuite = false;
  bool _chargementSuite = false;
  Object? _erreurSuite;
  CancelToken? _annulationSuite;

  @override
  void dispose() {
    _attente?.cancel();
    _annulationSuite?.cancel();
    _champ.dispose();
    super.dispose();
  }

  void _surSaisie(String texte) {
    _attente?.cancel();
    _attente = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _recherche = texte.trim());
    });
  }

  void _effacer() {
    _attente?.cancel();
    _champ.clear();
    setState(() => _recherche = '');
  }

  /// Nouvelle requête (catégorie, localités, type, sous-catégorie,
  /// recherche) ou nouvelle première page : la suite repart de la page 2.
  void _suivre(String cle, List<PartenaireCategorie> premiere) {
    if (cle == _cleSuite && identical(premiere, _premiere)) return;
    _annulationSuite?.cancel();
    _annulationSuite = null;
    _cleSuite = cle;
    _premiere = premiere;
    _suite.clear();
    _pagesChargees = 1;
    // Une page pleine laisse supposer une suite ; la page suivante dira
    // (`next`) s'il y en a encore.
    _aSuite = premiere.length >= taillePageAnnuaire;
    _chargementSuite = false;
    _erreurSuite = null;
  }

  /// Page suivante, à l'approche du bas de la liste.
  Future<void> _chargerSuite({
    required String cle,
    required String? type,
  }) async {
    if (_chargementSuite || !_aSuite || _erreurSuite != null) return;
    if (cle != _cleSuite) return;
    final annulation = CancelToken();
    _annulationSuite = annulation;
    setState(() => _chargementSuite = true);
    final page = _pagesChargees + 1;
    final repo = ref.read(catalogueRepositoryProvider);
    try {
      final recu = repo.pagePartenairesDepuis(
        await repo.partenairesParCategorieBrut(
          widget.categorieSlug,
          localites: ref.read(localitesChoisiesProvider),
          typeEtablissement: type,
          sousCategorie: widget.sousCategorieId,
          recherche: _recherche,
          page: page,
          taillePage: taillePageAnnuaire,
          annulation: annulation,
        ),
      );
      if (!mounted || cle != _cleSuite) return;
      final connus = {
        for (final p in [...?_premiere, ..._suite]) p.id,
      };
      final nouveaux = recu.partenaires.where((p) => connus.add(p.id));
      setState(() {
        _suite.addAll(nouveaux);
        _pagesChargees = page;
        // Rien de neuf : on s'arrête (serveur sans pagination).
        _aSuite = recu.aSuite && nouveaux.isNotEmpty;
        _chargementSuite = false;
      });
    } catch (e) {
      if (!mounted || cle != _cleSuite) return;
      if (annulation.isCancelled) return;
      setState(() {
        _chargementSuite = false;
        _erreurSuite = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categorieId = widget.categorieId;
    final categorieSlug = widget.categorieSlug;
    final typesPartenaire = widget.typesPartenaire;
    final afficheCatalogue = widget.afficheCatalogue;
    final modeTransaction = widget.modeTransaction;
    // L affichage de la liste des prestataires = une visite de categorie.
    ref.watch(visiteCategorieProvider(categorieId: categorieId));
    // Hôtels & Résidences : filtre par type, combiné aux localités.
    final hoteliers = typeLocation(typesPartenaire) == TypeLocation.hebergement;
    final type = hoteliers ? _typeEtablissement : null;
    final provider = partenairesParCategorieProvider(
      slug: categorieSlug,
      typeEtablissement: type,
      sousCategorie: widget.sousCategorieId,
      recherche: _recherche,
    );
    final annuaireAsync = ref.watch(provider);
    final localites = ref.watch(localitesChoisiesProvider);
    final cle = [
      categorieSlug,
      type ?? '',
      widget.sousCategorieId ?? '',
      ([...localites]..sort()).join(','),
      _recherche,
    ].join('|');
    return Column(
      children: [
        // Sous la barre, au-dessus des pastilles : recherche serveur
        // (nom, quartier, localité, secteur, description).
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SizedBox(
              height: ChampRecherche.hauteurBande,
              child: Padding(
                padding: ChampRecherche.marges,
                child: ChampRecherche(
                  controleur: _champ,
                  indice: 'Rechercher un partenaire',
                  onChanged: _surSaisie,
                  onEffacer: _effacer,
                ),
              ),
            ),
          ),
        ),
        const FiltreLocalites(),
        ?widget.entete,
        if (hoteliers)
          PucesFiltre<String?>(
            options: typesEtablissement,
            valeur: _typeEtablissement,
            onChange: (t) => setState(() => _typeEtablissement = t),
          ),
        const Divider(height: 1),
        Expanded(
          child: annuaireAsync.when(
            loading: () => const SqueletteListePartenaires(),
            error: (err, _) {
              final message = err is ApiException
                  ? err.messageLisible
                  : 'Erreur de chargement.';
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => ref.invalidate(provider),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            },
            data: (premiere) {
              _suivre(cle, premiere);
              final prestataires = filtrerEtablissements([
                ...premiere,
                ..._suite,
              ], type);
              if (prestataires.isEmpty && !_aSuite) {
                return Center(
                  child: Text(
                    _recherche.isEmpty
                        ? 'Aucun prestataire dans cette catégorie.'
                        : 'Aucun partenaire trouvé',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return GrillePrestataires(
                deuxColonnes: widget.deuxColonnes,
                prestataires: prestataires,
                onRefresh: () => rafraichir(ref, provider),
                onApprocheFin: _aSuite
                    ? () => _chargerSuite(cle: cle, type: type)
                    : null,
                pied: _PiedAnnuaire(
                  chargement: _chargementSuite,
                  erreur: _erreurSuite,
                  onReessayer: () {
                    setState(() => _erreurSuite = null);
                    _chargerSuite(cle: cle, type: type);
                  },
                ),
                // Mur d'inscription : un visiteur non enregistre voit la
                // liste mais doit creer un compte pour ouvrir une fiche
                // partenaire.
                onTap: (prestataire) => murInscription(context, ref, () {
                  final fiche = afficheCatalogue
                      ? EcranArticles(
                          categorieId: categorieId,
                          categorieNom: prestataire.nomCommerce,
                          modeTransaction: modeTransaction,
                          partenaireId: prestataire.id,
                        )
                      : EcranVitrinePartenaire(
                          partenaireId: prestataire.id,
                          modeTransaction: modeTransaction,
                          apercu: prestataire,
                        );
                  final location = typeLocation(typesPartenaire);
                  // Gabarit de la carte, sinon deduit du type du partenaire
                  // ou de la categorie (fast-food, boulangerie, pharmacie,
                  // mode, librairie).
                  final gabarit = gabaritPartenaire(
                    gabarit: prestataire.gabarit,
                    typesPartenaire: prestataire.typesPartenaire,
                    typesCategorie: typesPartenaire,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // Commerce a gabarit ou loueur (logements, vehicules) :
                      // sa page dediee. Un partenaire de la categorie que le
                      // serveur ne connait pas sous ce type garde sa fiche
                      // habituelle.
                      builder: (_) => gabarit != null
                          ? pageGabarit(
                              gabarit,
                              commerceId: prestataire.id,
                              nom: prestataire.nomCommerce,
                              siIntrouvable: fiche,
                            )
                          : estRestauration(typesPartenaire)
                          ? EcranRestaurant(
                              restaurantId: prestataire.id,
                              nom: prestataire.nomCommerce,
                              siIntrouvable: fiche,
                            )
                          : location != null
                          ? EcranLoueur(
                              partenaireId: prestataire.id,
                              type: location,
                              nom: prestataire.nomCommerce,
                              siIntrouvable: fiche,
                            )
                          : fiche,
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Grille des partenaires d'une categorie (couverture, logo, nom), bornee a
/// 700 px, avec « tirer pour rafraichir ».
class GrillePrestataires extends StatelessWidget {
  const GrillePrestataires({
    super.key,
    required this.prestataires,
    required this.onRefresh,
    required this.onTap,
    this.deuxColonnes = false,
    this.onApprocheFin,
    this.pied,
  });

  final List<PartenaireCategorie> prestataires;
  final Future<void> Function() onRefresh;
  final ValueChanged<PartenaireCategorie> onTap;

  /// Appelé quand les dernières cartes se construisent (page suivante).
  final VoidCallback? onApprocheFin;

  /// Sous la grille : chargement de la suite, ou erreur avec « Réessayer ».
  final Widget? pied;

  /// Cartes restantes avant le bas qui déclenchent [onApprocheFin].
  static const int _avance = 4;

  /// Toujours 2 colonnes, cartes compactes (sous-catégories).
  final bool deuxColonnes;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur = contraintes.maxWidth > 700
            ? 700.0
            : contraintes.maxWidth;
        // Colonnes selon la largeur disponible (tuiles ~330px).
        final colonnes = deuxColonnes ? 2 : (largeur / 330).floor().clamp(1, 2);
        return Center(
          child: SizedBox(
            width: largeur,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: pied == null
                        ? const EdgeInsets.all(12)
                        : const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: colonnes,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: deuxColonnes ? 0.78 : 16 / 11,
                      ),
                      itemCount: prestataires.length,
                      itemBuilder: (context, i) {
                        final fin = onApprocheFin;
                        if (fin != null && i >= prestataires.length - _avance) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => fin(),
                          );
                        }
                        return _CartePrestataire(
                          compacte: deuxColonnes,
                          prestataire: prestataires[i],
                          onTap: () => onTap(prestataires[i]),
                        );
                      },
                    ),
                  ),
                  if (pied != null) SliverToBoxAdapter(child: pied),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Bas de l'annuaire : indicateur pendant le chargement de la page
/// suivante, ou erreur réseau avec « Réessayer ».
class _PiedAnnuaire extends StatelessWidget {
  const _PiedAnnuaire({
    required this.chargement,
    required this.erreur,
    required this.onReessayer,
  });

  final bool chargement;
  final Object? erreur;
  final VoidCallback onReessayer;

  @override
  Widget build(BuildContext context) {
    final e = erreur;
    if (e != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              e is ApiException ? e.messageLisible : 'Erreur de chargement.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: onReessayer,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }
    if (!chargement) return const SizedBox(height: 12);
    return const Padding(
      key: ValueKey('annuaire-suite'),
      padding: EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _CartePrestataire extends ConsumerWidget {
  const _CartePrestataire({
    required this.prestataire,
    required this.onTap,
    this.compacte = false,
  });

  final PartenaireCategorie prestataire;
  final VoidCallback onTap;

  /// Demi-largeur : nom et localisation sur toute la largeur, boutons de
  /// contact en dessous.
  final bool compacte;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final logo = prestataire.logo.isNotEmpty
        ? CircleAvatar(
            radius: compacte ? 12 : 16,
            backgroundImage: imageReseauProvider(prestataire.logo),
          )
        : null;
    final nom = Text(
      prestataire.nomCommerce,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: compacte
          ? theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)
          : theme.textTheme.titleMedium,
    );
    final note = prestataire.nbAvis > 0
        ? ResumeNote(
            noteMoyenne: prestataire.noteMoyenne,
            nbAvis: prestataire.nbAvis,
          )
        : null;
    // « Localite - Quartier - Secteur » sous le nom.
    final localisation = prestataire.ligneLocalisation.isEmpty
        ? null
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.place_outlined,
                size: 13,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  prestataire.ligneLocalisation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          );
    final discuter = IconButton(
      icon: FaIcon(FontAwesomeIcons.whatsapp, color: theme.colorScheme.primary),
      tooltip: 'Discuter',
      onPressed: () async {
        // Discuter : compte connecté.
        if (!await exigerConnexion(context) || !context.mounted) {
          return;
        }
        final messenger = ScaffoldMessenger.of(context);
        final nav = Navigator.of(context);
        try {
          final conv = await ref
              .read(chatRepositoryProvider)
              .contacter(partenaireId: prestataire.id);
          nav.push(
            MaterialPageRoute(
              builder: (_) => EcranDiscussion(
                conversationId: conv.id,
                titre: prestataire.nomCommerce,
              ),
            ),
          );
        } catch (_) {
          messenger.showSnackBar(
            Notificateur.snackAvertissement('Connexion requise pour discuter.'),
          );
        }
      },
    );
    // Vrai WhatsApp, si le partenaire l'affiche.
    final whatsapp = IconeWhatsappExterne(
      numero: prestataire.whatsappExterne,
      partenaireId: prestataire.id,
    );

    final infos = compacte
        // Demi-largeur : nom, note, localisation, puis logo et contacts.
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                nom,
                ?note,
                ?localisation,
                Row(children: [?logo, const Spacer(), discuter, whatsapp]),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (logo != null) ...[logo, const SizedBox(width: 8)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nom, puis « ★ 4,5 (12) » s'il a des avis.
                      Row(
                        children: [
                          Flexible(child: nom),
                          if (note != null) ...[const SizedBox(width: 6), note],
                        ],
                      ),
                      ?localisation,
                    ],
                  ),
                ),
                discuter,
                whatsapp,
              ],
            ),
          );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo de couverture (ou fond neutre si absente).
            Expanded(
              child: prestataire.photoCouverture.isNotEmpty
                  ? ImageReseau(
                      prestataire.photoCouverture,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _FondNeutre(theme: theme),
                    )
                  : _FondNeutre(theme: theme),
            ),
            infos,
          ],
        ),
      ),
    );
  }
}

class _FondNeutre extends StatelessWidget {
  const _FondNeutre({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.storefront_outlined,
        size: 48,
        color: theme.colorScheme.outline,
      ),
    );
  }
}
