import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/barre_onglets.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../../orders/donnees/orders_providers.dart';
import '../../orders/screens/ecran_panier.dart';
import '../donnees/restaurants_providers.dart';
import '../metier_domaine/commande_plat.dart';
import '../metier_domaine/restaurant_models.dart';
import '../metier_domaine/tri_restaurants.dart';
import '../metier_domaine/types_restauration.dart';
import '../widgets/carte_restaurant.dart';
import '../widgets/feuille_infos_restaurant.dart';
import '../widgets/feuille_plat.dart';
import '../widgets/tuile_plat.dart';

/// Largeur maximale du contenu sur grand écran.
const double _largeurContenu = 700;

/// Stock en dessous duquel on affiche « Plus que N ».
const int _seuilStockBas = 5;

/// Page d'un restaurant : en-tête, menu du jour, carte par sections.
class EcranRestaurant extends ConsumerWidget {
  const EcranRestaurant({super.key, required this.restaurantId, this.apercu});

  final int restaurantId;

  /// Résumé déjà connu de l'écran précédent : son nom s'affiche pendant le
  /// premier chargement.
  final Restaurant? apercu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // L'ouverture de la page = une consultation de la fiche du partenaire.
    ref.watch(vueVitrineProvider(partenaireId: restaurantId));
    final provider = restaurantDetailProvider(id: restaurantId);
    return ref
        .watch(provider)
        .when(
          // Rechargement (tirer pour rafraîchir) : la page reste affichée.
          skipLoadingOnReload: true,
          loading: () => Scaffold(
            appBar: AppBar(title: Text(apercu?.nom ?? '')),
            body: const SqueletteVitrine(),
          ),
          error: (err, _) => Scaffold(
            appBar: AppBar(title: Text(apercu?.nom ?? '')),
            body: MessageErreur(
              message: messageErreurApi(
                err,
                repli: 'Impossible de charger ce restaurant.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
          ),
          data: (restaurant) => _PageRestaurant(restaurant: restaurant),
        );
  }
}

class _PageRestaurant extends ConsumerStatefulWidget {
  const _PageRestaurant({required this.restaurant});

  final Restaurant restaurant;

  @override
  ConsumerState<_PageRestaurant> createState() => _PageRestaurantState();
}

class _PageRestaurantState extends ConsumerState<_PageRestaurant> {
  final _defilement = ScrollController();
  final _champRecherche = TextEditingController();

  /// Clé de l'en-tête de chaque section (par id), pour la retrouver dans la
  /// zone défilante.
  final _cles = <int, GlobalKey>{};

  /// Sections affichées (après recherche), dans l'ordre des onglets.
  List<SectionCarte> _sections = const [];

  String _recherche = '';
  int _sectionActive = 0;

  /// Service du menu du jour choisi par l'utilisateur (null = automatique).
  String? _service;

  /// Vrai pendant un défilement lancé par un tap sur un onglet : évite que
  /// les sections traversées fassent « sauter » la sélection.
  bool _defilementParTap = false;

  @override
  void initState() {
    super.initState();
    _defilement.addListener(_suivreDefilement);
  }

  @override
  void dispose() {
    _defilement.dispose();
    _champRecherche.dispose();
    super.dispose();
  }

  /// Position de défilement qui amène l'en-tête d'une section juste sous les
  /// barres épinglées (le viewport tient compte de leur hauteur).
  double? _positionSection(SectionCarte section) {
    final objet = _cles[section.id]?.currentContext?.findRenderObject();
    if (objet == null || !objet.attached) return null;
    return RenderAbstractViewport.of(objet).getOffsetToReveal(objet, 0).offset;
  }

  /// Onglet actif = dernière section dont l'en-tête a atteint le haut.
  void _suivreDefilement() {
    if (_defilementParTap || !_defilement.hasClients) return;
    final position = _defilement.position;
    var active = 0;
    if (_sections.isNotEmpty &&
        position.pixels >= position.maxScrollExtent - 1) {
      // Bas de page : la dernière section, même trop courte pour atteindre
      // le haut de l'écran.
      active = _sections.length - 1;
    } else {
      for (var i = 0; i < _sections.length; i++) {
        final cible = _positionSection(_sections[i]);
        if (cible != null && cible <= position.pixels + 1) active = i;
      }
    }
    if (active != _sectionActive) setState(() => _sectionActive = active);
  }

  Future<void> _allerASection(int index) async {
    final position = _positionSection(_sections[index]);
    if (position == null) return;
    setState(() => _sectionActive = index);
    _defilementParTap = true;
    await _defilement.animateTo(
      position.clamp(0, _defilement.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _defilementParTap = false;
  }

  void _ouvrirPlat({int? platId, int? ligneId}) => ouvrirFeuillePlat(
    context,
    restaurantId: widget.restaurant.id,
    platId: platId,
    ligneId: ligneId,
  );

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;
    final enRecherche = _recherche.trim().isNotEmpty;
    final sections = [
      for (final s in r.carte)
        if (filtrerPlats(s.plats, _recherche).isNotEmpty)
          s.copyWith(plats: filtrerPlats(s.plats, _recherche)),
    ];
    _sections = sections;
    final active = sections.isEmpty
        ? 0
        : _sectionActive.clamp(0, sections.length - 1);

    return Scaffold(
      bottomNavigationBar: _BarrePanier(restaurantId: r.id),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = math.min(contraintes.maxWidth, _largeurContenu);
          // Contenu borné et centré sur grand écran.
          final marge = EdgeInsets.symmetric(
            horizontal: (contraintes.maxWidth - largeur) / 2,
          );
          return RefreshIndicator(
            edgeOffset: kToolbarHeight + MediaQuery.paddingOf(context).top,
            onRefresh: () =>
                rafraichir(ref, restaurantDetailProvider(id: r.id)),
            child: CustomScrollView(
              controller: _defilement,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _BarreCouverture(
                  restaurant: r,
                  hauteur: (largeur * 0.5).clamp(160.0, 300.0),
                ),
                SliverPadding(
                  padding: marge,
                  sliver: SliverToBoxAdapter(child: _Entete(restaurant: r)),
                ),
                if (!enRecherche && r.menus.isNotEmpty)
                  SliverPadding(
                    padding: marge,
                    sliver: SliverToBoxAdapter(
                      child: _SectionMenuDuJour(
                        restaurant: r,
                        service: _service,
                        onService: (s) => setState(() => _service = s),
                        onLigne: (ligne) => _ouvrirPlat(ligneId: ligne.id),
                      ),
                    ),
                  ),
                if (r.carte.isNotEmpty)
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _EnteteCarte(
                      marge: marge,
                      champRecherche: _champRecherche,
                      onRecherche: (v) => setState(() => _recherche = v),
                      libelles: [for (final s in sections) s.nom],
                      sectionActive: active,
                      onSection: _allerASection,
                    ),
                  ),
                for (final section in sections) ...[
                  SliverPadding(
                    padding: marge,
                    sliver: SliverToBoxAdapter(
                      child: _TitreSection(
                        key: _cles.putIfAbsent(section.id, GlobalKey.new),
                        section: section,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: marge,
                    // Toutes les lignes ont la hauteur du gabarit : les
                    // plats hors écran ne sont pas construits, et la
                    // position de chaque section reste exacte.
                    sliver: SliverPrototypeExtentList.builder(
                      prototypeItem: TuilePlat.gabarit,
                      itemCount: section.plats.length,
                      itemBuilder: (context, i) => _TuilePlatCarte(
                        plat: section.plats[i],
                        onTap: () => _ouvrirPlat(platId: section.plats[i].id),
                      ),
                    ),
                  ),
                ],
                if (r.carte.isNotEmpty && sections.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'Aucun plat ne correspond à votre recherche.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (r.carte.isEmpty && r.menus.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        "La carte de ce restaurant n'est pas encore en ligne.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Barre du haut : couverture en parallaxe qui se replie en barre de titre.
class _BarreCouverture extends StatelessWidget {
  const _BarreCouverture({required this.restaurant, required this.hauteur});

  final Restaurant restaurant;
  final double hauteur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = restaurant;
    final haut = MediaQuery.paddingOf(context).top;
    return SliverAppBar(
      pinned: true,
      expandedHeight: hauteur,
      // Boutons sur pastille claire : lisibles sur la photo comme sur la
      // barre repliée.
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: IconButton.filledTonal(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Retour',
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      actions: [
        IconButton.filledTonal(
          icon: const Icon(Icons.info_outline),
          tooltip: 'Infos',
          onPressed: () => ouvrirFeuilleInfos(context, r),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, contraintes) {
          // Le nom n'apparaît dans la barre qu'une fois la photo repliée.
          final replie = contraintes.maxHeight <= kToolbarHeight + haut + 8;
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            expandedTitleScale: 1,
            titlePadding: const EdgeInsetsDirectional.only(
              start: 60,
              end: 60,
              bottom: 16,
            ),
            title: AnimatedOpacity(
              opacity: replie ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: Text(
                r.nom,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.appBarTheme.titleTextStyle,
              ),
            ),
            background: r.couverture.isEmpty
                ? ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.restaurant,
                      size: 56,
                      color: theme.colorScheme.outline,
                    ),
                  )
                : ImageReseau(
                    r.couverture,
                    fit: BoxFit.cover,
                    largeurAffichee: contraintes.maxWidth,
                  ),
          );
        },
      ),
    );
  }
}

/// Logo, nom, délai, services et accès aux infos pratiques.
class _Entete extends StatelessWidget {
  const _Entete({required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = restaurant;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (r.logo.isNotEmpty) ...[
                MedaillonLogo(url: r.logo, rayon: 26),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.nom,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => ouvrirFeuilleInfos(context, r),
                icon: const Icon(Icons.info_outline, size: 18),
                label: const Text('Infos'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InfosPratiques(restaurant: r),
        ],
      ),
    );
  }
}

/// « Menu du jour », mis en avant sous l'en-tête : onglets de service selon
/// les menus présents, puis les plats avec prix du menu et stock.
class _SectionMenuDuJour extends StatelessWidget {
  const _SectionMenuDuJour({
    required this.restaurant,
    required this.service,
    required this.onService,
    required this.onLigne,
  });

  final Restaurant restaurant;
  final String? service;
  final ValueChanged<String> onService;
  final ValueChanged<LigneMenu> onLigne;

  /// Menu affiché : celui choisi, sinon celui en vigueur maintenant, sinon
  /// le premier.
  MenuDuJour get _menu {
    final menus = restaurant.menus;
    MenuDuJour? pour(bool Function(MenuDuJour) test) =>
        menus.where(test).firstOrNull;
    return pour((m) => m.service == service) ??
        pour((m) => restaurant.servicesEnVigueur.contains(m.service)) ??
        menus.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menu = _menu;
    final limite = menu.heureLimiteCommande;
    final clos = !menu.commandable || heureLimiteDepassee(menu, DateTime.now());
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      clipBehavior: Clip.antiAlias,
      // Fond teinté : la section se détache de la carte permanente.
      color: Color.alphaBlend(
        Config.couleurClaire.withValues(alpha: 0.18),
        Config.couleurSurface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: Row(
              children: [
                Icon(Icons.today, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    menu.titre.isEmpty ? 'Menu du jour' : menu.titre,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (restaurant.menus.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                segments: [
                  for (final m in restaurant.menus)
                    ButtonSegment(
                      value: m.service,
                      label: Text(libellesServiceMenu[m.service] ?? m.service),
                    ),
                ],
                selected: {menu.service},
                onSelectionChanged: (s) => onService(s.first),
              ),
            ),
          if (clos || limite != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Text(
                clos
                    ? limite == null
                          ? "Ce menu n'est plus commandable"
                          : 'Commandes closes depuis ${formatHeure(limite)}'
                    : "Commandable jusqu'à ${formatHeure(limite)}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: clos
                      ? Config.couleurErreur
                      : Config.couleurTexteSecondaire,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (menu.lignes.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Aucun plat dans ce menu pour le moment.'),
            ),
          for (final ligne in menu.lignes) _tuile(ligne, clos: clos),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _tuile(LigneMenu ligne, {required bool clos}) {
    final plat = restaurant.platDeLigne(ligne);
    final stock = ligne.stockRestant;
    return TuilePlat(
      nom: plat.nom.isEmpty ? ligne.platNom : plat.nom,
      description: plat.description,
      image: ligne.image.isNotEmpty ? ligne.image : plat.image,
      prix: formatMontant(ligne.prixEffectif),
      badges: [
        if (ligne.epuisee)
          const BadgeTexte('Épuisé', couleur: Config.couleurTexteSecondaire),
      ],
      mention: !ligne.epuisee && stock != null && stock <= _seuilStockBas
          ? 'Plus que $stock'
          : '',
      attenue: ligne.epuisee || clos,
      onTap: () => onLigne(ligne),
    );
  }
}

/// Barre collante de la carte : recherche, puis onglets des sections qui
/// suivent le défilement.
class _EnteteCarte extends SliverPersistentHeaderDelegate {
  _EnteteCarte({
    required this.marge,
    required this.champRecherche,
    required this.onRecherche,
    required this.libelles,
    required this.sectionActive,
    required this.onSection,
  });

  final EdgeInsets marge;
  final TextEditingController champRecherche;
  final ValueChanged<String> onRecherche;
  final List<String> libelles;
  final int sectionActive;
  final ValueChanged<int> onSection;

  static const double _hauteurRecherche = 56;
  static const double _hauteurOnglets = 45;

  /// Les onglets n'ont de sens qu'à partir de deux sections.
  bool get _avecOnglets => libelles.length > 1;

  @override
  double get minExtent =>
      _hauteurRecherche + (_avecOnglets ? _hauteurOnglets : 0);

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Config.couleurFond,
      elevation: overlapsContent ? 1 : 0,
      child: Padding(
        padding: marge,
        child: Column(
          children: [
            SizedBox(
              height: _hauteurRecherche,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: TextField(
                  controller: champRecherche,
                  onChanged: onRecherche,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher dans la carte',
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            if (_avecOnglets) ...[
              BarreOnglets(
                libelles: libelles,
                selectionIndex: sectionActive,
                onChoisir: onSection,
              ),
              const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_EnteteCarte ancien) =>
      ancien.sectionActive != sectionActive ||
      ancien.marge != marge ||
      ancien.libelles.join('|') != libelles.join('|');
}

class _TitreSection extends StatelessWidget {
  const _TitreSection({super.key, required this.section});

  final SectionCarte section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.icone.isEmpty
                ? section.nom
                : '${section.icone} ${section.nom}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (section.description.isNotEmpty)
            Text(
              section.description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
        ],
      ),
    );
  }
}

/// Un plat de la carte : « à partir de » si le prix dépend de la variante,
/// badges Promo / Épuisé.
class _TuilePlatCarte extends StatelessWidget {
  const _TuilePlatCarte({required this.plat, required this.onTap});

  final Plat plat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final prix = formatMontant(prixAPartirDe(plat));
    return TuilePlat(
      nom: plat.nom,
      description: plat.description,
      image: plat.image,
      prix: aPrixVariable(plat) ? 'à partir de $prix' : prix,
      badges: [
        if (plat.estEnPromotion && !plat.indisponible)
          const BadgeTexte('Promo', couleur: Config.couleurPrimaire),
        if (plat.indisponible)
          const BadgeTexte('Épuisé', couleur: Config.couleurTexteSecondaire),
      ],
      attenue: plat.indisponible,
      onTap: onTap,
    );
  }
}

/// Raccourci vers le panier, visible dès qu'il contient un plat de ce
/// restaurant.
class _BarrePanier extends ConsumerWidget {
  const _BarrePanier({required this.restaurantId});

  final int restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paniers = ref.watch(paniersProvider).value ?? const [];
    final panier = paniers
        .where((p) => p.partenaire == restaurantId && p.lignes.isNotEmpty)
        .firstOrNull;
    if (panier == null) return const SizedBox.shrink();
    final nb = panier.lignes.fold<int>(0, (n, l) => n + l.quantite);
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _largeurContenu),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const EcranPanier())),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(
                  'Voir le panier ($nb) · ${formatMontant(panier.total)}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
