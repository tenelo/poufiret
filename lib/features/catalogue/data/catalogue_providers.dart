import '../domain/partenaire_categorie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/categorie.dart';
import 'catalogue_repository.dart';
import '../domain/article_liste.dart';
import '../domain/article_detail.dart';
import '../domain/resultats_recherche.dart';
import '../domain/video_article.dart';

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
Future<List<ArticleListe>> articles(Ref ref,
    {required int categorieId, int? partenaireId}) {
  return ref
      .watch(catalogueRepositoryProvider)
      .articles(categorie: categorieId, partenaire: partenaireId);
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

/// Annuaire des prestataires d'une catégorie.
@riverpod
Future<List<PartenaireCategorie>> partenairesParCategorie(Ref ref,
    {required String slug}) {
  return ref
      .watch(catalogueRepositoryProvider)
      .partenairesParCategorie(slug);
}

/// Recherche unifiee : categories + partenaires + articles.
@riverpod
Future<ResultatsRecherche> rechercheUnifiee(Ref ref, {required String terme}) {
  if (terme.trim().length < 2) {
    return Future.value(const ResultatsRecherche());
  }
  return ref.watch(catalogueRepositoryProvider).rechercheUnifiee(terme.trim());
}

/// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.
@riverpod
Future<List<VideoArticle>> videosPartenaire(Ref ref,
    {required int partenaireId}) {
  return ref
      .watch(catalogueRepositoryProvider)
      .videosPartenaire(partenaireId);
}
