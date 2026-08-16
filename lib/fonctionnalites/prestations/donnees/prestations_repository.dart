import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/demande_intervention.dart';

class PrestationsRepository {
  PrestationsRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  static const _base = '${Env.apiPrefix}/messaging/interventions/';

  /// Mes demandes (côté client). [statut] optionnel pour filtrer.
  Future<List<DemandeIntervention>> mesDemandes({String? statut}) async {
    final reponse = await _dio.get(
      _base,
      queryParameters: statut != null ? {'statut': statut} : null,
    );
    return (reponse.data as List)
        .map((e) => DemandeIntervention.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Demandes reçues (côté artisan).
  Future<List<DemandeIntervention>> demandesRecues({String? statut}) async {
    final reponse = await _dio.get(
      '${_base}artisan/',
      queryParameters: statut != null ? {'statut': statut} : null,
    );
    return (reponse.data as List)
        .map((e) => DemandeIntervention.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DemandeIntervention> detail(int id) async {
    final reponse = await _dio.get('$_base$id/');
    return DemandeIntervention.fromJson(reponse.data as Map<String, dynamic>);
  }

  /// Crée une demande. Retourne la demande créée (avec id + numéro).
  Future<DemandeIntervention> creer({
    required int artisanId,
    required String typeIntervention,
    String typeLibre = '',
    required String description,
    required String urgence,
    int? adresseId,
    String descriptionAcces = '',
    required String disponibilitePreferee,
    double? latitude,
    double? longitude,
  }) async {
    final reponse = await _dio.post(_base, data: {
      'artisan': artisanId,
      'type_intervention': typeIntervention,
      if (typeLibre.isNotEmpty) 'type_libre': typeLibre,
      'description': description,
      'urgence': urgence,
      if (adresseId != null) 'adresse': adresseId,
      if (descriptionAcces.isNotEmpty) 'description_acces': descriptionAcces,
      'disponibilite_preferee': disponibilitePreferee,
      if (latitude != null) 'latitude': latitude.toStringAsFixed(6),
      if (longitude != null) 'longitude': longitude.toStringAsFixed(6),
    });
    return DemandeIntervention.fromJson(reponse.data as Map<String, dynamic>);
  }

  /// Transition de statut. Champs optionnels selon la cible.
  Future<DemandeIntervention> transitionner(
    int id,
    String statut, {
    String? dateProposee,
    int? prixPropose,
    String? raisonRefus,
  }) async {
    final reponse = await _dio.post('$_base$id/transition/', data: {
      'statut': statut,
      if (dateProposee != null) 'date_proposee': dateProposee,
      if (prixPropose != null) 'prix_propose': prixPropose,
      if (raisonRefus != null) 'raison_refus': raisonRefus,
    });
    return DemandeIntervention.fromJson(reponse.data as Map<String, dynamic>);
  }

  /// Ajoute une photo (multipart) après création de la demande.
  Future<void> ajouterPhoto(
    int demandeId, {
    required String cheminFichier,
    String legende = '',
    int ordre = 0,
  }) async {
    final form = FormData.fromMap({
      'image': await MultipartFile.fromFile(cheminFichier),
      if (legende.isNotEmpty) 'legende': legende,
      'ordre': ordre,
    });
    await _dio.post('$_base$demandeId/photos/', data: form);
  }
}
