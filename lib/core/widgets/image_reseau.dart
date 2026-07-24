import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

/// Image distante mise en cache sur le disque.
///
/// Remplace `Image.network` avec la meme signature, pour que les ecrans
/// n'aient rien a changer d'autre que le nom. L'interet : une affiche
/// n'est telechargee qu'une fois, puis relue localement — plus de zone
/// vide a chaque retour sur l'accueil, et beaucoup moins de data
/// consommee, ce qui compte a Ferke.
class ImageReseau extends StatelessWidget {
  const ImageReseau(
    this.url, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.errorBuilder,
    this.loadingBuilder,
  });

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Accepte pour compatibilite d'appel : le chargement est gere en
  /// interne par un fondu, plus fluide qu'un indicateur qui clignote.
  final ImageLoadingBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder();

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, _) => _placeholder(),
      errorWidget: (context, _, erreur) => errorBuilder != null
          ? errorBuilder!(context, erreur, null)
          : _placeholder(icone: Icons.image_not_supported_outlined),
    );
  }

  Widget _placeholder({IconData icone = Icons.image_outlined}) => Container(
        width: width,
        height: height,
        color: Config.couleurFond,
        child: Center(
          child: Icon(icone, size: 24, color: Config.couleurTexteSecondaire),
        ),
      );
}

/// Equivalent de `NetworkImage` avec cache, pour les `backgroundImage`.
ImageProvider imageReseauProvider(String url) =>
    CachedNetworkImageProvider(url);
