import 'package:freezed_annotation/freezed_annotation.dart';

part 'commentaire.freezed.dart';
part 'commentaire.g.dart';

@freezed
abstract class Commentaire with _$Commentaire {
  const Commentaire._();

  const factory Commentaire({
    required int id,
    required int user,
    @JsonKey(name: 'user_nom') @Default('') String userNom,
    int? parent,
    @Default('') String contenu,
    @JsonKey(name: 'est_modifie') @Default(false) bool estModifie,
    @JsonKey(name: 'nb_likes') @Default(0) int nbLikes,
    @JsonKey(name: 'est_like_par_moi') @Default(false) bool estLikeParMoi,
    @Default(<Commentaire>[]) List<Commentaire> reponses,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Commentaire;

  factory Commentaire.fromJson(Map<String, dynamic> json) =>
      _$CommentaireFromJson(json);
}
