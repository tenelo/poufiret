import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/categorie.dart';
import 'package:poufiret/features/catalogue/domain/partenaire_categorie.dart';
import 'package:poufiret/features/map/data/map_providers.dart';
import 'package:poufiret/features/map/data/service_position.dart';

/// Centre par defaut : Ferkessedougou (si la position n'est pas dispo).
const _centreDefaut = LatLng(9.5928, -5.1942);

class EcranMap extends ConsumerStatefulWidget {
  const EcranMap({super.key});
  @override
  ConsumerState<EcranMap> createState() => _EcranMapState();
}

class _EcranMapState extends ConsumerState<EcranMap>
    with WidgetsBindingObserver {
  GoogleMapController? _controller;

  double? _lat;
  double? _lng;
  bool _hybride = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Retente automatiquement quand l'utilisateur revient des paramètres.
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(positionUtilisateurProvider);
    }
  }

  Future<void> _recentrer() async {
    if (_lat == null || _lng == null || _controller == null) return;
    await _controller!.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(_lat!, _lng!), 14),
    );
  }

  Future<void> _zoomer(bool avant) async {
    if (_controller == null) return;
    await _controller!.animateCamera(
      avant ? CameraUpdate.zoomIn() : CameraUpdate.zoomOut(),
    );
  }

  Future<void> _rafraichir() async {
    ref.invalidate(partenairesCarteProvider);
    ref.invalidate(categoriesProvider);
    await ref.read(partenairesCarteProvider.future);
  }

  /// Distance formatee (m si < 1 km, sinon km).
  String _distance(double metres) {
    if (metres < 1000) return '${metres.round()} m';
    return '${(metres / 1000).toStringAsFixed(2)} km';
  }

  /// Retourne (partenaire le plus proche, distance) ou null.
  ({PartenaireCategorie p, double d})? _plusProche(
    List<PartenaireCategorie> liste,
  ) {
    if (_lat == null || _lng == null || liste.isEmpty) return null;
    final service = ref.read(servicePositionProvider);
    PartenaireCategorie? meilleur;
    double meilleureDist = double.infinity;
    for (final p in liste) {
      final d = service.distanceMetres(_lat!, _lng!, p.latitude!, p.longitude!);
      if (d < meilleureDist) {
        meilleureDist = d;
        meilleur = p;
      }
    }
    if (meilleur == null) return null;
    return (p: meilleur, d: meilleureDist);
  }

  Set<Marker> _marqueurs(List<PartenaireCategorie> liste) {
    return liste.map((p) {
      return Marker(
        markerId: MarkerId('part_${p.id}'),
        position: LatLng(p.latitude!, p.longitude!),
        infoWindow: InfoWindow(
          title: p.nomCommerce,
          snippet: p.quartier.isNotEmpty ? p.quartier : p.departement,
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final posAsync = ref.watch(positionUtilisateurProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Localisation des Services')),
      body: posAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _BlocageLocalisation(
          icone: Icons.error_outline,
          titre: 'Erreur de localisation',
          description: 'Une erreur est survenue : $e',
          labelAction: 'Réessayer',
          onAction: () => ref.invalidate(positionUtilisateurProvider),
        ),
        data: (res) => switch (res) {
          PositionObtenue(:final latitude, :final longitude) => Builder(
            builder: (context) {
              _lat = latitude;
              _lng = longitude;
              return _buildCarte(context);
            },
          ),
          ServiceDesactive() => _BlocageLocalisation(
            icone: Icons.location_off,
            titre: 'Localisation désactivée',
            description:
                "Pour afficher les services les plus proches de toi, active le GPS (localisation) de ton appareil.",
            labelAction: 'Activer la localisation',
            onAction: () async {
              await ref
                  .read(servicePositionProvider)
                  .ouvrirParametresLocalisation();
            },
          ),
          PermissionRefusee(definitif: true) => _BlocageLocalisation(
            icone: Icons.location_disabled,
            titre: 'Permission de localisation requise',
            description:
                "Tu as refusé l'accès à ta position. Autorise-la dans les paramètres de l'application pour utiliser la carte.",
            labelAction: 'Ouvrir les paramètres',
            onAction: () async {
              await ref.read(servicePositionProvider).ouvrirParametresApp();
            },
          ),
          PermissionRefusee() => _BlocageLocalisation(
            icone: Icons.location_disabled,
            titre: 'Localisation nécessaire',
            description:
                "Poufiret a besoin de ta position pour afficher les services les plus proches de toi.",
            labelAction: 'Autoriser la localisation',
            onAction: () => ref.invalidate(positionUtilisateurProvider),
          ),
          ErreurPosition(:final message) => _BlocageLocalisation(
            icone: Icons.error_outline,
            titre: 'Erreur de localisation',
            description: 'Une erreur est survenue : $message',
            labelAction: 'Réessayer',
            onAction: () => ref.invalidate(positionUtilisateurProvider),
          ),
        },
      ),
    );
  }

  Widget _buildCarte(BuildContext context) {
    final partenairesAsync = ref.watch(partenairesCarteProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final categorieActive = ref.watch(categorieCarteProvider);

    final contenu = Stack(
      children: [
        // ── Carte ──────────────────────────────────────────────
        partenairesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Impossible de charger la carte.\\n$e',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (liste) => GoogleMap(
            // Démarre toujours centré sur Ferké, puis anime vers la
            // position réelle de l'utilisateur (voir onMapCreated).
            initialCameraPosition: const CameraPosition(
              target: _centreDefaut,
              zoom: 13,
            ),
            mapType: _hybride ? MapType.satellite : MapType.normal,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _marqueurs(liste),
            onMapCreated: (c) {
              _controller = c;
              _recentrer();
            },
          ),
        ),

        // ── Barre de filtres (haut) ────────────────────────────
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: categoriesAsync.maybeWhen(
            data: (cats) => _BarreFiltres(
              categories: cats,
              active: categorieActive,
              onChoisir: (slug) =>
                  ref.read(categorieCarteProvider.notifier).choisir(slug),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),

        // ── Bouton style de carte (haut gauche) ────────────────
        Positioned(
          top: 64,
          left: 8,
          child: _BoutonTypeCarte(
            hybride: _hybride,
            onToggle: () => setState(() => _hybride = !_hybride),
          ),
        ),

        // ── Encart « Plus proche » (haut droite) ───────────────
        Positioned(
          top: 64,
          right: 8,
          child: partenairesAsync.maybeWhen(
            data: (liste) {
              final pp = _plusProche(liste);
              if (pp == null) return const SizedBox.shrink();
              return _EncartPlusProche(
                nom: pp.p.nomCommerce,
                distance: _distance(pp.d),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ),

        // ── Contrôles zoom + Centrer (bas droite) ──────────────
        Positioned(
          right: 12,
          bottom: 180,
          child: Column(
            children: [
              _ControlesZoom(
                onZoomIn: () => _zoomer(true),
                onZoomOut: () => _zoomer(false),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: 'centrer_map',
                onPressed: _recentrer,
                child: const Icon(Icons.my_location),
              ),
            ],
          ),
        ),

        // ── Liste basse ────────────────────────────────────────
        partenairesAsync.maybeWhen(
          data: (liste) => Align(
            alignment: Alignment.bottomCenter,
            child: _ListeBasse(
              partenaires: liste,
              distanceDe: (p) {
                if (_lat == null || _lng == null) return null;
                final d = ref
                    .read(servicePositionProvider)
                    .distanceMetres(_lat!, _lng!, p.latitude!, p.longitude!);
                return _distance(d);
              },
              onTap: (p) async {
                await _controller?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(p.latitude!, p.longitude!),
                    16,
                  ),
                );
              },
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ],
    );

    // Tirer l'écran vers le bas recharge partenaires + catégories.
    return RefreshIndicator(
      onRefresh: _rafraichir,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: contenu,
          ),
        ),
      ),
    );
  }
}

/// Écran plein cadre qui bloque l'accès à la carte tant que la position
/// n'est pas disponible (GPS désactivé, permission refusée, erreur…).
class _BlocageLocalisation extends StatelessWidget {
  const _BlocageLocalisation({
    required this.icone,
    required this.titre,
    required this.description,
    required this.labelAction,
    required this.onAction,
  });
  final IconData icone;
  final String titre;
  final String description;
  final String labelAction;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 64, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              titre,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: onAction, child: Text(labelAction)),
          ],
        ),
      ),
    );
  }
}

/// Bouton (haut gauche) : bascule entre carte normale et vue satellite
/// (sans libellés) à chaque clic.
class _BoutonTypeCarte extends StatelessWidget {
  const _BoutonTypeCarte({required this.hybride, required this.onToggle});
  final bool hybride;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: hybride ? 'Vue normale' : 'Vue satellite',
      onPressed: onToggle,
      isSelected: hybride,
      icon: const Icon(Icons.map_outlined),
      selectedIcon: const Icon(Icons.map),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? Colors.white.withOpacity(0.6)
              : Theme.of(context).colorScheme.surfaceContainer;
        }),
      ),
    );
  }
}

/// Contrôles zoom +/- (custom, car les contrôles natifs Google Maps ne
/// sont pas fiables sous nos overlays et n'existent pas sur iOS).
class _ControlesZoom extends StatelessWidget {
  const _ControlesZoom({required this.onZoomIn, required this.onZoomOut});
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Zoomer',
            onPressed: onZoomIn,
            icon: const Icon(Icons.add),
          ),
          const Divider(height: 1),
          IconButton(
            tooltip: 'Dézoomer',
            onPressed: onZoomOut,
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

/// Barre horizontale de filtres : Tous + une puce par categorie.
class _BarreFiltres extends StatelessWidget {
  const _BarreFiltres({
    required this.categories,
    required this.active,
    required this.onChoisir,
  });
  final List<Categorie> categories;
  final String? active;
  final ValueChanged<String?> onChoisir;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _Puce(
              label: 'Tous',
              actif: active == null,
              onTap: () => onChoisir(null),
            ),
            for (final c in categories)
              _Puce(
                label: c.nom,
                actif: active == c.slug,
                onTap: () => onChoisir(c.slug),
              ),
          ],
        ),
      ),
    );
  }
}

class _Puce extends StatelessWidget {
  const _Puce({required this.label, required this.actif, required this.onTap});
  final String label;
  final bool actif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: actif,
        onSelected: (_) => onTap(),
        backgroundColor: theme.colorScheme.surface,
      ),
    );
  }
}

/// Encart vert « Plus proche de vous ».
class _EncartPlusProche extends StatelessWidget {
  const _EncartPlusProche({required this.nom, required this.distance});
  final String nom;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDDF3DD),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Plus proche de vous',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(
            nom,
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
          ),
          Text(distance, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

/// Liste basse scrollable des partenaires avec distance.
class _ListeBasse extends StatelessWidget {
  const _ListeBasse({
    required this.partenaires,
    required this.distanceDe,
    required this.onTap,
  });
  final List<PartenaireCategorie> partenaires;
  final String? Function(PartenaireCategorie) distanceDe;
  final ValueChanged<PartenaireCategorie> onTap;

  @override
  Widget build(BuildContext context) {
    if (partenaires.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Aucun service géolocalisé dans cette zone.'),
      );
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 170),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      // Material (au lieu d'une simple decoration) fournit un ancêtre
      // opaque pour ListTile : évite l'avertissement "background color
      // or ink splashes may be invisible" et clippe correctement les
      // splashes dans les coins arrondis.
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: partenaires.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final p = partenaires[i];
            final dist = distanceDe(p);
            return ListTile(
              dense: true,
              leading: CircleAvatar(
                child: Text(
                  p.nomCommerce.isNotEmpty
                      ? p.nomCommerce[0].toUpperCase()
                      : '?',
                ),
              ),
              title: Text(
                p.nomCommerce,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                [
                  if (p.quartier.isNotEmpty) p.quartier,
                  if (dist != null) dist,
                ].join(' • '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => onTap(p),
            );
          },
        ),
      ),
    );
  }
}
