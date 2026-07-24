import 'package:freezed_annotation/freezed_annotation.dart';
part 'ma_categorie.freezed.dart';
part 'ma_categorie.g.dart';

/// Rattachement du partenaire a une categorie, avec son image dediee.
@freezed
abstract class MaCategorie with _$MaCategorie {
  const MaCategorie._();

  const factory MaCategorie({
    required int id,
    int? categorie,
    @JsonKey(name: 'categorie_nom') @Default('') String nom,
    @JsonKey(name: 'categorie_slug') @Default('') String slug,
    @JsonKey(name: 'categorie_icone') @Default('') String icone,
    @JsonKey(name: 'est_principale') @Default(false) bool estPrincipale,
    @JsonKey(name: 'image_couverture') String? imageCouverture,
  }) = _MaCategorie;

  factory MaCategorie.fromJson(Map<String, dynamic> json) =>
      _$MaCategorieFromJson(json);

  bool get aUneImage => (imageCouverture ?? '').isNotEmpty;
}
