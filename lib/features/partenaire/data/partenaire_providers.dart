import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/partenaire_vitrine.dart';
import 'partenaire_repository.dart';

part 'partenaire_providers.g.dart';

@riverpod
PartenaireRepository partenaireRepository(Ref ref) {
  return PartenaireRepository(dio: ref.watch(dioProvider));
}

/// Vitrine d'un partenaire par son id. Mis en cache par id.
@riverpod
Future<PartenaireVitrine> partenaireVitrine(Ref ref, {required int id}) {
  return ref.watch(partenaireRepositoryProvider).vitrine(id);
}
