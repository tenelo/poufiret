import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../metier_domaine/elevage.dart';
import '../metier_domaine/fiche_produit.dart';
import 'tuiles_produits.dart';

/// Hauteur de la zone de texte d'une case d'éleveur (sous la photo carrée).
const double hauteurTexteElevage = 176;

/// Case de grille d'un produit d'éleveur : photo, nom, puce d'état
/// (« Vivant »...), prix à l'unité (« 2 500 F / kg »), poids moyen, stock ou
/// délai de commande, « Livraison possible ».
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
                      if (p.etatVente.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        PuceEtatVente(p.etatVente),
                      ],
                      const Spacer(),
                      Text(
                        formatPrixUnite(p.prixEffectif, p.unitePrix),
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

/// Puce d'information « Vivant », « Abattu entier », « Découpé » (pas un
/// filtre : rien à toucher).
class PuceEtatVente extends StatelessWidget {
  const PuceEtatVente(this.texte, {super.key});

  final String texte;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Config.couleurFond,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Text(
        texte,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
