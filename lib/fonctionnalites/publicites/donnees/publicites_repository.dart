import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/credit_formule.dart';
import '../metier_domaine/formule_publicite.dart';
import '../metier_domaine/publicite_detail.dart';
import '../metier_domaine/stats_publicite.dart';
import '../metier_domaine/publicite_liste.dart';

/// Types d'affichage cotes backend (TypeAffichage).
class TypeAffichage {
  static const carrousel = 'carrousel';
  static const interstitiel = 'interstitiel';
  static const bandeauBas = 'bandeau_bas';
  static const pagePublicites = 'page_publicites';
}

class PublicitesRepository {
  final Dio _dio;

  PublicitesRepository({required Dio dio}) : _dio = dio;

  String get _base => '${Env.apiPrefix}/publicites';

  /// Extrait une liste, que la reponse soit paginee DRF ou non.
  List<Map<String, dynamic>> _liste(dynamic data, String cle) {
    final brut = data is Map<String, dynamic>
        ? (data[cle] ?? data['results'])
        : data;
    if (brut is! List) return const [];
    return brut.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }

  /// GET /publicites/carrousel/ — pubs du carrousel d'accueil (public).
  Future<List<PubliciteListe>> carrousel() async {
    final r = await _dio.get('$_base/carrousel/');
    return _liste(r.data, 'publicites').map(PubliciteListe.fromJson).toList();
  }

  /// GET /publicites/ — toutes les pubs actives (onglet Publicites, public).
  Future<List<PubliciteListe>> pagePublicites() async {
    final r = await _dio.get('$_base/');
    return _liste(r.data, 'publicites').map(PubliciteListe.fromJson).toList();
  }

  /// GET /publicites/bandeau-bas/ — une pub ou rien (public).
  Future<PubliciteListe?> bandeauBas() async {
    final r = await _dio.get('$_base/bandeau-bas/');
    final data = r.data;
    if (data is! Map<String, dynamic>) return null;
    final pub = data['publicite'];
    if (pub is! Map) return null;
    return PubliciteListe.fromJson(Map<String, dynamic>.from(pub));
  }

  /// GET /publicites/interstitiel/?minute_session=N — pub plein ecran ou rien.
  Future<PubliciteDetail?> interstitiel({required int minuteSession}) async {
    final r = await _dio.get(
      '$_base/interstitiel/',
      queryParameters: {'minute_session': minuteSession},
    );
    final data = r.data;
    if (data is! Map<String, dynamic>) return null;
    final pub = data['publicite'];
    if (pub is! Map) return null;
    return PubliciteDetail.fromJson(Map<String, dynamic>.from(pub));
  }

  /// GET `/publicites/<id>/` — fiche detail d'une pub (public).
  Future<PubliciteDetail> detail(String id) async {
    final r = await _dio.get('$_base/$id/');
    return PubliciteDetail.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST `/publicites/<id>/impression/` — trace un affichage ou un clic.
  /// Ne doit jamais casser l'UI : les erreurs sont avalees.
  Future<void> enregistrerImpression(
    String id, {
    required String typeAffichage,
    bool cliquee = false,
    int? minuteSession,
    String? sessionId,
  }) async {
    try {
      await _dio.post('$_base/$id/impression/', data: {
        'type_affichage': typeAffichage,
        'cliquee': cliquee,
        'minute_session': ?minuteSession,
        // Permet au serveur de ne compter qu'une impression par session
        // et par emplacement : un retour sur l'accueil ne regonfle pas
        // les compteurs et ne brule pas un passage.
        'session_id': ?sessionId,
      });
    } catch (_) {
      // Tracking best-effort : on ignore silencieusement.
    }
  }

  /// GET /publicites/mes-publicites/ — campagnes du partenaire connecte.
  Future<List<Map<String, dynamic>>> mesPublicites() async {
    final r = await _dio.get(
      '$_base/mes-publicites/',
      queryParameters: {'page_size': 100},
    );
    return _liste(r.data, 'results');
  }

  /// POST /publicites/mes-publicites/ — cree une campagne (brouillon).
  ///
  /// [cheminImage] est le chemin local du flyer choisi par le partenaire.
  /// [creditId] : si fourni, active la pub immediatement via un credit de
  /// formule (gratuit) au lieu du cycle de paiement.
  Future<Map<String, dynamic>> creerPublicite({
    required String formuleId,
    required String titre,
    required String description,
    required String cheminImage,
    String portee = 'departement',
    String? creditId,
  }) async {
    final form = FormData.fromMap({
      'formule': formuleId,
      'titre': titre,
      'description': description,
      'portee': portee,
      'image_couverture': await MultipartFile.fromFile(cheminImage),
      'credit_id': ?creditId,
    });
    final r = await _dio.post('$_base/mes-publicites/', data: form);
    return Map<String, dynamic>.from(r.data as Map);
  }

  /// POST `/publicites/<id>/transition/<action>/` — change le statut.
  ///
  /// Cote partenaire, seule l'action `soumettre` est autorisee
  /// (brouillon -> en attente de paiement).
  Future<String> transition(String id, String action) async {
    final r = await _dio.post('$_base/$id/transition/$action/');
    final data = r.data;
    return data is Map && data['statut'] != null
        ? data['statut'].toString()
        : '';
  }

  /// GET /publicites/mes-stats/ — resultats des campagnes du partenaire.
  Future<List<StatsPublicite>> mesStats() async {
    final r = await _dio.get('$_base/mes-stats/');
    return _liste(r.data, 'publicites')
        .map(StatsPublicite.fromJson)
        .toList();
  }

  /// GET /publicites/formules/ — forfaits disponibles (partenaire).
  Future<List<FormulePublicite>> formules() async {
    final r = await _dio.get(
      '$_base/formules/',
      queryParameters: {'page_size': 100},
    );
    return _liste(r.data, 'results').map(FormulePublicite.fromJson).toList();
  }

  /// GET /publicites/mes-credits/ — credits de formule du partenaire.
  Future<List<CreditFormule>> mesCredits({String? statut}) async {
    final r = await _dio.get(
      '$_base/mes-credits/',
      queryParameters: {'statut': ?statut},
    );
    return _liste(r.data, 'resultats').map(CreditFormule.fromJson).toList();
  }
}
