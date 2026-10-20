import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../restaurants/metier_domaine/commande_plat.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../metier_domaine/catalogue_commerce.dart';
import '../metier_domaine/fiche_produit.dart';

/// Prix affiché d'un produit : « à partir de » si la variante le change.
String prixLisible(Plat p) {
  final prix = formatMontant(prixAPartirDeProduit(p));
  return aPrixVariable(p) ? 'à partir de $prix' : prix;
}

/// Photo d'un produit (ou icône), décodée à la taille affichée.
class PhotoProduit extends StatelessWidget {
  const PhotoProduit({
    super.key,
    required this.url,
    required this.largeur,
    this.icone = Icons.shopping_bag_outlined,
  });

  final String url;
  final double largeur;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (url.isEmpty) {
      return ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(icone, size: 32, color: theme.colorScheme.outline),
        ),
      );
    }
    return ImageReseau(url, fit: BoxFit.cover, largeurAffichee: largeur);
  }
}

/// Grille 2 colonnes de produits : hauteur de case = photo (au
/// [ratioPhoto]) + zone de texte, qui suit la taille de police choisie.
SliverGridDelegate grilleProduits(
  BuildContext context,
  double largeur, {
  double ratioPhoto = 1,
}) {
  const espacement = 12.0;
  final colonne = (largeur - espacement) / 2;
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: espacement,
    crossAxisSpacing: espacement,
    mainAxisExtent:
        colonne / ratioPhoto + MediaQuery.textScalerOf(context).scale(132),
  );
}

/// Case de grille : photo (carrée, ou au [ratioPhoto] voulu), sur-titre
/// (marque), nom, prix, mention (« Épuisé », « Sur commande… »).
class TuileGrilleProduit extends StatelessWidget {
  const TuileGrilleProduit({
    super.key,
    required this.produit,
    required this.onTap,
    this.surTitre = '',
    this.mention = '',
    this.ratioPhoto = 1,
    this.icone = Icons.shopping_bag_outlined,
  });

  final Plat produit;
  final VoidCallback onTap;
  final String surTitre;
  final String mention;
  final double ratioPhoto;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = produit;
    final epuise = p.toutEpuise;
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
                aspectRatio: ratioPhoto,
                child: Opacity(
                  opacity: epuise ? 0.5 : 1,
                  child: PhotoProduit(
                    url: p.image,
                    largeur: contraintes.maxWidth,
                    icone: icone,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (surTitre.isNotEmpty)
                        Text(
                          surTitre.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Config.couleurTexteSecondaire,
                            letterSpacing: 0.5,
                          ),
                        ),
                      Text(
                        p.nom,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (epuise || mention.isNotEmpty)
                        Text(
                          epuise ? 'Épuisé' : mention,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: epuise
                                ? Config.couleurErreur
                                : Config.couleurTexteSecondaire,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      Text(
                        prixLisible(p),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
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

/// Ligne de liste : vignette à gauche (au [ratioPhoto] voulu), lignes de
/// texte, prix, et une action à droite (Ajouter, Appeler...).
class LigneProduit extends StatelessWidget {
  const LigneProduit({
    super.key,
    required this.produit,
    required this.onTap,
    this.lignes = const [],
    this.mention = '',
    this.couleurMention,
    this.action,
    this.ratioPhoto = 1,
    this.icone = Icons.shopping_bag_outlined,
  });

  final Plat produit;
  final VoidCallback onTap;

  /// Lignes secondaires (« Comprimé · 500 mg », laboratoire, auteur...).
  final List<String> lignes;
  final String mention;
  final Color? couleurMention;
  final Widget? action;
  final double ratioPhoto;
  final IconData icone;

  static const double hauteurVignette = 96;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = produit;
    final epuise = p.toutEpuise;
    final largeur = hauteurVignette * ratioPhoto;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: largeur,
                height: hauteurVignette,
                child: PhotoProduit(
                  url: p.image,
                  largeur: largeur,
                  icone: icone,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
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
                  for (final l in lignes.where((l) => l.isNotEmpty))
                    Text(
                      l,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Config.couleurTexteSecondaire,
                      ),
                    ),
                  if (epuise || mention.isNotEmpty)
                    Text(
                      epuise ? 'Épuisé' : mention,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: epuise
                            ? Config.couleurErreur
                            : couleurMention ?? Config.couleurTexteSecondaire,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    prixLisible(p),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Sous le texte : « Appeler la pharmacie » tient sur un
                  // petit écran.
                  if (action != null)
                    Align(alignment: Alignment.centerRight, child: action),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
