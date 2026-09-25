import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Cache memoire des icones deja decodees (cle = url|taille).
/// Instantane pour toute reouverture dans la meme session. La MEME instance
/// d'octets est renvoyee a chaque fois : les cartes s'en servent comme cle de
/// cache (Google : descripteur de marqueur ; OSM : image en memoire).
final Map<String, Uint8List> _cacheMarqueurs = {};

/// Telecharge un PNG depuis une URL et le redimensionne a `taille` px, pret a
/// servir de marqueur sur les DEUX cartes (Google Maps et OpenStreetMap).
/// Deux niveaux de cache : memoire (session) puis disque (persistant, via
/// flutter_cache_manager). Le reseau n'est sollicite qu'a la 1re rencontre.
/// Retourne null si tout echoue.
Future<Uint8List?> octetsPngDepuisUrl(String url, {int taille = 110}) async {
  final cle = '$url|$taille';
  final enMemoire = _cacheMarqueurs[cle];
  if (enMemoire != null) return enMemoire;
  try {
    // Cache disque : telecharge si absent, sinon lit le fichier local.
    final fichier = await DefaultCacheManager().getSingleFile(url);
    final octets = await fichier.readAsBytes();
    final codec = await ui.instantiateImageCodec(
      octets,
      targetWidth: taille,
      targetHeight: taille,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) return null;
    final png = data.buffer.asUint8List();
    _cacheMarqueurs[cle] = png;
    return png;
  } catch (_) {
    return null;
  }
}
