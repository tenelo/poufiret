import 'package:flutter/material.dart';

import 'image_reseau.dart';

/// Visionneuse plein ecran : zoom par pincement, double-tap, et
/// glissement entre les images quand l'article en a plusieurs.
///
/// Utile ici plus qu'ailleurs : un client qui achete un pagne ou une
/// piece detachee veut voir le detail du motif ou de la reference.
class VisionneuseImages extends StatefulWidget {
  const VisionneuseImages({
    super.key,
    required this.images,
    this.indexInitial = 0,
    this.titre,
  });

  final List<String> images;
  final int indexInitial;
  final String? titre;

  /// Ouvre la visionneuse par-dessus l'ecran courant.
  static Future<void> ouvrir(
    BuildContext context, {
    required List<String> images,
    int indexInitial = 0,
    String? titre,
  }) {
    if (images.isEmpty) return Future.value();
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VisionneuseImages(
          images: images,
          indexInitial: indexInitial,
          titre: titre,
        ),
      ),
    );
  }

  @override
  State<VisionneuseImages> createState() => _VisionneuseImagesState();
}

class _VisionneuseImagesState extends State<VisionneuseImages> {
  late final PageController _pages =
      PageController(initialPage: widget.indexInitial);
  late int _index = widget.indexInitial;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plusieurs = widget.images.length > 1;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          plusieurs
              ? '${_index + 1} / ${widget.images.length}'
              : (widget.titre ?? ''),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: PageView.builder(
        controller: _pages,
        itemCount: widget.images.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) => _ImageZoomable(url: widget.images[i]),
      ),
      bottomNavigationBar: plusieurs
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
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
                          color: i == _index ? Colors.white : Colors.white38,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

/// Une image zoomable. Le double-tap alterne entre taille normale et
/// agrandissement, plus rapide que le pincement sur petit ecran.
class _ImageZoomable extends StatefulWidget {
  const _ImageZoomable({required this.url});
  final String url;

  @override
  State<_ImageZoomable> createState() => _ImageZoomableState();
}

class _ImageZoomableState extends State<_ImageZoomable>
    with SingleTickerProviderStateMixin {
  final _controleur = TransformationController();
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  Animation<Matrix4>? _transition;
  TapDownDetails? _dernierTap;

  @override
  void initState() {
    super.initState();
    // Un seul ecouteur, ajoute une fois : en le rattachant a chaque
    // double-tap, une animation encore en cours au moment de la
    // fermeture ecrivait dans un controleur deja detruit.
    _animation.addListener(_appliquerTransition);
  }

  void _appliquerTransition() {
    if (!mounted) return;
    final valeur = _transition?.value;
    if (valeur != null) _controleur.value = valeur;
  }

  @override
  void dispose() {
    _animation
      ..stop()
      ..removeListener(_appliquerTransition)
      ..dispose();
    _controleur.dispose();
    super.dispose();
  }

  void _doubleTap() {
    final actuel = _controleur.value;
    final Matrix4 cible;
    if (actuel.getMaxScaleOnAxis() > 1.05) {
      cible = Matrix4.identity();
    } else {
      final position = _dernierTap?.localPosition ?? Offset.zero;
      const facteur = 2.5;
      cible = Matrix4.identity()
        ..translateByDouble(
            -position.dx * (facteur - 1), -position.dy * (facteur - 1), 0, 1)
        ..scaleByDouble(facteur, facteur, facteur, 1);
    }
    _transition = Matrix4Tween(begin: actuel, end: cible).animate(
      CurvedAnimation(parent: _animation, curve: Curves.easeOut),
    );
    _animation.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (d) => _dernierTap = d,
      onDoubleTap: _doubleTap,
      child: InteractiveViewer(
        transformationController: _controleur,
        minScale: 1,
        maxScale: 5,
        child: Center(
          child: ImageReseau(widget.url, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
