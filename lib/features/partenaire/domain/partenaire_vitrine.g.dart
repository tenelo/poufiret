// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partenaire_vitrine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartenaireVitrine _$PartenaireVitrineFromJson(Map<String, dynamic> json) =>
    _PartenaireVitrine(
      id: (json['id'] as num).toInt(),
      nomCommerce: json['nom_commerce'] as String? ?? '',
      typePartenaire: json['type_partenaire'] as String? ?? '',
      typeLibelle: json['type_partenaire_libelle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      logo: json['logo'] as String?,
      photoCouverture: json['photo_couverture'] as String?,
      adresse: json['adresse'] as String? ?? '',
      quartier: json['quartier'] as String? ?? '',
      secteur: json['secteur'] as String? ?? '',
      ville: json['ville'] as String? ?? '',
      descriptionAcces: json['description_acces'] as String? ?? '',
      telephonePro: json['telephone_pro'] as String? ?? '',
      whatsapp: json['whatsapp'] as String? ?? '',
      emailPro: json['email_pro'] as String? ?? '',
      nbVues: (json['nb_vues'] as num?)?.toInt() ?? 0,
      nombreLikes: (json['nombre_likes'] as num?)?.toInt() ?? 0,
      estLikeParMoi: json['est_like_par_moi'] as bool? ?? false,
      estFavoriParMoi: json['est_favori_par_moi'] as bool? ?? false,
    );

Map<String, dynamic> _$PartenaireVitrineToJson(_PartenaireVitrine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom_commerce': instance.nomCommerce,
      'type_partenaire': instance.typePartenaire,
      'type_partenaire_libelle': instance.typeLibelle,
      'description': instance.description,
      'logo': instance.logo,
      'photo_couverture': instance.photoCouverture,
      'adresse': instance.adresse,
      'quartier': instance.quartier,
      'secteur': instance.secteur,
      'ville': instance.ville,
      'description_acces': instance.descriptionAcces,
      'telephone_pro': instance.telephonePro,
      'whatsapp': instance.whatsapp,
      'email_pro': instance.emailPro,
      'nb_vues': instance.nbVues,
      'nombre_likes': instance.nombreLikes,
      'est_like_par_moi': instance.estLikeParMoi,
      'est_favori_par_moi': instance.estFavoriParMoi,
    };
