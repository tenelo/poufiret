import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/formule_publicite.dart';
import '../domain/publicite_detail.dart';
import '../domain/publicite_liste.dart';
import 'publicites_repository.dart';

part 'publicites_providers.g.dart';

@riverpod
PublicitesRepository publicitesRepository(Ref ref) {
  return PublicitesRepository(dio: ref.watch(dioProvider));
}

/// Pubs du carrousel d'accueil.
@riverpod
Future<List<PubliciteListe>> carrouselPublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).carrousel();
}

/// Pubs de l'onglet Publicites.
@riverpod
Future<List<PubliciteListe>> pagePublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).pagePublicites();
}

/// Pub du bandeau bas (peut etre nulle).
@riverpod
Future<PubliciteListe?> bandeauBasPublicite(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).bandeauBas();
}

/// Forfaits proposes au partenaire.
@riverpod
Future<List<FormulePublicite>> formulesPublicite(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).formules();
}

/// Fiche detail d'une publicite.
@riverpod
Future<PubliciteDetail> publiciteDetail(Ref ref, {required String id}) {
  return ref.watch(publicitesRepositoryProvider).detail(id);
}

/// Campagnes du partenaire connecte.
@riverpod
Future<List<Map<String, dynamic>>> mesPublicites(Ref ref) {
  return ref.watch(publicitesRepositoryProvider).mesPublicites();
}
