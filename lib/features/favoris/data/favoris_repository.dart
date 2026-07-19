import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/favoris_models.dart';

class FavorisRepository {
  final Dio _dio;

  FavorisRepository({required Dio dio}) : _dio = dio;

  /// GET /social/mes-favoris/ — articles et partenaires mis en favori.
  Future<MesFavoris> mesFavoris() async {
    final r = await _dio.get('${Env.apiPrefix}/social/mes-favoris/');
    return MesFavoris.fromJson(r.data as Map<String, dynamic>);
  }
}
