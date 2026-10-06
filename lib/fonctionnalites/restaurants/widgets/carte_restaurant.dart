import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../metier_domaine/restaurant_models.dart';
import '../metier_domaine/types_restauration.dart';
import '../screens/ecran_restaurant.dart';

/// Ouvre la page d'un restaurant. Mur d'inscription (option B) : un visiteur
/// voit les cartes, mais doit créer un compte pour entrer.
void ouvrirRestaurant(
  BuildContext context,
  WidgetRef ref,
  Restaurant restaurant,
) {
  murInscription(context, ref, () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            EcranRestaurant(restaurantId: restaurant.id, apercu: restaurant),
      ),
    );
  });
}

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

/// Aperçu d'un menu : 2 à 3 plats avec leur prix.
class ApercuMenu extends StatelessWidget {
  const ApercuMenu({super.key, required this.plats});

  final List<PlatApercu> plats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        for (final p in plats.take(3))
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    p.nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatMontant(p.prix),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Image de couverture (ou fond neutre), décodée à sa largeur d'affichage.
class _Couverture extends StatelessWidget {
  const _Couverture({required this.url, required this.ratio});

  final String url;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final fond = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.restaurant,
        size: 40,
        color: Theme.of(context).colorScheme.outline,
      ),
    );
    return AspectRatio(
      aspectRatio: ratio,
      child: url.isEmpty
          ? fond
          : LayoutBuilder(
              builder: (context, contraintes) => ImageReseau(
                url,
                fit: BoxFit.cover,
                largeurAffichee: contraintes.maxWidth,
                errorBuilder: (_, _, _) => fond,
              ),
            ),
    );
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

/// Carte riche d'un restaurant : couverture, logo, délai, services,
/// spécialités et aperçu du menu du jour.
class CarteRestaurant extends ConsumerWidget {
  const CarteRestaurant({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final r = restaurant;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => ouvrirRestaurant(context, ref, r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                _Couverture(url: r.couverture, ratio: 16 / 7),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: MedaillonLogo(url: r.logo),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InfosPratiques(restaurant: r),
                  if (r.fiche.specialites.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      r.fiche.specialites.join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Config.couleurTexteSecondaire,
                      ),
                    ),
                  ],
                  if (r.apercuPlats.isNotEmpty) ...[
                    const Divider(height: 16),
                    Text(
                      'Menu du jour',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ApercuMenu(plats: r.apercuPlats),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Carte du carrousel « Menus du jour » : photo du plat, restaurant, 2 à 3
/// plats avec prix.
class CarteMenuDuJour extends ConsumerWidget {
  const CarteMenuDuJour({super.key, required this.menu});

  final MenuDuJourAccueil menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final r = menu.restaurant;
    // Photo du premier plat illustré ; à défaut, la couverture du restaurant.
    final photo = menu.plats
        .map((p) => p.image)
        .firstWhere((i) => i.isNotEmpty, orElse: () => r.couverture);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => ouvrirRestaurant(context, ref, r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Couverture(url: photo, ratio: 16 / 9),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (r.logo.isNotEmpty) ...[
                        MedaillonLogo(url: r.logo, rayon: 11),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          r.nom,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (menu.titre.isNotEmpty)
                    Text(
                      menu.titre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Config.couleurTexteSecondaire,
                      ),
                    ),
                  const SizedBox(height: 2),
                  ApercuMenu(plats: menu.plats),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
