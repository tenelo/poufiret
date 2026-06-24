import 'package:freezed_annotation/freezed_annotation.dart';
part 'article_liste.freezed.dart';
part 'article_liste.g.dart';

@freezed
abstract class ArticleListe with _$ArticleListe {
  const ArticleListe._();

  const factory ArticleListe({
    required int id,
    required String nom,
    required String slug,
    @Default('') String type,
    @Default('0') String prix, // arrive en String depuis DRF
    @JsonKey(name: 'prix_promotion') String? prixPromotion,
    @JsonKey(name: 'est_en_promotion') @Default(false) bool estEnPromotion,
    @JsonKey(name: 'est_disponible') @Default(true) bool estDisponible,
    @JsonKey(name: 'nb_vues') @Default(0) int nbVues,
    @JsonKey(name: 'nb_likes') @Default(0) int nbLikes,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    int? categorie,
    @JsonKey(name: 'image_principale') String? imagePrincipale,
  }) = _ArticleListe;

  factory ArticleListe.fromJson(Map<String, dynamic> json) =>
      _$ArticleListeFromJson(json);

  /// Prix à afficher (promo si active), en nombre.
  double get prixEffectif {
    final source = estEnPromotion && prixPromotion != null
        ? prixPromotion!
        : prix;
    return double.tryParse(source) ?? 0;
  }
}
