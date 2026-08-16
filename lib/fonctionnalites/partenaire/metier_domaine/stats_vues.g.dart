// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_vues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatsArticle _$StatsArticleFromJson(Map<String, dynamic> json) =>
    _StatsArticle(
      articleId: (json['article_id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      estActif: json['est_actif'] as bool? ?? true,
      total: (json['total'] as num?)?.toInt() ?? 0,
      jour: (json['jour'] as num?)?.toInt() ?? 0,
      semaine: (json['semaine'] as num?)?.toInt() ?? 0,
      mois: (json['mois'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StatsArticleToJson(_StatsArticle instance) =>
    <String, dynamic>{
      'article_id': instance.articleId,
      'nom': instance.nom,
      'slug': instance.slug,
      'est_actif': instance.estActif,
      'total': instance.total,
      'jour': instance.jour,
      'semaine': instance.semaine,
      'mois': instance.mois,
    };

_StatsVues _$StatsVuesFromJson(Map<String, dynamic> json) => _StatsVues(
  totalVues: (json['total_vues'] as num?)?.toInt() ?? 0,
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map((e) => StatsArticle.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatsArticle>[],
);

Map<String, dynamic> _$StatsVuesToJson(_StatsVues instance) =>
    <String, dynamic>{
      'total_vues': instance.totalVues,
      'articles': instance.articles,
    };
