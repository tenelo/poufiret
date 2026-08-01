// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoArticle _$VideoArticleFromJson(Map<String, dynamic> json) =>
    _VideoArticle(
      id: (json['id'] as num).toInt(),
      article: (json['article'] as num?)?.toInt(),
      articleNom: json['article_nom'] as String? ?? '',
      articleSlug: json['article_slug'] as String? ?? '',
      video: json['video'] as String? ?? '',
      titre: json['titre'] as String? ?? '',
      miniature: json['miniature'] as String?,
    );

Map<String, dynamic> _$VideoArticleToJson(_VideoArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'article': instance.article,
      'article_nom': instance.articleNom,
      'article_slug': instance.articleSlug,
      'video': instance.video,
      'titre': instance.titre,
      'miniature': instance.miniature,
    };
