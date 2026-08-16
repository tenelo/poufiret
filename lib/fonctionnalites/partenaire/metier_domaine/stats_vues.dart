import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_vues.freezed.dart';
part 'stats_vues.g.dart';

@freezed
abstract class StatsArticle with _$StatsArticle {
  const factory StatsArticle({
    @JsonKey(name: 'article_id') required int articleId,
    @Default('') String nom,
    @Default('') String slug,
    @JsonKey(name: 'est_actif') @Default(true) bool estActif,
    @Default(0) int total,
    @Default(0) int jour,
    @Default(0) int semaine,
    @Default(0) int mois,
  }) = _StatsArticle;

  factory StatsArticle.fromJson(Map<String, dynamic> json) =>
      _$StatsArticleFromJson(json);
}

@freezed
abstract class StatsVues with _$StatsVues {
  const factory StatsVues({
    @JsonKey(name: 'total_vues') @Default(0) int totalVues,
    @Default(<StatsArticle>[]) List<StatsArticle> articles,
  }) = _StatsVues;

  factory StatsVues.fromJson(Map<String, dynamic> json) =>
      _$StatsVuesFromJson(json);
}
