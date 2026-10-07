// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OptionMeta _$OptionMetaFromJson(Map<String, dynamic> json) => _OptionMeta(
  valeur: json['valeur'] as String? ?? '',
  libelle: json['libelle'] as String? ?? '',
);

Map<String, dynamic> _$OptionMetaToJson(_OptionMeta instance) =>
    <String, dynamic>{'valeur': instance.valeur, 'libelle': instance.libelle};

_MetaLocations _$MetaLocationsFromJson(Map<String, dynamic> json) =>
    _MetaLocations(
      typesLogement:
          (json['types_logement'] as List<dynamic>?)
              ?.map((e) => OptionMeta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OptionMeta>[],
      equipements:
          (json['equipements'] as List<dynamic>?)
              ?.map((e) => OptionMeta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OptionMeta>[],
      disponibilites:
          (json['disponibilites'] as List<dynamic>?)
              ?.map((e) => OptionMeta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OptionMeta>[],
    );

Map<String, dynamic> _$MetaLocationsToJson(_MetaLocations instance) =>
    <String, dynamic>{
      'types_logement': instance.typesLogement,
      'equipements': instance.equipements,
      'disponibilites': instance.disponibilites,
    };

_Loueur _$LoueurFromJson(Map<String, dynamic> json) => _Loueur(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  logo: json['logo'] as String? ?? '',
  couverture: json['couverture'] as String? ?? '',
  telephonePro: json['telephone_pro'] as String? ?? '',
  whatsapp: json['whatsapp'] as String? ?? '',
);

Map<String, dynamic> _$LoueurToJson(_Loueur instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'logo': instance.logo,
  'couverture': instance.couverture,
  'telephone_pro': instance.telephonePro,
  'whatsapp': instance.whatsapp,
};

_LogementResume _$LogementResumeFromJson(Map<String, dynamic> json) =>
    _LogementResume(
      id: (json['id'] as num).toInt(),
      titre: json['titre'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      typeLogement: json['type_logement'] as String? ?? '',
      typeLogementLibelle: json['type_logement_libelle'] as String? ?? '',
      localisationTexte: json['localisation_texte'] as String? ?? '',
      loyer: json['loyer'] == null ? 0 : versInt(json['loyer']),
      nbChambres: json['nb_chambres'] == null
          ? 0
          : versInt(json['nb_chambres']),
      nbSallesDeBain: json['nb_salles_de_bain'] == null
          ? 0
          : versInt(json['nb_salles_de_bain']),
      meuble: json['meuble'] as bool? ?? false,
      disponibilite: json['disponibilite'] as String? ?? '',
    );

Map<String, dynamic> _$LogementResumeToJson(_LogementResume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'photo': instance.photo,
      'type_logement': instance.typeLogement,
      'type_logement_libelle': instance.typeLogementLibelle,
      'localisation_texte': instance.localisationTexte,
      'loyer': instance.loyer,
      'nb_chambres': instance.nbChambres,
      'nb_salles_de_bain': instance.nbSallesDeBain,
      'meuble': instance.meuble,
      'disponibilite': instance.disponibilite,
    };

_PageLoueur _$PageLoueurFromJson(Map<String, dynamic> json) => _PageLoueur(
  loueur: Loueur.fromJson(json['loueur'] as Map<String, dynamic>),
  resultats:
      (json['resultats'] as List<dynamic>?)
          ?.map((e) => LogementResume.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LogementResume>[],
);

Map<String, dynamic> _$PageLoueurToJson(_PageLoueur instance) =>
    <String, dynamic>{
      'loueur': instance.loueur,
      'resultats': instance.resultats,
    };

_Panorama _$PanoramaFromJson(Map<String, dynamic> json) => _Panorama(
  id: (json['id'] as num).toInt(),
  image: json['image'] as String? ?? '',
  titre: json['titre'] as String? ?? '',
  typeVue: json['type_vue'] as String? ?? 'panoramique',
  ordre: json['ordre'] == null ? 0 : versInt(json['ordre']),
  estActive: json['est_active'] as bool? ?? true,
);

Map<String, dynamic> _$PanoramaToJson(_Panorama instance) => <String, dynamic>{
  'id': instance.id,
  'image': instance.image,
  'titre': instance.titre,
  'type_vue': instance.typeVue,
  'ordre': instance.ordre,
  'est_active': instance.estActive,
};

_Logement _$LogementFromJson(Map<String, dynamic> json) => _Logement(
  id: (json['id'] as num).toInt(),
  titre: json['titre'] as String? ?? '',
  description: json['description'] as String? ?? '',
  galerie:
      (json['galerie'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  panoramas:
      (json['panoramas'] as List<dynamic>?)
          ?.map((e) => Panorama.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Panorama>[],
  typeLogement: json['type_logement'] as String? ?? '',
  typeLogementLibelle: json['type_logement_libelle'] as String? ?? '',
  nbChambres: json['nb_chambres'] == null ? 0 : versInt(json['nb_chambres']),
  nbSalons: json['nb_salons'] == null ? 0 : versInt(json['nb_salons']),
  nbSallesDeBain: json['nb_salles_de_bain'] == null
      ? 0
      : versInt(json['nb_salles_de_bain']),
  surfaceM2: versIntNullable(json['surface_m2']),
  meuble: json['meuble'] as bool? ?? false,
  loyer: json['loyer'] == null ? 0 : versInt(json['loyer']),
  cautionMois: versIntNullable(json['caution_mois']),
  avanceMois: versIntNullable(json['avance_mois']),
  fraisAgence: versIntNullable(json['frais_agence']),
  compteurEauIndividuel: json['compteur_eau_individuel'] as bool? ?? false,
  compteurElectriciteIndividuel:
      json['compteur_electricite_individuel'] as bool? ?? false,
  equipements:
      (json['equipements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  disponibilite: json['disponibilite'] as String? ?? '',
  disponibleAPartirDu: json['disponible_a_partir_du'] as String?,
  localiteNom: json['localite_nom'] as String?,
  quartierNom: json['quartier_nom'] as String?,
  secteur: json['secteur'] as String? ?? '',
  adresseReperes: json['adresse_reperes'] as String? ?? '',
  latitude: versDoubleNullable(json['latitude']),
  longitude: versDoubleNullable(json['longitude']),
  loueur: json['loueur'] == null
      ? null
      : Loueur.fromJson(json['loueur'] as Map<String, dynamic>),
  autresLogements:
      (json['autres_logements'] as List<dynamic>?)
          ?.map((e) => LogementResume.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LogementResume>[],
);

Map<String, dynamic> _$LogementToJson(_Logement instance) => <String, dynamic>{
  'id': instance.id,
  'titre': instance.titre,
  'description': instance.description,
  'galerie': instance.galerie,
  'panoramas': instance.panoramas,
  'type_logement': instance.typeLogement,
  'type_logement_libelle': instance.typeLogementLibelle,
  'nb_chambres': instance.nbChambres,
  'nb_salons': instance.nbSalons,
  'nb_salles_de_bain': instance.nbSallesDeBain,
  'surface_m2': instance.surfaceM2,
  'meuble': instance.meuble,
  'loyer': instance.loyer,
  'caution_mois': instance.cautionMois,
  'avance_mois': instance.avanceMois,
  'frais_agence': instance.fraisAgence,
  'compteur_eau_individuel': instance.compteurEauIndividuel,
  'compteur_electricite_individuel': instance.compteurElectriciteIndividuel,
  'equipements': instance.equipements,
  'disponibilite': instance.disponibilite,
  'disponible_a_partir_du': instance.disponibleAPartirDu,
  'localite_nom': instance.localiteNom,
  'quartier_nom': instance.quartierNom,
  'secteur': instance.secteur,
  'adresse_reperes': instance.adresseReperes,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'loueur': instance.loueur,
  'autres_logements': instance.autresLogements,
};

_DemandeReservation _$DemandeReservationFromJson(Map<String, dynamic> json) =>
    _DemandeReservation(
      id: (json['id'] as num).toInt(),
      numero: json['numero'] as String? ?? '',
      natureLibelle: json['nature_libelle'] as String? ?? '',
      objetNom: json['objet_nom'] as String? ?? '',
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      dateSouhaitee: json['date_souhaitee'] as String?,
      statut: json['statut'] as String? ?? '',
      statutLibelle: json['statut_libelle'] as String? ?? '',
      raisonRefus: json['raison_refus'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$DemandeReservationToJson(_DemandeReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numero': instance.numero,
      'nature_libelle': instance.natureLibelle,
      'objet_nom': instance.objetNom,
      'partenaire_nom': instance.partenaireNom,
      'date_souhaitee': instance.dateSouhaitee,
      'statut': instance.statut,
      'statut_libelle': instance.statutLibelle,
      'raison_refus': instance.raisonRefus,
      'created_at': instance.createdAt,
    };
