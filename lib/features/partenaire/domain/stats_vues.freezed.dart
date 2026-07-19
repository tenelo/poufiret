// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_vues.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatsArticle {

@JsonKey(name: 'article_id') int get articleId; String get nom; String get slug;@JsonKey(name: 'est_actif') bool get estActif; int get total; int get jour; int get semaine; int get mois;
/// Create a copy of StatsArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsArticleCopyWith<StatsArticle> get copyWith => _$StatsArticleCopyWithImpl<StatsArticle>(this as StatsArticle, _$identity);

  /// Serializes this StatsArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsArticle&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&(identical(other.total, total) || other.total == total)&&(identical(other.jour, jour) || other.jour == jour)&&(identical(other.semaine, semaine) || other.semaine == semaine)&&(identical(other.mois, mois) || other.mois == mois));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,articleId,nom,slug,estActif,total,jour,semaine,mois);

@override
String toString() {
  return 'StatsArticle(articleId: $articleId, nom: $nom, slug: $slug, estActif: $estActif, total: $total, jour: $jour, semaine: $semaine, mois: $mois)';
}


}

/// @nodoc
abstract mixin class $StatsArticleCopyWith<$Res>  {
  factory $StatsArticleCopyWith(StatsArticle value, $Res Function(StatsArticle) _then) = _$StatsArticleCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'article_id') int articleId, String nom, String slug,@JsonKey(name: 'est_actif') bool estActif, int total, int jour, int semaine, int mois
});




}
/// @nodoc
class _$StatsArticleCopyWithImpl<$Res>
    implements $StatsArticleCopyWith<$Res> {
  _$StatsArticleCopyWithImpl(this._self, this._then);

  final StatsArticle _self;
  final $Res Function(StatsArticle) _then;

/// Create a copy of StatsArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? articleId = null,Object? nom = null,Object? slug = null,Object? estActif = null,Object? total = null,Object? jour = null,Object? semaine = null,Object? mois = null,}) {
  return _then(_self.copyWith(
articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,jour: null == jour ? _self.jour : jour // ignore: cast_nullable_to_non_nullable
as int,semaine: null == semaine ? _self.semaine : semaine // ignore: cast_nullable_to_non_nullable
as int,mois: null == mois ? _self.mois : mois // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsArticle].
extension StatsArticlePatterns on StatsArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsArticle value)  $default,){
final _that = this;
switch (_that) {
case _StatsArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsArticle value)?  $default,){
final _that = this;
switch (_that) {
case _StatsArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'article_id')  int articleId,  String nom,  String slug, @JsonKey(name: 'est_actif')  bool estActif,  int total,  int jour,  int semaine,  int mois)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsArticle() when $default != null:
return $default(_that.articleId,_that.nom,_that.slug,_that.estActif,_that.total,_that.jour,_that.semaine,_that.mois);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'article_id')  int articleId,  String nom,  String slug, @JsonKey(name: 'est_actif')  bool estActif,  int total,  int jour,  int semaine,  int mois)  $default,) {final _that = this;
switch (_that) {
case _StatsArticle():
return $default(_that.articleId,_that.nom,_that.slug,_that.estActif,_that.total,_that.jour,_that.semaine,_that.mois);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'article_id')  int articleId,  String nom,  String slug, @JsonKey(name: 'est_actif')  bool estActif,  int total,  int jour,  int semaine,  int mois)?  $default,) {final _that = this;
switch (_that) {
case _StatsArticle() when $default != null:
return $default(_that.articleId,_that.nom,_that.slug,_that.estActif,_that.total,_that.jour,_that.semaine,_that.mois);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatsArticle implements StatsArticle {
  const _StatsArticle({@JsonKey(name: 'article_id') required this.articleId, this.nom = '', this.slug = '', @JsonKey(name: 'est_actif') this.estActif = true, this.total = 0, this.jour = 0, this.semaine = 0, this.mois = 0});
  factory _StatsArticle.fromJson(Map<String, dynamic> json) => _$StatsArticleFromJson(json);

@override@JsonKey(name: 'article_id') final  int articleId;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String slug;
@override@JsonKey(name: 'est_actif') final  bool estActif;
@override@JsonKey() final  int total;
@override@JsonKey() final  int jour;
@override@JsonKey() final  int semaine;
@override@JsonKey() final  int mois;

/// Create a copy of StatsArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsArticleCopyWith<_StatsArticle> get copyWith => __$StatsArticleCopyWithImpl<_StatsArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsArticle&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&(identical(other.total, total) || other.total == total)&&(identical(other.jour, jour) || other.jour == jour)&&(identical(other.semaine, semaine) || other.semaine == semaine)&&(identical(other.mois, mois) || other.mois == mois));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,articleId,nom,slug,estActif,total,jour,semaine,mois);

@override
String toString() {
  return 'StatsArticle(articleId: $articleId, nom: $nom, slug: $slug, estActif: $estActif, total: $total, jour: $jour, semaine: $semaine, mois: $mois)';
}


}

/// @nodoc
abstract mixin class _$StatsArticleCopyWith<$Res> implements $StatsArticleCopyWith<$Res> {
  factory _$StatsArticleCopyWith(_StatsArticle value, $Res Function(_StatsArticle) _then) = __$StatsArticleCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'article_id') int articleId, String nom, String slug,@JsonKey(name: 'est_actif') bool estActif, int total, int jour, int semaine, int mois
});




}
/// @nodoc
class __$StatsArticleCopyWithImpl<$Res>
    implements _$StatsArticleCopyWith<$Res> {
  __$StatsArticleCopyWithImpl(this._self, this._then);

  final _StatsArticle _self;
  final $Res Function(_StatsArticle) _then;

/// Create a copy of StatsArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articleId = null,Object? nom = null,Object? slug = null,Object? estActif = null,Object? total = null,Object? jour = null,Object? semaine = null,Object? mois = null,}) {
  return _then(_StatsArticle(
articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,jour: null == jour ? _self.jour : jour // ignore: cast_nullable_to_non_nullable
as int,semaine: null == semaine ? _self.semaine : semaine // ignore: cast_nullable_to_non_nullable
as int,mois: null == mois ? _self.mois : mois // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StatsVues {

@JsonKey(name: 'total_vues') int get totalVues; List<StatsArticle> get articles;
/// Create a copy of StatsVues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsVuesCopyWith<StatsVues> get copyWith => _$StatsVuesCopyWithImpl<StatsVues>(this as StatsVues, _$identity);

  /// Serializes this StatsVues to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsVues&&(identical(other.totalVues, totalVues) || other.totalVues == totalVues)&&const DeepCollectionEquality().equals(other.articles, articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalVues,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'StatsVues(totalVues: $totalVues, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $StatsVuesCopyWith<$Res>  {
  factory $StatsVuesCopyWith(StatsVues value, $Res Function(StatsVues) _then) = _$StatsVuesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_vues') int totalVues, List<StatsArticle> articles
});




}
/// @nodoc
class _$StatsVuesCopyWithImpl<$Res>
    implements $StatsVuesCopyWith<$Res> {
  _$StatsVuesCopyWithImpl(this._self, this._then);

  final StatsVues _self;
  final $Res Function(StatsVues) _then;

/// Create a copy of StatsVues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalVues = null,Object? articles = null,}) {
  return _then(_self.copyWith(
totalVues: null == totalVues ? _self.totalVues : totalVues // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<StatsArticle>,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsVues].
extension StatsVuesPatterns on StatsVues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsVues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsVues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsVues value)  $default,){
final _that = this;
switch (_that) {
case _StatsVues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsVues value)?  $default,){
final _that = this;
switch (_that) {
case _StatsVues() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_vues')  int totalVues,  List<StatsArticle> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsVues() when $default != null:
return $default(_that.totalVues,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_vues')  int totalVues,  List<StatsArticle> articles)  $default,) {final _that = this;
switch (_that) {
case _StatsVues():
return $default(_that.totalVues,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_vues')  int totalVues,  List<StatsArticle> articles)?  $default,) {final _that = this;
switch (_that) {
case _StatsVues() when $default != null:
return $default(_that.totalVues,_that.articles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatsVues implements StatsVues {
  const _StatsVues({@JsonKey(name: 'total_vues') this.totalVues = 0, final  List<StatsArticle> articles = const <StatsArticle>[]}): _articles = articles;
  factory _StatsVues.fromJson(Map<String, dynamic> json) => _$StatsVuesFromJson(json);

@override@JsonKey(name: 'total_vues') final  int totalVues;
 final  List<StatsArticle> _articles;
@override@JsonKey() List<StatsArticle> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of StatsVues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsVuesCopyWith<_StatsVues> get copyWith => __$StatsVuesCopyWithImpl<_StatsVues>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsVuesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsVues&&(identical(other.totalVues, totalVues) || other.totalVues == totalVues)&&const DeepCollectionEquality().equals(other._articles, _articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalVues,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'StatsVues(totalVues: $totalVues, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$StatsVuesCopyWith<$Res> implements $StatsVuesCopyWith<$Res> {
  factory _$StatsVuesCopyWith(_StatsVues value, $Res Function(_StatsVues) _then) = __$StatsVuesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_vues') int totalVues, List<StatsArticle> articles
});




}
/// @nodoc
class __$StatsVuesCopyWithImpl<$Res>
    implements _$StatsVuesCopyWith<$Res> {
  __$StatsVuesCopyWithImpl(this._self, this._then);

  final _StatsVues _self;
  final $Res Function(_StatsVues) _then;

/// Create a copy of StatsVues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalVues = null,Object? articles = null,}) {
  return _then(_StatsVues(
totalVues: null == totalVues ? _self.totalVues : totalVues // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<StatsArticle>,
  ));
}


}

// dart format on
