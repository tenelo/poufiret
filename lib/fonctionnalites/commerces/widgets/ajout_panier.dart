import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/notificateur.dart';
import '../../orders/donnees/orders_providers.dart';
import '../../orders/metier_domaine/orders_models.dart';
import '../../orders/screens/ecran_panier.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../metier_domaine/fiche_produit.dart';
import '../../auth/widgets/mur_inscription.dart';

/// Ajoute un produit (et sa variante) au panier ; confirme par une
/// notification avec « Voir » ([confirmer] ; pas pour le « + » d'une tuile,
/// la barre du panier suffit), ou relaie le refus du serveur. Renvoie vrai
/// si l'ajout a réussi.
Future<bool> ajouterProduitAuPanier(
  BuildContext context,
  WidgetRef ref, {
  required Plat produit,
  VariantePlat? variante,
  num quantite = 1,
  bool confirmer = true,
}) async {
  // Panier réservé aux comptes connectés ; l'ajout reprend après connexion.
  if (!await exigerConnexion(context) || !context.mounted) return false;
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  try {
    await ref
        .read(ordersRepositoryProvider)
        .ajouterLigne(
          articleId: produit.id,
          varianteId: variante?.id,
          quantite: quantite,
        );
    ref.invalidate(paniersProvider);
    if (!confirmer) return true;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        Notificateur.snackSucces(
          'Ajouté au panier.',
          action: SnackBarAction(
            label: 'Voir',
            textColor: Colors.white,
            onPressed: () => navigator.push(
              MaterialPageRoute(builder: (_) => const EcranPanier()),
            ),
          ),
        ),
      );
    return true;
  } catch (e) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        Notificateur.snackErreur(
          messageErreurApi(e, repli: "Impossible d'ajouter au panier."),
        ),
      );
    return false;
  }
}

/// Le produit se choisit dans sa fiche (variante, ou option obligatoire) :
/// le « + » de la tuile l'ouvre au lieu d'ajouter directement.
bool exigeFiche(Plat p) =>
    p.variantesActives.isNotEmpty || p.groupesActifs.any((g) => g.minChoix > 0);

/// Ligne « simple » du produit dans les paniers (sans variante, option ni
/// menu du jour) : celle que pilote le compteur de la tuile.
LignePanier? ligneDuProduit(List<Panier>? paniers, int produitId) {
  for (final panier in paniers ?? const <Panier>[]) {
    for (final l in panier.lignes) {
      if (l.article == produitId &&
          l.varianteId == null &&
          l.ligneMenu == null &&
          l.choix.isEmpty) {
        return l;
      }
    }
  }
  return null;
}

/// « + » d'une tuile produit : ajoute 1 au panier, puis devient un compteur
/// « − n + » (revenir à 0 retire le produit). Produit à variante ou à
/// option obligatoire : ouvre sa fiche ([onOuvrirFiche]). Rien pour un
/// produit épuisé ou non commandable. Suit le panier : les ajouts faits
/// depuis la fiche ou l'écran panier s'y reflètent.
class BoutonPanierTuile extends ConsumerStatefulWidget {
  const BoutonPanierTuile({
    super.key,
    required this.produit,
    required this.onOuvrirFiche,
  });

  final Plat produit;
  final VoidCallback onOuvrirFiche;

  @override
  ConsumerState<BoutonPanierTuile> createState() => _BoutonPanierTuileState();
}

class _BoutonPanierTuileState extends ConsumerState<BoutonPanierTuile> {
  bool _occupe = false;

  static final _style = IconButton.styleFrom(
    visualDensity: VisualDensity.compact,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  Future<void> _modifier(LignePanier ligne, num quantite) async {
    setState(() => _occupe = true);
    final repo = ref.read(ordersRepositoryProvider);
    try {
      if (quantite <= 0) {
        await repo.supprimerLigne(ligne.id);
      } else {
        await repo.modifierLigne(ligneId: ligne.id, quantite: quantite);
      }
      ref.invalidate(paniersProvider);
    } catch (e) {
      if (mounted) {
        Notificateur.erreur(
          context,
          messageErreurApi(e, repli: 'Erreur, réessayez.'),
        );
      }
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _ajouter() async {
    final p = widget.produit;
    if (exigeFiche(p)) {
      widget.onOuvrirFiche();
      return;
    }
    setState(() => _occupe = true);
    await ajouterProduitAuPanier(context, ref, produit: p, confirmer: false);
    if (mounted) setState(() => _occupe = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.produit;
    if (!p.commandable || p.toutEpuise) return const SizedBox.shrink();
    final ligne = exigeFiche(p)
        ? null
        : ligneDuProduit(ref.watch(paniersProvider).value, p.id);
    if (ligne == null) {
      return IconButton.filled(
        style: _style,
        tooltip: 'Ajouter au panier',
        onPressed: _occupe ? null : _ajouter,
        icon: const Icon(Icons.add),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          style: _style,
          tooltip: 'Retirer un',
          onPressed: _occupe
              ? null
              : () => _modifier(ligne, ligne.quantite - 1),
          icon: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            ligne.quantiteLisible,
            key: const ValueKey('compteur-tuile'),
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        IconButton.filled(
          style: _style,
          tooltip: 'Ajouter un',
          onPressed: _occupe
              ? null
              : () => _modifier(ligne, ligne.quantite + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

/// Barre fixe d'une page commerce, dès que son panier contient un article :
/// « n article(s) · total — Voir le panier », qui ouvre le panier.
class BarrePanierCommerce extends ConsumerWidget {
  const BarrePanierCommerce({
    super.key,
    required this.partenaireId,
    this.largeurMax = 700,
  });

  final int partenaireId;

  /// Contenu borné sur grand écran.
  final double largeurMax;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paniers = ref.watch(paniersProvider).value ?? const <Panier>[];
    final panier = paniers
        .where((p) => p.partenaire == partenaireId && p.lignes.isNotEmpty)
        .firstOrNull;
    if (panier == null) return const SizedBox.shrink();
    final nb = panier.lignes.fold<int>(0, (n, l) => n + l.nbArticles);
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: largeurMax),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => ouvrirPanier(context),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(
                  '$nb ${nb > 1 ? 'articles' : 'article'} · '
                  '${formatMontant(panier.total)} — Voir le panier',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
