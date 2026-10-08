import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../../../global/json/convertisseurs.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';

class LocationsRepository {
  LocationsRepository(this._dio);

  final Dio _dio;

  // Lectures cachées : `xxxBrut` (réseau, JSON stocké tel quel sur disque)
  // et `xxxDepuis` (décodage, appliqué aussi au JSON relu du cache).

  /// `GET /locations/meta/` — types de logement, équipements, disponibilités.
  Future<Object?> metaBrut() async =>
      (await _dio.get('${Env.apiPrefix}/locations/meta/')).data;

  MetaLocations metaDepuis(Object? json) =>
      MetaLocations.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/partenaires/<id>/logements/` — le loueur et ses
  /// logements disponibles, filtrés.
  Future<Object?> logementsBrut(
    int partenaireId,
    FiltreLogements filtre,
  ) async => (await _dio.get(
    '${Env.apiPrefix}/locations/partenaires/$partenaireId/logements/',
    queryParameters: filtre.parametres,
  )).data;

  PageLoueur pageLoueurDepuis(Object? json) =>
      PageLoueur.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/logements/<id>/` — fiche complète.
  Future<Object?> logementBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/locations/logements/$id/')).data;

  Logement logementDepuis(Object? json) =>
      Logement.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/partenaires/<id>/vehicules/` — le loueur et ses
  /// véhicules disponibles, filtrés.
  Future<Object?> vehiculesBrut(
    int partenaireId,
    FiltreVehicules filtre,
  ) async => (await _dio.get(
    '${Env.apiPrefix}/locations/partenaires/$partenaireId/vehicules/',
    queryParameters: filtre.parametres,
  )).data;

  PageLoueurVehicules pageVehiculesDepuis(Object? json) =>
      PageLoueurVehicules.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/vehicules/<id>/` — fiche complète.
  Future<Object?> vehiculeBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/locations/vehicules/$id/')).data;

  Vehicule vehiculeDepuis(Object? json) =>
      Vehicule.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/partenaires/<id>/etablissement/` — l'établissement
  /// (hôtel, résidence) et ses hébergements.
  Future<Object?> etablissementBrut(int partenaireId) async => (await _dio.get(
    '${Env.apiPrefix}/locations/partenaires/$partenaireId/etablissement/',
  )).data;

  PageEtablissement pageEtablissementDepuis(Object? json) =>
      PageEtablissement.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/hebergements/<id>/` — fiche complète.
  Future<Object?> hebergementBrut(int id) async =>
      (await _dio.get('${Env.apiPrefix}/locations/hebergements/$id/')).data;

  Hebergement hebergementDepuis(Object? json) =>
      Hebergement.fromJson(Map<String, dynamic>.from(json as Map));

  /// `GET /locations/hebergements/<id>/disponibilite/` — unités libres du
  /// [arrivee] au [depart] (jamais en cache).
  Future<int> disponibiliteHebergement(
    int id, {
    required DateTime arrivee,
    required DateTime depart,
  }) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/locations/hebergements/$id/disponibilite/',
      queryParameters: {
        'date_debut': formatDateIso(arrivee),
        'date_fin': formatDateIso(depart),
      },
    );
    return versInt((r.data as Map)['unites_disponibles']);
  }

  // ── Demandes de visite et réservations (jamais en cache : écritures et suivi) ──────────

  /// `POST /reservations/` — demande de visite d'un logement.
  Future<void> demanderVisite({
    required int logementId,
    required DateTime date,
    required String telephone,
    String message = '',
  }) async {
    await _dio.post(
      '${Env.apiPrefix}/reservations/',
      data: {
        'objet_id': logementId,
        'nature': 'visite',
        'date_souhaitee': formatDateIso(date),
        'message': message,
        'telephone_contact': telephone,
      },
    );
  }

  /// `POST /reservations/` — réservation d'un véhicule. Un refus (400 :
  /// chevauchement, durée minimale, chauffeur) remonte en [DioException].
  Future<void> reserverVehicule({
    required int vehiculeId,
    required DateTime du,
    required DateTime au,
    required bool avecChauffeur,
    required String telephone,
    String lieuPriseEnCharge = '',
    String message = '',
  }) async {
    await _dio.post(
      '${Env.apiPrefix}/reservations/',
      data: {
        'objet_id': vehiculeId,
        'nature': 'reservation',
        'date_debut': formatDateIso(du),
        'date_fin': formatDateIso(au),
        'avec_chauffeur': avecChauffeur,
        'lieu_prise_en_charge': lieuPriseEnCharge,
        'message': message,
        'telephone_contact': telephone,
      },
    );
  }

  /// `POST /reservations/` — réservation d'un séjour dans un hébergement.
  Future<void> reserverHebergement({
    required int hebergementId,
    required DateTime arrivee,
    required DateTime depart,
    required int adultes,
    required int enfants,
    required int unites,
    required String telephone,
    String message = '',
  }) async {
    await _dio.post(
      '${Env.apiPrefix}/reservations/',
      data: {
        'objet_id': hebergementId,
        'nature': 'reservation',
        'date_debut': formatDateIso(arrivee),
        'date_fin': formatDateIso(depart),
        'nb_adultes': adultes,
        'nb_enfants': enfants,
        'nb_unites': unites,
        'message': message,
        'telephone_contact': telephone,
      },
    );
  }

  /// `GET /reservations/mes-demandes/` — mes demandes (paginé).
  Future<List<DemandeReservation>> mesDemandes({String? statut}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/reservations/mes-demandes/',
      queryParameters: {'statut': ?statut, 'page_size': 100},
    );
    return [
      for (final e in (r.data as Map)['results'] as List)
        DemandeReservation.fromJson(Map<String, dynamic>.from(e as Map)),
    ];
  }

  /// `POST /reservations/<id>/annuler/`.
  Future<void> annulerDemande(int id, {String commentaire = ''}) async {
    await _dio.post(
      '${Env.apiPrefix}/reservations/$id/annuler/',
      data: {'commentaire': commentaire},
    );
  }
}
