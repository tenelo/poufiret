import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/departement.dart';
import '../metier_domaine/quartier.dart';

class GeoRepository {
  GeoRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  /// Liste des departements pour les menus deroulants (endpoint public).
  Future<List<Departement>> departements() async {
    final r = await _dio.get('${Env.apiPrefix}/geo/departements/');
    final data = r.data;
    final brut = data is Map<String, dynamic> ? data['results'] : data;
    if (brut is! List) return const [];
    return brut
        .whereType<Map>()
        .map((e) => Departement.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Quartiers actifs d'un departement (autocompletion livraison).
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
