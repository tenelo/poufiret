import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart' as ll;
import 'package:url_launcher/url_launcher.dart';

import '../config/config.dart';
import 'carte_base.dart';
import 'config_carte.dart';
import 'modeles_carte.dart';

/// Implementation OpenStreetMap (flutter_map) du contrat commun : repli pour
/// les appareils sans Google Play Services.
///
/// Les tuiles sont mises en cache sur disque par flutter_map lui-meme
/// (cache integre du NetworkTileProvider).
class CarteOsm extends CarteBase {
  const CarteOsm({
    super.key,
    required super.centreInitial,
    super.zoomInitial,
    super.marqueurs,
    super.polylignes,
    super.controleur,
    super.onTap,
    super.onPrete,
    super.afficherPosition,
    super.positionUtilisateur,
    super.boutonsZoom,
    super.satellite,
  });

  @override
  State<CarteOsm> createState() => _CarteOsmState();
}

ll.LatLng _ll(PointCarte p) => ll.LatLng(p.latitude, p.longitude);

class _CarteOsmState extends State<CarteOsm> {
  final _carte = fm.MapController();
  // Marqueur dont la bulle (titre / sous-titre) est ouverte.
  String? _ouvert;

  @override
  void initState() {
    super.initState();
    widget.controleur?.lier(
      zoomer: (avant) async {
        final cam = _carte.camera;
        _carte.move(
          cam.center,
          (cam.zoom + (avant ? 1 : -1)).clamp(
            ConfigCarte.zoomMin,
            ConfigCarte.zoomMax,
          ),
        );
      },
      centrer: (p, zoom) async =>
          _carte.move(_ll(p), zoom ?? _carte.camera.zoom),
      cadrer: (points, marge) async {
        _carte.fitCamera(
          fm.CameraFit.bounds(
            bounds: fm.LatLngBounds.fromPoints([
              for (final p in points) _ll(p),
            ]),
            padding: EdgeInsets.all(marge),
            maxZoom: ConfigCarte.zoomMax,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controleur?.delier();
    _carte.dispose();
    super.dispose();
  }

  static const _tailleEpingle = 40.0;
  static const _taillePng = 36.0;

  Color _couleur(TeinteMarqueur t) => switch (t) {
    TeinteMarqueur.rouge => Colors.red.shade600,
    TeinteMarqueur.bleu => Colors.blue.shade600,
    TeinteMarqueur.vert => Config.couleurSucces,
  };

  fm.Marker _marqueur(MarqueurCarte m) {
    final png = m.octetsPng;
    final ouvert = _ouvert == m.id;
    final aBulle = (m.titre ?? '').isNotEmpty;
    final taille = png != null ? _taillePng : _tailleEpingle;

    final visuel = png != null
        ? Image.memory(png, width: taille, height: taille, fit: BoxFit.contain)
        : Icon(Icons.location_on, size: taille, color: _couleur(m.teinte));

    return fm.Marker(
      point: _ll(m.position),
      width: taille,
      height: taille,
      // Epingle : pointe sur le point (marqueur AU-DESSUS du point). Icone PNG :
      // centree sur le point, comme sur Google Maps.
      alignment: png != null ? Alignment.center : Alignment.topCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: aBulle
            ? () => setState(() => _ouvert = ouvert ? null : m.id)
            : null,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            visuel,
            if (ouvert && aBulle)
              Positioned(
                bottom: taille + 2,
                left: (taille - 220) / 2,
                width: 220,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _Bulle(titre: m.titre!, sousTitre: m.sousTitre),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Le marqueur a bulle ouverte est dessine en dernier (au-dessus des autres).
    final marqueurs = [
      ...widget.marqueurs.where((m) => m.id != _ouvert),
      ...widget.marqueurs.where((m) => m.id == _ouvert),
    ];
    final pos = widget.positionUtilisateur;

    return Stack(
      children: [
        fm.FlutterMap(
          mapController: _carte,
          options: fm.MapOptions(
            initialCenter: _ll(widget.centreInitial),
            initialZoom: widget.zoomInitial,
            minZoom: ConfigCarte.zoomMin,
            maxZoom: ConfigCarte.zoomMax,
            interactionOptions: const fm.InteractionOptions(
              flags: fm.InteractiveFlag.all & ~fm.InteractiveFlag.rotate,
            ),
            onMapReady: () => widget.onPrete?.call(),
            onTap: (_, point) {
              if (_ouvert != null) setState(() => _ouvert = null);
              widget.onTap?.call(PointCarte(point.latitude, point.longitude));
            },
          ),
          children: [
            fm.TileLayer(
              urlTemplate: ConfigCarte.urlTuilesOsm,
              userAgentPackageName: ConfigCarte.identifiantApp,
              maxNativeZoom: 19,
            ),
            if (widget.polylignes.isNotEmpty)
              fm.PolylineLayer(
                polylines: [
                  for (final l in widget.polylignes)
                    fm.Polyline(
                      points: [for (final p in l.points) _ll(p)],
                      color: l.couleur,
                      strokeWidth: l.epaisseur,
                    ),
                ],
              ),
            if (widget.afficherPosition && pos != null)
              fm.MarkerLayer(
                markers: [
                  fm.Marker(
                    point: _ll(pos),
                    width: 22,
                    height: 22,
                    child: const _PointPosition(),
                  ),
                ],
              ),
            fm.MarkerLayer(markers: [for (final m in marqueurs) _marqueur(m)]),
            // Mention legale OpenStreetMap, toujours visible.
            fm.SimpleAttributionWidget(
              source: const Text(ConfigCarte.attribution),
              alignment: Alignment.bottomLeft,
              onTap: () => launchUrl(
                Uri.parse(ConfigCarte.urlAttribution),
                mode: LaunchMode.externalApplication,
              ),
            ),
          ],
        ),
        if (widget.boutonsZoom)
          Positioned(
            right: 8,
            bottom: 28,
            child: _BoutonsZoom(
              onZoom: (avant) => widget.controleur?.zoomer(avant),
            ),
          ),
      ],
    );
  }
}

/// Bulle d'information d'un marqueur (equivalent de l'InfoWindow Google).
class _Bulle extends StatelessWidget {
  const _Bulle({required this.titre, this.sousTitre});
  final String titre;
  final String? sousTitre;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      color: Config.couleurSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge,
            ),
            if ((sousTitre ?? '').isNotEmpty)
              Text(
                sousTitre!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}

/// Point bleu de la position de l'utilisateur (comme sur Google Maps).
class _PointPosition extends StatelessWidget {
  const _PointPosition();

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade600,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 3),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
    ),
  );
}

class _BoutonsZoom extends StatelessWidget {
  const _BoutonsZoom({required this.onZoom});
  final ValueChanged<bool> onZoom;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Config.couleurSurface,
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Zoomer',
            icon: const Icon(Icons.add),
            onPressed: () => onZoom(true),
          ),
          const Divider(height: 1),
          IconButton(
            tooltip: 'Dézoomer',
            icon: const Icon(Icons.remove),
            onPressed: () => onZoom(false),
          ),
        ],
      ),
    );
  }
}
