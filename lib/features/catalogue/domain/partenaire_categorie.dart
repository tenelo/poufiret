import 'package:freezed_annotation/freezed_annotation.dart';

part 'partenaire_categorie.freezed.dart';
part 'partenaire_categorie.g.dart';

/// Prestataire/commerce listé dans l'annuaire d'une catégorie.
@freezed
abstract class PartenaireCategorie with _$PartenaireCategorie {
  const factory PartenaireCategorie({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @Default('') String description,
    @Default('') String logo,
    @JsonKey(name: 'photo_couverture') @Default('') String photoCouverture,
    @Default('') String departement,
    @Default('') String region,
    double? latitude,
    double? longitude,
    @Default('') String adresse,
    @Default('') String quartier,
  }) = _PartenaireCategorie;

  const PartenaireCategorie._();

  /// Vrai si le partenaire a des coordonnees GPS exploitables sur la carte.
  bool get aPosition => latitude != null && longitude != null;

  factory PartenaireCategorie.fromJson(Map<String, dynamic> json) =>
      _$PartenaireCategorieFromJson(json);
}
