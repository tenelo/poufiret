// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Variante _$VarianteFromJson(Map<String, dynamic> json) => _Variante(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String,
  prixSupplement: json['prix_supplement'] as String? ?? '0',
  estParDefaut: json['est_par_defaut'] as bool? ?? false,
);

Map<String, dynamic> _$VarianteToJson(_Variante instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'prix_supplement': instance.prixSupplement,
  'est_par_defaut': instance.estParDefaut,
};

_Supplement _$SupplementFromJson(Map<String, dynamic> json) => _Supplement(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String,
  prix: json['prix'] as String? ?? '0',
  estOptionnel: json['est_optionnel'] as bool? ?? true,
);

Map<String, dynamic> _$SupplementToJson(_Supplement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prix': instance.prix,
      'est_optionnel': instance.estOptionnel,
    };

_ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    _ArticleDetail(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? '',
      prix: json['prix'] as String? ?? '0',
      prixPromotion: json['prix_promotion'] as String?,
      unite: json['unite'] as String? ?? '',
      estDisponible: json['est_disponible'] as bool? ?? true,
      estActif: json['est_actif'] as bool? ?? true,
      estEnPromotion: json['est_en_promotion'] as bool? ?? false,
      nbVues: (json['nb_vues'] as num?)?.toInt() ?? 0,
      nbLikes: (json['nb_likes'] as num?)?.toInt() ?? 0,
      nbFavoris: (json['nb_favoris'] as num?)?.toInt() ?? 0,
      nbCommentaires: (json['nb_commentaires'] as num?)?.toInt() ?? 0,
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      partenaire: (json['partenaire'] as num?)?.toInt(),
      categorie: (json['categorie'] as num?)?.toInt(),
      images: json['images'] == null
          ? const <String>[]
          : const ImagesUrlConverter().fromJson(json['images'] as List?),
      variantes:
          (json['variantes'] as List<dynamic>?)
              ?.map((e) => Variante.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Variante>[],
      supplements:
          (json['supplements'] as List<dynamic>?)
              ?.map((e) => Supplement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Supplement>[],
      estLikeParMoi: json['est_like_par_moi'] as bool? ?? false,
      estFavoriParMoi: json['est_favori_par_moi'] as bool? ?? false,
    );

Map<String, dynamic> _$ArticleDetailToJson(_ArticleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'description': instance.description,
      'type': instance.type,
      'prix': instance.prix,
      'prix_promotion': instance.prixPromotion,
      'unite': instance.unite,
      'est_disponible': instance.estDisponible,
      'est_actif': instance.estActif,
      'est_en_promotion': instance.estEnPromotion,
      'nb_vues': instance.nbVues,
      'nb_likes': instance.nbLikes,
      'nb_favoris': instance.nbFavoris,
      'nb_commentaires': instance.nbCommentaires,
      'partenaire_nom': instance.partenaireNom,
      'partenaire': instance.partenaire,
      'categorie': instance.categorie,
      'images': const ImagesUrlConverter().toJson(instance.images),
      'variantes': instance.variantes,
      'supplements': instance.supplements,
      'est_like_par_moi': instance.estLikeParMoi,
      'est_favori_par_moi': instance.estFavoriParMoi,
    };
