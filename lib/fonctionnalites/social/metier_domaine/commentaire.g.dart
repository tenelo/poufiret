// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Commentaire _$CommentaireFromJson(Map<String, dynamic> json) => _Commentaire(
  id: (json['id'] as num).toInt(),
  user: (json['user'] as num).toInt(),
  userNom: json['user_nom'] as String? ?? '',
  parent: (json['parent'] as num?)?.toInt(),
  contenu: json['contenu'] as String? ?? '',
  estModifie: json['est_modifie'] as bool? ?? false,
  nbLikes: (json['nb_likes'] as num?)?.toInt() ?? 0,
  estLikeParMoi: json['est_like_par_moi'] as bool? ?? false,
  reponses:
      (json['reponses'] as List<dynamic>?)
          ?.map((e) => Commentaire.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Commentaire>[],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CommentaireToJson(_Commentaire instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'user_nom': instance.userNom,
      'parent': instance.parent,
      'contenu': instance.contenu,
      'est_modifie': instance.estModifie,
      'nb_likes': instance.nbLikes,
      'est_like_par_moi': instance.estLikeParMoi,
      'reponses': instance.reponses,
      'created_at': instance.createdAt?.toIso8601String(),
    };
