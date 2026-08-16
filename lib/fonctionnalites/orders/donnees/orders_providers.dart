import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/orders_models.dart';
import 'orders_repository.dart';

part 'orders_providers.g.dart';

@riverpod
OrdersRepository ordersRepository(Ref ref) {
  return OrdersRepository(dio: ref.watch(dioProvider));
}

/// Mes paniers (un par partenaire). Rechargé après chaque mutation.
@riverpod
Future<List<Panier>> paniers(Ref ref) {
  return ref.watch(ordersRepositoryProvider).paniers();
}

/// Mes commandes (option filtre statut).
@riverpod
Future<List<Commande>> commandes(Ref ref, {String? statut}) {
  return ref.watch(ordersRepositoryProvider).commandes(statut: statut);
}

/// Détail d'une commande par id.
@riverpod
Future<Commande> commandeDetail(Ref ref, {required int id}) {
  return ref.watch(ordersRepositoryProvider).commandeDetail(id);
}


/// Commandes reçues par le partenaire connecté.
@riverpod
Future<List<Commande>> commandesPartenaire(Ref ref, {String? statut}) {
  return ref
      .watch(ordersRepositoryProvider)
      .commandesPartenaire(statut: statut);
}
