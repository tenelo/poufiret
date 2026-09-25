import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/partenaire_vitrine.dart';
import 'partenaire_repository.dart';

part 'partenaire_providers.g.dart';

@riverpod
PartenaireRepository partenaireRepository(Ref ref) {
  return PartenaireRepository(dio: ref.watch(dioProvider));
}

/// Vitrine d'un partenaire par son id (cache d'abord, une entree par id).
@riverpod
Stream<PartenaireVitrine> partenaireVitrine(Ref ref, {required int id}) {
  final repo = ref.watch(partenaireRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'vitrine/$id',
    politique: PolitiqueCache.vitrine,
    reseau: () => repo.vitrineBrut(id),
    decoder: repo.vitrineDepuis,
  );
}
