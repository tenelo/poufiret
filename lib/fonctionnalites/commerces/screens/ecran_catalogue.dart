import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
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
  /// ligne de contact, « + » sur les tuiles, barre du panier.
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

  /// Zone de texte des cases de grille (l'éleveur en affiche plus ; une
  /// boutique y place son bouton panier).
  double get hauteurTexteGrille => switch (this) {
    Gabarit.elevage => hauteurTexteElevage,
    _ when boutique => hauteurTexteTuileAction,
    _ => 132,
  };
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
    // « + » / compteur du panier ; la fiche si un choix est à faire.
    final panier = BoutonPanierTuile(
      produit: p,
      onOuvrirFiche: () => _ouvrir(p),
    );
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
        action: panier,
      ),
      Gabarit.librairie => LigneProduit(
        key: ValueKey(p.id),
        produit: p,
        ratioPhoto: 2 / 3,
        icone: Icons.menu_book_outlined,
        lignes: [p.auteur, p.niveauClasse],
        mention: p.etatLivre,
        onTap: () => _ouvrir(p),
        action: panier,
      ),
      _ => LigneProduit(
        key: ValueKey(p.id),
        produit: p,
        icone: Icons.medication_outlined,
        lignes: [p.formeDosage, p.laboratoire],
        mention: p.surOrdonnance ? 'Sur ordonnance' : '',
        couleurMention: Config.couleurErreur,
        onTap: () => _ouvrir(p),
        action: p.surOrdonnance
            ? (telephone.isEmpty
                  ? null
                  : TextButton.icon(
                      onPressed: () => appelerPartenaire(
                        context,
                        telephone,
                        partenaireId: widget.commerce.id,
                      ),
                      icon: const Icon(Icons.call_outlined, size: 18),
                      label: const Text('Appeler la pharmacie'),
                    ))
            : panier,
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
                          tuile: _tuile,
                        )
                      : SliverProduitsPagines(
                          key: ValueKey(requete.cle),
                          requete: requete,
                          presentation: g.presentation,
                          hauteurTexte: g.hauteurTexteGrille,
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
          else
            Row(
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
                if (gabarit.boutique)
                  TextButton.icon(
                    onPressed: () => ouvrirFeuilleInfos(context, c),
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('Infos'),
                  ),
              ],
            ),
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
          if (gabarit.boutique) ...[
            // Appeler, Discuter, WhatsApp : la ligne de la page loueur.
            const SizedBox(height: 10),
            LigneContactLoueur(
              telephone: telephone,
              whatsapp: c.whatsappExterne,
              partenaireId: c.id,
              nom: c.nom,
            ),
          ] else if (telephone.isNotEmpty || c.whatsappExterne != null) ...[
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
    required this.tuile,
  });

  final List<Plat> produits;
  final double hauteurTexte;
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
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      sliver: SliverLayoutBuilder(
        builder: (context, contraintes) => SliverGrid.builder(
          gridDelegate: grilleProduits(
            context,
            contraintes.crossAxisExtent,
            hauteurTexte: hauteurTexte,
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
