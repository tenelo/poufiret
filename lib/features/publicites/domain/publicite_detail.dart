import 'package:freezed_annotation/freezed_annotation.dart';
part 'publicite_detail.freezed.dart';
part 'publicite_detail.g.dart';

/// Image secondaire d'une publicité (galerie de la page détail).
@freezed
abstract class ImagePublicite with _$ImagePublicite {
  const factory ImagePublicite({
    required String id,
    String? image,
    @Default(0) int ordre,
  }) = _ImagePublicite;

  factory ImagePublicite.fromJson(Map<String, dynamic> json) =>
      _$ImagePubliciteFromJson(json);
}

/// Fiche complète d'une publicité (page détail, interstitiel).
@freezed
abstract class PubliciteDetail with _$PubliciteDetail {
  const PubliciteDetail._();

  const factory PubliciteDetail({
    required String id,
    @Default('') String titre,
    @Default('') String description,
    @JsonKey(name: 'image_couverture') String? imageCouverture,
    String? video,
    @Default(<ImagePublicite>[]) List<ImagePublicite> images,
    @JsonKey(name: 'partenaire_id') int? partenaireId,
    @JsonKey(name: 'nom_partenaire') @Default('') String nomPartenaire,
  }) = _PubliciteDetail;

  factory PubliciteDetail.fromJson(Map<String, dynamic> json) =>
      _$PubliciteDetailFromJson(json);

  bool get aUneVideo => (video ?? '').isNotEmpty;
}
