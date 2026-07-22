import 'package:freezed_annotation/freezed_annotation.dart';

part 'categorie.freezed.dart';
part 'categorie.g.dart';

@freezed
abstract class Categorie with _$Categorie {
  const factory Categorie({
    required int id,
    required String nom,
    required String slug,
    @Default('') String description,
    @Default('') String icone, // emoji 🍽️
    @JsonKey(name: 'image_couverture') String? imageCouverture,
    int? parent,
    @JsonKey(name: 'mode_transaction') @Default('') String modeTransaction,
    @Default(0) int ordre,
    @JsonKey(name: 'types_articles') @Default(<String>[]) List<String> typesArticles,
    @JsonKey(name: 'affiche_catalogue') @Default(true) bool afficheCatalogue,
    @JsonKey(name: 'est_active') @Default(true) bool estActive,
    @JsonKey(name: 'nb_partenaires') int? nbPartenaires,
    @Default(<Categorie>[]) List<Categorie> enfants,
  }) = _Categorie;

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);
}
