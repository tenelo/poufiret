import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';

/// Ligne d'un plat (carte ou menu du jour) : nom, description courte, prix,
/// badges, et photo à droite.
class TuilePlat extends StatelessWidget {
  const TuilePlat({
    super.key,
    required this.nom,
    required this.prix,
    this.description = '',
    this.image = '',
    this.badges = const [],
    this.mention = '',
    this.attenue = false,
    this.onTap,
  });

  final String nom;

  /// Prix déjà mis en forme (« 3 500 F », « à partir de 3 500 F »).
  final String prix;
  final String description;
  final String image;
  final List<Widget> badges;

  /// Précision sous le prix (« Plus que 3 », « Commandable jusqu'à 14h »).
  final String mention;

  /// Plat non commandable (épuisé…) : consultable, mais estompé.
  final bool attenue;
  final VoidCallback? onTap;

  static const double _cotePhoto = 84;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: attenue ? 0.55 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          // Hauteur minimale = celle de la photo : une ligne sans photo
          // garde le même gabarit.
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _cotePhoto),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nom,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Config.couleurTexteSecondaire,
                          ),
                        ),
                      ],
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              prix,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          for (final badge in badges) ...[
                            const SizedBox(width: 6),
                            badge,
                          ],
                        ],
                      ),
                      if (mention.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          mention,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Config.couleurAvertissement,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (image.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageReseau(
                      image,
                      width: _cotePhoto,
                      height: _cotePhoto,
                      fit: BoxFit.cover,
                      largeurAffichee: _cotePhoto,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tuile la plus haute possible : sert de gabarit pour donner la même
  /// hauteur à toutes les lignes de la carte (défilement et repérage des
  /// sections exacts, sans construire les plats hors écran).
  static const gabarit = TuilePlat(
    nom: 'Plat',
    description: 'Ligne\nLigne',
    prix: '0 F',
  );
}
