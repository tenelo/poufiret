import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as g;

import 'carte_base.dart';
import 'modeles_carte.dart';

/// Implementation Google Maps du contrat commun.
class CarteGoogle extends CarteBase {
  const CarteGoogle({
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
  State<CarteGoogle> createState() => _CarteGoogleState();
}

// Une seule conversion PNG -> BitmapDescriptor par instance d'octets : evite de
// renvoyer l'image au plugin a chaque mise a jour de marqueur (position du
// livreur toutes les quelques secondes).
final _descripteurs = Expando<g.BitmapDescriptor>('descripteurs_png');

g.BitmapDescriptor _icone(MarqueurCarte m) {
  final octets = m.octetsPng;
  if (octets != null) {
    return _descripteurs[octets] ??= g.BitmapDescriptor.bytes(octets);
  }
  return g.BitmapDescriptor.defaultMarkerWithHue(switch (m.teinte) {
    TeinteMarqueur.rouge => g.BitmapDescriptor.hueRed,
    TeinteMarqueur.bleu => g.BitmapDescriptor.hueBlue,
    TeinteMarqueur.vert => g.BitmapDescriptor.hueGreen,
  });
}

g.LatLng _ll(PointCarte p) => g.LatLng(p.latitude, p.longitude);

class _CarteGoogleState extends State<CarteGoogle> {
  g.GoogleMapController? _ctrl;

  @override
  void initState() {
    super.initState();
    widget.controleur?.lier(
      zoomer: (avant) async => _ctrl?.animateCamera(
        avant ? g.CameraUpdate.zoomIn() : g.CameraUpdate.zoomOut(),
      ),
      centrer: (p, zoom) async => _ctrl?.animateCamera(
        zoom == null
            ? g.CameraUpdate.newLatLng(_ll(p))
            : g.CameraUpdate.newLatLngZoom(_ll(p), zoom),
      ),
      cadrer: (points, marge) async {
        var minLat = points.first.latitude, maxLat = minLat;
        var minLng = points.first.longitude, maxLng = minLng;
        for (final p in points) {
          if (p.latitude < minLat) minLat = p.latitude;
          if (p.latitude > maxLat) maxLat = p.latitude;
          if (p.longitude < minLng) minLng = p.longitude;
          if (p.longitude > maxLng) maxLng = p.longitude;
        }
        await _ctrl?.animateCamera(
          g.CameraUpdate.newLatLngBounds(
            g.LatLngBounds(
              southwest: g.LatLng(minLat, minLng),
              northeast: g.LatLng(maxLat, maxLng),
            ),
            marge,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controleur?.delier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return g.GoogleMap(
      initialCameraPosition: g.CameraPosition(
        target: _ll(widget.centreInitial),
        zoom: widget.zoomInitial,
      ),
      mapType: widget.satellite ? g.MapType.satellite : g.MapType.normal,
      markers: {
        for (final m in widget.marqueurs)
          g.Marker(
            markerId: g.MarkerId(m.id),
            position: _ll(m.position),
            icon: _icone(m),
            infoWindow: g.InfoWindow(title: m.titre, snippet: m.sousTitre),
          ),
      },
      polylines: {
        for (final l in widget.polylignes)
          g.Polyline(
            polylineId: g.PolylineId(l.id),
            points: [for (final p in l.points) _ll(p)],
            color: l.couleur,
            width: l.epaisseur.round(),
          ),
      },
      zoomControlsEnabled: widget.boutonsZoom,
      zoomGesturesEnabled: true,
      myLocationEnabled: widget.afficherPosition,
      myLocationButtonEnabled: false,
      onTap: widget.onTap == null
          ? null
          : (p) => widget.onTap!(PointCarte(p.latitude, p.longitude)),
      onMapCreated: (c) {
        _ctrl = c;
        widget.onPrete?.call();
      },
    );
  }
}
