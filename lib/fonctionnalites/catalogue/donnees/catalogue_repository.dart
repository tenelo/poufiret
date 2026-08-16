import '../metier_domaine/partenaire_categorie.dart';
import 'package:dio/dio.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_liste.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/categorie.dart';
import '../metier_domaine/article_detail.dart';
import '../metier_domaine/resultats_recherche.dart';
import '../metier_domaine/video_article.dart';

class CatalogueRepository {
  final Dio _dio;

  CatalogueRepository({required Dio dio}) : _dio = dio;

  /// GET /catalogue/categories/ — liste des catégories racines (public).
  Future<List<Categorie>> categories() async {
    final r = await _dio.get('${Env.apiPrefix}/catalogue/categories/');
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(Categorie.fromJson).toList();
  }

/// GET /catalogue/articles/ — articles filtrés (catégorie et/ou recherche).
  Future<List<ArticleListe>> articles({
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
    final data = r.data as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(ArticleListe.fromJson).toList();
  }
  
  /// GET /catalogue/categories/<slug>/partenaires/ — annuaire d'une catégorie.
  Future<List<PartenaireCategorie>> partenairesParCategorie(
    String slug, {
    List<String>? localites,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/catalogue/categories/$slug/partenaires/',
      queryParameters: {
        if (localites != null && localites.isNotEmpty)
          'localites': localites.join(','),
      },
    );
    return (r.data as List)
        .map((e) => PartenaireCategorie.fromJson(e as Map<String, dynamic>))
        .toList();
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
  Future<ArticleDetail> articleDetail(String slug) async {
    final r = await _dio.get('${Env.apiPrefix}/catalogue/articles/$slug/');
    return ArticleDetail.fromJson(r.data as Map<String, dynamic>);
  }

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
