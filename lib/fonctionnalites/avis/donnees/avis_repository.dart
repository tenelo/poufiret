import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/env.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/avis.dart';

/// Avis clients : donner, modifier, lire, répondre (partenaire).
class AvisRepository {
  AvisRepository(this._dio);

  final Dio _dio;

  /// `POST /avis/` — avis sur un objet reçu (une fois par objet).
  Future<Avis> creer({
    required ObjetAvis objet,
    required String objetId,
    required int note,
    String commentaire = '',
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/avis/',
      data: {
        'objet_type': objet.code,
        'objet_id': objetId,
        'note': note,
        if (commentaire.trim().isNotEmpty) 'commentaire': commentaire.trim(),
      },
    );
    return Avis.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  /// `PATCH /avis/<id>/` — par son auteur, pendant 7 jours.
  Future<Avis> modifier(
    int id, {
    required int note,
    String? commentaire,
  }) async {
    final r = await _dio.patch(
      '${Env.apiPrefix}/avis/$id/',
      data: {'note': note, 'commentaire': ?commentaire?.trim()},
    );
    return Avis.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  /// `GET /avis/mes-avis/` — avis du client connecté.
  Future<List<Avis>> mesAvis() async {
    final r = await _dio.get('${Env.apiPrefix}/avis/mes-avis/');
    return PageAvis.fromJson(r.data).avis;
  }

  /// `GET /partenaires/<id>/avis/` — avis visibles d'un partenaire, paginés.
  Future<PageAvis> avisPartenaire(int partenaireId, {int page = 1}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/partenaires/$partenaireId/avis/',
      queryParameters: {'page': page},
    );
    return PageAvis.fromJson(r.data);
  }

  /// `POST /avis/<id>/repondre/` — le partenaire noté, une seule fois.
  Future<Avis> repondre(int id, String reponse) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/avis/$id/repondre/',
      data: {'reponse': reponse.trim()},
    );
    return Avis.fromJson(Map<String, dynamic>.from(r.data as Map));
  }
}

final avisRepositoryProvider = Provider<AvisRepository>(
  (ref) => AvisRepository(ref.watch(dioProvider)),
);

/// Avis du client connecté (retrouve « Votre avis » d'un objet).
final mesAvisProvider = FutureProvider.autoDispose<List<Avis>>(
  (ref) => ref.watch(avisRepositoryProvider).mesAvis(),
);

/// Première page des avis d'un partenaire (section de la vitrine).
final avisPartenaireProvider = FutureProvider.autoDispose.family<PageAvis, int>(
  (ref, partenaireId) =>
      ref.watch(avisRepositoryProvider).avisPartenaire(partenaireId),
);
