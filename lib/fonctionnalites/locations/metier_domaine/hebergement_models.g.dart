// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hebergement_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Etablissement _$EtablissementFromJson(
  Map<String, dynamic> json,
) => _Etablissement(
  id: json['id'] == null ? 0 : versInt(json['id']),
  nom: json['nom'] as String? ?? '',
  logo: json['logo'] as String? ?? '',
  couverture: json['couverture'] as String? ?? '',
  telephonePro: json['telephone_pro'] as String? ?? '',
  whatsapp: json['whatsapp'] as String? ?? '',
  typeEtablissement: json['type_etablissement'] as String? ?? '',
  typeEtablissementLibelle: json['type_etablissement_libelle'] as String? ?? '',
  description: json['description'] as String? ?? '',
  galerie:
      (json['galerie'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  panoramas:
      (json['panoramas'] as List<dynamic>?)
          ?.map((e) => Panorama.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Panorama>[],
  etoiles: versIntNullable(json['etoiles']),
  localisationTexte: json['localisation_texte'] as String? ?? '',
  latitude: versDoubleNullable(json['latitude']),
  longitude: versDoubleNullable(json['longitude']),
  heureArrivee: json['heure_arrivee'] as String? ?? '',
  heureDepart: json['heure_depart'] as String? ?? '',
  equipements: json['equipements_etablissement'] == null
      ? const <String>[]
      : versListeTextes(json['equipements_etablissement']),
  petitDejeuner: json['petit_dejeuner'] == null
      ? ''
      : versCodePetitDejeuner(json['petit_dejeuner']),
  petitDejeunerLibelle: json['petit_dejeuner_libelle'] as String? ?? '',
  prixPetitDejeuner: versIntNullable(json['prix_petit_dejeuner']),
  politiqueAnnulation: json['politique_annulation'] as String? ?? '',
  politiqueAnnulationLibelle:
      json['politique_annulation_libelle'] as String? ?? '',
  conditions: json['conditions'] as String? ?? '',
);

Map<String, dynamic> _$EtablissementToJson(_Etablissement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'logo': instance.logo,
      'couverture': instance.couverture,
      'telephone_pro': instance.telephonePro,
      'whatsapp': instance.whatsapp,
      'type_etablissement': instance.typeEtablissement,
      'type_etablissement_libelle': instance.typeEtablissementLibelle,
      'description': instance.description,
      'galerie': instance.galerie,
      'panoramas': instance.panoramas,
      'etoiles': instance.etoiles,
      'localisation_texte': instance.localisationTexte,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heure_arrivee': instance.heureArrivee,
      'heure_depart': instance.heureDepart,
      'equipements_etablissement': instance.equipements,
      'petit_dejeuner': instance.petitDejeuner,
      'petit_dejeuner_libelle': instance.petitDejeunerLibelle,
      'prix_petit_dejeuner': instance.prixPetitDejeuner,
      'politique_annulation': instance.politiqueAnnulation,
      'politique_annulation_libelle': instance.politiqueAnnulationLibelle,
      'conditions': instance.conditions,
    };

_HebergementResume _$HebergementResumeFromJson(Map<String, dynamic> json) =>
    _HebergementResume(
      id: (json['id'] as num).toInt(),
      titre: json['titre'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      typeHebergement: json['type_hebergement'] as String? ?? '',
      typeHebergementLibelle: json['type_hebergement_libelle'] as String? ?? '',
      capaciteAdultes: json['capacite_adultes'] == null
          ? 0
          : versInt(json['capacite_adultes']),
      capaciteEnfants: json['capacite_enfants'] == null
          ? 0
          : versInt(json['capacite_enfants']),
      lits: json['lits'] == null ? '' : versTexteLits(json['lits']),
      prixNuit: json['prix_nuit'] == null ? 0 : versInt(json['prix_nuit']),
      prixSemaine: versIntNullable(json['prix_semaine']),
      prixMois: versIntNullable(json['prix_mois']),
      disponibilite: json['disponibilite'] as String? ?? '',
    );

Map<String, dynamic> _$HebergementResumeToJson(_HebergementResume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'photo': instance.photo,
      'type_hebergement': instance.typeHebergement,
      'type_hebergement_libelle': instance.typeHebergementLibelle,
      'capacite_adultes': instance.capaciteAdultes,
      'capacite_enfants': instance.capaciteEnfants,
      'lits': instance.lits,
      'prix_nuit': instance.prixNuit,
      'prix_semaine': instance.prixSemaine,
      'prix_mois': instance.prixMois,
      'disponibilite': instance.disponibilite,
    };

_PageEtablissement _$PageEtablissementFromJson(Map<String, dynamic> json) =>
    _PageEtablissement(
      etablissement: Etablissement.fromJson(
        json['etablissement'] as Map<String, dynamic>,
      ),
      hebergements:
          (json['hebergements'] as List<dynamic>?)
              ?.map(
                (e) => HebergementResume.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <HebergementResume>[],
    );

Map<String, dynamic> _$PageEtablissementToJson(_PageEtablissement instance) =>
    <String, dynamic>{
      'etablissement': instance.etablissement,
      'hebergements': instance.hebergements,
    };

_Hebergement _$HebergementFromJson(Map<String, dynamic> json) => _Hebergement(
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
  typeHebergement: json['type_hebergement'] as String? ?? '',
  typeHebergementLibelle: json['type_hebergement_libelle'] as String? ?? '',
  capaciteAdultes: json['capacite_adultes'] == null
      ? 0
      : versInt(json['capacite_adultes']),
  capaciteEnfants: json['capacite_enfants'] == null
      ? 0
      : versInt(json['capacite_enfants']),
  lits: json['lits'] == null ? '' : versTexteLits(json['lits']),
  surfaceM2: versIntNullable(json['surface_m2']),
  equipements: json['equipements'] == null
      ? const <String>[]
      : versListeTextes(json['equipements']),
  prixNuit: json['prix_nuit'] == null ? 0 : versInt(json['prix_nuit']),
  prixSemaine: versIntNullable(json['prix_semaine']),
  prixMois: versIntNullable(json['prix_mois']),
  dureeMinNuits: lireDureeMin(json, 'dureeMinNuits') == null
      ? 1
      : versInt(lireDureeMin(json, 'dureeMinNuits')),
  nbUnites: json['nb_unites'] == null ? 0 : versInt(json['nb_unites']),
  unitesDisponibles: versIntNullable(json['unites_disponibles']),
  heureArrivee: json['heure_arrivee'] as String? ?? '',
  heureDepart: json['heure_depart'] as String? ?? '',
  disponibilite: json['disponibilite'] as String? ?? '',
  etablissement: json['etablissement'] == null
      ? null
      : Etablissement.fromJson(json['etablissement'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HebergementToJson(_Hebergement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'description': instance.description,
      'galerie': instance.galerie,
      'panoramas': instance.panoramas,
      'type_hebergement': instance.typeHebergement,
      'type_hebergement_libelle': instance.typeHebergementLibelle,
      'capacite_adultes': instance.capaciteAdultes,
      'capacite_enfants': instance.capaciteEnfants,
      'lits': instance.lits,
      'surface_m2': instance.surfaceM2,
      'equipements': instance.equipements,
      'prix_nuit': instance.prixNuit,
      'prix_semaine': instance.prixSemaine,
      'prix_mois': instance.prixMois,
      'dureeMinNuits': instance.dureeMinNuits,
      'nb_unites': instance.nbUnites,
      'unites_disponibles': instance.unitesDisponibles,
      'heure_arrivee': instance.heureArrivee,
      'heure_depart': instance.heureDepart,
      'disponibilite': instance.disponibilite,
      'etablissement': instance.etablissement,
    };
