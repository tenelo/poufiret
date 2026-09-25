import 'dart:typed_data';

import 'package:flutter/painting.dart';

/// Coordonnees neutres : les ecrans ne dependent d'aucune bibliotheque de
/// carte (Google ou OpenStreetMap).
class PointCarte {
  const PointCarte(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  @override
  bool operator ==(Object other) =>
      other is PointCarte &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);
}

/// Couleur d'une epingle standard (quand aucun PNG n'est fourni).
enum TeinteMarqueur { rouge, bleu, vert }

/// Un marqueur : epingle standard teintee, ou icone PNG.
class MarqueurCarte {
  const MarqueurCarte({
    required this.id,
    required this.position,
    this.titre,
    this.sousTitre,
    this.octetsPng,
    this.teinte = TeinteMarqueur.rouge,
  });

  final String id;
  final PointCarte position;

  /// Texte de la bulle affichee au toucher du marqueur.
  final String? titre;
  final String? sousTitre;

  /// Icone PNG (ex. moto du livreur) ; prioritaire sur [teinte]. Passer
  /// TOUJOURS la meme instance (cache de marqueur_icone.dart) : elle sert de
  /// cle de cache aux deux implementations.
  final Uint8List? octetsPng;
  final TeinteMarqueur teinte;
}

/// Un trace (ex. itineraire d'une course).
class PolyligneCarte {
  const PolyligneCarte({
    required this.id,
    required this.points,
    required this.couleur,
    this.epaisseur = 4,
  });

  final String id;
  final List<PointCarte> points;
  final Color couleur;
  final double epaisseur;
}

/// Commandes de la camera, communes aux deux implementations. Le widget de
/// carte s'y branche ; tant qu'il n'est pas pret, les appels sont ignores.
class ControleurCarte {
  Future<void> Function(bool avant)? _zoomer;
  Future<void> Function(PointCarte point, double? zoom)? _centrer;
  Future<void> Function(List<PointCarte> points, double marge)? _cadrer;

  bool get pret => _zoomer != null;

  /// Zoom avant / arriere d'un cran.
  Future<void> zoomer(bool avant) async => _zoomer?.call(avant);

  /// Centre la camera sur un point ; [zoom] null = zoom courant conserve.
  Future<void> centrerSur(PointCarte point, {double? zoom}) async =>
      _centrer?.call(point, zoom);

  /// Cadre tous les points : un seul => centre dessus a [zoomSiUnPoint], sinon
  /// zoom pour tous les voir avec [marge] pixels.
  Future<void> ajuster(
    List<PointCarte> points, {
    double marge = 60,
    double zoomSiUnPoint = 14,
  }) async {
    if (points.isEmpty) return;
    if (points.length == 1) {
      return centrerSur(points.first, zoom: zoomSiUnPoint);
    }
    await _cadrer?.call(points, marge);
  }

  /// Appele par les implementations.
  void lier({
    required Future<void> Function(bool avant) zoomer,
    required Future<void> Function(PointCarte point, double? zoom) centrer,
    required Future<void> Function(List<PointCarte> points, double marge)
    cadrer,
  }) {
    _zoomer = zoomer;
    _centrer = centrer;
    _cadrer = cadrer;
  }

  void delier() {
    _zoomer = null;
    _centrer = null;
    _cadrer = null;
  }
}
