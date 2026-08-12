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

class _EcranMapState extends ConsumerState<EcranMap> {
  GoogleMapController? _controller;

  double? _lat;
  double? _lng;

  Future<void> _recentrer() async {
    if (_lat == null || _lng == null || _controller == null) return;
    await _controller!.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(_lat!, _lng!), 14),
    );
  }

  /// Distance formatee (m si < 1 km, sinon km).
  String _distance(double metres) {
    if (metres < 1000) return '${metres.round()} m';
    return '${(metres / 1000).toStringAsFixed(2)} km';
  }

  /// Retourne (partenaire le plus proche, distance) ou null.
  ({PartenaireCategorie p, double d})? _plusProche(
      List<PartenaireCategorie> liste) {
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
    final partenairesAsync = ref.watch(partenairesCarteProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final categorieActive = ref.watch(categorieCarteProvider);

    // Met a jour la position locale quand elle arrive.
    posAsync.whenData((res) {
      if (res is PositionObtenue && _lat != res.latitude) {
        _lat = res.latitude;
        _lng = res.longitude;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Localisation des Services')),
      body: Stack(
        children: [
          // ── Carte ──────────────────────────────────────────────
          partenairesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Impossible de charger la carte.\\n$e',
                    textAlign: TextAlign.center),
              ),
            ),
            data: (liste) => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: (_lat != null && _lng != null)
                    ? LatLng(_lat!, _lng!)
                    : _centreDefaut,
                zoom: 13,
              ),
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

          // ── Bouton Centrer (bas droite) ────────────────────────
          Positioned(
            right: 12,
            bottom: 180,
            child: FloatingActionButton.small(
              heroTag: 'centrer_map',
              onPressed: _recentrer,
              child: const Icon(Icons.my_location),
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
                  final d = ref.read(servicePositionProvider).distanceMetres(
                      _lat!, _lng!, p.latitude!, p.longitude!);
                  return _distance(d);
                },
                onTap: (p) async {
                  await _controller?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                        LatLng(p.latitude!, p.longitude!), 16),
                  );
                },
              ),
            ),
            orElse: () => const SizedBox.shrink(),
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
      child: ListView(
        scrollDirection: Axis.horizontal,
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
          const Text('Plus proche de vous',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(nom,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13)),
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
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
              child: Text(p.nomCommerce.isNotEmpty
                  ? p.nomCommerce[0].toUpperCase()
                  : '?'),
            ),
            title: Text(p.nomCommerce,
                maxLines: 1, overflow: TextOverflow.ellipsis),
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
    );
  }
}
