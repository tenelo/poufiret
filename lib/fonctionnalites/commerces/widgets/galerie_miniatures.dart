import 'package:flutter/material.dart';

import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/visionneuse_images.dart';

/// Galerie d'un produit : grande image en haut (la photo principale
/// d'abord), vignettes alignées en dessous dans l'ordre reçu. Toucher une
/// vignette la passe en grand (la vignette active est encadrée) ; toucher la
/// grande image ouvre le plein écran (zoom, balayage) sur la photo affichée.
/// Une seule photo : pas de vignettes.
///
/// Par défaut, au plus [maxVignettes] vignettes de taille égale se partagent
/// la largeur (aucune ne déborde, même à 320 px). Avec [rangeeDefilante],
/// toutes les photos défilent en vignettes de taille fixe (page éleveur).
class GalerieMiniatures extends StatefulWidget {
  const GalerieMiniatures({
    super.key,
    required this.images,
    this.titre,
    this.ratio = 1,
    this.iconeVide = Icons.image_outlined,
    this.rangeeDefilante = false,
  });

  final List<String> images;
  final String? titre;

  /// Rapport largeur / hauteur de la grande image (2/3 pour un livre).
  final double ratio;
  final IconData iconeVide;

  /// Rangée défilante de vignettes fixes, au lieu de la rangée partagée.
  final bool rangeeDefilante;

  /// Côté d'une vignette dans la rangée défilante.
  static const double coteMiniature = 64;

  /// Vignettes affichées au plus dans la rangée partagée.
  static const int maxVignettes = 4;

  /// Marge de la rangée et écart entre vignettes.
  static const double _marge = 12;
  static const double _ecart = 8;

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

  /// Rangée défilante : toutes les photos, vignettes de taille fixe.
  Widget _rangeeDefilante(List<String> images) => SizedBox(
    height: GalerieMiniatures.coteMiniature + 16,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: images.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (context, i) => _Miniature(
        key: ValueKey('miniature-$i'),
        url: images[i],
        cote: GalerieMiniatures.coteMiniature,
        active: i == _index,
        onTap: () => setState(() => _index = i),
      ),
    ),
  );

  /// Rangée partagée : les [GalerieMiniatures.maxVignettes] premières
  /// photos, en cases égales qui se répartissent la largeur disponible.
  Widget _rangeePartagee(List<String> images, double largeur) {
    const marge = GalerieMiniatures._marge;
    const ecart = GalerieMiniatures._ecart;
    const cases = GalerieMiniatures.maxVignettes;
    final cote = (largeur - 2 * marge - (cases - 1) * ecart) / cases;
    final vignettes = images.take(cases).toList();
    return Padding(
      key: const ValueKey('rangee-vignettes'),
      padding: const EdgeInsets.symmetric(horizontal: marge, vertical: ecart),
      child: Row(
        children: [
          for (var i = 0; i < vignettes.length; i++) ...[
            if (i > 0) const SizedBox(width: ecart),
            _Miniature(
              key: ValueKey('miniature-$i'),
              url: vignettes[i],
              cote: cote,
              active: i == _index,
              onTap: () => setState(() => _index = i),
            ),
          ],
        ],
      ),
    );
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
              widget.rangeeDefilante
                  ? _rangeeDefilante(images)
                  : _rangeePartagee(images, largeur),
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
    required this.cote,
    required this.active,
    required this.onTap,
  });

  final String url;
  final double cote;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final couleur = Theme.of(context).colorScheme.primary;
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
