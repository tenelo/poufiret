import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../metier_domaine/elevage.dart';
import '../metier_domaine/fiche_produit.dart';
import 'tuiles_produits.dart';

/// Hauteur de repli de la zone de texte d'une case d'éleveur (sous la photo
/// carrée), quand elle n'est pas ajustée aux produits.
const double hauteurTexteElevage = 176;

/// Écart entre le nom et le prix d'une case d'éleveur.
const double _ecartNomPrix = 2;

/// Zone de texte d'une [TuileElevage] ajustée aux [produits] de la grille :
/// nom (2 lignes au plus), prix juste dessous, puis le poids moyen, la
/// disponibilité (2 lignes) et « Livraison possible » si l'une des cases en
/// affiche. Mesurée sans agrandissement, que [grilleProduits] applique.
double hauteurTexteElevageAjustee(BuildContext context, List<Plat> produits) {
  final textes = Theme.of(context).textTheme;
  const gras = TextStyle(fontWeight: FontWeight.w600);
  double ligne(TextStyle? style) {
    final mesure = TextPainter(
      text: TextSpan(text: 'Ag', style: style),
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.noScaling,
    )..layout();
    final hauteur = mesure.height;
    mesure.dispose();
    return hauteur;
  }

  final poids = produits.any((p) => p.poidsMoyenLisible.isNotEmpty);
  final dispo = produits.any(
    (p) => p.toutEpuise || p.disponibiliteElevage.isNotEmpty,
  );
  final livraison = produits.any((p) => p.livraisonPossible);
  final hauteur =
      16 + // marges haute et basse
      2 * ligne(textes.titleSmall?.merge(gras)) +
      _ecartNomPrix +
      ligne(textes.bodyMedium?.merge(gras)) +
      (poids ? ligne(textes.labelSmall) : 0) +
      (dispo ? 2 * ligne(textes.labelSmall?.merge(gras)) : 0) +
      (livraison ? ligne(textes.labelSmall) : 0);
  return hauteur.ceilToDouble();
}

/// Case de grille d'un produit d'éleveur : photo, nom, prix à l'unité
/// (« 2 500 f/kg ») juste dessous, poids moyen, délai de commande (et le
/// stock si [afficherStockElevage]), « Livraison possible ».
class TuileElevage extends StatelessWidget {
  const TuileElevage({super.key, required this.produit, required this.onTap});

  final Plat produit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = produit;
    final epuise = p.toutEpuise;
    final secondaire = theme.textTheme.labelSmall?.copyWith(
      color: Config.couleurTexteSecondaire,
    );
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, contraintes) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Opacity(
                  opacity: epuise ? 0.5 : 1,
                  child: PhotoProduit(
                    url: p.image,
                    largeur: contraintes.maxWidth,
                    icone: Icons.agriculture_outlined,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.nom,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: _ecartNomPrix),
                      Text(
                        formatPrixUnite(
                          p.prixEffectif,
                          p.unitePrix,
                          suffixe: p.suffixePrix,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (p.poidsMoyenLisible.isNotEmpty)
                        Text(
                          p.poidsMoyenLisible,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: secondaire,
                        ),
                      if (epuise || p.disponibiliteElevage.isNotEmpty)
                        Text(
                          epuise ? 'Épuisé' : p.disponibiliteElevage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: secondaire?.copyWith(
                            color: epuise ? Config.couleurErreur : null,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (p.livraisonPossible)
                        Text(
                          'Livraison possible',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: secondaire?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
