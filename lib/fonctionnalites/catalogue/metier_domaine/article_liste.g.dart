// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_liste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleListe _$ArticleListeFromJson(Map<String, dynamic> json) =>
    _ArticleListe(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String,
      slug: json['slug'] as String,
      type: json['type'] as String? ?? '',
      prix: json['prix'] as String? ?? '0',
      prixPromotion: json['prix_promotion'] as String?,
      estEnPromotion: json['est_en_promotion'] as bool? ?? false,
      estDisponible: json['est_disponible'] as bool? ?? true,
      nbVues: (json['nb_vues'] as num?)?.toInt() ?? 0,
      nbLikes: (json['nb_likes'] as num?)?.toInt() ?? 0,
      partenaire: (json['partenaire'] as num?)?.toInt(),
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      categorie: (json['categorie'] as num?)?.toInt(),
      imagePrincipale: json['image_principale'] as String?,
    );

Map<String, dynamic> _$ArticleListeToJson(_ArticleListe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'type': instance.type,
      'prix': instance.prix,
      'prix_promotion': instance.prixPromotion,
      'est_en_promotion': instance.estEnPromotion,
      'est_disponible': instance.estDisponible,
      'nb_vues': instance.nbVues,
      'nb_likes': instance.nbLikes,
      'partenaire': instance.partenaire,
      'partenaire_nom': instance.partenaireNom,
      'categorie': instance.categorie,
      'image_principale': instance.imagePrincipale,
    };
