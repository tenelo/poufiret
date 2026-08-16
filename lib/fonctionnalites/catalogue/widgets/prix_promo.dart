import 'package:flutter/material.dart';

import '../../../global/config/config.dart';

/// Affiche un prix, avec gestion de la promotion.
///
/// Sans promo : le prix normal seul.
/// Avec promo valide : l'ancien prix barré + le nouveau prix + un badge -X%.
/// Réutilisable partout où un prix d'article s'affiche (listes, détail,
/// recherche, panier). Les tailles s'ajustent via [taillePrix].
class PrixPromo extends StatelessWidget {
  const PrixPromo({
    super.key,
    required this.prixNormal,
    required this.prixEffectif,
    this.pourcentageReduction,
    this.taillePrix = 16,
    this.aligneADroite = false,
  });

  /// Prix habituel (avant réduction).
  final double prixNormal;

  /// Prix réellement payé (= promo si active, sinon prix normal).
  final double prixEffectif;

  /// Pourcentage de réduction (entier) ; null = pas de promo.
  final int? pourcentageReduction;

  /// Taille de police du prix principal (le reste s'adapte).
  final double taillePrix;

  /// Aligner le contenu à droite (utile dans certaines cartes).
  final bool aligneADroite;

  String _format(double v) {
    // Entier sans décimales, séparateur de milliers avec espace insécable.
    final s = v.toStringAsFixed(0);
    final tampon = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) tampon.write('\u00A0');
      tampon.write(s[i]);
    }
    return '${tampon.toString()} FCFA';
  }

  @override
  Widget build(BuildContext context) {
    final enPromo = pourcentageReduction != null;
    final aligne =
        aligneADroite ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    if (!enPromo) {
      return Text(
        _format(prixNormal),
        style: TextStyle(
          fontSize: taillePrix,
          fontWeight: FontWeight.w700,
          color: Config.couleurPrimaire,
        ),
      );
    }

    return Column(
      crossAxisAlignment: aligne,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ancien prix barré + badge -X%
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _format(prixNormal),
              style: TextStyle(
                fontSize: taillePrix * 0.75,
                color: Config.couleurTexteSecondaire,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: Config.couleurPrimaire,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '-$pourcentageReduction%',
                style: TextStyle(
                  fontSize: taillePrix * 0.65,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        // Nouveau prix, mis en avant
        Text(
          _format(prixEffectif),
          style: TextStyle(
            fontSize: taillePrix,
            fontWeight: FontWeight.w700,
            color: Config.couleurPrimaire,
          ),
        ),
      ],
    );
  }
}
