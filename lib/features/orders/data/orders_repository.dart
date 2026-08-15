import 'package:dio/dio.dart';

import '../../../core/config/env.dart';
import '../domain/orders_models.dart';

class OrdersRepository {
  final Dio _dio;

  OrdersRepository({required Dio dio}) : _dio = dio;

  // ── Paniers ────────────────────────────────────────────────────────

  /// GET /orders/paniers/ — mes paniers (un par partenaire).
  Future<List<Panier>> paniers() async {
    final r = await _dio.get('${Env.apiPrefix}/orders/paniers/');
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(Panier.fromJson)
        .toList();
  }

  /// POST /orders/paniers/ajouter/ — ajoute une ligne, renvoie le panier à jour.
  Future<Panier> ajouterLigne({
    required int articleId,
    required int quantite,
    int? varianteId,
    List<int>? supplementIds,
    String? noteSpeciale,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/orders/paniers/ajouter/',
      data: {
        'article': articleId,
        'quantite': quantite,
        if (varianteId != null) 'variante_id': varianteId,
        if (supplementIds != null) 'supplement_ids': supplementIds,
        if (noteSpeciale != null) 'note_speciale': noteSpeciale,
      },
    );
    return Panier.fromJson(r.data as Map<String, dynamic>);
  }

  /// PATCH /orders/lignes/<id>/ — modifie quantité et/ou note.
  Future<Panier> modifierLigne({
    required int ligneId,
    int? quantite,
    String? noteSpeciale,
  }) async {
    final r = await _dio.patch(
      '${Env.apiPrefix}/orders/lignes/$ligneId/',
      data: {
        if (quantite != null) 'quantite': quantite,
        if (noteSpeciale != null) 'note_speciale': noteSpeciale,
      },
    );
    // Peut renvoyer le panier, ou un message si le panier devient vide.
    final data = r.data;
    if (data is Map<String, dynamic> && data.containsKey('id')) {
      return Panier.fromJson(data);
    }
    return const Panier(id: -1); // panier vidé/supprimé (sentinelle)
  }

  /// DELETE /orders/lignes/<id>/ — retire une ligne.
  Future<Panier?> supprimerLigne(int ligneId) async {
    final r = await _dio.delete('${Env.apiPrefix}/orders/lignes/$ligneId/');
    final data = r.data;
    if (data is Map<String, dynamic> && data.containsKey('id')) {
      return Panier.fromJson(data);
    }
    return null; // panier vide et supprimé
  }

  /// DELETE /orders/paniers/<id>/ — vide un panier entier.
  Future<void> viderPanier(int panierId) async {
    await _dio.delete('${Env.apiPrefix}/orders/paniers/$panierId/');
  }

  // ── Commandes ──────────────────────────────────────────────────────

  /// POST /orders/paniers/<id>/valider/ — transforme un panier en commande.
  Future<Commande> validerPanier({
    required int panierId,
    String modeLivraison = 'emporter',
    int? adresseId,
    String modePaiement = 'cash',
    String? notesClient,
    int fraisLivraison = 0,
    double? latitude,
    double? longitude,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/orders/paniers/$panierId/valider/',
      data: {
        'mode_livraison': modeLivraison,
        if (adresseId != null) 'adresse': adresseId,
        'mode_paiement': modePaiement,
        if (notesClient != null) 'notes_client': notesClient,
        'frais_livraison': fraisLivraison,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      },
    );
    return Commande.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /orders/commandes/ — mes commandes (option filtre statut).
  Future<List<Commande>> commandes({String? statut}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/orders/commandes/',
      queryParameters: {if (statut != null) 'statut': statut},
    );
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(Commande.fromJson)
        .toList();
  }

/// GET /orders/commandes/partenaire/ — commandes reçues par le partenaire.
  Future<List<Commande>> commandesPartenaire({String? statut}) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/orders/commandes/partenaire/',
      queryParameters: {if (statut != null) 'statut': statut},
    );
    return (r.data as List)
        .cast<Map<String, dynamic>>()
        .map(Commande.fromJson)
        .toList();
  }

  /// GET /orders/commandes/<id>/ — détail d'une commande.
  Future<Commande> commandeDetail(int id) async {
    final r = await _dio.get('${Env.apiPrefix}/orders/commandes/$id/');
    return Commande.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST /orders/commandes/<id>/transition/ — change le statut.
  /// Côté client : annuler une commande encore "nouvelle".
  Future<Commande> transition({
    required int commandeId,
    required String statut,
    String? raisonRefus,
  }) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/orders/commandes/$commandeId/transition/',
      data: {
        'statut': statut,
        if (raisonRefus != null) 'raison_refus': raisonRefus,
      },
    );
    return Commande.fromJson(r.data as Map<String, dynamic>);
  }

  /// POST /orders/commandes/<id>/livreur/ — le partenaire commande un
  /// livreur pour une commande prete en mode livraison.
  /// Retourne {course, commande_statut, assigne, message?}.
  Future<Map<String, dynamic>> commanderLivreur(int commandeId) async {
    final r = await _dio.post(
      '${Env.apiPrefix}/orders/commandes/$commandeId/livreur/',
    );
    return r.data as Map<String, dynamic>;
  }
}
