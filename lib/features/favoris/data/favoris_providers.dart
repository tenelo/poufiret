import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/favoris_models.dart';
import 'favoris_repository.dart';

part 'favoris_providers.g.dart';

@riverpod
FavorisRepository favorisRepository(Ref ref) {
  return FavorisRepository(dio: ref.watch(dioProvider));
}

/// Mes favoris (articles + partenaires).
@riverpod
Future<MesFavoris> mesFavoris(Ref ref) {
  return ref.watch(favorisRepositoryProvider).mesFavoris();
}
