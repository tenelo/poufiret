// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partenaire_categorie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartenaireCategorie {

 int get id;@JsonKey(name: 'nom_commerce') String get nomCommerce; String get description; String get logo;@JsonKey(name: 'photo_couverture') String get photoCouverture;
/// Create a copy of PartenaireCategorie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartenaireCategorieCopyWith<PartenaireCategorie> get copyWith => _$PartenaireCategorieCopyWithImpl<PartenaireCategorie>(this as PartenaireCategorie, _$identity);

  /// Serializes this PartenaireCategorie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartenaireCategorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,description,logo,photoCouverture);

@override
String toString() {
  return 'PartenaireCategorie(id: $id, nomCommerce: $nomCommerce, description: $description, logo: $logo, photoCouverture: $photoCouverture)';
}


}

/// @nodoc
abstract mixin class $PartenaireCategorieCopyWith<$Res>  {
  factory $PartenaireCategorieCopyWith(PartenaireCategorie value, $Res Function(PartenaireCategorie) _then) = _$PartenaireCategorieCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce, String description, String logo,@JsonKey(name: 'photo_couverture') String photoCouverture
});




}
/// @nodoc
class _$PartenaireCategorieCopyWithImpl<$Res>
    implements $PartenaireCategorieCopyWith<$Res> {
  _$PartenaireCategorieCopyWithImpl(this._self, this._then);

  final PartenaireCategorie _self;
  final $Res Function(PartenaireCategorie) _then;

/// Create a copy of PartenaireCategorie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nomCommerce = null,Object? description = null,Object? logo = null,Object? photoCouverture = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,photoCouverture: null == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PartenaireCategorie].
extension PartenaireCategoriePatterns on PartenaireCategorie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartenaireCategorie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartenaireCategorie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartenaireCategorie value)  $default,){
final _that = this;
switch (_that) {
case _PartenaireCategorie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartenaireCategorie value)?  $default,){
final _that = this;
switch (_that) {
case _PartenaireCategorie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartenaireCategorie() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture)  $default,) {final _that = this;
switch (_that) {
case _PartenaireCategorie():
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture)?  $default,) {final _that = this;
switch (_that) {
case _PartenaireCategorie() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartenaireCategorie implements PartenaireCategorie {
  const _PartenaireCategorie({required this.id, @JsonKey(name: 'nom_commerce') this.nomCommerce = '', this.description = '', this.logo = '', @JsonKey(name: 'photo_couverture') this.photoCouverture = ''});
  factory _PartenaireCategorie.fromJson(Map<String, dynamic> json) => _$PartenaireCategorieFromJson(json);

@override final  int id;
@override@JsonKey(name: 'nom_commerce') final  String nomCommerce;
@override@JsonKey() final  String description;
@override@JsonKey() final  String logo;
@override@JsonKey(name: 'photo_couverture') final  String photoCouverture;

/// Create a copy of PartenaireCategorie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartenaireCategorieCopyWith<_PartenaireCategorie> get copyWith => __$PartenaireCategorieCopyWithImpl<_PartenaireCategorie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartenaireCategorieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartenaireCategorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,description,logo,photoCouverture);

@override
String toString() {
  return 'PartenaireCategorie(id: $id, nomCommerce: $nomCommerce, description: $description, logo: $logo, photoCouverture: $photoCouverture)';
}


}

/// @nodoc
abstract mixin class _$PartenaireCategorieCopyWith<$Res> implements $PartenaireCategorieCopyWith<$Res> {
  factory _$PartenaireCategorieCopyWith(_PartenaireCategorie value, $Res Function(_PartenaireCategorie) _then) = __$PartenaireCategorieCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce, String description, String logo,@JsonKey(name: 'photo_couverture') String photoCouverture
});




}
/// @nodoc
class __$PartenaireCategorieCopyWithImpl<$Res>
    implements _$PartenaireCategorieCopyWith<$Res> {
  __$PartenaireCategorieCopyWithImpl(this._self, this._then);

  final _PartenaireCategorie _self;
  final $Res Function(_PartenaireCategorie) _then;

/// Create a copy of PartenaireCategorie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nomCommerce = null,Object? description = null,Object? logo = null,Object? photoCouverture = null,}) {
  return _then(_PartenaireCategorie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,photoCouverture: null == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
