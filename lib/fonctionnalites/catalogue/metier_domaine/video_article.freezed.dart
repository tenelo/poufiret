// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoArticle {

 int get id; int? get article;@JsonKey(name: 'article_nom') String get articleNom;@JsonKey(name: 'article_slug') String get articleSlug; String get video; String get titre; String? get miniature;
/// Create a copy of VideoArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoArticleCopyWith<VideoArticle> get copyWith => _$VideoArticleCopyWithImpl<VideoArticle>(this as VideoArticle, _$identity);

  /// Serializes this VideoArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.articleNom, articleNom) || other.articleNom == articleNom)&&(identical(other.articleSlug, articleSlug) || other.articleSlug == articleSlug)&&(identical(other.video, video) || other.video == video)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.miniature, miniature) || other.miniature == miniature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,articleNom,articleSlug,video,titre,miniature);

@override
String toString() {
  return 'VideoArticle(id: $id, article: $article, articleNom: $articleNom, articleSlug: $articleSlug, video: $video, titre: $titre, miniature: $miniature)';
}


}

/// @nodoc
abstract mixin class $VideoArticleCopyWith<$Res>  {
  factory $VideoArticleCopyWith(VideoArticle value, $Res Function(VideoArticle) _then) = _$VideoArticleCopyWithImpl;
@useResult
$Res call({
 int id, int? article,@JsonKey(name: 'article_nom') String articleNom,@JsonKey(name: 'article_slug') String articleSlug, String video, String titre, String? miniature
});




}
/// @nodoc
class _$VideoArticleCopyWithImpl<$Res>
    implements $VideoArticleCopyWith<$Res> {
  _$VideoArticleCopyWithImpl(this._self, this._then);

  final VideoArticle _self;
  final $Res Function(VideoArticle) _then;

/// Create a copy of VideoArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? article = freezed,Object? articleNom = null,Object? articleSlug = null,Object? video = null,Object? titre = null,Object? miniature = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,articleNom: null == articleNom ? _self.articleNom : articleNom // ignore: cast_nullable_to_non_nullable
as String,articleSlug: null == articleSlug ? _self.articleSlug : articleSlug // ignore: cast_nullable_to_non_nullable
as String,video: null == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,miniature: freezed == miniature ? _self.miniature : miniature // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoArticle].
extension VideoArticlePatterns on VideoArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoArticle value)  $default,){
final _that = this;
switch (_that) {
case _VideoArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoArticle value)?  $default,){
final _that = this;
switch (_that) {
case _VideoArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'article_slug')  String articleSlug,  String video,  String titre,  String? miniature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoArticle() when $default != null:
return $default(_that.id,_that.article,_that.articleNom,_that.articleSlug,_that.video,_that.titre,_that.miniature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'article_slug')  String articleSlug,  String video,  String titre,  String? miniature)  $default,) {final _that = this;
switch (_that) {
case _VideoArticle():
return $default(_that.id,_that.article,_that.articleNom,_that.articleSlug,_that.video,_that.titre,_that.miniature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'article_slug')  String articleSlug,  String video,  String titre,  String? miniature)?  $default,) {final _that = this;
switch (_that) {
case _VideoArticle() when $default != null:
return $default(_that.id,_that.article,_that.articleNom,_that.articleSlug,_that.video,_that.titre,_that.miniature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoArticle implements VideoArticle {
  const _VideoArticle({required this.id, this.article, @JsonKey(name: 'article_nom') this.articleNom = '', @JsonKey(name: 'article_slug') this.articleSlug = '', this.video = '', this.titre = '', this.miniature});
  factory _VideoArticle.fromJson(Map<String, dynamic> json) => _$VideoArticleFromJson(json);

@override final  int id;
@override final  int? article;
@override@JsonKey(name: 'article_nom') final  String articleNom;
@override@JsonKey(name: 'article_slug') final  String articleSlug;
@override@JsonKey() final  String video;
@override@JsonKey() final  String titre;
@override final  String? miniature;

/// Create a copy of VideoArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoArticleCopyWith<_VideoArticle> get copyWith => __$VideoArticleCopyWithImpl<_VideoArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.articleNom, articleNom) || other.articleNom == articleNom)&&(identical(other.articleSlug, articleSlug) || other.articleSlug == articleSlug)&&(identical(other.video, video) || other.video == video)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.miniature, miniature) || other.miniature == miniature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,articleNom,articleSlug,video,titre,miniature);

@override
String toString() {
  return 'VideoArticle(id: $id, article: $article, articleNom: $articleNom, articleSlug: $articleSlug, video: $video, titre: $titre, miniature: $miniature)';
}


}

/// @nodoc
abstract mixin class _$VideoArticleCopyWith<$Res> implements $VideoArticleCopyWith<$Res> {
  factory _$VideoArticleCopyWith(_VideoArticle value, $Res Function(_VideoArticle) _then) = __$VideoArticleCopyWithImpl;
@override @useResult
$Res call({
 int id, int? article,@JsonKey(name: 'article_nom') String articleNom,@JsonKey(name: 'article_slug') String articleSlug, String video, String titre, String? miniature
});




}
/// @nodoc
class __$VideoArticleCopyWithImpl<$Res>
    implements _$VideoArticleCopyWith<$Res> {
  __$VideoArticleCopyWithImpl(this._self, this._then);

  final _VideoArticle _self;
  final $Res Function(_VideoArticle) _then;

/// Create a copy of VideoArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? article = freezed,Object? articleNom = null,Object? articleSlug = null,Object? video = null,Object? titre = null,Object? miniature = freezed,}) {
  return _then(_VideoArticle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,articleNom: null == articleNom ? _self.articleNom : articleNom // ignore: cast_nullable_to_non_nullable
as String,articleSlug: null == articleSlug ? _self.articleSlug : articleSlug // ignore: cast_nullable_to_non_nullable
as String,video: null == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,miniature: freezed == miniature ? _self.miniature : miniature // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
