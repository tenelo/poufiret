import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/departement.dart';
import '../metier_domaine/localite.dart';
import '../metier_domaine/quartier.dart';

class GeoRepository {
  GeoRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  /// Liste des departements pour les menus deroulants (endpoint public).
  Future<Object?> departementsBrut() async =>
      (await _dio.get('${Env.apiPrefix}/geo/departements/')).data;

  List<Departement> departementsDepuis(Object? data) {
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => Departement.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // Cascade Departement -> Localite -> Quartier : reponses
  // `{"resultats": [{"id", "nom"}]}`, actives et triees par nom.

  /// Localites d'un departement.
  Future<Object?> localitesBrut(int departementId) async => (await _dio.get(
    '${Env.apiPrefix}/geo/localites/',
    queryParameters: {'departement': departementId},
  )).data;

  List<Localite> localitesDepuis(Object? data) => [
    for (final e in (data as Map)['resultats'] as List)
      Localite.fromJson(Map<String, dynamic>.from(e as Map)),
  ];

  /// Quartiers d'une localite.
  Future<Object?> quartiersDeLocaliteBrut(int localiteId) async =>
      (await _dio.get(
        '${Env.apiPrefix}/geo/quartiers/',
        queryParameters: {'localite': localiteId},
      )).data;

  List<Quartier> quartiersDeLocaliteDepuis(Object? data) => [
    for (final e in (data as Map)['resultats'] as List)
      Quartier.fromJson(Map<String, dynamic>.from(e as Map)),
  ];

  /// Quartiers actifs d'un departement (autocompletion livraison). Liste
  /// brute, sans "resultats" : a ne pas utiliser pour la cascade.
  Future<List<Quartier>> quartiers(int departementId) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/geo/quartiers/',
      queryParameters: {'departement': departementId},
    );
    final data = r.data;
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => Quartier.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
