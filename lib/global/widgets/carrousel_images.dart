import 'dart:async';

import 'package:flutter/material.dart';

import 'image_reseau.dart';
import 'visionneuse_images.dart';

/// Zone image qui defile toute seule quand l'article a plusieurs photos.
///
/// Le defilement est lui-meme l'indication qu'il y en a plusieurs : sans
/// mouvement, la majorite des utilisateurs ne pense pas a glisser. Le
/// rendu reste identique a une image fixe (meme cadrage, meme badge).
class CarrouselImages extends StatefulWidget {
  const CarrouselImages({
    super.key,
    required this.images,
    this.titre,
    this.intervalle = const Duration(milliseconds: 3500),
    this.constructeurVide,
    this.points = false,
    this.largeurAffichee,
  });

  final List<String> images;
  final String? titre;
  final Duration intervalle;

  /// Affiche des points indicateurs (un par photo) en bas, au centre.
  final bool points;

  /// Largeur logique affichée : les images sont alors décodées à cette
  /// taille (voir [ImageReseau.largeurAffichee]).
  final double? largeurAffichee;

  /// Affiche a la place du carrousel quand la liste est vide.
  final WidgetBuilder? constructeurVide;

  @override
  State<CarrouselImages> createState() => _CarrouselImagesState();
}

class _CarrouselImagesState extends State<CarrouselImages> {
  final _pages = PageController();
  Timer? _minuteur;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _programmer();
  }

  @override
  void dispose() {
    _minuteur?.cancel();
    _pages.dispose();
    super.dispose();
  }

  void _programmer() {
    _minuteur?.cancel();
    if (widget.images.length < 2) return;
    _minuteur = Timer.periodic(widget.intervalle, (_) {
      if (!mounted || !_pages.hasClients) return;
      _pages.animateToPage(
        (_index + 1) % widget.images.length,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  /// Relance le compte a rebours apres un glissement manuel, pour ne pas
  /// enchainer une transition automatique juste apres le geste.
  void _surChangement(int i) {
    setState(() => _index = i);
    _programmer();
  }

  void _ouvrirVisionneuse() {
    VisionneuseImages.ouvrir(
      context,
      images: widget.images,
      indexInitial: _index,
      titre: widget.titre,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return widget.constructeurVide?.call(context) ?? const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: _ouvrirVisionneuse,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pages,
            itemCount: widget.images.length,
            onPageChanged: _surChangement,
            itemBuilder: (context, i) => ImageReseau(
              widget.images[i],
              fit: BoxFit.cover,
              largeurAffichee: widget.largeurAffichee,
            ),
          ),
          if (widget.points && widget.images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < widget.images.length; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _index ? 18 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: i == _index ? Colors.white : Colors.white54,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 4),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.zoom_out_map, size: 14, color: Colors.white),
                  if (widget.images.length > 1) ...[
                    const SizedBox(width: 5),
                    Text(
                      '${_index + 1}/${widget.images.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
