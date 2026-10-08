// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicule_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehiculeResume _$VehiculeResumeFromJson(Map<String, dynamic> json) =>
    _VehiculeResume(
      id: (json['id'] as num).toInt(),
      titre: json['titre'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      categorie: json['categorie'] as String? ?? '',
      categorieLibelle: json['categorie_libelle'] as String? ?? '',
      marque: json['marque'] as String? ?? '',
      modele: json['modele'] as String? ?? '',
      annee: versIntNullable(json['annee']),
      nbPlaces: json['nb_places'] == null ? 0 : versInt(json['nb_places']),
      boiteLibelle: json['boite_libelle'] as String? ?? '',
      carburantLibelle: json['carburant_libelle'] as String? ?? '',
      climatisation: json['climatisation'] as bool? ?? false,
      prixJour: json['prix_jour'] == null ? 0 : versInt(json['prix_jour']),
      prixJourAvecChauffeur: versIntNullable(json['prix_jour_avec_chauffeur']),
      chauffeurDisponible: json['chauffeur_disponible'] as bool? ?? false,
      chauffeurObligatoire: json['chauffeur_obligatoire'] as bool? ?? false,
      localisationTexte: json['localisation_texte'] as String? ?? '',
      disponibilite: json['disponibilite'] as String? ?? '',
    );

Map<String, dynamic> _$VehiculeResumeToJson(_VehiculeResume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'photo': instance.photo,
      'categorie': instance.categorie,
      'categorie_libelle': instance.categorieLibelle,
      'marque': instance.marque,
      'modele': instance.modele,
      'annee': instance.annee,
      'nb_places': instance.nbPlaces,
      'boite_libelle': instance.boiteLibelle,
      'carburant_libelle': instance.carburantLibelle,
      'climatisation': instance.climatisation,
      'prix_jour': instance.prixJour,
      'prix_jour_avec_chauffeur': instance.prixJourAvecChauffeur,
      'chauffeur_disponible': instance.chauffeurDisponible,
      'chauffeur_obligatoire': instance.chauffeurObligatoire,
      'localisation_texte': instance.localisationTexte,
      'disponibilite': instance.disponibilite,
    };

_PageLoueurVehicules _$PageLoueurVehiculesFromJson(Map<String, dynamic> json) =>
    _PageLoueurVehicules(
      loueur: Loueur.fromJson(json['loueur'] as Map<String, dynamic>),
      resultats:
          (json['resultats'] as List<dynamic>?)
              ?.map((e) => VehiculeResume.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VehiculeResume>[],
    );

Map<String, dynamic> _$PageLoueurVehiculesToJson(
  _PageLoueurVehicules instance,
) => <String, dynamic>{
  'loueur': instance.loueur,
  'resultats': instance.resultats,
};

_PeriodeIndisponible _$PeriodeIndisponibleFromJson(Map<String, dynamic> json) =>
    _PeriodeIndisponible(
      dateDebut: json['date_debut'] as String? ?? '',
      dateFin: json['date_fin'] as String? ?? '',
    );

Map<String, dynamic> _$PeriodeIndisponibleToJson(
  _PeriodeIndisponible instance,
) => <String, dynamic>{
  'date_debut': instance.dateDebut,
  'date_fin': instance.dateFin,
};

_Vehicule _$VehiculeFromJson(Map<String, dynamic> json) => _Vehicule(
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
  categorie: json['categorie'] as String? ?? '',
  categorieLibelle: json['categorie_libelle'] as String? ?? '',
  marque: json['marque'] as String? ?? '',
  modele: json['modele'] as String? ?? '',
  annee: versIntNullable(json['annee']),
  couleur: json['couleur'] as String? ?? '',
  nbPlaces: json['nb_places'] == null ? 0 : versInt(json['nb_places']),
  boite: json['boite'] as String? ?? '',
  boiteLibelle: json['boite_libelle'] as String? ?? '',
  carburant: json['carburant'] as String? ?? '',
  carburantLibelle: json['carburant_libelle'] as String? ?? '',
  climatisation: json['climatisation'] as bool? ?? false,
  prixJour: json['prix_jour'] == null ? 0 : versInt(json['prix_jour']),
  prixJourAvecChauffeur: versIntNullable(json['prix_jour_avec_chauffeur']),
  chauffeurDisponible: json['chauffeur_disponible'] as bool? ?? false,
  chauffeurObligatoire: json['chauffeur_obligatoire'] as bool? ?? false,
  caution: versIntNullable(json['caution']),
  kmInclusParJour: json['km_inclus_par_jour'] == null
      ? 0
      : versInt(json['km_inclus_par_jour']),
  prixKmSupplementaire: versIntNullable(json['prix_km_supplementaire']),
  carburantInclus: json['carburant_inclus'] as bool? ?? false,
  dureeMinJours: json['duree_min_jours'] == null
      ? 1
      : versInt(json['duree_min_jours']),
  zoneCirculation: json['zone_circulation'] as String? ?? '',
  zoneCirculationLibelle: json['zone_circulation_libelle'] as String? ?? '',
  equipements:
      (json['equipements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  disponibilite: json['disponibilite'] as String? ?? '',
  localisationTexte: json['localisation_texte'] as String? ?? '',
  latitude: versDoubleNullable(json['latitude']),
  longitude: versDoubleNullable(json['longitude']),
  loueur: json['loueur'] == null
      ? null
      : Loueur.fromJson(json['loueur'] as Map<String, dynamic>),
  autresVehicules:
      (json['autres_vehicules'] as List<dynamic>?)
          ?.map((e) => VehiculeResume.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VehiculeResume>[],
  periodesIndisponibles:
      (json['periodes_indisponibles'] as List<dynamic>?)
          ?.map((e) => PeriodeIndisponible.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PeriodeIndisponible>[],
);

Map<String, dynamic> _$VehiculeToJson(_Vehicule instance) => <String, dynamic>{
  'id': instance.id,
  'titre': instance.titre,
  'description': instance.description,
  'galerie': instance.galerie,
  'panoramas': instance.panoramas,
  'categorie': instance.categorie,
  'categorie_libelle': instance.categorieLibelle,
  'marque': instance.marque,
  'modele': instance.modele,
  'annee': instance.annee,
  'couleur': instance.couleur,
  'nb_places': instance.nbPlaces,
  'boite': instance.boite,
  'boite_libelle': instance.boiteLibelle,
  'carburant': instance.carburant,
  'carburant_libelle': instance.carburantLibelle,
  'climatisation': instance.climatisation,
  'prix_jour': instance.prixJour,
  'prix_jour_avec_chauffeur': instance.prixJourAvecChauffeur,
  'chauffeur_disponible': instance.chauffeurDisponible,
  'chauffeur_obligatoire': instance.chauffeurObligatoire,
  'caution': instance.caution,
  'km_inclus_par_jour': instance.kmInclusParJour,
  'prix_km_supplementaire': instance.prixKmSupplementaire,
  'carburant_inclus': instance.carburantInclus,
  'duree_min_jours': instance.dureeMinJours,
  'zone_circulation': instance.zoneCirculation,
  'zone_circulation_libelle': instance.zoneCirculationLibelle,
  'equipements': instance.equipements,
  'disponibilite': instance.disponibilite,
  'localisation_texte': instance.localisationTexte,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'loueur': instance.loueur,
  'autres_vehicules': instance.autresVehicules,
  'periodes_indisponibles': instance.periodesIndisponibles,
};
