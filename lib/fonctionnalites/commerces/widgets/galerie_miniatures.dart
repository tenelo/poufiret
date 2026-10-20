import 'package:flutter/material.dart';

import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/visionneuse_images.dart';

/// Galerie d'un produit : grande image en haut, miniatures alignées en
/// dessous. Toucher une miniature la passe en grand (la miniature active est
/// encadrée) ; toucher la grande image ouvre le plein écran (zoom, balayage).
class GalerieMiniatures extends StatefulWidget {
  const GalerieMiniatures({
    super.key,
    required this.images,
    this.titre,
    this.ratio = 1,
    this.iconeVide = Icons.image_outlined,
  });

  final List<String> images;
  final String? titre;

  /// Rapport largeur / hauteur de la grande image (2/3 pour un livre).
  final double ratio;
  final IconData iconeVide;

  static const double coteMiniature = 64;

  @override
  State<GalerieMiniatures> createState() => _GalerieMiniaturesState();
}

class _GalerieMiniaturesState extends State<GalerieMiniatures> {
  int _index = 0;

  @override
  void didUpdateWidget(GalerieMiniatures ancien) {
    super.didUpdateWidget(ancien);
    if (_index >= widget.images.length) _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final images = widget.images;
    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur = contraintes.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: widget.ratio,
              child: images.isEmpty
                  ? ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        widget.iconeVide,
                        size: 56,
                        color: theme.colorScheme.outline,
                      ),
                    )
                  : Semantics(
                      button: true,
                      label: 'Agrandir la photo',
                      child: GestureDetector(
                        key: const ValueKey('galerie-grande'),
                        onTap: () => VisionneuseImages.ouvrir(
                          context,
                          images: images,
                          indexInitial: _index,
                          titre: widget.titre,
                        ),
                        child: ColoredBox(
                          color: theme.colorScheme.surfaceContainerLowest,
                          child: ImageReseau(
                            images[_index],
                            key: ValueKey('grande-${images[_index]}'),
                            fit: BoxFit.contain,
                            largeurAffichee: largeur,
                          ),
                        ),
                      ),
                    ),
            ),
            if (images.length > 1)
              SizedBox(
                height: GalerieMiniatures.coteMiniature + 16,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: images.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => _Miniature(
                    key: ValueKey('miniature-$i'),
                    url: images[i],
                    active: i == _index,
                    onTap: () => setState(() => _index = i),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Miniature extends StatelessWidget {
  const _Miniature({
    super.key,
    required this.url,
    required this.active,
    required this.onTap,
  });

  final String url;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final couleur = Theme.of(context).colorScheme.primary;
    const cote = GalerieMiniatures.coteMiniature;
    return Semantics(
      selected: active,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: cote,
          height: cote,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: active ? couleur : Colors.transparent,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: ImageReseau(url, fit: BoxFit.cover, largeurAffichee: cote),
          ),
        ),
      ),
    );
  }
}
