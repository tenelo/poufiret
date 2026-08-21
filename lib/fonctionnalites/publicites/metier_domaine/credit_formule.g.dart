// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_formule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreditFormule _$CreditFormuleFromJson(Map<String, dynamic> json) =>
    _CreditFormule(
      id: json['id'] as String,
      formuleId: json['formule_id'] as String,
      formuleNom: json['formule_nom'] as String? ?? '',
      formulePrix: (json['formule_prix'] as num?)?.toInt() ?? 0,
      formuleTypesAffichage:
          (json['formule_types_affichage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      statut: json['statut'] as String? ?? 'disponible',
      creeLe: json['cree_le'] as String?,
      consommeLe: json['consomme_le'] as String?,
      publiciteConsommatriceId: json['publicite_consommatrice_id'] as String?,
    );

Map<String, dynamic> _$CreditFormuleToJson(_CreditFormule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'formule_id': instance.formuleId,
      'formule_nom': instance.formuleNom,
      'formule_prix': instance.formulePrix,
      'formule_types_affichage': instance.formuleTypesAffichage,
      'statut': instance.statut,
      'cree_le': instance.creeLe,
      'consomme_le': instance.consommeLe,
      'publicite_consommatrice_id': instance.publiciteConsommatriceId,
    };
