import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../metier_domaine/vente_models.dart';
import 'elements_fiche.dart';

/// Pastille « À vendre » (cartes et fiches).
class BadgeAVendre extends StatelessWidget {
  const BadgeAVendre({super.key, this.texte = 'À vendre'});

  final String texte;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texte,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Bandeau « Vendu » : remplace les boutons d'action d'une annonce vendue.
class BandeauVendu extends StatelessWidget {
  const BandeauVendu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: 'Annonce vendue',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Config.couleurFond,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Config.couleurBordure),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sell_outlined,
              size: 20,
              color: Config.couleurTexteSecondaire,
            ),
            const SizedBox(width: 8),
            Text(
              'Vendu',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Prix de vente : « 12 500 000 FCFA » et, s'il l'est, « négociable ».
class PrixVente extends StatelessWidget {
  const PrixVente({super.key, required this.infos, this.grand = false});

  final InfosVente infos;

  /// Taille de la fiche (sinon, celle d'une carte).
  final bool grand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prix = infos.prixVenteLisible;
    if (prix.isEmpty) return const SizedBox.shrink();
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        Text(
          prix,
          style:
              (grand ? theme.textTheme.titleLarge : theme.textTheme.bodyMedium)
                  ?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
        ),
        if (infos.prixNegociable)
          Text(
            'négociable',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Config.couleurTexteSecondaire,
            ),
          ),
      ],
    );
  }
}

/// Section « Vente » d'une fiche : prix de vente puis les champs renseignés.
class SectionVente extends StatelessWidget {
  const SectionVente({super.key, required this.infos, required this.lignes});

  final InfosVente infos;
  final List<(String, String)> lignes;

  @override
  Widget build(BuildContext context) {
    return SectionFiche(
      titre: 'Vente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (infos.prixVente != null)
            LigneFiche(
              infos.prixNegociable ? 'Prix (négociable)' : 'Prix',
              infos.prixVenteLisible,
            ),
          for (final (libelle, valeur) in lignes) LigneFiche(libelle, valeur),
        ],
      ),
    );
  }
}

/// Bouton(s) du bas de fiche selon l'annonce : [louer] (réserver, visiter)
/// si elle est à louer, « Je suis intéressé » si elle est à vendre, les
/// deux pour une annonce en location et vente ; le bandeau « Vendu » une
/// fois vendue.
class ActionsFicheVente extends StatelessWidget {
  const ActionsFicheVente({
    super.key,
    required this.actions,
    required this.louer,
    required this.onInteresse,
  });

  final ActionsAnnonce actions;
  final Widget louer;
  final VoidCallback onInteresse;

  @override
  Widget build(BuildContext context) {
    if (actions.vendu) return const BandeauVendu();
    final interesse = FilledButton.icon(
      onPressed: onInteresse,
      icon: const Icon(Icons.handshake_outlined),
      label: const Text('Je suis intéressé'),
    );
    if (actions.louer && actions.acheter) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [louer, const SizedBox(height: 8), interesse],
      );
    }
    return actions.acheter ? interesse : louer;
  }
}
