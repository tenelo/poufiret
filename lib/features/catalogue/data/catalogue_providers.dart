import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/categorie.dart';
import 'catalogue_repository.dart';

part 'catalogue_providers.g.dart';

@riverpod
CatalogueRepository catalogueRepository(Ref ref) {
  return CatalogueRepository(dio: ref.watch(dioProvider));
}

/// Charge la liste des catégories. FutureProvider : gère loading/error/data.
@riverpod
Future<List<Categorie>> categories(Ref ref) {
  return ref.watch(catalogueRepositoryProvider).categories();
}
