// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoris_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleFavori _$ArticleFavoriFromJson(Map<String, dynamic> json) =>
    _ArticleFavori(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      type: json['type'] as String? ?? '',
      prix: json['prix'] == null ? 0 : _versInt(json['prix']),
      nbVues: (json['nb_vues'] as num?)?.toInt() ?? 0,
      nbLikes: (json['nb_likes'] as num?)?.toInt() ?? 0,
      partenaire: (json['partenaire'] as num?)?.toInt(),
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      categorie: (json['categorie'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ArticleFavoriToJson(_ArticleFavori instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'type': instance.type,
      'prix': instance.prix,
      'nb_vues': instance.nbVues,
      'nb_likes': instance.nbLikes,
      'partenaire': instance.partenaire,
      'partenaire_nom': instance.partenaireNom,
      'categorie': instance.categorie,
    };

_PartenaireFavori _$PartenaireFavoriFromJson(Map<String, dynamic> json) =>
    _PartenaireFavori(
      id: (json['id'] as num).toInt(),
      nomCommerce: json['nom_commerce'] as String? ?? '',
      typePartenaire: json['type_partenaire'] as String? ?? '',
      ville: json['ville'] as String? ?? '',
      quartier: json['quartier'] as String? ?? '',
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$PartenaireFavoriToJson(_PartenaireFavori instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom_commerce': instance.nomCommerce,
      'type_partenaire': instance.typePartenaire,
      'ville': instance.ville,
      'quartier': instance.quartier,
      'logo': instance.logo,
    };

_EntreeArticleFavori _$EntreeArticleFavoriFromJson(Map<String, dynamic> json) =>
    _EntreeArticleFavori(
      id: (json['id'] as num).toInt(),
      article: ArticleFavori.fromJson(json['article'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$EntreeArticleFavoriToJson(
  _EntreeArticleFavori instance,
) => <String, dynamic>{
  'id': instance.id,
  'article': instance.article,
  'created_at': instance.createdAt,
};

_EntreePartenaireFavori _$EntreePartenaireFavoriFromJson(
  Map<String, dynamic> json,
) => _EntreePartenaireFavori(
  id: (json['id'] as num).toInt(),
  partenaire: PartenaireFavori.fromJson(
    json['partenaire'] as Map<String, dynamic>,
  ),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$EntreePartenaireFavoriToJson(
  _EntreePartenaireFavori instance,
) => <String, dynamic>{
  'id': instance.id,
  'partenaire': instance.partenaire,
  'created_at': instance.createdAt,
};

_MesFavoris _$MesFavorisFromJson(Map<String, dynamic> json) => _MesFavoris(
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map((e) => EntreeArticleFavori.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EntreeArticleFavori>[],
  partenaires:
      (json['partenaires'] as List<dynamic>?)
          ?.map(
            (e) => EntreePartenaireFavori.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <EntreePartenaireFavori>[],
);

Map<String, dynamic> _$MesFavorisToJson(_MesFavoris instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'partenaires': instance.partenaires,
    };
