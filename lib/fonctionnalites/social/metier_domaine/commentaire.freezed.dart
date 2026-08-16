// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commentaire.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Commentaire {

 int get id; int get user;@JsonKey(name: 'user_nom') String get userNom; int? get parent; String get contenu;@JsonKey(name: 'est_modifie') bool get estModifie;@JsonKey(name: 'nb_likes') int get nbLikes;@JsonKey(name: 'est_like_par_moi') bool get estLikeParMoi; List<Commentaire> get reponses;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Commentaire
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaireCopyWith<Commentaire> get copyWith => _$CommentaireCopyWithImpl<Commentaire>(this as Commentaire, _$identity);

  /// Serializes this Commentaire to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Commentaire&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.userNom, userNom) || other.userNom == userNom)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.estModifie, estModifie) || other.estModifie == estModifie)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&const DeepCollectionEquality().equals(other.reponses, reponses)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,userNom,parent,contenu,estModifie,nbLikes,estLikeParMoi,const DeepCollectionEquality().hash(reponses),createdAt);

@override
String toString() {
  return 'Commentaire(id: $id, user: $user, userNom: $userNom, parent: $parent, contenu: $contenu, estModifie: $estModifie, nbLikes: $nbLikes, estLikeParMoi: $estLikeParMoi, reponses: $reponses, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommentaireCopyWith<$Res>  {
  factory $CommentaireCopyWith(Commentaire value, $Res Function(Commentaire) _then) = _$CommentaireCopyWithImpl;
@useResult
$Res call({
 int id, int user,@JsonKey(name: 'user_nom') String userNom, int? parent, String contenu,@JsonKey(name: 'est_modifie') bool estModifie,@JsonKey(name: 'nb_likes') int nbLikes,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi, List<Commentaire> reponses,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$CommentaireCopyWithImpl<$Res>
    implements $CommentaireCopyWith<$Res> {
  _$CommentaireCopyWithImpl(this._self, this._then);

  final Commentaire _self;
  final $Res Function(Commentaire) _then;

/// Create a copy of Commentaire
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? userNom = null,Object? parent = freezed,Object? contenu = null,Object? estModifie = null,Object? nbLikes = null,Object? estLikeParMoi = null,Object? reponses = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as int,userNom: null == userNom ? _self.userNom : userNom // ignore: cast_nullable_to_non_nullable
as String,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,estModifie: null == estModifie ? _self.estModifie : estModifie // ignore: cast_nullable_to_non_nullable
as bool,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,reponses: null == reponses ? _self.reponses : reponses // ignore: cast_nullable_to_non_nullable
as List<Commentaire>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Commentaire].
extension CommentairePatterns on Commentaire {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Commentaire value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Commentaire() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Commentaire value)  $default,){
final _that = this;
switch (_that) {
case _Commentaire():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Commentaire value)?  $default,){
final _that = this;
switch (_that) {
case _Commentaire() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int user, @JsonKey(name: 'user_nom')  String userNom,  int? parent,  String contenu, @JsonKey(name: 'est_modifie')  bool estModifie, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi,  List<Commentaire> reponses, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Commentaire() when $default != null:
return $default(_that.id,_that.user,_that.userNom,_that.parent,_that.contenu,_that.estModifie,_that.nbLikes,_that.estLikeParMoi,_that.reponses,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int user, @JsonKey(name: 'user_nom')  String userNom,  int? parent,  String contenu, @JsonKey(name: 'est_modifie')  bool estModifie, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi,  List<Commentaire> reponses, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Commentaire():
return $default(_that.id,_that.user,_that.userNom,_that.parent,_that.contenu,_that.estModifie,_that.nbLikes,_that.estLikeParMoi,_that.reponses,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int user, @JsonKey(name: 'user_nom')  String userNom,  int? parent,  String contenu, @JsonKey(name: 'est_modifie')  bool estModifie, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi,  List<Commentaire> reponses, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Commentaire() when $default != null:
return $default(_that.id,_that.user,_that.userNom,_that.parent,_that.contenu,_that.estModifie,_that.nbLikes,_that.estLikeParMoi,_that.reponses,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Commentaire extends Commentaire {
  const _Commentaire({required this.id, required this.user, @JsonKey(name: 'user_nom') this.userNom = '', this.parent, this.contenu = '', @JsonKey(name: 'est_modifie') this.estModifie = false, @JsonKey(name: 'nb_likes') this.nbLikes = 0, @JsonKey(name: 'est_like_par_moi') this.estLikeParMoi = false, final  List<Commentaire> reponses = const <Commentaire>[], @JsonKey(name: 'created_at') this.createdAt}): _reponses = reponses,super._();
  factory _Commentaire.fromJson(Map<String, dynamic> json) => _$CommentaireFromJson(json);

@override final  int id;
@override final  int user;
@override@JsonKey(name: 'user_nom') final  String userNom;
@override final  int? parent;
@override@JsonKey() final  String contenu;
@override@JsonKey(name: 'est_modifie') final  bool estModifie;
@override@JsonKey(name: 'nb_likes') final  int nbLikes;
@override@JsonKey(name: 'est_like_par_moi') final  bool estLikeParMoi;
 final  List<Commentaire> _reponses;
@override@JsonKey() List<Commentaire> get reponses {
  if (_reponses is EqualUnmodifiableListView) return _reponses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reponses);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Commentaire
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentaireCopyWith<_Commentaire> get copyWith => __$CommentaireCopyWithImpl<_Commentaire>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaireToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Commentaire&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.userNom, userNom) || other.userNom == userNom)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.estModifie, estModifie) || other.estModifie == estModifie)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&const DeepCollectionEquality().equals(other._reponses, _reponses)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,userNom,parent,contenu,estModifie,nbLikes,estLikeParMoi,const DeepCollectionEquality().hash(_reponses),createdAt);

@override
String toString() {
  return 'Commentaire(id: $id, user: $user, userNom: $userNom, parent: $parent, contenu: $contenu, estModifie: $estModifie, nbLikes: $nbLikes, estLikeParMoi: $estLikeParMoi, reponses: $reponses, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommentaireCopyWith<$Res> implements $CommentaireCopyWith<$Res> {
  factory _$CommentaireCopyWith(_Commentaire value, $Res Function(_Commentaire) _then) = __$CommentaireCopyWithImpl;
@override @useResult
$Res call({
 int id, int user,@JsonKey(name: 'user_nom') String userNom, int? parent, String contenu,@JsonKey(name: 'est_modifie') bool estModifie,@JsonKey(name: 'nb_likes') int nbLikes,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi, List<Commentaire> reponses,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$CommentaireCopyWithImpl<$Res>
    implements _$CommentaireCopyWith<$Res> {
  __$CommentaireCopyWithImpl(this._self, this._then);

  final _Commentaire _self;
  final $Res Function(_Commentaire) _then;

/// Create a copy of Commentaire
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? userNom = null,Object? parent = freezed,Object? contenu = null,Object? estModifie = null,Object? nbLikes = null,Object? estLikeParMoi = null,Object? reponses = null,Object? createdAt = freezed,}) {
  return _then(_Commentaire(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as int,userNom: null == userNom ? _self.userNom : userNom // ignore: cast_nullable_to_non_nullable
as String,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,estModifie: null == estModifie ? _self.estModifie : estModifie // ignore: cast_nullable_to_non_nullable
as bool,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,reponses: null == reponses ? _self._reponses : reponses // ignore: cast_nullable_to_non_nullable
as List<Commentaire>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
