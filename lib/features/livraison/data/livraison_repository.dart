import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/livraison_models.dart';

class LivraisonRepository {
  final Dio _dio;

  LivraisonRepository({required Dio dio}) : _dio = dio;

  // ── Courses ──────────────────────────────────────────────────────

  /// POST /livraison/courses/creer/ — cree une course A -> B et tente
  /// l'assignation auto au livreur le plus proche.
  /// [ville] = id entier du Departement. GPS optionnels (obligatoires
  /// cote UI seulement si c'est "ma position").
  Future<ResultatCreationCourse> creerCourse({
    required int ville,
    required String aQuartier,
    required String aNomContact,
    required String aTelephoneContact,
    double? aLatitude,
    double? aLongitude,
    required String bQuartier,
    required String bNomContact,
    required String bTelephoneContact,
    double? bLatitude,
    double? bLongitude,
    String descriptionColis = '',
    int prix = 0,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/livraison/courses/creer/',
      data: {
        'ville': ville,
        'a_quartier': aQuartier,
        'a_nom_contact': aNomContact,
        'a_telephone_contact': aTelephoneContact,
        if (aLatitude != null) 'a_latitude': aLatitude,
        if (aLongitude != null) 'a_longitude': aLongitude,
        'b_quartier': bQuartier,
        'b_nom_contact': bNomContact,
        'b_telephone_contact': bTelephoneContact,
        if (bLatitude != null) 'b_latitude': bLatitude,
        if (bLongitude != null) 'b_longitude': bLongitude,
        if (descriptionColis.isNotEmpty) 'description_colis': descriptionColis,
        'prix': prix,
      },
    );
    return ResultatCreationCourse.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /livraison/courses/ — historique de mes courses (option filtre statut).
  Future<List<Course>> mesCourses({String? statut}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/livraison/courses/',
      queryParameters: {if (statut != null) 'statut': statut},
    );
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(Course.fromJson)
        .toList();
  }

  /// GET /livraison/courses/<id>/ — detail d'une course (id = UUID string).
  Future<Course> courseDetail(String id) async {
    final r = await _dio.get('${Env.apiPrefix}/livraison/courses/$id/');
    return Course.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST /livraison/courses/<id>/transition/ — change le statut.
  /// Cote demandeur : seule "annulee" est autorisee, avant colis pris.
  Future<Course> transition({
    required String courseId,
    required String statut,
    String? raisonRefus,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/livraison/courses/$courseId/transition/',
      data: {
        'statut': statut,
        if (raisonRefus != null) 'raison_refus': raisonRefus,
      },
    );
    return Course.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /livraison/courses/recues/ — courses ou je suis le destinataire
  /// (contact_user). Alimente la surface "colis qui m'arrivent".
  Future<List<Course>> coursesRecues({String? statut}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/livraison/courses/recues/',
      queryParameters: {if (statut != null) 'statut': statut},
    );
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(Course.fromJson)
        .toList();
  }

  /// POST /livraison/courses/<id>/position-contact/ — le destinataire depose
  /// sa position GPS reelle sur son point (B). N'affecte pas le statut.
  Future<Course> deposerPositionContact({
    required String courseId,
    required double latitude,
    required double longitude,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/livraison/courses/$courseId/position-contact/',
      data: {'latitude': latitude, 'longitude': longitude},
    );
    return Course.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Livreurs (carte) ─────────────────────────────────────────────

  /// GET /livreurs/proches/?lat=&lng= — livreurs EN LIGNE de ma ville,
  /// tries par distance. Renvoie un tableau brut (pas d'enveloppe).
  Future<List<LivreurProche>> livreursProches({
    double? lat,
    double? lng,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/livreurs/proches/',
      queryParameters: {
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(LivreurProche.fromJson)
        .toList();
  }
}
