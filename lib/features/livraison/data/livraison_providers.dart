import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/livraison_models.dart';
import 'livraison_repository.dart';

part 'livraison_providers.g.dart';

@riverpod
LivraisonRepository livraisonRepository(Ref ref) {
  return LivraisonRepository(dio: ref.watch(dioProvider));
}

/// Historique de mes courses (option filtre statut).
@riverpod
Future<List<Course>> mesCourses(Ref ref, {String? statut}) {
  return ref.watch(livraisonRepositoryProvider).mesCourses(statut: statut);
}

/// Detail d'une course par id (UUID string).
@riverpod
Future<Course> courseDetail(Ref ref, {required String id}) {
  return ref.watch(livraisonRepositoryProvider).courseDetail(id);
}

/// Courses ou je suis le destinataire (colis qui m'arrivent).
@riverpod
Future<List<Course>> coursesRecues(Ref ref, {String? statut}) {
  return ref.watch(livraisonRepositoryProvider).coursesRecues(statut: statut);
}

/// Prix de course courant (lu depuis l'admin via l'endpoint public).
@riverpod
Future<int> tarifCourse(Ref ref) {
  return ref.watch(livraisonRepositoryProvider).tarifCourse();
}

/// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.
@riverpod
Future<List<LivreurProche>> livreursProches(
  Ref ref, {
  double? lat,
  double? lng,
}) {
  return ref
      .watch(livraisonRepositoryProvider)
      .livreursProches(lat: lat, lng: lng);
}
