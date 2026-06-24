import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_detail.freezed.dart';
part 'article_detail.g.dart';

@freezed
abstract class Variante with _$Variante {
  const Variante._();
  const factory Variante({
    required int id,
    required String nom,
    @JsonKey(name: 'prix_supplement') @Default('0') String prixSupplement,
    @JsonKey(name: 'est_par_defaut') @Default(false) bool estParDefaut,
  }) = _Variante;
  factory Variante.fromJson(Map<String, dynamic> json) =>
      _$VarianteFromJson(json);

  double get supplement => double.tryParse(prixSupplement) ?? 0;
}

@freezed
abstract class Supplement with _$Supplement {
  const Supplement._();
  const factory Supplement({
    required int id,
    required String nom,
    @Default('0') String prix,
    @JsonKey(name: 'est_optionnel') @Default(true) bool estOptionnel,
  }) = _Supplement;
  factory Supplement.fromJson(Map<String, dynamic> json) =>
      _$SupplementFromJson(json);

  double get montant => double.tryParse(prix) ?? 0;
}

@freezed
abstract class ArticleDetail with _$ArticleDetail {
  const ArticleDetail._();

  const factory ArticleDetail({
    required int id,
    required String nom,
    required String slug,
    @Default('') String description,
    @Default('') String type,
    @Default('0') String prix,
    @JsonKey(name: 'prix_promotion') String? prixPromotion,
    @Default('') String unite,
    @JsonKey(name: 'est_disponible') @Default(true) bool estDisponible,
    @JsonKey(name: 'est_en_promotion') @Default(false) bool estEnPromotion,
    @JsonKey(name: 'nb_vues') @Default(0) int nbVues,
    @JsonKey(name: 'nb_likes') @Default(0) int nbLikes,
    @JsonKey(name: 'nb_favoris') @Default(0) int nbFavoris,
    @JsonKey(name: 'nb_commentaires') @Default(0) int nbCommentaires,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    int? partenaire,
    int? categorie,
    @Default(<String>[]) List<String> images,
    @Default(<Variante>[]) List<Variante> variantes,
    @Default(<Supplement>[]) List<Supplement> supplements,
    @JsonKey(name: 'est_like_par_moi') @Default(false) bool estLikeParMoi,
    @JsonKey(name: 'est_favori_par_moi') @Default(false) bool estFavoriParMoi,
   }) = _ArticleDetail;

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);

  double get prixEffectif {
    final source = estEnPromotion && prixPromotion != null
        ? prixPromotion!
        : prix;
    return double.tryParse(source) ?? 0;
  }
}
