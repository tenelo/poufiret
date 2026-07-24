// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ma_categorie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaCategorie {

 int get id; int? get categorie;@JsonKey(name: 'categorie_nom') String get nom;@JsonKey(name: 'categorie_slug') String get slug;@JsonKey(name: 'categorie_icone') String get icone;@JsonKey(name: 'est_principale') bool get estPrincipale;@JsonKey(name: 'image_couverture') String? get imageCouverture;
/// Create a copy of MaCategorie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaCategorieCopyWith<MaCategorie> get copyWith => _$MaCategorieCopyWithImpl<MaCategorie>(this as MaCategorie, _$identity);

  /// Serializes this MaCategorie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaCategorie&&(identical(other.id, id) || other.id == id)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.estPrincipale, estPrincipale) || other.estPrincipale == estPrincipale)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categorie,nom,slug,icone,estPrincipale,imageCouverture);

@override
String toString() {
  return 'MaCategorie(id: $id, categorie: $categorie, nom: $nom, slug: $slug, icone: $icone, estPrincipale: $estPrincipale, imageCouverture: $imageCouverture)';
}


}

/// @nodoc
abstract mixin class $MaCategorieCopyWith<$Res>  {
  factory $MaCategorieCopyWith(MaCategorie value, $Res Function(MaCategorie) _then) = _$MaCategorieCopyWithImpl;
@useResult
$Res call({
 int id, int? categorie,@JsonKey(name: 'categorie_nom') String nom,@JsonKey(name: 'categorie_slug') String slug,@JsonKey(name: 'categorie_icone') String icone,@JsonKey(name: 'est_principale') bool estPrincipale,@JsonKey(name: 'image_couverture') String? imageCouverture
});




}
/// @nodoc
class _$MaCategorieCopyWithImpl<$Res>
    implements $MaCategorieCopyWith<$Res> {
  _$MaCategorieCopyWithImpl(this._self, this._then);

  final MaCategorie _self;
  final $Res Function(MaCategorie) _then;

/// Create a copy of MaCategorie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categorie = freezed,Object? nom = null,Object? slug = null,Object? icone = null,Object? estPrincipale = null,Object? imageCouverture = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,estPrincipale: null == estPrincipale ? _self.estPrincipale : estPrincipale // ignore: cast_nullable_to_non_nullable
as bool,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaCategorie].
extension MaCategoriePatterns on MaCategorie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaCategorie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaCategorie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaCategorie value)  $default,){
final _that = this;
switch (_that) {
case _MaCategorie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaCategorie value)?  $default,){
final _that = this;
switch (_that) {
case _MaCategorie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? categorie, @JsonKey(name: 'categorie_nom')  String nom, @JsonKey(name: 'categorie_slug')  String slug, @JsonKey(name: 'categorie_icone')  String icone, @JsonKey(name: 'est_principale')  bool estPrincipale, @JsonKey(name: 'image_couverture')  String? imageCouverture)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaCategorie() when $default != null:
return $default(_that.id,_that.categorie,_that.nom,_that.slug,_that.icone,_that.estPrincipale,_that.imageCouverture);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? categorie, @JsonKey(name: 'categorie_nom')  String nom, @JsonKey(name: 'categorie_slug')  String slug, @JsonKey(name: 'categorie_icone')  String icone, @JsonKey(name: 'est_principale')  bool estPrincipale, @JsonKey(name: 'image_couverture')  String? imageCouverture)  $default,) {final _that = this;
switch (_that) {
case _MaCategorie():
return $default(_that.id,_that.categorie,_that.nom,_that.slug,_that.icone,_that.estPrincipale,_that.imageCouverture);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? categorie, @JsonKey(name: 'categorie_nom')  String nom, @JsonKey(name: 'categorie_slug')  String slug, @JsonKey(name: 'categorie_icone')  String icone, @JsonKey(name: 'est_principale')  bool estPrincipale, @JsonKey(name: 'image_couverture')  String? imageCouverture)?  $default,) {final _that = this;
switch (_that) {
case _MaCategorie() when $default != null:
return $default(_that.id,_that.categorie,_that.nom,_that.slug,_that.icone,_that.estPrincipale,_that.imageCouverture);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaCategorie extends MaCategorie {
  const _MaCategorie({required this.id, this.categorie, @JsonKey(name: 'categorie_nom') this.nom = '', @JsonKey(name: 'categorie_slug') this.slug = '', @JsonKey(name: 'categorie_icone') this.icone = '', @JsonKey(name: 'est_principale') this.estPrincipale = false, @JsonKey(name: 'image_couverture') this.imageCouverture}): super._();
  factory _MaCategorie.fromJson(Map<String, dynamic> json) => _$MaCategorieFromJson(json);

@override final  int id;
@override final  int? categorie;
@override@JsonKey(name: 'categorie_nom') final  String nom;
@override@JsonKey(name: 'categorie_slug') final  String slug;
@override@JsonKey(name: 'categorie_icone') final  String icone;
@override@JsonKey(name: 'est_principale') final  bool estPrincipale;
@override@JsonKey(name: 'image_couverture') final  String? imageCouverture;

/// Create a copy of MaCategorie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaCategorieCopyWith<_MaCategorie> get copyWith => __$MaCategorieCopyWithImpl<_MaCategorie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaCategorieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaCategorie&&(identical(other.id, id) || other.id == id)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.estPrincipale, estPrincipale) || other.estPrincipale == estPrincipale)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categorie,nom,slug,icone,estPrincipale,imageCouverture);

@override
String toString() {
  return 'MaCategorie(id: $id, categorie: $categorie, nom: $nom, slug: $slug, icone: $icone, estPrincipale: $estPrincipale, imageCouverture: $imageCouverture)';
}


}

/// @nodoc
abstract mixin class _$MaCategorieCopyWith<$Res> implements $MaCategorieCopyWith<$Res> {
  factory _$MaCategorieCopyWith(_MaCategorie value, $Res Function(_MaCategorie) _then) = __$MaCategorieCopyWithImpl;
@override @useResult
$Res call({
 int id, int? categorie,@JsonKey(name: 'categorie_nom') String nom,@JsonKey(name: 'categorie_slug') String slug,@JsonKey(name: 'categorie_icone') String icone,@JsonKey(name: 'est_principale') bool estPrincipale,@JsonKey(name: 'image_couverture') String? imageCouverture
});




}
/// @nodoc
class __$MaCategorieCopyWithImpl<$Res>
    implements _$MaCategorieCopyWith<$Res> {
  __$MaCategorieCopyWithImpl(this._self, this._then);

  final _MaCategorie _self;
  final $Res Function(_MaCategorie) _then;

/// Create a copy of MaCategorie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categorie = freezed,Object? nom = null,Object? slug = null,Object? icone = null,Object? estPrincipale = null,Object? imageCouverture = freezed,}) {
  return _then(_MaCategorie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,estPrincipale: null == estPrincipale ? _self.estPrincipale : estPrincipale // ignore: cast_nullable_to_non_nullable
as bool,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
