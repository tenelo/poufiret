import 'package:freezed_annotation/freezed_annotation.dart';

part 'livraison_models.freezed.dart';
part 'livraison_models.g.dart';

/// Convertit un montant reçu en int, quel que soit son format JSON
/// (int, double comme 1500.0, ou String comme "1500").
int _versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is num) return valeur.round();
  return double.tryParse(valeur.toString())?.round() ?? 0;
}

/// Coordonnees GPS d'un point (absent -> gps == null).
@freezed
abstract class GpsPoint with _$GpsPoint {
  const factory GpsPoint({
    double? latitude,
    double? longitude,
  }) = _GpsPoint;

  factory GpsPoint.fromJson(Map<String, dynamic> json) =>
      _$GpsPointFromJson(json);
}

/// Un point d'une course (retrait A ou livraison B).
/// quartier + nomContact + telephoneContact TOUJOURS ; gps en plus.
@freezed
abstract class PointLivraison with _$PointLivraison {
  const factory PointLivraison({
    @Default('') String quartier,
    @JsonKey(name: 'nom_contact') @Default('') String nomContact,
    @JsonKey(name: 'telephone_contact') @Default('') String telephoneContact,
    GpsPoint? gps,
  }) = _PointLivraison;

  factory PointLivraison.fromJson(Map<String, dynamic> json) =>
      _$PointLivraisonFromJson(json);
}

/// Derniere position connue du livreur assigne (bloc livreur_position).
@freezed
abstract class LivreurPosition with _$LivreurPosition {
  const factory LivreurPosition({
    double? latitude,
    double? longitude,
    @JsonKey(name: 'type_vehicule') @Default('moto') String typeVehicule,
    @JsonKey(name: 'maj_le') String? majLe,
  }) = _LivreurPosition;

  factory LivreurPosition.fromJson(Map<String, dynamic> json) =>
      _$LivreurPositionFromJson(json);
}

/// Une course de livraison directe A -> B (miroir de _course_dict backend).
@freezed
abstract class Course with _$Course {
  const factory Course({
    @Default('') String id,
    @Default('') String numero,
    @Default('demandee') String statut,
    @Default('') String ville,
    @JsonKey(name: 'description_colis') @Default('') String descriptionColis,
    @JsonKey(fromJson: _versInt) @Default(0) int prix,
    @JsonKey(name: 'point_a') required PointLivraison pointA,
    @JsonKey(name: 'point_b') required PointLivraison pointB,
    String? livreur,
    @JsonKey(name: 'livreur_position') LivreurPosition? livreurPosition,
    @JsonKey(name: 'cree_le') String? creeLe,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);
}

/// Resultat de la creation d'une course : la course + info d'assignation.
/// message est vide si un livreur a ete assigne ; sinon = "Aucun livreur...".
@freezed
abstract class ResultatCreationCourse with _$ResultatCreationCourse {
  const factory ResultatCreationCourse({
    required Course course,
    @Default(false) bool assigne,
    @Default('') String message,
  }) = _ResultatCreationCourse;

  factory ResultatCreationCourse.fromJson(Map<String, dynamic> json) =>
      _$ResultatCreationCourseFromJson(json);
}

/// Un livreur en ligne proche, pour la carte (endpoint /livreurs/proches/).
@freezed
abstract class LivreurProche with _$LivreurProche {
  const factory LivreurProche({
    @Default('') String id,
    @Default('') String nom,
    @JsonKey(name: 'type_vehicule') @Default('moto') String typeVehicule,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'position_maj_le') String? positionMajLe,
  }) = _LivreurProche;

  factory LivreurProche.fromJson(Map<String, dynamic> json) =>
      _$LivreurProcheFromJson(json);
}
