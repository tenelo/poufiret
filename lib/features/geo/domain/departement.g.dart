// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Departement _$DepartementFromJson(Map<String, dynamic> json) => _Departement(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  region: json['region'] as String? ?? '',
  district: json['district'] as String? ?? '',
);

Map<String, dynamic> _$DepartementToJson(_Departement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'region': instance.region,
      'district': instance.district,
    };
