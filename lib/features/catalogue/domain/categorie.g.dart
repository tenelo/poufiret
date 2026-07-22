// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Categorie _$CategorieFromJson(Map<String, dynamic> json) => _Categorie(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String? ?? '',
  icone: json['icone'] as String? ?? '',
  imageCouverture: json['image_couverture'] as String?,
  parent: (json['parent'] as num?)?.toInt(),
  modeTransaction: json['mode_transaction'] as String? ?? '',
  ordre: (json['ordre'] as num?)?.toInt() ?? 0,
  typesArticles:
      (json['types_articles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  afficheCatalogue: json['affiche_catalogue'] as bool? ?? true,
  estActive: json['est_active'] as bool? ?? true,
  nbPartenaires: (json['nb_partenaires'] as num?)?.toInt(),
  enfants:
      (json['enfants'] as List<dynamic>?)
          ?.map((e) => Categorie.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Categorie>[],
);

Map<String, dynamic> _$CategorieToJson(_Categorie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'description': instance.description,
      'icone': instance.icone,
      'image_couverture': instance.imageCouverture,
      'parent': instance.parent,
      'mode_transaction': instance.modeTransaction,
      'ordre': instance.ordre,
      'types_articles': instance.typesArticles,
      'affiche_catalogue': instance.afficheCatalogue,
      'est_active': instance.estActive,
      'nb_partenaires': instance.nbPartenaires,
      'enfants': instance.enfants,
    };
