import '../metier_domaine/partenaire_categorie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
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

// Les lectures ci-dessous sont en « cache d'abord » (voir fluxCache) : la
// derniere valeur connue s'affiche tout de suite, puis la valeur fraiche la
// remplace. Elles restent en memoire pendant leur duree « fraiche » au lieu
// d'etre rechargees a chaque navigation ; ref.invalidate force le reseau.

/// Charge la liste des catégories.
@riverpod
Stream<List<Categorie>> categories(Ref ref) {
  final repo = ref.watch(catalogueRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'categories',
    politique: PolitiqueCache.categories,
    reseau: repo.categoriesBrut,
    decoder: repo.categoriesDepuis,
  );
}

/// Fiche article telle que le serveur la connait MAINTENANT (sans cache) :
/// pour les formulaires d'edition, qui ne doivent jamais se pre-remplir avec
/// une donnee perimee (le partenaire l'ecraserait a l'enregistrement).
@riverpod
Future<ArticleDetail> articleDetailFrais(Ref ref, {required String slug}) async {
  final repo = ref.watch(catalogueRepositoryProvider);
  return repo.articleDetailDepuis(await repo.articleDetailBrut(slug));
}

/// Articles d'une catégorie donnée (et éventuellement d'un partenaire).
@riverpod
Stream<List<ArticleListe>> articles(Ref ref,
    {required int categorieId, int? partenaireId}) {
  final repo = ref.watch(catalogueRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'articles/c$categorieId/p${partenaireId ?? 0}',
    politique: PolitiqueCache.articles,
    reseau: () => repo.articlesBrut(
      categorie: categorieId,
      partenaire: partenaireId,
    ),
    decoder: repo.articlesDepuis,
  );
}

/// Fiche détail d'un article par son slug.
@riverpod
Stream<ArticleDetail> articleDetail(Ref ref, {required String slug}) {
  final repo = ref.watch(catalogueRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'article/$slug',
    politique: PolitiqueCache.articleDetail,
    reseau: () => repo.articleDetailBrut(slug),
    decoder: repo.articleDetailDepuis,
  );
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
Stream<List<PartenaireCategorie>> partenairesParCategorie(Ref ref,
    {required String slug}) {
  final localites = ref.watch(localitesChoisiesProvider);
  final repo = ref.watch(catalogueRepositoryProvider);
  // Les localites choisies changent le resultat : elles font partie de la cle.
  final loc = ([...localites]..sort()).join(',');
  return fluxCache(
    ref,
    cle: 'partenaires/$slug?loc=$loc',
    politique: PolitiqueCache.partenaires,
    reseau: () => repo.partenairesParCategorieBrut(slug, localites: localites),
    decoder: repo.partenairesDepuis,
  );
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
