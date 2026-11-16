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
/// rotation selon [rang]).
///  - Avec image : la photo couvre la tuile (fine bordure pastel autour),
///    nom en blanc sur un dégradé sombre en bas.
///  - Sans image : emoji en haut, nom en bas à gauche.
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

  /// Arrondi des coins de la tuile.
  static const double rayonTuile = 22;

  /// Bordure pastel visible autour de la photo (0 : photo bord à bord).
  static const double margeImage = 6;

  /// Grisée si désactivée par l'admin OU si aucun partenaire enregistré.
  bool get _bientot =>
      !categorie.estActive ||
      (categorie.nbPartenaires != null && categorie.nbPartenaires == 0);

  @override
  Widget build(BuildContext context) {
    final bientot = _bientot;
    final image = avecImage ? categorie.imageTuile : '';
    final avecPhoto = image.isNotEmpty;
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

    // Légende : nom (jusqu'à 3 lignes) + « Bientôt disponible ».
    // Blanc sur la photo, encre pastel sinon.
    final couleurNom = avecPhoto ? Colors.white : encre;
    final legende = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          categorie.nom,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: couleurNom,
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
              color: couleurNom.withValues(alpha: avecPhoto ? 0.85 : 0.7),
            ),
          ),
      ],
    );

    return Material(
      color: fond,
      borderRadius: BorderRadius.circular(rayonTuile),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: bientot ? null : onTap,
        child: Opacity(
          opacity: bientot ? 0.45 : 1.0,
          child: avecPhoto
              ? _TuilePhoto(
                  image: image,
                  emoji: emoji,
                  emojiEnAttente: categorie.icone.isNotEmpty,
                  legende: legende,
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: emoji),
                      const SizedBox(height: 10),
                      legende,
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

/// Contenu d'une tuile avec image : photo plein cadre (moins [margeImage]),
/// légende posée en bas sur un dégradé sombre.
class _TuilePhoto extends StatelessWidget {
  const _TuilePhoto({
    required this.image,
    required this.emoji,
    required this.emojiEnAttente,
    required this.legende,
  });

  final String image;

  /// Affiché pendant le chargement et en cas d'erreur de l'image.
  final Widget emoji;

  /// Faux : rien pendant le chargement (catégorie sans emoji).
  final bool emojiEnAttente;
  final Widget legende;

  @override
  Widget build(BuildContext context) {
    const marge = TuileCategorie.margeImage;
    final remplacant = Padding(
      padding: const EdgeInsets.all(10),
      child: Align(alignment: Alignment.topLeft, child: emoji),
    );
    return Padding(
      padding: const EdgeInsets.all(marge),
      child: ClipRRect(
        // Coins concentriques à ceux de la tuile.
        borderRadius: BorderRadius.circular(TuileCategorie.rayonTuile - marge),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo : couvre toute la zone.
            LayoutBuilder(
              builder: (context, contraintes) => ImageReseau(
                image,
                fit: BoxFit.cover,
                width: contraintes.maxWidth,
                height: contraintes.maxHeight,
                largeurAffichee: contraintes.maxWidth,
                attente: emojiEnAttente ? remplacant : const SizedBox.shrink(),
                errorBuilder: (_, _, _) => remplacant,
              ),
            ),
            // Dégradé du bas : transparent en haut, sombre sous le nom.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0),
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 28, 12, 12),
                  child: legende,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
