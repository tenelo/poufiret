import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/restaurant_models.dart';
import '../metier_domaine/types_restauration.dart';

/// Petit badge plein (Promo, Épuisé…).
class BadgeTexte extends StatelessWidget {
  const BadgeTexte(this.texte, {super.key, required this.couleur});

  final String texte;
  final Color couleur;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texte,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Délai de préparation et services, sur une ligne qui passe à la ligne.
class InfosPratiques extends StatelessWidget {
  const InfosPratiques({super.key, required this.restaurant, this.couleur});

  final Restaurant restaurant;
  final Color? couleur;

  static const _icones = {
    'livraison': Icons.delivery_dining_outlined,
    'emporter': Icons.shopping_bag_outlined,
    'sur_place': Icons.restaurant_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final teinte = couleur ?? Config.couleurTexteSecondaire;
    final style = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: teinte);
    Widget element(IconData icone, String texte) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 15, color: teinte),
        const SizedBox(width: 3),
        Text(texte, style: style),
      ],
    );
    final delai = restaurant.fiche.delaiPreparationMin;
    final elements = [
      if (delai != null && delai > 0)
        element(Icons.schedule_outlined, '$delai min'),
      for (final s in restaurant.fiche.services)
        if (libellesService[s] != null)
          element(_icones[s] ?? Icons.check, libellesService[s]!),
    ];
    if (elements.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 12, runSpacing: 4, children: elements);
  }
}

/// Logo en médaillon, cerclé de blanc pour se détacher de la couverture.
class MedaillonLogo extends StatelessWidget {
  const MedaillonLogo({super.key, required this.url, this.rayon = 20});

  final String url;
  final double rayon;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return const SizedBox.shrink();
    return CircleAvatar(
      radius: rayon + 2,
      backgroundColor: Config.couleurSurface,
      child: ClipOval(
        child: ImageReseau(
          url,
          width: rayon * 2,
          height: rayon * 2,
          fit: BoxFit.cover,
          largeurAffichee: rayon * 2,
        ),
      ),
    );
  }
}
