import 'package:freezed_annotation/freezed_annotation.dart';
part 'resultats_recherche.freezed.dart';
part 'resultats_recherche.g.dart';

/// Categorie trouvee par la recherche.
@freezed
abstract class CategorieTrouvee with _$CategorieTrouvee {
  const factory CategorieTrouvee({
    required int id,
    @Default('') String nom,
    @Default('') String slug,
    @Default('') String icone,
    @JsonKey(name: 'mode_transaction') @Default('') String modeTransaction,
    @JsonKey(name: 'affiche_catalogue') @Default(true) bool afficheCatalogue,
  }) = _CategorieTrouvee;

  factory CategorieTrouvee.fromJson(Map<String, dynamic> json) =>
      _$CategorieTrouveeFromJson(json);
}

/// Partenaire trouve par la recherche.
@freezed
abstract class PartenaireTrouve with _$PartenaireTrouve {
  const factory PartenaireTrouve({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @Default('') String description,
    @Default('') String logo,
    @JsonKey(name: 'photo_couverture') @Default('') String photoCouverture,
    @JsonKey(name: 'type_partenaire') @Default('') String typePartenaire,
  }) = _PartenaireTrouve;

  factory PartenaireTrouve.fromJson(Map<String, dynamic> json) =>
      _$PartenaireTrouveFromJson(json);
}

/// Article trouve par la recherche.
@freezed
abstract class ArticleTrouve with _$ArticleTrouve {
  const factory ArticleTrouve({
    required int id,
    @Default('') String nom,
    @Default('') String slug,
    @Default('0') String prix,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'image_principale') @Default('') String imagePrincipale,
  }) = _ArticleTrouve;

  factory ArticleTrouve.fromJson(Map<String, dynamic> json) =>
      _$ArticleTrouveFromJson(json);
}

/// Reponse complete de la recherche unifiee.
///
/// L'ordre des sections traduit une intention : un terme generique
/// ("chaussure") vise l'annuaire, un terme precis ("doliprane") un produit.
@freezed
abstract class ResultatsRecherche with _$ResultatsRecherche {
  const ResultatsRecherche._();

  const factory ResultatsRecherche({
    @Default(<CategorieTrouvee>[]) List<CategorieTrouvee> categories,
    @Default(<PartenaireTrouve>[]) List<PartenaireTrouve> partenaires,
    @Default(<ArticleTrouve>[]) List<ArticleTrouve> articles,
  }) = _ResultatsRecherche;

  factory ResultatsRecherche.fromJson(Map<String, dynamic> json) =>
      _$ResultatsRechercheFromJson(json);

  bool get estVide =>
      categories.isEmpty && partenaires.isEmpty && articles.isEmpty;

  int get total => categories.length + partenaires.length + articles.length;
}
