import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_models.freezed.dart';
part 'orders_models.g.dart';

/// Convertit un montant reçu en int, quel que soit son format JSON
/// (int, double comme 7000.0, ou String comme "3500").
int _versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is num) return valeur.round();
  return double.tryParse(valeur.toString())?.round() ?? 0;
}

/// Un supplément figé dans une ligne (snapshot {id, nom, prix}).
@freezed
abstract class SupplementSnapshot with _$SupplementSnapshot {
  const factory SupplementSnapshot({
    int? id,
    @Default('') String nom,
    @JsonKey(fromJson: _versInt) @Default(0) int prix,
  }) = _SupplementSnapshot;

  factory SupplementSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SupplementSnapshotFromJson(json);
}

/// Ligne de panier (modifiable).
@freezed
abstract class LignePanier with _$LignePanier {
  const factory LignePanier({
    required int id,
    required int article,
    @JsonKey(name: 'article_nom') @Default('') String articleNom,
    @JsonKey(name: 'variante_id') int? varianteId,
    @Default(<SupplementSnapshot>[]) List<SupplementSnapshot> supplements,
    @Default(1) int quantite,
    @JsonKey(name: 'prix_unitaire', fromJson: _versInt)
    @Default(0)
    int prixUnitaire,
    @JsonKey(name: 'prix_ligne', fromJson: _versInt) @Default(0) int prixLigne,
    @JsonKey(name: 'note_speciale') @Default('') String noteSpeciale,
  }) = _LignePanier;

  factory LignePanier.fromJson(Map<String, dynamic> json) =>
      _$LignePanierFromJson(json);
}

/// Panier pur d'un client : un par couple (commerçant, catégorie).
@freezed
abstract class Panier with _$Panier {
  const factory Panier({
    required int id,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'categorie') int? categorie,
    @JsonKey(name: 'categorie_nom') @Default('') String categorieNom,
    @Default(<LignePanier>[]) List<LignePanier> lignes,
    @JsonKey(fromJson: _versInt) @Default(0) int total,
  }) = _Panier;

  factory Panier.fromJson(Map<String, dynamic> json) => _$PanierFromJson(json);
}

/// Ligne de commande (snapshot figé, non modifiable).
@freezed
abstract class LigneCommande with _$LigneCommande {
  const factory LigneCommande({
    required int id,
    int? article,
    @JsonKey(name: 'nom_article') @Default('') String nomArticle,
    @JsonKey(name: 'variante_nom') @Default('') String varianteNom,
    @Default(<SupplementSnapshot>[]) List<SupplementSnapshot> supplements,
    @Default(1) int quantite,
    @JsonKey(name: 'prix_unitaire', fromJson: _versInt)
    @Default(0)
    int prixUnitaire,
    @JsonKey(name: 'prix_ligne', fromJson: _versInt) @Default(0) int prixLigne,
    @JsonKey(name: 'note_speciale') @Default('') String noteSpeciale,
  }) = _LigneCommande;

  factory LigneCommande.fromJson(Map<String, dynamic> json) =>
      _$LigneCommandeFromJson(json);
}

/// Une commande passée.
@freezed
abstract class Commande with _$Commande {
  const Commande._();

  const factory Commande({
    required int id,
    @Default('') String numero,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'client_nom') @Default('') String clientNom,
    @JsonKey(name: 'client_telephone') @Default('') String clientTelephone,
    @JsonKey(name: 'mode_livraison') @Default('emporter') String modeLivraison,
    @JsonKey(name: 'adresse_snapshot') @Default('') String adresseSnapshot,
    @Default('nouvelle') String statut,
    @JsonKey(name: 'raison_refus') @Default('') String raisonRefus,
    @JsonKey(name: 'sous_total', fromJson: _versInt) @Default(0) int sousTotal,
    @JsonKey(name: 'frais_livraison', fromJson: _versInt)
    @Default(0)
    int fraisLivraison,
    @JsonKey(fromJson: _versInt) @Default(0) int total,
    @JsonKey(name: 'mode_paiement') @Default('cash') String modePaiement,
    @JsonKey(name: 'notes_client') @Default('') String notesClient,
    @Default(<LigneCommande>[]) List<LigneCommande> lignes,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Commande;

  factory Commande.fromJson(Map<String, dynamic> json) =>
      _$CommandeFromJson(json);

  /// Libellé lisible du statut.
  String get statutLibelle =>
      const {
        'nouvelle': 'Nouvelle',
        'acceptee': 'Acceptée',
        'refusee': 'Refusée',
        'en_preparation': 'En préparation',
        'prete': 'Prête',
        'en_livraison': 'En livraison',
        'livree': 'Livrée',
        'annulee': 'Annulée',
        'expiree': 'Expirée',
      }[statut] ??
      statut;

  /// Libellé du mode de livraison.
  String get modeLivraisonLibelle =>
      const {
        'emporter': 'À emporter',
        'sur_place': 'Sur place',
        'livraison': 'Livraison',
      }[modeLivraison] ??
      modeLivraison;

  /// Libellé du mode de paiement.
  String get modePaiementLibelle =>
      const {'cash': 'Espèces', 'mobile_money': 'Mobile Money'}[modePaiement] ??
      modePaiement;

  /// Le client ne peut annuler qu'une commande encore "nouvelle".
  bool get peutAnnuler => statut == 'nouvelle';
}
