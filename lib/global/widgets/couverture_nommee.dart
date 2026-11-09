import 'package:flutter/material.dart';

import '../config/config.dart';
import 'image_reseau.dart';

/// En-tête d'un partenaire : photo de couverture assombrie du bas vers le
/// haut, le nom écrit en bas du dégradé, et le logo carré aux coins
/// arrondis posé à cheval,
/// moitié sur la couverture, moitié dessous.
class CouvertureNommee extends StatelessWidget {
  const CouvertureNommee({
    super.key,
    required this.couverture,
    required this.logo,
    required this.nom,
    required this.iconeVide,
    this.ratio = 16 / 7,
  });

  final String couverture;
  final String logo;
  final String nom;

  /// Affichée sur fond neutre quand il n'y a pas de couverture.
  final IconData iconeVide;

  /// Largeur / hauteur de la couverture.
  final double ratio;

  /// Côté du logo (cadre blanc compris).
  static const double _logo = 76;

  /// Arrondi des coins du logo carré.
  static const double _arrondi = 18;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avecLogo = logo.isNotEmpty;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: ratio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (couverture.isEmpty)
                    ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Align(
                        alignment: const Alignment(0, -0.4),
                        child: Icon(
                          iconeVide,
                          size: 48,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    )
                  else
                    LayoutBuilder(
                      builder: (context, c) => ImageReseau(
                        couverture,
                        fit: BoxFit.cover,
                        largeurAffichee: c.maxWidth,
                      ),
                    ),
                  // Dégradé du bas vers le haut : le nom reste lisible.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0, 0.65],
                        colors: [Color(0xCC000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: avecLogo ? 16 + _logo + 12 : 16,
                    right: 16,
                    bottom: 10,
                    child: Text(
                      nom,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: const [
                          Shadow(color: Color(0x66000000), blurRadius: 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Place de la moitié basse du logo.
            if (avecLogo) const SizedBox(height: _logo / 2 + 4),
          ],
        ),
        if (avecLogo)
          Positioned(
            left: 16,
            bottom: 4,
            child: Container(
              width: _logo,
              height: _logo,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Config.couleurSurface,
                borderRadius: BorderRadius.circular(_arrondi),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_arrondi - 3),
                child: ImageReseau(
                  logo,
                  fit: BoxFit.cover,
                  largeurAffichee: _logo,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
