import '../metier_domaine/partenaire_categorie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/categorie.dart';
import 'catalogue_repository.dart';
import '../metier_domaine/article_liste.dart';
import '../metier_domaine/article_detail.dart';
import '../metier_domaine/resultats_recherche.dart';
import '../metier_domaine/video_article.dart';

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

/// Localites choisies par l'utilisateur pour elargir sa vue.
///
/// Liste d'ids de departements, ou ['all'] pour tout voir. Vide = vue par
/// defaut (son departement + ce que la portee des partenaires autorise).
/// keepAlive : le choix persiste entre les categories consultees.
@Riverpod(keepAlive: true)
class LocalitesChoisies extends _$LocalitesChoisies {
  @override
  List<String> build() => const [];

  void definir(List<String> localites) => state = localites;
  void tout() => state = const ['all'];
  void reinitialiser() => state = const [];
}

/// Annuaire des prestataires d'une catégorie, filtre par les localites
/// choisies (le backend applique aussi la regle de portee).
@riverpod
Future<List<PartenaireCategorie>> partenairesParCategorie(Ref ref,
    {required String slug}) {
  final localites = ref.watch(localitesChoisiesProvider);
  return ref
      .watch(catalogueRepositoryProvider)
      .partenairesParCategorie(slug, localites: localites);
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
