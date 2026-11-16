import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/restaurant_models.dart';

/// Formats d'un article en cartes (photo, nom, prix), un seul sélectionné.
///
/// Utilisé par les fiches dès qu'un format a une photo ([avecPhotos]) ;
/// sinon elles gardent leur affichage habituel. Ordre : celui du serveur.
class CartesFormats extends StatelessWidget {
  const CartesFormats({
    super.key,
    required this.formats,
    required this.selection,
    required this.prixDe,
    required this.onChoisir,
  });

  final List<VariantePlat> formats;

  /// Id du format sélectionné (null : aucun).
  final int? selection;

  /// Prix affiché d'un format, déjà mis en forme.
  final String Function(VariantePlat format) prixDe;
  final ValueChanged<int> onChoisir;

  /// Vrai si au moins un format a une photo.
  static bool avecPhotos(Iterable<VariantePlat> formats) =>
      formats.any((f) => (f.image ?? '').isNotEmpty);

  static const double _espace = 10;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        // 2 cartes par ligne sur téléphone, jusqu'à 4 sur grand écran.
        final colonnes = (contraintes.maxWidth / 160).floor().clamp(2, 4);
        final largeur =
            (contraintes.maxWidth - _espace * (colonnes - 1)) / colonnes;
        return Wrap(
          spacing: _espace,
          runSpacing: _espace,
          children: [
            for (final f in formats)
              SizedBox(
                width: largeur,
                child: _CarteFormat(
                  key: ValueKey('format-${f.id}'),
                  format: f,
                  prix: prixDe(f),
                  choisi: f.id == selection,
                  // Épuisé : grisé, non sélectionnable.
                  onTap: f.epuisee ? null : () => onChoisir(f.id),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Une carte : photo (ou icône), nom, prix ; bordure de couleur si choisie.
class _CarteFormat extends StatelessWidget {
  const _CarteFormat({
    super.key,
    required this.format,
    required this.prix,
    required this.choisi,
    required this.onTap,
  });

  final VariantePlat format;
  final String prix;
  final bool choisi;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = format.image ?? '';
    final forme = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(
        color: choisi ? Config.couleurPrimaire : Config.couleurBordure,
        width: choisi ? 2 : 1,
      ),
    );
    final repli = ColoredBox(
      color: Config.couleurClaire,
      child: Icon(Icons.image_outlined, color: Config.couleurTexteSecondaire),
    );
    return Semantics(
      selected: choisi,
      button: true,
      child: Opacity(
        opacity: format.epuisee ? 0.45 : 1,
        child: Material(
          color: Config.couleurSurface,
          shape: forme,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo du format ; sans photo, une icône.
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (image.isEmpty)
                        repli
                      else
                        LayoutBuilder(
                          builder: (context, c) => ImageReseau(
                            image,
                            fit: BoxFit.cover,
                            width: c.maxWidth,
                            height: c.maxHeight,
                            largeurAffichee: c.maxWidth,
                            errorBuilder: (_, _, _) => repli,
                          ),
                        ),
                      // Coche du format choisi.
                      if (choisi)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Icon(
                            Icons.check_circle,
                            color: Config.couleurPrimaire,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        format.nom,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        format.epuisee ? 'Épuisé' : prix,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: format.epuisee
                              ? Config.couleurTexteSecondaire
                              : theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
