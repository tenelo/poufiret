import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/formule_publicite.dart';
import '../domain/publicite_detail.dart';
import '../domain/publicite_liste.dart';

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
  }) async {
    try {
      await _dio.post('$_base/$id/impression/', data: {
        'type_affichage': typeAffichage,
        'cliquee': cliquee,
        'minute_session': ?minuteSession,
      });
    } catch (_) {
      // Tracking best-effort : on ignore silencieusement.
    }
  }

  /// GET /publicites/formules/ — forfaits disponibles (partenaire).
  Future<List<FormulePublicite>> formules() async {
    final r = await _dio.get(
      '$_base/formules/',
      queryParameters: {'page_size': 100},
    );
    return _liste(r.data, 'results').map(FormulePublicite.fromJson).toList();
  }
}
