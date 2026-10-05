import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/ui/squelette.dart';
import '../../auth/screens/auth_notifier.dart';
import '../donnees/restaurants_providers.dart';
import '../metier_domaine/tri_restaurants.dart';
import '../screens/ecran_restaurants.dart';
import 'carte_restaurant.dart';

/// Sections restauration de l'accueil : « Menus du jour à (ville) »
/// (carrousel) puis « Restaurants » (rangée de cartes), pour le département
/// de l'utilisateur.
///
/// Une section sans contenu, ou dont le chargement échoue, disparaît : elle
/// ne doit jamais gêner la grille des catégories en dessous.
class SectionsRestaurantsAccueil extends ConsumerWidget {
  const SectionsRestaurantsAccueil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(menusDuJourAccueilProvider);
    final restaurants = ref.watch(restaurantsProvider);
    final ville = ref.watch(
      authProvider.select((a) => a.value?.departementNom ?? ''),
    );
    final liste = filtrerRestaurants(restaurants.value ?? const []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (menus.isLoading && !menus.hasValue)
          const _RangeeSquelette()
        else if (menus.value?.isNotEmpty ?? false) ...[
          _Titre(ville.isEmpty ? 'Menus du jour' : 'Menus du jour à $ville'),
          _Rangee(
            enfants: [for (final m in menus.value!) CarteMenuDuJour(menu: m)],
          ),
        ],
        if (restaurants.isLoading && !restaurants.hasValue)
          const _RangeeSquelette()
        else if (liste.isNotEmpty) ...[
          _Titre(
            'Restaurants',
            onToutVoir: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const EcranRestaurants())),
          ),
          _Rangee(
            enfants: [for (final r in liste) CarteRestaurant(restaurant: r)],
          ),
        ],
      ],
    );
  }
}

class _Titre extends StatelessWidget {
  const _Titre(this.texte, {this.onToutVoir});

  final String texte;
  final VoidCallback? onToutVoir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              texte,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (onToutVoir != null)
            TextButton(onPressed: onToutVoir, child: const Text('Tout voir'))
          else
            // Même hauteur de titre avec ou sans bouton.
            const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Largeur d'une carte de rangée : une carte et l'amorce de la suivante sur
/// téléphone, bornée sur grand écran.
double _largeurCarte(double disponible) =>
    (disponible * 0.72).clamp(220.0, 300.0);

/// Rangée horizontale de cartes de même hauteur.
class _Rangee extends StatelessWidget {
  const _Rangee({required this.enfants});

  final List<Widget> enfants;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur = _largeurCarte(contraintes.maxWidth);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < enfants.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  SizedBox(width: largeur, child: enfants[i]),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Squelette d'une rangée pendant le premier chargement.
class _RangeeSquelette extends StatelessWidget {
  const _RangeeSquelette();

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = _largeurCarte(contraintes.maxWidth);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  SizedBox(
                    width: largeur,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Squelette(hauteur: 999, rayon: 16),
                        ),
                        SizedBox(height: 8),
                        Squelette(largeur: 140, hauteur: 14),
                        SizedBox(height: 6),
                        Squelette(hauteur: 12),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
