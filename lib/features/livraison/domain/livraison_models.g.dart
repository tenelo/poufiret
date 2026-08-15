// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livraison_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GpsPoint _$GpsPointFromJson(Map<String, dynamic> json) => _GpsPoint(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$GpsPointToJson(_GpsPoint instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

_PointLivraison _$PointLivraisonFromJson(Map<String, dynamic> json) =>
    _PointLivraison(
      quartier: json['quartier'] as String? ?? '',
      nomContact: json['nom_contact'] as String? ?? '',
      telephoneContact: json['telephone_contact'] as String? ?? '',
      gps: json['gps'] == null
          ? null
          : GpsPoint.fromJson(json['gps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PointLivraisonToJson(_PointLivraison instance) =>
    <String, dynamic>{
      'quartier': instance.quartier,
      'nom_contact': instance.nomContact,
      'telephone_contact': instance.telephoneContact,
      'gps': instance.gps,
    };

_LivreurPosition _$LivreurPositionFromJson(Map<String, dynamic> json) =>
    _LivreurPosition(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      typeVehicule: json['type_vehicule'] as String? ?? 'moto',
      majLe: json['maj_le'] as String?,
    );

Map<String, dynamic> _$LivreurPositionToJson(_LivreurPosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'type_vehicule': instance.typeVehicule,
      'maj_le': instance.majLe,
    };

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  id: json['id'] as String? ?? '',
  numero: json['numero'] as String? ?? '',
  statut: json['statut'] as String? ?? 'demandee',
  ville: json['ville'] as String? ?? '',
  descriptionColis: json['description_colis'] as String? ?? '',
  prix: json['prix'] == null ? 0 : _versInt(json['prix']),
  pointA: PointLivraison.fromJson(json['point_a'] as Map<String, dynamic>),
  pointB: PointLivraison.fromJson(json['point_b'] as Map<String, dynamic>),
  livreur: json['livreur'] as String?,
  livreurPosition: json['livreur_position'] == null
      ? null
      : LivreurPosition.fromJson(
          json['livreur_position'] as Map<String, dynamic>,
        ),
  jeSuisLivreur: json['je_suis_livreur'] as bool? ?? false,
  jeSuisDestinataire: json['je_suis_destinataire'] as bool? ?? false,
  positionBDeposee: json['position_b_deposee'] as bool? ?? false,
  creeLe: json['cree_le'] as String?,
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'id': instance.id,
  'numero': instance.numero,
  'statut': instance.statut,
  'ville': instance.ville,
  'description_colis': instance.descriptionColis,
  'prix': instance.prix,
  'point_a': instance.pointA,
  'point_b': instance.pointB,
  'livreur': instance.livreur,
  'livreur_position': instance.livreurPosition,
  'je_suis_livreur': instance.jeSuisLivreur,
  'je_suis_destinataire': instance.jeSuisDestinataire,
  'position_b_deposee': instance.positionBDeposee,
  'cree_le': instance.creeLe,
};

_ResultatCreationCourse _$ResultatCreationCourseFromJson(
  Map<String, dynamic> json,
) => _ResultatCreationCourse(
  course: Course.fromJson(json['course'] as Map<String, dynamic>),
  assigne: json['assigne'] as bool? ?? false,
  message: json['message'] as String? ?? '',
);

Map<String, dynamic> _$ResultatCreationCourseToJson(
  _ResultatCreationCourse instance,
) => <String, dynamic>{
  'course': instance.course,
  'assigne': instance.assigne,
  'message': instance.message,
};

_LivreurProche _$LivreurProcheFromJson(Map<String, dynamic> json) =>
    _LivreurProche(
      id: json['id'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      typeVehicule: json['type_vehicule'] as String? ?? 'moto',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      positionMajLe: json['position_maj_le'] as String?,
    );

Map<String, dynamic> _$LivreurProcheToJson(_LivreurProche instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'type_vehicule': instance.typeVehicule,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'position_maj_le': instance.positionMajLe,
    };
