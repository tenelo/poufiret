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

  /// Prix normal (sans promo), en nombre.
  double get prixNormal => double.tryParse(prix) ?? 0;

  /// Prix promotionnel en nombre (0 si absent).
  double get _prixPromoNum => double.tryParse(prixPromotion ?? '') ?? 0;

  /// True si une promo cohérente est active (promo ON, prix promo < prix).
  /// Miroir du backend : évite d'afficher une fausse promo.
  bool get promotionValide =>
      estEnPromotion &&
      prixPromotion != null &&
      prixNormal > 0 &&
      _prixPromoNum < prixNormal;

  /// Prix à afficher (promo si valide, sinon prix normal).
  double get prixEffectif => promotionValide ? _prixPromoNum : prixNormal;

  /// Pourcentage de réduction (entier), ou null si pas de promo valide.
  int? get pourcentageReduction {
    if (!promotionValide) return null;
    return ((prixNormal - _prixPromoNum) / prixNormal * 100).round();
  }
}
