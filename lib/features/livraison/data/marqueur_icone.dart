import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Convertit une icone Material en marqueur Google Maps (BitmapDescriptor).
///
/// Permet d'afficher une vraie icone (ex: moto) a la place de la goutte par
/// defaut, teintee a la couleur voulue. Option (b) : peinture au runtime,
/// pas d'asset externe. Le PNG custom (motard) pourra remplacer ceci plus tard.
Future<BitmapDescriptor> bitmapDepuisIcone(
  IconData icone, {
  Color couleur = Colors.black,
  double taille = 110,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // Pastille de fond (cercle blanc) pour la lisibilite sur la carte.
  final rayon = taille / 2;
  final fond = Paint()..color = Colors.white;
  final bord = Paint()
    ..color = couleur
    ..style = PaintingStyle.stroke
    ..strokeWidth = taille * 0.06;
  canvas.drawCircle(Offset(rayon, rayon), rayon * 0.92, fond);
  canvas.drawCircle(Offset(rayon, rayon), rayon * 0.92, bord);

  // L'icone, centree.
  final tp = TextPainter(textDirection: TextDirection.ltr);
  tp.text = TextSpan(
    text: String.fromCharCode(icone.codePoint),
    style: TextStyle(
      fontSize: taille * 0.62,
      fontFamily: icone.fontFamily,
      package: icone.fontPackage,
      color: couleur,
    ),
  );
  tp.layout();
  tp.paint(
    canvas,
    Offset((taille - tp.width) / 2, (taille - tp.height) / 2),
  );

  final image = await recorder
      .endRecording()
      .toImage(taille.toInt(), taille.toInt());
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
}
