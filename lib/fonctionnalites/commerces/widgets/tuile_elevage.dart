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

/// Case de grille d'un produit d'éleveur : photo, nom, prix à l'unité
/// (« 2 500 f/kg ») juste dessous, poids moyen, délai de commande (et le
/// stock si [afficherStockElevage]), « Livraison possible ». Sa hauteur
/// suit son contenu (grille en colonnes décalées) : rien de vide dessous.
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
            mainAxisSize: MainAxisSize.min,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
            ],
          ),
        ),
      ),
    );
  }
}
