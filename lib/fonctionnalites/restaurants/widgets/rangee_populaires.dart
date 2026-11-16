import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/commande_plat.dart';
import '../metier_domaine/restaurant_models.dart';
import 'carte_restaurant.dart';

/// Articles « Les plus commandés » (fast-food) : rang 1 à 3, dans l'ordre du
/// rang, chacun une seule fois.
List<Plat> platsPopulaires(Restaurant r) {
  final vus = <int>{};
  final populaires = [
    for (final s in r.carte)
      for (final p in s.plats)
        if ((p.rangPopulaire ?? 0) >= 1 &&
            p.rangPopulaire! <= 3 &&
            vus.add(p.id))
          p,
  ]..sort((a, b) => a.rangPopulaire!.compareTo(b.rangPopulaire!));
  return populaires;
}

/// Badge « Formule » d'un combo de fast-food.
class BadgeFormule extends StatelessWidget {
  const BadgeFormule({super.key});

  @override
  Widget build(BuildContext context) =>
      BadgeTexte('Formule', couleur: Config.couleurSecondaire);
}

/// Badge « 🔥 Populaire » d'un article parmi les plus commandés.
class BadgePopulaire extends StatelessWidget {
  const BadgePopulaire({super.key});

  @override
  Widget build(BuildContext context) =>
      BadgeTexte('🔥 Populaire', couleur: Config.couleurSoleil);
}

/// Rangée défilante « Les plus commandés », en haut de la carte.
class RangeePopulaires extends StatelessWidget {
  const RangeePopulaires({super.key, required this.plats, required this.onTap});

  final List<Plat> plats;
  final ValueChanged<Plat> onTap;

  static const double _largeurCarte = 150;
  static const double _hauteurPhoto = 100;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Hauteur des cartes : photo + 2 lignes de nom + le prix, à la taille
    // de texte choisie sur le téléphone.
    final echelle = MediaQuery.textScalerOf(context);
    final hauteur =
        _hauteurPhoto +
        22 +
        echelle.scale(14) * 1.3 * 2 +
        echelle.scale(14) * 1.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Les plus commandés',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: hauteur,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: plats.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, i) => SizedBox(
              width: _largeurCarte,
              child: _CartePopulaire(
                key: ValueKey('populaire-${plats[i].id}'),
                plat: plats[i],
                onTap: () => onTap(plats[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Une carte : photo (ou icône), nom, prix ; rang en pastille.
class _CartePopulaire extends StatelessWidget {
  const _CartePopulaire({super.key, required this.plat, required this.onTap});

  final Plat plat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final montant = formatMontant(prixAPartirDe(plat));
    final prix = aPrixVariable(plat) ? 'à partir de $montant' : montant;
    return Material(
      color: Config.couleurSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Config.couleurBordure),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: RangeePopulaires._hauteurPhoto,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (plat.image.isEmpty)
                    ColoredBox(
                      color: Config.couleurClaire,
                      child: Icon(
                        Icons.fastfood_outlined,
                        color: Config.couleurTexteSecondaire,
                      ),
                    )
                  else
                    ImageReseau(
                      plat.image,
                      fit: BoxFit.cover,
                      width: RangeePopulaires._largeurCarte,
                      height: RangeePopulaires._hauteurPhoto,
                      largeurAffichee: RangeePopulaires._largeurCarte,
                    ),
                  // Rang : 1, 2 ou 3.
                  Positioned(
                    top: 6,
                    left: 6,
                    child: BadgeTexte(
                      '${plat.rangPopulaire}',
                      couleur: Config.couleurSoleil,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Text(
                plat.nom,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Text(
                prix,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
