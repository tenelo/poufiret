// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupplementSnapshot _$SupplementSnapshotFromJson(Map<String, dynamic> json) =>
    _SupplementSnapshot(
      id: (json['id'] as num?)?.toInt(),
      nom: json['nom'] as String? ?? '',
      prix: json['prix'] == null ? 0 : _versInt(json['prix']),
    );

Map<String, dynamic> _$SupplementSnapshotToJson(_SupplementSnapshot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prix': instance.prix,
    };

_LignePanier _$LignePanierFromJson(Map<String, dynamic> json) => _LignePanier(
  id: (json['id'] as num).toInt(),
  article: (json['article'] as num).toInt(),
  articleNom: json['article_nom'] as String? ?? '',
  varianteId: (json['variante_id'] as num?)?.toInt(),
  supplements:
      (json['supplements'] as List<dynamic>?)
          ?.map((e) => SupplementSnapshot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SupplementSnapshot>[],
  quantite: (json['quantite'] as num?)?.toInt() ?? 1,
  prixUnitaire: json['prix_unitaire'] == null
      ? 0
      : _versInt(json['prix_unitaire']),
  prixLigne: json['prix_ligne'] == null ? 0 : _versInt(json['prix_ligne']),
  noteSpeciale: json['note_speciale'] as String? ?? '',
);

Map<String, dynamic> _$LignePanierToJson(_LignePanier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'article': instance.article,
      'article_nom': instance.articleNom,
      'variante_id': instance.varianteId,
      'supplements': instance.supplements,
      'quantite': instance.quantite,
      'prix_unitaire': instance.prixUnitaire,
      'prix_ligne': instance.prixLigne,
      'note_speciale': instance.noteSpeciale,
    };

_Panier _$PanierFromJson(Map<String, dynamic> json) => _Panier(
  id: (json['id'] as num).toInt(),
  partenaire: (json['partenaire'] as num?)?.toInt(),
  partenaireNom: json['partenaire_nom'] as String? ?? '',
  categorie: (json['categorie'] as num?)?.toInt(),
  categorieNom: json['categorie_nom'] as String? ?? '',
  lignes:
      (json['lignes'] as List<dynamic>?)
          ?.map((e) => LignePanier.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LignePanier>[],
  total: json['total'] == null ? 0 : _versInt(json['total']),
);

Map<String, dynamic> _$PanierToJson(_Panier instance) => <String, dynamic>{
  'id': instance.id,
  'partenaire': instance.partenaire,
  'partenaire_nom': instance.partenaireNom,
  'categorie': instance.categorie,
  'categorie_nom': instance.categorieNom,
  'lignes': instance.lignes,
  'total': instance.total,
};

_LigneCommande _$LigneCommandeFromJson(Map<String, dynamic> json) =>
    _LigneCommande(
      id: (json['id'] as num).toInt(),
      article: (json['article'] as num?)?.toInt(),
      nomArticle: json['nom_article'] as String? ?? '',
      varianteNom: json['variante_nom'] as String? ?? '',
      supplements:
          (json['supplements'] as List<dynamic>?)
              ?.map(
                (e) => SupplementSnapshot.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <SupplementSnapshot>[],
      quantite: (json['quantite'] as num?)?.toInt() ?? 1,
      prixUnitaire: json['prix_unitaire'] == null
          ? 0
          : _versInt(json['prix_unitaire']),
      prixLigne: json['prix_ligne'] == null ? 0 : _versInt(json['prix_ligne']),
      noteSpeciale: json['note_speciale'] as String? ?? '',
    );

Map<String, dynamic> _$LigneCommandeToJson(_LigneCommande instance) =>
    <String, dynamic>{
      'id': instance.id,
      'article': instance.article,
      'nom_article': instance.nomArticle,
      'variante_nom': instance.varianteNom,
      'supplements': instance.supplements,
      'quantite': instance.quantite,
      'prix_unitaire': instance.prixUnitaire,
      'prix_ligne': instance.prixLigne,
      'note_speciale': instance.noteSpeciale,
    };

_Commande _$CommandeFromJson(Map<String, dynamic> json) => _Commande(
  id: (json['id'] as num).toInt(),
  numero: json['numero'] as String? ?? '',
  partenaire: (json['partenaire'] as num?)?.toInt(),
  partenaireNom: json['partenaire_nom'] as String? ?? '',
  clientNom: json['client_nom'] as String? ?? '',
  modeLivraison: json['mode_livraison'] as String? ?? 'emporter',
  adresseSnapshot: json['adresse_snapshot'] as String? ?? '',
  statut: json['statut'] as String? ?? 'nouvelle',
  raisonRefus: json['raison_refus'] as String? ?? '',
  sousTotal: json['sous_total'] == null ? 0 : _versInt(json['sous_total']),
  fraisLivraison: json['frais_livraison'] == null
      ? 0
      : _versInt(json['frais_livraison']),
  total: json['total'] == null ? 0 : _versInt(json['total']),
  modePaiement: json['mode_paiement'] as String? ?? 'cash',
  notesClient: json['notes_client'] as String? ?? '',
  lignes:
      (json['lignes'] as List<dynamic>?)
          ?.map((e) => LigneCommande.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LigneCommande>[],
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$CommandeToJson(_Commande instance) => <String, dynamic>{
  'id': instance.id,
  'numero': instance.numero,
  'partenaire': instance.partenaire,
  'partenaire_nom': instance.partenaireNom,
  'client_nom': instance.clientNom,
  'mode_livraison': instance.modeLivraison,
  'adresse_snapshot': instance.adresseSnapshot,
  'statut': instance.statut,
  'raison_refus': instance.raisonRefus,
  'sous_total': instance.sousTotal,
  'frais_livraison': instance.fraisLivraison,
  'total': instance.total,
  'mode_paiement': instance.modePaiement,
  'notes_client': instance.notesClient,
  'lignes': instance.lignes,
  'created_at': instance.createdAt,
};
