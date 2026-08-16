import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_article.freezed.dart';
part 'video_article.g.dart';

/// Video rattachee a un article, affichee dans l'onglet Videos.
@freezed
abstract class VideoArticle with _$VideoArticle {
  const factory VideoArticle({
    required int id,
    int? article,
    @JsonKey(name: 'article_nom') @Default('') String articleNom,
    @JsonKey(name: 'article_slug') @Default('') String articleSlug,
    @Default('') String video,
    @Default('') String titre,
    String? miniature,
  }) = _VideoArticle;

  factory VideoArticle.fromJson(Map<String, dynamic> json) =>
      _$VideoArticleFromJson(json);
}
