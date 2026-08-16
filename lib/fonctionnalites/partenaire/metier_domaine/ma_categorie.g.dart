// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ma_categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaCategorie _$MaCategorieFromJson(Map<String, dynamic> json) => _MaCategorie(
  id: (json['id'] as num).toInt(),
  categorie: (json['categorie'] as num?)?.toInt(),
  nom: json['categorie_nom'] as String? ?? '',
  slug: json['categorie_slug'] as String? ?? '',
  icone: json['categorie_icone'] as String? ?? '',
  estPrincipale: json['est_principale'] as bool? ?? false,
  imageCouverture: json['image_couverture'] as String?,
);

Map<String, dynamic> _$MaCategorieToJson(_MaCategorie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categorie': instance.categorie,
      'categorie_nom': instance.nom,
      'categorie_slug': instance.slug,
      'categorie_icone': instance.icone,
      'est_principale': instance.estPrincipale,
      'image_couverture': instance.imageCouverture,
    };
