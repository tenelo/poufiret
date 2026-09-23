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
    @JsonKey(name: 'types_partenaire')
    @Default(<String>[])
    List<String> typesPartenaire,
    @JsonKey(name: 'est_active') @Default(true) bool estActive,
    @JsonKey(name: 'nb_partenaires') int? nbPartenaires,
    @Default(<Categorie>[]) List<Categorie> enfants,
  }) = _Categorie;

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);
}

extension CategorieAffichage on Categorie {
  /// Active ET avec au moins un partenaire (ou effectif inconnu).
  /// Exactement l'inverse de « Bientôt disponible » sur l'accueil.
  bool get aDesPartenaires =>
      estActive && (nbPartenaires == null || nbPartenaires! > 0);
}

extension ListeCategories on List<Categorie> {
  /// Categories terminales : un parent qui a des enfants est remplacé par
  /// ses enfants (récursif). Sans hiérarchie, renvoie la liste telle quelle.
  /// À utiliser partout où l'on doit CHOISIR une catégorie réelle.
  List<Categorie> get feuilles => [
        for (final c in this)
          if (c.enfants.isEmpty) c else ...c.enfants.feuilles,
      ];
}
