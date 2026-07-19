import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/categorie.dart';
import 'catalogue_repository.dart';
import '../domain/article_liste.dart';
import '../domain/article_detail.dart';

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

/// Articles d'une catégorie donnée. Le paramètre categorieId permet
/// à Riverpod de mettre en cache par catégorie.
@riverpod
Future<List<ArticleListe>> articles(Ref ref, {required int categorieId}) {
  return ref
      .watch(catalogueRepositoryProvider)
      .articles(categorie: categorieId);
}

/// Fiche détail d'un article par son slug.
@riverpod
Future<ArticleDetail> articleDetail(Ref ref, {required String slug}) {
  return ref.watch(catalogueRepositoryProvider).articleDetail(slug);
}

/// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.
@riverpod
Future<List<ArticleListe>> rechercheArticles(Ref ref, {required String terme}) {
  if (terme.trim().isEmpty) return Future.value(const []);
  return ref
      .watch(catalogueRepositoryProvider)
      .articles(recherche: terme.trim());
}
