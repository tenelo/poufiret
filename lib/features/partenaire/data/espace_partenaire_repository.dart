import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/ma_categorie.dart';
import '../domain/stats_vues.dart';

class EspacePartenaireRepository {
  EspacePartenaireRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  static const _articles = '${Env.apiPrefix}/catalogue/articles/';

  /// Stats de vues du partenaire connecté.
  Future<StatsVues> statsVues() async {
    final r = await _dio
        .get('${Env.apiPrefix}/catalogue/partenaire/stats-vues/');
    return StatsVues.fromJson(r.data as Map<String, dynamic>);
  }

  /// Crée un article. Retourne le JSON complet (avec slug).
  Future<Map<String, dynamic>> creerArticle(Map<String, dynamic> donnees) async {
    final r = await _dio.post(_articles, data: donnees);
    return r.data as Map<String, dynamic>;
  }

  /// Modifie un article (PATCH partiel par slug).
  Future<Map<String, dynamic>> modifierArticle(
      String slug, Map<String, dynamic> donnees) async {
    final r = await _dio.patch('$_articles$slug/', data: donnees);
    return r.data as Map<String, dynamic>;
  }

  /// Supprime un article.
  Future<void> supprimerArticle(String slug) async {
    await _dio.delete('$_articles$slug/');
  }

  /// Profil du partenaire connecte (sa vitrine).
  Future<Map<String, dynamic>> monProfil() async {
    final r = await _dio.get('${Env.apiPrefix}/auth/mon-profil-partenaire/');
    return Map<String, dynamic>.from(r.data as Map);
  }

  /// Modifie le profil. [cheminLogo] et [cheminCouverture] sont des
  /// chemins locaux ; s'ils sont nuls, les images ne sont pas touchees.
  Future<Map<String, dynamic>> modifierProfil(
    Map<String, dynamic> champs, {
    String? cheminLogo,
    String? cheminCouverture,
  }) async {
    final aDesFichiers = cheminLogo != null || cheminCouverture != null;
    final dynamic corps = aDesFichiers
        ? FormData.fromMap({
            ...champs,
            if (cheminLogo != null)
              'logo': await MultipartFile.fromFile(cheminLogo),
            if (cheminCouverture != null)
              'photo_couverture':
                  await MultipartFile.fromFile(cheminCouverture),
          })
        : champs;
    final r = await _dio.patch(
      '${Env.apiPrefix}/auth/mon-profil-partenaire/',
      data: corps,
    );
    return Map<String, dynamic>.from(r.data as Map);
  }

  /// Categories auxquelles le partenaire est rattache.
  Future<List<MaCategorie>> mesCategories() async {
    final r = await _dio.get(
      '${Env.apiPrefix}/auth/mes-categories/',
      queryParameters: {'page_size': 100},
    );
    final data = r.data;
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => MaCategorie.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Change l'image de couverture affichee dans une categorie donnee.
  Future<void> changerImageCategorie(int lienId, String cheminImage) async {
    final form = FormData.fromMap({
      'image_couverture': await MultipartFile.fromFile(cheminImage),
    });
    await _dio.patch(
      '${Env.apiPrefix}/auth/mes-categories/$lienId/',
      data: form,
    );
  }

  /// Ajoute une photo à un article (multipart).
  Future<void> ajouterImage(
    int articleId, {
    required String cheminFichier,
    bool estPrincipale = false,
    int ordre = 0,
  }) async {
    final form = FormData.fromMap({
      'article': articleId,
      'image': await MultipartFile.fromFile(cheminFichier),
      'est_principale': estPrincipale,
      'ordre': ordre,
    });
    await _dio.post('${Env.apiPrefix}/catalogue/images/', data: form);
  }
}
