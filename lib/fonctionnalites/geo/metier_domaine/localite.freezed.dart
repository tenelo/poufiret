// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Localite {

 int get id; String get nom;
/// Create a copy of Localite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaliteCopyWith<Localite> get copyWith => _$LocaliteCopyWithImpl<Localite>(this as Localite, _$identity);

  /// Serializes this Localite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Localite&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom);

@override
String toString() {
  return 'Localite(id: $id, nom: $nom)';
}


}

/// @nodoc
abstract mixin class $LocaliteCopyWith<$Res>  {
  factory $LocaliteCopyWith(Localite value, $Res Function(Localite) _then) = _$LocaliteCopyWithImpl;
@useResult
$Res call({
 int id, String nom
});




}
/// @nodoc
class _$LocaliteCopyWithImpl<$Res>
    implements $LocaliteCopyWith<$Res> {
  _$LocaliteCopyWithImpl(this._self, this._then);

  final Localite _self;
  final $Res Function(Localite) _then;

/// Create a copy of Localite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Localite].
extension LocalitePatterns on Localite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Localite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Localite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Localite value)  $default,){
final _that = this;
switch (_that) {
case _Localite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Localite value)?  $default,){
final _that = this;
switch (_that) {
case _Localite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Localite() when $default != null:
return $default(_that.id,_that.nom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom)  $default,) {final _that = this;
switch (_that) {
case _Localite():
return $default(_that.id,_that.nom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom)?  $default,) {final _that = this;
switch (_that) {
case _Localite() when $default != null:
return $default(_that.id,_that.nom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Localite implements Localite {
  const _Localite({required this.id, this.nom = ''});
  factory _Localite.fromJson(Map<String, dynamic> json) => _$LocaliteFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;

/// Create a copy of Localite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocaliteCopyWith<_Localite> get copyWith => __$LocaliteCopyWithImpl<_Localite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocaliteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Localite&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom);

@override
String toString() {
  return 'Localite(id: $id, nom: $nom)';
}


}

/// @nodoc
abstract mixin class _$LocaliteCopyWith<$Res> implements $LocaliteCopyWith<$Res> {
  factory _$LocaliteCopyWith(_Localite value, $Res Function(_Localite) _then) = __$LocaliteCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom
});




}
/// @nodoc
class __$LocaliteCopyWithImpl<$Res>
    implements _$LocaliteCopyWith<$Res> {
  __$LocaliteCopyWithImpl(this._self, this._then);

  final _Localite _self;
  final $Res Function(_Localite) _then;

/// Create a copy of Localite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,}) {
  return _then(_Localite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
