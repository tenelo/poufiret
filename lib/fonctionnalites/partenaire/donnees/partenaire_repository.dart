import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/partenaire_vitrine.dart';

class PartenaireRepository {
  final Dio _dio;

  PartenaireRepository({required Dio dio}) : _dio = dio;

  /// GET /auth/partenaires/<id>/ — vitrine publique d'un partenaire.
  Future<PartenaireVitrine> vitrine(int id) async {
    final r = await _dio.get('${Env.apiPrefix}/auth/partenaires/$id/');
    return PartenaireVitrine.fromJson(r.data as Map<String, dynamic>);
  }
}
