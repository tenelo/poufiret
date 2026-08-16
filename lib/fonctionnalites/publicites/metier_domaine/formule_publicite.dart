import 'package:freezed_annotation/freezed_annotation.dart';
part 'formule_publicite.freezed.dart';
part 'formule_publicite.g.dart';

/// Forfait de publicité proposé au partenaire.
@freezed
abstract class FormulePublicite with _$FormulePublicite {
  const FormulePublicite._();

  const factory FormulePublicite({
    required String id,
    @Default('') String nom,
    @Default(0) int prix,
    @Default(0) int priorite,
    @JsonKey(name: 'duree_jours') @Default(1) int dureeJours,
    @JsonKey(name: 'passages_par_jour') @Default(1) int passagesParJour,
    @JsonKey(name: 'duree_affichage_secondes') @Default(5) int dureeAffichageSecondes,
    @JsonKey(name: 'quota_partenaires') @Default(50) int quotaPartenaires,
    @JsonKey(name: 'acces_heures_affluence') @Default(false) bool accesHeuresAffluence,
    @JsonKey(name: 'types_affichage') @Default(<String>[]) List<String> typesAffichage,
    @JsonKey(name: 'nb_images_max') @Default(1) int nbImagesMax,
    @JsonKey(name: 'video_autorisee') @Default(false) bool videoAutorisee,
    @JsonKey(name: 'duree_video_max_secondes') @Default(30) int dureeVideoMaxSecondes,
    @JsonKey(name: 'cible_pourcentage_actifs') int? ciblePourcentageActifs,
  }) = _FormulePublicite;

  factory FormulePublicite.fromJson(Map<String, dynamic> json) =>
      _$FormulePubliciteFromJson(json);

  bool get estExclusive => quotaPartenaires <= 1;
  bool autorise(String type) => typesAffichage.contains(type);
}
