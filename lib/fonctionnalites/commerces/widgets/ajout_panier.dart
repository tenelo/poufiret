import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/notificateur.dart';
import '../../orders/donnees/orders_providers.dart';
import '../../orders/metier_domaine/orders_models.dart';
import '../../orders/screens/ecran_panier.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../../auth/widgets/mur_inscription.dart';

/// Ajoute un produit (et sa variante) au panier ; confirme par une
/// notification avec « Voir », ou relaie le refus du serveur. Renvoie vrai
/// si l'ajout a réussi.
Future<bool> ajouterProduitAuPanier(
  BuildContext context,
  WidgetRef ref, {
  required Plat produit,
  VariantePlat? variante,
  num quantite = 1,
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
