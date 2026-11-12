import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/categorie.dart';

// Tuiles de catégorie de l'accueil, réutilisées par la grille des
// sous-catégories.

/// Grille responsive de tuiles : le nombre de colonnes s'ajuste selon la
/// largeur disponible (~180 px par tuile).
class GrilleCategories extends StatelessWidget {
  const GrilleCategories({
    super.key,
    required this.categories,
    required this.onTap,
    this.onRefresh,
    this.avecImages = true,
  });
  final List<Categorie> categories;
  final ValueChanged<Categorie> onTap;

  /// Faux : chaque tuile montre l'icône de sa catégorie, aucune image n'est
  /// affichée ni téléchargée (mode « icônes » de l'accueil).
  final bool avecImages;

  /// Tirer pour rafraîchir (accueil) ; null : pas de rafraîchissement.
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraintes) {
        final nbColonnes = (contraintes.maxWidth / 180).floor().clamp(2, 5);
        final grille = GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: nbColonnes,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, i) => TuileCategorie(
            categorie: categories[i],
            rang: i,
            avecImage: avecImages,
            onTap: () => onTap(categories[i]),
          ),
        );
        final rafraichir = onRefresh;
        return rafraichir == null
            ? grille
            : RefreshIndicator(onRefresh: rafraichir, child: grille);
      },
    );
  }
}

/// Tuile « Explorer » : fond pastel (bleu, vert, ambre, sarcelle en
/// rotation selon [rang]), emoji ou image en haut, nom en bas à gauche.
class TuileCategorie extends StatelessWidget {
  final Categorie categorie;
  final int rang;
  final VoidCallback onTap;
  const TuileCategorie({
    super.key,
    required this.categorie,
    required this.rang,
    required this.onTap,
    this.avecImage = true,
  });

  /// Faux : l'icône (emoji) même si la catégorie a une image.
  final bool avecImage;

  /// Grisée si désactivée par l'admin OU si aucun partenaire enregistré.
  bool get _bientot =>
      !categorie.estActive ||
      (categorie.nbPartenaires != null && categorie.nbPartenaires == 0);

  @override
  Widget build(BuildContext context) {
    final bientot = _bientot;
    final image = avecImage ? categorie.imageTuile : '';
    final pastels = Config.pastels;
    final (fond, encre) = pastels[rang % pastels.length];
    final emoji = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topLeft,
      child: Text(
        categorie.icone.isNotEmpty ? categorie.icone : '📦',
        style: const TextStyle(fontSize: 60, height: 1),
      ),
    );
    return Material(
      color: fond,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: bientot ? null : onTap,
        child: Opacity(
          opacity: bientot ? 0.45 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image.isEmpty)
                  Expanded(child: emoji)
                else
                  // Image reelle : elle remplit la zone visuelle. L'emoji
                  // la remplace pendant le chargement et en cas d'erreur.
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: LayoutBuilder(
                        builder: (context, contraintes) => ImageReseau(
                          image,
                          fit: BoxFit.cover,
                          width: contraintes.maxWidth,
                          height: contraintes.maxHeight,
                          largeurAffichee: contraintes.maxWidth,
                          attente: categorie.icone.isNotEmpty
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  child: emoji,
                                )
                              : const SizedBox.shrink(),
                          errorBuilder: (_, _, _) =>
                              Align(alignment: Alignment.topLeft, child: emoji),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                // Nom en entier : jusqu'à 3 lignes, l'image se réduit
                // pour lui laisser la place.
                Text(
                  categorie.nom,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: encre,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 1.15,
                  ),
                ),
                if (bientot)
                  Text(
                    'Bientôt disponible',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: encre.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
