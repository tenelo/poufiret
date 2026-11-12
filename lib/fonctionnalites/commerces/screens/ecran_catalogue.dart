import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/barre_onglets.dart';
import '../../../global/widgets/couverture_nommee.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../../analytics/donnees/service_suivi.dart';
import '../../restaurants/donnees/restaurants_providers.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../../restaurants/widgets/carte_restaurant.dart' show MedaillonLogo;
import '../../restaurants/widgets/feuille_infos_restaurant.dart';
import '../donnees/commerces_providers.dart';
import '../metier_domaine/catalogue_commerce.dart';
import '../metier_domaine/fiche_produit.dart';
import '../metier_domaine/gabarits.dart';
import '../metier_domaine/meta_gabarits.dart';
import '../widgets/ajout_panier.dart';
import '../widgets/feuille_filtre_catalogue.dart';
import '../widgets/liste_produits_paginee.dart';
import '../widgets/tuile_elevage.dart';
import '../widgets/tuiles_produits.dart';
import 'ecran_produit.dart';
import '../../../global/widgets/bouton_whatsapp.dart';
import '../../locations/widgets/elements_fiche.dart' show LigneContactLoueur;

const double _largeurContenu = 700;

/// « 2026-10-21T08:00:00 » → « 21/10/2026 à 08h00 » ; « 2026-10-21 » →
/// « 21/10/2026 » ; un texte libre reste tel quel.
String formatGarde(String brut) {
  final d = DateTime.tryParse(brut.trim());
  if (d == null) return brut.trim();
  String deux(int n) => n.toString().padLeft(2, '0');
  final jour = '${deux(d.day)}/${deux(d.month)}/${d.year}';
  final avecHeure = brut.contains('T') || brut.contains(' ');
  return avecHeure ? '$jour à ${deux(d.hour)}h${deux(d.minute)}' : jour;
}

/// Numéro à appeler : le téléphone pro, sinon le premier de la fiche.
String telephoneCommerce(Restaurant r) => r.telephonePro.isNotEmpty
    ? r.telephonePro
    : r.fiche.telephones
              .where((t) => t.numero.isNotEmpty)
              .firstOrNull
              ?.numero ??
          '';

/// Page catalogue d'un commerce (pharmacie, mode, librairie) : en-tête,
/// recherche ou « Filtrer », onglets des rayons (un rayon à la fois) et la
/// liste paginée des produits.
class EcranCatalogue extends ConsumerWidget {
  const EcranCatalogue({
    super.key,
    required this.commerceId,
    required this.gabarit,
    this.nom = '',
    this.siIntrouvable,
  });

  final int commerceId;
  final Gabarit gabarit;

  /// Nom déjà connu de l'écran précédent, affiché pendant le chargement.
  final String nom;

  /// Écran affiché à la place si le serveur ne connaît pas ce commerce
  /// (404) : sa fiche habituelle.
  final Widget? siIntrouvable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // L'ouverture de la page = une consultation de la fiche du partenaire.
    ref.watch(vueVitrineProvider(partenaireId: commerceId));
    final provider = restaurantDetailProvider(id: commerceId);
    return ref
        .watch(provider)
        .when(
          skipLoadingOnReload: true,
          loading: () => Scaffold(
            appBar: AppBar(title: Text(nom)),
            body: const SqueletteListeLignes(),
          ),
          error: (err, _) =>
              (exceptionApi(err)?.code == 404 ? siIntrouvable : null) ??
              Scaffold(
                appBar: AppBar(title: Text(nom)),
                body: MessageErreur(
                  message: messageErreurApi(
                    err,
                    repli: 'Impossible de charger ce commerce.',
                  ),
                  onReessayer: () => ref.invalidate(provider),
                ),
              ),
          data: (commerce) => _Page(commerce: commerce, gabarit: gabarit),
        );
  }
}

/// Ce qui change d'un gabarit à l'autre.
extension ProfilCatalogue on Gabarit {
  bool get avecRecherche =>
      this == Gabarit.pharmacie || this == Gabarit.librairie;

  String get indiceRecherche => switch (this) {
    Gabarit.pharmacie => 'Rechercher un médicament, un produit…',
    Gabarit.librairie => 'Titre, auteur ou ISBN',
    _ => 'Rechercher',
  };

  bool get avecPrixMax => this == Gabarit.mode;

  Presentation get presentation =>
      this == Gabarit.mode || this == Gabarit.elevage
      ? Presentation.grille
      : Presentation.liste;

  /// Photo de couverture en tête de page.
  bool get avecCouverture => this == Gabarit.elevage;

  /// Commerce « boutique » (boulangerie, pharmacie, librairie, mode) :
  /// contacts sur la ligne du nom, « Infos », barre du panier.
  bool get boutique =>
      this == Gabarit.boulangerie ||
      this == Gabarit.pharmacie ||
      this == Gabarit.librairie ||
      this == Gabarit.mode;

  /// Icône du commerce (sans logo ni photo).
  IconData get icone => switch (this) {
    Gabarit.restaurant => Icons.restaurant,
    Gabarit.boulangerie => Icons.bakery_dining_outlined,
    Gabarit.pharmacie => Icons.medication_outlined,
    Gabarit.mode => Icons.checkroom_outlined,
    Gabarit.librairie => Icons.menu_book_outlined,
    Gabarit.elevage => Icons.storefront_outlined,
  };

  /// Zone de texte des cases de grille (l'éleveur en affiche plus).
  double get hauteurTexteGrille =>
      this == Gabarit.elevage ? hauteurTexteElevage : 132;
}

class _Page extends ConsumerStatefulWidget {
  const _Page({required this.commerce, required this.gabarit});

  final Restaurant commerce;
  final Gabarit gabarit;

  @override
  ConsumerState<_Page> createState() => _PageState();
}

class _PageState extends ConsumerState<_Page> {
  final _champ = TextEditingController();
  Timer? _attente;
  String _recherche = '';
  int _rayon = 0;
  FiltreCatalogue _filtre = const FiltreCatalogue();

  @override
  void dispose() {
    _attente?.cancel();
    _champ.dispose();
    super.dispose();
  }

  /// La recherche part après une courte pause de frappe.
  void _surSaisie(String texte) {
    _attente?.cancel();
    _attente = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _recherche = texte.trim());
    });
  }

  List<ChampFiltre> get _champs =>
      (ref.read(metaGabaritsProvider).value ?? MetaGabarits.vide).champsFiltre(
        widget.gabarit,
      );

  bool get _avecFiltre => _champs.isNotEmpty || widget.gabarit.avecPrixMax;

  Future<void> _filtrer() async {
    final choisi = await ouvrirFiltreCatalogue(
      context,
      actuel: _filtre,
      champs: _champs,
      avecPrixMax: widget.gabarit.avecPrixMax,
    );
    if (choisi != null && mounted) setState(() => _filtre = choisi);
  }

  /// Produits affichés : recherche sur tout le commerce, sinon le rayon
  /// choisi.
  RequeteProduits get _requete {
    final rayons = widget.commerce.carte;
    final enRecherche = _recherche.isNotEmpty;
    final rayon = rayons.isEmpty
        ? null
        : rayons[_rayon.clamp(0, rayons.length - 1)];
    return RequeteProduits(
      commerceId: widget.commerce.id,
      sectionId: enRecherche ? null : rayon?.id,
      recherche: _recherche,
      filtre: _filtre,
    );
  }

  void _ouvrir(Plat p) {
    // Produit trouvé par une recherche : le toucher est compté.
    if (_recherche.isNotEmpty) {
      suivreClicRecherche(
        context,
        ref.read(produitsPaginesProvider(_requete)).rechercheId,
        'article',
        p.id,
      );
    }
    Navigator.of(context).push(_routeProduit(p));
  }

  MaterialPageRoute<void> _routeProduit(Plat p) => MaterialPageRoute(
    builder: (_) => EcranProduit(
      produitId: p.id,
      gabarit: widget.gabarit,
      titre: p.nom,
      telephoneCommerce: telephoneCommerce(widget.commerce),
    ),
  );

  Widget _tuile(BuildContext context, Plat p) {
    final telephone = telephoneCommerce(widget.commerce);
    return switch (widget.gabarit) {
      Gabarit.elevage => TuileElevage(
        key: ValueKey(p.id),
        produit: p,
        onTap: () => _ouvrir(p),
      ),
      Gabarit.mode => TuileGrilleProduit(
        key: ValueKey(p.id),
        produit: p,
        surTitre: p.marque,
        icone: Icons.checkroom_outlined,
        onTap: () => _ouvrir(p),
      ),
      Gabarit.librairie => LigneProduit(
        key: ValueKey(p.id),
        produit: p,
        ratioPhoto: 2 / 3,
        icone: Icons.menu_book_outlined,
        lignes: [p.auteur, p.niveauClasse],
        mention: p.etatLivre,
        onTap: () => _ouvrir(p),
      ),
      _ => LigneProduit(
        key: ValueKey(p.id),
        produit: p,
        icone: Icons.medication_outlined,
        lignes: [p.formeDosage, p.laboratoire],
        mention: p.surOrdonnance ? 'Sur ordonnance' : '',
        couleurMention: Config.couleurErreur,
        onTap: () => _ouvrir(p),
        // Pas de bouton d'ajout : on ajoute depuis la fiche produit.
        action: p.surOrdonnance && telephone.isNotEmpty
            ? TextButton.icon(
                onPressed: () => appelerPartenaire(
                  context,
                  telephone,
                  partenaireId: widget.commerce.id,
                ),
                icon: const Icon(Icons.call_outlined, size: 18),
                label: const Text('Appeler la pharmacie'),
              )
            : null,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(metaGabaritsProvider);
    final c = widget.commerce;
    final g = widget.gabarit;
    final rayons = c.carte;
    final enRecherche = _recherche.isNotEmpty;
    final rayon = rayons.isEmpty
        ? null
        : rayons[_rayon.clamp(0, rayons.length - 1)];
    final requete = _requete;
    final avecOnglets = rayons.length > 1 && !enRecherche;
    // Mode (boutique en grille) : tuile ajustée à son contenu, rien de
    // vide sous le prix.
    double hauteurAjusteeMode(List<Plat> produits) => hauteurTexteAjustee(
      context,
      surTitre: produits.any((p) => p.marque.isNotEmpty),
      mention: produits.any((p) => p.toutEpuise),
    );
    final hauteurAjustee = g == Gabarit.mode ? hauteurAjusteeMode : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(c.nom),
        // Boutique : « Infos », comme sur la boulangerie.
        actions: [
          if (g.boutique)
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Infos',
              onPressed: () => ouvrirFeuilleInfos(context, c),
            ),
        ],
      ),
      // Boutique : « n article(s) · total — Voir le panier ».
      bottomNavigationBar: g.boutique
          ? BarrePanierCommerce(partenaireId: c.id, largeurMax: _largeurContenu)
          : null,
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = math.min(contraintes.maxWidth, _largeurContenu);
          final marge = EdgeInsets.symmetric(
            horizontal: (contraintes.maxWidth - largeur) / 2,
          );
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(produitsPaginesProvider(requete));
              await rafraichir(ref, restaurantDetailProvider(id: c.id));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: marge,
                  sliver: SliverToBoxAdapter(
                    child: _EnteteCommerce(commerce: c, gabarit: g),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _BarreCatalogue(
                    marge: marge,
                    recherche: g.avecRecherche
                        ? TextField(
                            controller: _champ,
                            onChanged: _surSaisie,
                            onSubmitted: (v) {
                              _attente?.cancel();
                              setState(() => _recherche = v.trim());
                            },
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: g.indiceRecherche,
                              prefixIcon: const Icon(Icons.search),
                              isDense: true,
                              suffixIcon: _champ.text.isEmpty
                                  ? null
                                  : IconButton(
                                      tooltip: 'Effacer',
                                      icon: const Icon(Icons.close),
                                      onPressed: () => setState(() {
                                        _champ.clear();
                                        _recherche = '';
                                      }),
                                    ),
                            ),
                          )
                        : null,
                    boutonFiltre: _avecFiltre
                        ? OutlinedButton.icon(
                            onPressed: _filtrer,
                            icon: const Icon(Icons.tune, size: 18),
                            label: Text(
                              _filtre.nombre == 0
                                  ? 'Filtrer'
                                  : 'Filtrer (${_filtre.nombre})',
                            ),
                          )
                        : null,
                    titre: enRecherche
                        ? 'Résultats pour « $_recherche »'
                        : rayon?.nom ?? 'Produits',
                    onglets: avecOnglets
                        ? [for (final r in rayons) r.nom]
                        : const [],
                    ongletActif: _rayon.clamp(
                      0,
                      math.max(rayons.length - 1, 0),
                    ),
                    onOnglet: (i) => setState(() => _rayon = i),
                  ),
                ),
                SliverPadding(
                  padding: marge,
                  // Produits joints à la fiche (sans pagination publique) :
                  // affichés et filtrés sur place ; sinon page par page.
                  sliver:
                      !c.paginationPublique &&
                          !enRecherche &&
                          (rayon?.plats.isNotEmpty ?? false)
                      ? _GrilleLocale(
                          produits: rayon!.plats.where(_filtre.garde).toList(),
                          hauteurTexte: g.hauteurTexteGrille,
                          hauteurTexteSelon: hauteurAjustee,
                          tuile: _tuile,
                        )
                      : SliverProduitsPagines(
                          key: ValueKey(requete.cle),
                          requete: requete,
                          presentation: g.presentation,
                          hauteurTexte: g.hauteurTexteGrille,
                          hauteurTexteSelon: hauteurAjustee,
                          tuile: _tuile,
                          vide: 'Aucun produit dans ce rayon pour le moment.',
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Logo, nom, localisation, garde (pharmacie), Appeler et WhatsApp.
class _EnteteCommerce extends StatelessWidget {
  const _EnteteCommerce({required this.commerce, required this.gabarit});

  final Restaurant commerce;
  final Gabarit gabarit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = commerce;
    final telephone = telephoneCommerce(c);
    final garde = c.fiche.deGarde;
    final jusquAu = c.fiche.deGardeJusquAu ?? '';
    // Avec couverture, le logo et le nom sont posés dessus.
    final avecCouverture = gabarit.avecCouverture && c.couverture.isNotEmpty;
    final identite = Row(
      children: [
        if (c.logo.isNotEmpty) ...[
          MedaillonLogo(url: c.logo, rayon: 24),
          const SizedBox(width: 12),
        ] else if (gabarit.boutique) ...[
          // Sans logo : l'icône du commerce.
          IconeCommerce(gabarit: gabarit),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.nom,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (c.localisation.isNotEmpty)
                Text(
                  c.localisation,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
    final entete = Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (avecCouverture)
            if (c.localisation.isNotEmpty)
              Text(
                c.localisation,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              )
            else
              const SizedBox.shrink()
          else if (gabarit.boutique)
            // « Infos » et Appeler, Discuter, WhatsApp sur la ligne du nom.
            LigneNomBoutique(commerce: c, identite: identite)
          else
            identite,
          if (gabarit == Gabarit.pharmacie && garde)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.local_pharmacy_outlined,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      jusquAu.isEmpty
                          ? 'Pharmacie de garde'
                          : "Pharmacie de garde jusqu'au ${formatGarde(jusquAu)}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (!gabarit.boutique &&
              (telephone.isNotEmpty || c.whatsappExterne != null)) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                if (telephone.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => appelerPartenaire(
                        context,
                        telephone,
                        partenaireId: c.id,
                      ),
                      icon: const Icon(Icons.call_outlined, size: 18),
                      label: const Text('Appeler'),
                    ),
                  ),
                if (telephone.isNotEmpty && c.whatsappExterne != null)
                  const SizedBox(width: 12),
                // Vrai WhatsApp, seulement si le partenaire l'affiche.
                if (c.whatsappExterne != null)
                  Expanded(
                    child: BoutonWhatsappExterne(
                      numero: c.whatsappExterne,
                      partenaireId: c.id,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
    if (!avecCouverture) return entete;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CouvertureNommee(
          couverture: c.couverture,
          logo: c.logo,
          nom: c.nom,
          iconeVide: Icons.storefront_outlined,
        ),
        entete,
      ],
    );
  }
}

/// Ligne du nom d'une boutique : [identite] (logo, nom...), « Infos », puis
/// Appeler, Discuter et WhatsApp (selon ce qui existe) s'il reste au moins
/// [largeurIdentiteMin] à l'identité ; sinon les contacts passent sous le
/// nom, alignés à gauche.
class LigneNomBoutique extends StatelessWidget {
  const LigneNomBoutique({
    super.key,
    required this.commerce,
    required this.identite,
    this.centrer = true,
  });

  final Restaurant commerce;
  final Widget identite;

  /// Boutons centrés sur la hauteur de la ligne (sinon en haut).
  final bool centrer;

  static const largeurIdentiteMin = 170.0;

  @override
  Widget build(BuildContext context) {
    final c = commerce;
    return _LigneAdaptative(
      centrer: centrer,
      children: [
        identite,
        TextButton.icon(
          onPressed: () => ouvrirFeuilleInfos(context, c),
          icon: const Icon(Icons.info_outline, size: 18),
          label: const Text('Infos'),
        ),
        LigneContactLoueur(
          telephone: telephoneCommerce(c),
          whatsapp: c.whatsappExterne,
          partenaireId: c.id,
          nom: c.nom,
          compacte: true,
        ),
      ],
    );
  }
}

/// Trois enfants : identité, « Infos », contacts (voir [LigneNomBoutique]).
class _LigneAdaptative extends MultiChildRenderObjectWidget {
  const _LigneAdaptative({required this.centrer, required super.children});

  final bool centrer;

  @override
  _RenduLigneAdaptative createRenderObject(BuildContext context) =>
      _RenduLigneAdaptative(centrer);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenduLigneAdaptative renderObject,
  ) => renderObject.centrer = centrer;
}

class _DonneesLigne extends ContainerBoxParentData<RenderBox> {}

class _RenduLigneAdaptative extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DonneesLigne>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DonneesLigne> {
  _RenduLigneAdaptative(this._centrer);

  bool _centrer;
  set centrer(bool valeur) {
    if (valeur == _centrer) return;
    _centrer = valeur;
    markNeedsLayout();
  }

  /// Entre « Infos » et les contacts ; sous le nom, si à la ligne.
  static const _ecart = 8.0;
  static const _ecartVertical = 10.0;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DonneesLigne) child.parentData = _DonneesLigne();
  }

  @override
  void performLayout() {
    final identite = firstChild!;
    final infos = childAfter(identite)!;
    final contacts = childAfter(infos)!;
    final largeur = constraints.maxWidth;
    final libre = BoxConstraints(maxWidth: largeur);
    infos.layout(libre, parentUsesSize: true);
    contacts.layout(libre, parentUsesSize: true);
    final enLigne =
        largeur - infos.size.width - _ecart - contacts.size.width >=
        LigneNomBoutique.largeurIdentiteMin;
    final largeurIdentite = math.max(
      0.0,
      largeur - infos.size.width - (enLigne ? _ecart + contacts.size.width : 0),
    );
    identite.layout(
      BoxConstraints.tightFor(width: largeurIdentite),
      parentUsesSize: true,
    );
    final hauteurLigne = [
      identite.size.height,
      infos.size.height,
      if (enLigne) contacts.size.height,
    ].reduce(math.max);
    void placer(RenderBox enfant, double x, double y) =>
        (enfant.parentData! as _DonneesLigne).offset = Offset(x, y);
    double haut(RenderBox enfant) =>
        _centrer ? (hauteurLigne - enfant.size.height) / 2 : 0;
    placer(identite, 0, haut(identite));
    placer(infos, largeurIdentite, haut(infos));
    var hauteur = hauteurLigne;
    if (enLigne) {
      placer(
        contacts,
        largeurIdentite + infos.size.width + _ecart,
        haut(contacts),
      );
    } else {
      placer(contacts, 0, hauteurLigne + _ecartVertical);
      hauteur += _ecartVertical + contacts.size.height;
    }
    size = constraints.constrain(Size(largeur, hauteur));
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}

/// Icône d'un commerce sans logo, à la place du médaillon.
class IconeCommerce extends StatelessWidget {
  const IconeCommerce({super.key, required this.gabarit, this.rayon = 24});

  final Gabarit gabarit;
  final double rayon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      radius: rayon,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Icon(gabarit.icone, color: theme.colorScheme.primary),
    );
  }
}

/// Grille des produits joints à la fiche (rayon non paginé).
class _GrilleLocale extends StatelessWidget {
  const _GrilleLocale({
    required this.produits,
    required this.hauteurTexte,
    required this.hauteurTexteSelon,
    required this.tuile,
  });

  final List<Plat> produits;
  final double hauteurTexte;
  final double Function(List<Plat> produits)? hauteurTexteSelon;
  final Widget Function(BuildContext context, Plat produit) tuile;

  @override
  Widget build(BuildContext context) {
    if (produits.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Aucun produit ne correspond à ces critères.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final hauteur = hauteurTexteSelon?.call(produits) ?? hauteurTexte;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      sliver: SliverLayoutBuilder(
        builder: (context, contraintes) => SliverGrid.builder(
          gridDelegate: grilleProduits(
            context,
            contraintes.crossAxisExtent,
            hauteurTexte: hauteur,
          ),
          itemCount: produits.length,
          itemBuilder: (context, i) => tuile(context, produits[i]),
        ),
      ),
    );
  }
}

/// Barre collante : recherche (pharmacie, librairie), titre du rayon et
/// bouton « Filtrer », onglets des rayons.
class _BarreCatalogue extends SliverPersistentHeaderDelegate {
  _BarreCatalogue({
    required this.marge,
    required this.recherche,
    required this.boutonFiltre,
    required this.titre,
    required this.onglets,
    required this.ongletActif,
    required this.onOnglet,
  });

  final EdgeInsets marge;
  final Widget? recherche;
  final Widget? boutonFiltre;
  final String titre;
  final List<String> onglets;
  final int ongletActif;
  final ValueChanged<int> onOnglet;

  static const double _hauteurRecherche = 60;
  static const double _hauteurTitre = 48;
  static const double _hauteurOnglets = 46;

  @override
  double get minExtent =>
      (recherche == null ? 0 : _hauteurRecherche) +
      _hauteurTitre +
      (onglets.isEmpty ? 0 : _hauteurOnglets);

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(BuildContext context, double decalage, bool recouvre) {
    final theme = Theme.of(context);
    return Material(
      color: Config.couleurFond,
      elevation: recouvre ? 1 : 0,
      child: Padding(
        padding: marge,
        child: Column(
          children: [
            if (recherche != null)
              SizedBox(
                height: _hauteurRecherche,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: recherche,
                ),
              ),
            if (onglets.isNotEmpty)
              SizedBox(
                height: _hauteurOnglets - 1,
                child: BarreOnglets(
                  libelles: onglets,
                  selectionIndex: ongletActif,
                  onChoisir: onOnglet,
                ),
              ),
            if (onglets.isNotEmpty) const Divider(height: 1),
            SizedBox(
              height: _hauteurTitre,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        titre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ?boutonFiltre,
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
  bool shouldRebuild(_BarreCatalogue ancien) => true;
}
