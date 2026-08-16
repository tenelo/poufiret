import 'package:freezed_annotation/freezed_annotation.dart';

part 'favoris_models.freezed.dart';
part 'favoris_models.g.dart';

/// Convertit un prix reçu en int (String "3500", double ou int).
int _versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is num) return valeur.round();
  return double.tryParse(valeur.toString())?.round() ?? 0;
}

/// Article tel qu'il apparaît dans la liste des favoris (résumé).
@freezed
abstract class ArticleFavori with _$ArticleFavori {
  const factory ArticleFavori({
    required int id,
    @Default('') String nom,
    @Default('') String slug,
    @Default('') String type,
    @JsonKey(fromJson: _versInt) @Default(0) int prix,
    @JsonKey(name: 'nb_vues') @Default(0) int nbVues,
    @JsonKey(name: 'nb_likes') @Default(0) int nbLikes,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    int? categorie,
  }) = _ArticleFavori;

  factory ArticleFavori.fromJson(Map<String, dynamic> json) =>
      _$ArticleFavoriFromJson(json);
}

/// Partenaire tel qu'il apparaît dans la liste des favoris (résumé).
@freezed
abstract class PartenaireFavori with _$PartenaireFavori {
  const factory PartenaireFavori({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @JsonKey(name: 'type_partenaire') @Default('') String typePartenaire,
    @Default('') String ville,
    @Default('') String quartier,
    String? logo,
  }) = _PartenaireFavori;

  factory PartenaireFavori.fromJson(Map<String, dynamic> json) =>
      _$PartenaireFavoriFromJson(json);
}

/// Entrée de favori sur un article (enveloppe avec la date).
@freezed
abstract class EntreeArticleFavori with _$EntreeArticleFavori {
  const factory EntreeArticleFavori({
    required int id,
    required ArticleFavori article,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _EntreeArticleFavori;

  factory EntreeArticleFavori.fromJson(Map<String, dynamic> json) =>
      _$EntreeArticleFavoriFromJson(json);
}

/// Entrée de favori sur un partenaire.
@freezed
abstract class EntreePartenaireFavori with _$EntreePartenaireFavori {
  const factory EntreePartenaireFavori({
    required int id,
    required PartenaireFavori partenaire,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _EntreePartenaireFavori;

  factory EntreePartenaireFavori.fromJson(Map<String, dynamic> json) =>
      _$EntreePartenaireFavoriFromJson(json);
}

/// Réponse complète de /social/mes-favoris/.
@freezed
abstract class MesFavoris with _$MesFavoris {
  const factory MesFavoris({
    @Default(<EntreeArticleFavori>[]) List<EntreeArticleFavori> articles,
    @Default(<EntreePartenaireFavori>[])
    List<EntreePartenaireFavori> partenaires,
  }) = _MesFavoris;

  factory MesFavoris.fromJson(Map<String, dynamic> json) =>
      _$MesFavorisFromJson(json);
}
