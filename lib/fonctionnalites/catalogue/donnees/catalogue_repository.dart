import '../metier_domaine/partenaire_categorie.dart';
import 'package:dio/dio.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_liste.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/categorie.dart';
import '../metier_domaine/article_detail.dart';
import '../metier_domaine/resultats_recherche.dart';
import '../metier_domaine/video_article.dart';

/// Une page de l'annuaire d'une catégorie.
class PagePartenaires {
  const PagePartenaires({required this.partenaires, required this.aSuite});

  final List<PartenaireCategorie> partenaires;

  /// Le serveur annonce une page suivante.
  final bool aSuite;
}

class CatalogueRepository {
  final Dio _dio;

  CatalogueRepository({required Dio dio}) : _dio = dio;

  // Les lectures cachees sont scindees en deux : `xxxBrut` (appel reseau,
  // renvoie le JSON tel quel — c'est lui qui est stocke sur disque) et
  // `xxxDepuis` (decodage, applique aussi au JSON relu du cache).

  /// GET /catalogue/categories/ — liste des catégories racines (public).
  Future<Object?> categoriesBrut() async =>
      (await _dio.get('${Env.apiPrefix}/catalogue/categories/')).data;

  List<Categorie> categoriesDepuis(Object? json) {
    final data = json as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(Categorie.fromJson).toList();
  }

  /// GET /catalogue/articles/ — articles filtrés (catégorie et/ou recherche).
  Future<Object?> articlesBrut({
    int? categorie,
    String? recherche,
    int? partenaire,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/articles/',
      queryParameters: {
        if (partenaire != null) 'partenaire': partenaire,
        if (categorie != null) 'categorie': categorie,
        if (recherche != null && recherche.isNotEmpty) 'recherche': recherche,
      },
    );
    return r.data;
  }

  List<ArticleListe> articlesDepuis(Object? json) {
    final data = json as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(ArticleListe.fromJson).toList();
  }

  Future<List<ArticleListe>> articles({
    int? categorie,
    String? recherche,
    int? partenaire,
  }) async => articlesDepuis(
    await articlesBrut(
      categorie: categorie,
      recherche: recherche,
      partenaire: partenaire,
    ),
  );

  /// GET /catalogue/categories/<slug>/partenaires/ — annuaire d'une catégorie.
  ///
  /// [recherche] : `?q=` (début de mot, casse et accents ignorés, côté
  /// serveur). [page] : réponse paginée `{count, next, previous, results}`
  /// ([taillePage] par page) ; sans [page], liste simple.
  Future<Object?> partenairesParCategorieBrut(
    String slug, {
    List<String>? localites,
    String? typeEtablissement,
    int? sousCategorie,
    String recherche = '',
    int? page,
    int? taillePage,
    CancelToken? annulation,
  }) async {
    final terme = recherche.trim();
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/categories/$slug/partenaires/',
      queryParameters: {
        if (localites != null && localites.isNotEmpty)
          'localites': localites.join(','),
        // Hotels & Residences : hotel | residence_meublee.
        'type_etablissement': ?typeEtablissement,
        // Catégorie parente : une seule sous-catégorie (et ses descendantes).
        'sous_categorie': ?sousCategorie,
        if (terme.isNotEmpty) 'q': terme,
        'page': ?page,
        'page_size': ?taillePage,
      },
      cancelToken: annulation,
    );
    return r.data;
  }

  /// Partenaires d'une réponse paginée (`results`) ou d'une liste simple.
  List<PartenaireCategorie> partenairesDepuis(Object? json) =>
      pagePartenairesDepuis(json).partenaires;

  /// Page de l'annuaire : partenaires et présence d'une page suivante
  /// (`next`). Une liste simple (serveur sans pagination) est complète.
  PagePartenaires pagePartenairesDepuis(Object? json) {
    final paginee = json is Map;
    final brut = paginee ? json['results'] : json;
    return PagePartenaires(
      partenaires: [
        for (final e in brut as List? ?? const [])
          PartenaireCategorie.fromJson(e as Map<String, dynamic>),
      ],
      aSuite: paginee && json['next'] != null,
    );
  }

  /// GET /catalogue/carte/partenaires/ — tous les partenaires geolocalises
  /// de la portee (pour la carte). Filtre optionnel par [categorie] (slug).
  /// Un seul appel : le plus proche est calcule cote client.
  Future<List<PartenaireCategorie>> cartePartenaires({
    String? categorie,
    List<String>? localites,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/carte/partenaires/',
      queryParameters: {
        if (categorie != null && categorie.isNotEmpty) 'categorie': categorie,
        if (localites != null && localites.isNotEmpty)
          'localites': localites.join(','),
      },
    );
    return (r.data as List)
        .map((e) => PartenaireCategorie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /catalogue/articles/<slug>/ — fiche détail (public).
  Future<Object?> articleDetailBrut(String slug) async =>
      (await _dio.get('${Env.apiPrefix}/catalogue/articles/$slug/')).data;

  ArticleDetail articleDetailDepuis(Object? json) =>
      ArticleDetail.fromJson(json as Map<String, dynamic>);

  /// GET /catalogue/recherche/?q= — recherche unifiee en 3 sections.
  ///
  /// Poufiret est un annuaire avant d'etre un catalogue : on renvoie les
  /// categories (intention annuaire), les partenaires, puis les articles
  /// (intention produit), pour que le client choisisse son chemin.
  Future<ResultatsRecherche> rechercheUnifiee(String terme) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/recherche/',
      queryParameters: {'q': terme},
    );
    return ResultatsRecherche.fromJson(r.data as Map<String, dynamic>);
  }

  /// Toutes les videos actives d'un partenaire (onglet Videos).
  Future<List<VideoArticle>> videosPartenaire(int partenaireId) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/partenaire/$partenaireId/videos/',
    );
    final data = r.data;
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => VideoArticle.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
