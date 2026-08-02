// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partenaire_categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartenaireCategorie _$PartenaireCategorieFromJson(Map<String, dynamic> json) =>
    _PartenaireCategorie(
      id: (json['id'] as num).toInt(),
      nomCommerce: json['nom_commerce'] as String? ?? '',
      description: json['description'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      photoCouverture: json['photo_couverture'] as String? ?? '',
      departement: json['departement'] as String? ?? '',
      region: json['region'] as String? ?? '',
    );

Map<String, dynamic> _$PartenaireCategorieToJson(
  _PartenaireCategorie instance,
) => <String, dynamic>{
  'id': instance.id,
  'nom_commerce': instance.nomCommerce,
  'description': instance.description,
  'logo': instance.logo,
  'photo_couverture': instance.photoCouverture,
  'departement': instance.departement,
  'region': instance.region,
};
