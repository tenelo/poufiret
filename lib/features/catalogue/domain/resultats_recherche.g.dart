// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultats_recherche.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategorieTrouvee _$CategorieTrouveeFromJson(Map<String, dynamic> json) =>
    _CategorieTrouvee(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      icone: json['icone'] as String? ?? '',
      modeTransaction: json['mode_transaction'] as String? ?? '',
      afficheCatalogue: json['affiche_catalogue'] as bool? ?? true,
    );

Map<String, dynamic> _$CategorieTrouveeToJson(_CategorieTrouvee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'icone': instance.icone,
      'mode_transaction': instance.modeTransaction,
      'affiche_catalogue': instance.afficheCatalogue,
    };

_PartenaireTrouve _$PartenaireTrouveFromJson(Map<String, dynamic> json) =>
    _PartenaireTrouve(
      id: (json['id'] as num).toInt(),
      nomCommerce: json['nom_commerce'] as String? ?? '',
      description: json['description'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      photoCouverture: json['photo_couverture'] as String? ?? '',
      typePartenaire: json['type_partenaire'] as String? ?? '',
    );

Map<String, dynamic> _$PartenaireTrouveToJson(_PartenaireTrouve instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom_commerce': instance.nomCommerce,
      'description': instance.description,
      'logo': instance.logo,
      'photo_couverture': instance.photoCouverture,
      'type_partenaire': instance.typePartenaire,
    };

_ArticleTrouve _$ArticleTrouveFromJson(Map<String, dynamic> json) =>
    _ArticleTrouve(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      prix: json['prix'] as String? ?? '0',
      prixPromotion: json['prix_promotion'] as String?,
      estEnPromotion: json['est_en_promotion'] as bool? ?? false,
      pourcentageReductionApi: (json['pourcentage_reduction'] as num?)?.toInt(),
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      departement: json['departement'] as String? ?? '',
      imagePrincipale: json['image_principale'] as String? ?? '',
    );

Map<String, dynamic> _$ArticleTrouveToJson(_ArticleTrouve instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'slug': instance.slug,
      'prix': instance.prix,
      'prix_promotion': instance.prixPromotion,
      'est_en_promotion': instance.estEnPromotion,
      'pourcentage_reduction': instance.pourcentageReductionApi,
      'partenaire_nom': instance.partenaireNom,
      'departement': instance.departement,
      'image_principale': instance.imagePrincipale,
    };

_ResultatsRecherche _$ResultatsRechercheFromJson(Map<String, dynamic> json) =>
    _ResultatsRecherche(
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategorieTrouvee.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CategorieTrouvee>[],
      partenaires:
          (json['partenaires'] as List<dynamic>?)
              ?.map((e) => PartenaireTrouve.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PartenaireTrouve>[],
      articles:
          (json['articles'] as List<dynamic>?)
              ?.map((e) => ArticleTrouve.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArticleTrouve>[],
    );

Map<String, dynamic> _$ResultatsRechercheToJson(_ResultatsRecherche instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'partenaires': instance.partenaires,
      'articles': instance.articles,
    };
