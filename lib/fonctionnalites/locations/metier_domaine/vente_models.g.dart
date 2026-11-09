// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vente_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InfosVente _$InfosVenteFromJson(Map<String, dynamic> json) => _InfosVente(
  mode: json['mode'] == null ? ModeAnnonce.location : _modeDepuis(json['mode']),
  modeLibelle: json['mode_libelle'] as String? ?? '',
  prixVente: versIntNullable(json['prix_vente']),
  prixNegociable: json['prix_negociable'] as bool? ?? false,
  vendu: json['vendu'] as bool? ?? false,
  venduLe: json['vendu_le'] as String?,
  etat: json['etat'] as String?,
  etatLibelle: json['etat_libelle'] as String?,
  kilometrage: versIntNullable(json['kilometrage']),
  dedouane: _versBoolNullable(json['dedouane']),
  carteGrise: _versBoolNullable(json['carte_grise']),
  visiteTechniqueValideJusquAu:
      json['visite_technique_valide_jusqu_au'] as String?,
  assuranceValideJusquAu: json['assurance_valide_jusqu_au'] as String?,
  nbProprietaires: versIntNullable(json['nb_proprietaires']),
  typeDocument: json['type_document'] as String?,
  typeDocumentLibelle: json['type_document_libelle'] as String?,
  surfaceTerrainM2: versIntNullable(json['surface_terrain_m2']),
  estLotie: _versBoolNullable(json['est_lotie']),
);

Map<String, dynamic> _$InfosVenteToJson(_InfosVente instance) =>
    <String, dynamic>{
      'mode': _modeVers(instance.mode),
      'mode_libelle': instance.modeLibelle,
      'prix_vente': instance.prixVente,
      'prix_negociable': instance.prixNegociable,
      'vendu': instance.vendu,
      'vendu_le': instance.venduLe,
      'etat': instance.etat,
      'etat_libelle': instance.etatLibelle,
      'kilometrage': instance.kilometrage,
      'dedouane': instance.dedouane,
      'carte_grise': instance.carteGrise,
      'visite_technique_valide_jusqu_au': instance.visiteTechniqueValideJusquAu,
      'assurance_valide_jusqu_au': instance.assuranceValideJusquAu,
      'nb_proprietaires': instance.nbProprietaires,
      'type_document': instance.typeDocument,
      'type_document_libelle': instance.typeDocumentLibelle,
      'surface_terrain_m2': instance.surfaceTerrainM2,
      'est_lotie': instance.estLotie,
    };
