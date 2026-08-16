import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_detail.freezed.dart';
part 'article_detail.g.dart';

/// L'API renvoie les images comme objets ({id, image, legende, ordre...}).
/// L'app n'a besoin que des URLs : ce convertisseur fait le pont, tout en
/// acceptant une liste de chaines si le format venait a changer.
class ImagesUrlConverter
    implements JsonConverter<List<String>, List<dynamic>?> {
  const ImagesUrlConverter();

  @override
  List<String> fromJson(List<dynamic>? json) {
    if (json == null) return const [];
    final urls = <String>[];
    for (final e in json) {
      if (e is String) {
        if (e.isNotEmpty) urls.add(e);
      } else if (e is Map) {
        final url = e['image'];
        if (url is String && url.isNotEmpty) urls.add(url);
      }
    }
    return urls;
  }

  @override
  List<dynamic> toJson(List<String> objet) => objet;
}

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
    @JsonKey(name: 'est_actif') @Default(true) bool estActif,
    @JsonKey(name: 'est_en_promotion') @Default(false) bool estEnPromotion,
    @JsonKey(name: 'nb_vues') @Default(0) int nbVues,
    @JsonKey(name: 'nb_likes') @Default(0) int nbLikes,
    @JsonKey(name: 'nb_favoris') @Default(0) int nbFavoris,
    @JsonKey(name: 'nb_commentaires') @Default(0) int nbCommentaires,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    int? partenaire,
    int? categorie,
    @ImagesUrlConverter() @Default(<String>[]) List<String> images,
    @Default(<Variante>[]) List<Variante> variantes,
    @Default(<Supplement>[]) List<Supplement> supplements,
    @JsonKey(name: 'est_like_par_moi') @Default(false) bool estLikeParMoi,
    @JsonKey(name: 'est_favori_par_moi') @Default(false) bool estFavoriParMoi,
   }) = _ArticleDetail;

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);

  /// Prix normal (sans promo), en nombre.
  double get prixNormal => double.tryParse(prix) ?? 0;

  double get _prixPromoNum => double.tryParse(prixPromotion ?? '') ?? 0;

  /// True si une promo cohérente est active (miroir du backend).
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
