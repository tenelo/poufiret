import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/departement.dart';

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
}
