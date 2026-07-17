import 'package:freezed_annotation/freezed_annotation.dart';

part 'partenaire_vitrine.freezed.dart';
part 'partenaire_vitrine.g.dart';

@freezed
abstract class PartenaireVitrine with _$PartenaireVitrine {
  const PartenaireVitrine._();

  const factory PartenaireVitrine({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @JsonKey(name: 'type_partenaire') @Default('') String typePartenaire,
    @JsonKey(name: 'type_partenaire_libelle') @Default('') String typeLibelle,
    @Default('') String description,
    String? logo,
    @JsonKey(name: 'photo_couverture') String? photoCouverture,
    @Default('') String adresse,
    @Default('') String quartier,
    @Default('') String secteur,
    @Default('') String ville,
    @JsonKey(name: 'description_acces') @Default('') String descriptionAcces,
    @JsonKey(name: 'telephone_pro') @Default('') String telephonePro,
    @Default('') String whatsapp,
    @JsonKey(name: 'email_pro') @Default('') String emailPro,
    @JsonKey(name: 'nombre_likes') @Default(0) int nombreLikes,
    @JsonKey(name: 'est_like_par_moi') @Default(false) bool estLikeParMoi,
    @JsonKey(name: 'est_favori_par_moi') @Default(false) bool estFavoriParMoi,
  }) = _PartenaireVitrine;

  factory PartenaireVitrine.fromJson(Map<String, dynamic> json) =>
      _$PartenaireVitrineFromJson(json);

  /// Localisation lisible : concatène quartier / secteur / ville non vides.
  String get localisationLisible {
    final parts = [quartier, secteur, ville].where((p) => p.isNotEmpty);
    return parts.join(' · ');
  }
}
