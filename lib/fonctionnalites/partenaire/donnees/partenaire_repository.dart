import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/partenaire_vitrine.dart';

class PartenaireRepository {
  final Dio _dio;

  PartenaireRepository({required Dio dio}) : _dio = dio;

  /// GET /auth/partenaires/<id>/ — vitrine publique d'un partenaire.
  Future<Object?> vitrineBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/auth/partenaires/$id/')).data;

  PartenaireVitrine vitrineDepuis(Object? json) =>
      PartenaireVitrine.fromJson(json as Map<String, dynamic>);
}
