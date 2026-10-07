import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/location_models.dart';

/// « Visite immersive » d'un logement : une visionneuse pour la vue choisie,
/// puis les miniatures des vues disponibles.
///
/// - photo 360° : sphère que l'on tourne du doigt ;
/// - photo panoramique : image large que l'on fait glisser horizontalement.
class VisiteImmersive extends StatefulWidget {
  const VisiteImmersive({super.key, required this.panoramas});

  /// Vues actives, dans l'ordre d'affichage (au moins une).
  final List<Panorama> panoramas;

  @override
  State<VisiteImmersive> createState() => _VisiteImmersiveState();
}

class _VisiteImmersiveState extends State<VisiteImmersive> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vues = widget.panoramas;
    final vue = vues[_index.clamp(0, vues.length - 1)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            // Une visionneuse neuve par vue : elle repart de face.
            child: KeyedSubtree(
              key: ValueKey(vue.id),
              child: vue.est360
                  ? VueSpherique(image: vue.image)
                  : VuePanoramique(image: vue.image),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              vue.est360 ? Icons.threesixty : Icons.swipe_outlined,
              size: 16,
              color: Config.couleurTexteSecondaire,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                vue.est360
                    ? 'Tournez la vue avec le doigt'
                    : 'Maintenez et déplacez la photo',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              ),
            ),
          ],
        ),
        if (vues.length > 1) ...[
          const SizedBox(height: 12),
          Text(
            'Sélectionner la vue à visionner',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < vues.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _Miniature(
                      vue: vues[i],
                      active: i == _index,
                      onTap: () => setState(() => _index = i),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Vue sphérique (photo 360°), que l'on tourne du doigt.
class VueSpherique extends StatelessWidget {
  const VueSpherique({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return PanoramaViewer(
      // Tactile seulement : pas de capteurs, la vue ne bouge pas toute seule.
      sensorControl: SensorControl.none,
      child: Image(image: CachedNetworkImageProvider(image)),
    );
  }
}

/// Photo large (panoramique) : affichée à pleine hauteur, on la fait glisser
/// horizontalement pour en voir toute la largeur.
class VuePanoramique extends StatelessWidget {
  const VuePanoramique({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) => ColoredBox(
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            // Au moins la largeur du cadre : une photo étroite reste centrée.
            constraints: BoxConstraints(minWidth: contraintes.maxWidth),
            child: CachedNetworkImage(
              imageUrl: image,
              height: contraintes.maxHeight,
              fit: BoxFit.fitHeight,
              placeholder: (_, _) => SizedBox(
                width: contraintes.maxWidth,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, _, _) => SizedBox(
                width: contraintes.maxWidth,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Miniature extends StatelessWidget {
  const _Miniature({
    required this.vue,
    required this.active,
    required this.onTap,
  });

  final Panorama vue;
  final bool active;
  final VoidCallback onTap;

  static const double _largeur = 96;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur = theme.colorScheme.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: _largeur,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: active ? couleur : Config.couleurBordure,
                      width: active ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ImageReseau(
                        vue.image,
                        fit: BoxFit.cover,
                        largeurAffichee: _largeur,
                      ),
                    ),
                  ),
                ),
                if (active)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: couleur,
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              vue.titre.isEmpty ? 'Vue' : vue.titre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                color: active ? couleur : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
