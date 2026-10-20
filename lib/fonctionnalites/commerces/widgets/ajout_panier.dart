import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../orders/donnees/orders_providers.dart';
import '../../orders/screens/ecran_panier.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';

/// Ajoute un produit (et sa variante) au panier ; confirme par une
/// notification avec « Voir », ou relaie le refus du serveur. Renvoie vrai
/// si l'ajout a réussi.
Future<bool> ajouterProduitAuPanier(
  BuildContext context,
  WidgetRef ref, {
  required Plat produit,
  VariantePlat? variante,
  int quantite = 1,
}) async {
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
