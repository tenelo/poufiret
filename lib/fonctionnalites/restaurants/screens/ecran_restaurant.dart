import 'dart:math' as math;

import 'package:flutter/material.dart';
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
  const EcranRestaurant({
    super.key,
    required this.restaurantId,
    this.nom = '',
    this.siIntrouvable,
  });

  final int restaurantId;

  /// Nom déjà connu de l'écran précédent, affiché pendant le chargement.
  final String nom;

  /// Écran affiché à la place si le serveur ne connaît pas ce restaurant
  /// (404) : partenaire rangé dans la catégorie sans fiche restaurant.
  final Widget? siIntrouvable;

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
            appBar: AppBar(title: Text(nom)),
            body: const SqueletteVitrine(),
          ),
          error: (err, _) =>
              (exceptionApi(err)?.code == 404 ? siIntrouvable : null) ??
              Scaffold(
                appBar: AppBar(title: Text(nom)),
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
  final _champRecherche = TextEditingController();

  String _recherche = '';

  /// Section affichée (une seule à la fois), par son rang dans la carte.
  int _sectionActive = 0;

  /// Service du menu du jour choisi par l'utilisateur (null = automatique).
  String? _service;

  @override
  void dispose() {
    _champRecherche.dispose();
    super.dispose();
  }

  void _choisirSection(int index) {
    final nb = widget.restaurant.carte.length;
    if (index < 0 || index >= nb || index == _sectionActive) return;
    setState(() => _sectionActive = index);
  }

  /// Balayage horizontal sur la liste : section suivante ou précédente.
  void _balayer(DragEndDetails details) {
    final vitesse = details.primaryVelocity ?? 0;
    if (vitesse.abs() < 300) return;
    _choisirSection(_sectionActive + (vitesse < 0 ? 1 : -1));
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
    // Recherche : les plats de toutes les sections, dans l'ordre de la carte.
    final resultats = enRecherche
        ? [for (final s in r.carte) ...filtrerPlats(s.plats, _recherche)]
        : const <Plat>[];
    final active = r.carte.isEmpty
        ? 0
        : _sectionActive.clamp(0, r.carte.length - 1);
    final section = r.carte.isEmpty ? null : r.carte[active];
    final plats = enRecherche ? resultats : section?.plats ?? const <Plat>[];
    // Un menu sans plat n'est pas affiché.
    final menus = [
      for (final m in r.menus)
        if (m.lignes.isNotEmpty) m,
    ];

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
                if (!enRecherche && menus.isNotEmpty)
                  SliverPadding(
                    padding: marge,
                    sliver: SliverToBoxAdapter(
                      child: _SectionMenuDuJour(
                        restaurant: r,
                        menus: menus,
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
                      // Pendant une recherche, ses résultats remplacent la
                      // section : les onglets s'effacent.
                      libelles: enRecherche
                          ? const []
                          : [for (final s in r.carte) s.nom],
                      sectionActive: active,
                      onSection: _choisirSection,
                    ),
                  ),
                if (section != null && !enRecherche)
                  SliverPadding(
                    padding: marge,
                    sliver: SliverToBoxAdapter(
                      child: _TitreSection(section: section),
                    ),
                  ),
                // Seule la section active (ou les résultats de recherche) :
                // la liste s'arrête à sa fin. Un balayage horizontal change
                // de section.
                SliverPadding(
                  padding: marge,
                  sliver: SliverList.builder(
                    itemCount: plats.length,
                    itemBuilder: (context, i) => GestureDetector(
                      onHorizontalDragEnd: enRecherche ? null : _balayer,
                      child: _TuilePlatCarte(
                        key: ValueKey(plats[i].id),
                        plat: plats[i],
                        onTap: () => _ouvrirPlat(platId: plats[i].id),
                      ),
                    ),
                  ),
                ),
                if (enRecherche && resultats.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'Aucun plat ne correspond à votre recherche.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (r.carte.isEmpty && menus.isEmpty)
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
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 227, 227, 227),
          ),
          tooltip: 'Retour',
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      actions: [
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
          icon: const Icon(
            Icons.info_outline,
            color: Color.fromARGB(255, 227, 227, 227),
          ),
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
    required this.menus,
    required this.service,
    required this.onService,
    required this.onLigne,
  });

  final Restaurant restaurant;

  /// Menus à proposer, chacun avec au moins un plat.
  final List<MenuDuJour> menus;
  final String? service;
  final ValueChanged<String> onService;
  final ValueChanged<LigneMenu> onLigne;

  /// Menu affiché : celui choisi, sinon celui en vigueur maintenant, sinon
  /// le premier.
  MenuDuJour get _menu {
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
          if (menus.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                segments: [
                  for (final m in menus)
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
          BadgeTexte('Épuisé', couleur: Config.couleurTexteSecondaire),
      ],
      mention: !ligne.epuisee && stock != null && stock <= _seuilStockBas
          ? 'Plus que $stock'
          : '',
      attenue: ligne.epuisee || clos,
      onTap: () => onLigne(ligne),
    );
  }
}

/// Barre collante de la carte : recherche, puis onglets des sections (un
/// onglet = une section affichée).
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
  static const double _hauteurOnglets = 47; // BarreOnglets (46) + Divider (1)

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
  const _TitreSection({required this.section});

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
  const _TuilePlatCarte({super.key, required this.plat, required this.onTap});

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
          BadgeTexte('Promo', couleur: Config.couleurPrimaire),
        if (plat.indisponible)
          BadgeTexte('Épuisé', couleur: Config.couleurTexteSecondaire),
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
