// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicite_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImagePublicite _$ImagePubliciteFromJson(Map<String, dynamic> json) =>
    _ImagePublicite(
      id: json['id'] as String,
      image: json['image'] as String?,
      ordre: (json['ordre'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ImagePubliciteToJson(_ImagePublicite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'ordre': instance.ordre,
    };

_PubliciteDetail _$PubliciteDetailFromJson(Map<String, dynamic> json) =>
    _PubliciteDetail(
      id: json['id'] as String,
      titre: json['titre'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageCouverture: json['image_couverture'] as String?,
      video: json['video'] as String?,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => ImagePublicite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ImagePublicite>[],
      partenaireId: (json['partenaire_id'] as num?)?.toInt(),
      nomPartenaire: json['nom_partenaire'] as String? ?? '',
      portee: json['portee'] as String? ?? 'departement',
      porteeEffective: json['portee_effective'] as String? ?? 'departement',
    );

Map<String, dynamic> _$PubliciteDetailToJson(_PubliciteDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'description': instance.description,
      'image_couverture': instance.imageCouverture,
      'video': instance.video,
      'images': instance.images,
      'partenaire_id': instance.partenaireId,
      'nom_partenaire': instance.nomPartenaire,
      'portee': instance.portee,
      'portee_effective': instance.porteeEffective,
    };
