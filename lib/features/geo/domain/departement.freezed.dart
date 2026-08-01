// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Departement {

 int get id; String get nom; String get region; String get district;
/// Create a copy of Departement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartementCopyWith<Departement> get copyWith => _$DepartementCopyWithImpl<Departement>(this as Departement, _$identity);

  /// Serializes this Departement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Departement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.region, region) || other.region == region)&&(identical(other.district, district) || other.district == district));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,region,district);

@override
String toString() {
  return 'Departement(id: $id, nom: $nom, region: $region, district: $district)';
}


}

/// @nodoc
abstract mixin class $DepartementCopyWith<$Res>  {
  factory $DepartementCopyWith(Departement value, $Res Function(Departement) _then) = _$DepartementCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String region, String district
});




}
/// @nodoc
class _$DepartementCopyWithImpl<$Res>
    implements $DepartementCopyWith<$Res> {
  _$DepartementCopyWithImpl(this._self, this._then);

  final Departement _self;
  final $Res Function(Departement) _then;

/// Create a copy of Departement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? region = null,Object? district = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Departement].
extension DepartementPatterns on Departement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Departement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Departement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Departement value)  $default,){
final _that = this;
switch (_that) {
case _Departement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Departement value)?  $default,){
final _that = this;
switch (_that) {
case _Departement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String region,  String district)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Departement() when $default != null:
return $default(_that.id,_that.nom,_that.region,_that.district);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String region,  String district)  $default,) {final _that = this;
switch (_that) {
case _Departement():
return $default(_that.id,_that.nom,_that.region,_that.district);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String region,  String district)?  $default,) {final _that = this;
switch (_that) {
case _Departement() when $default != null:
return $default(_that.id,_that.nom,_that.region,_that.district);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Departement implements Departement {
  const _Departement({required this.id, this.nom = '', this.region = '', this.district = ''});
  factory _Departement.fromJson(Map<String, dynamic> json) => _$DepartementFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String region;
@override@JsonKey() final  String district;

/// Create a copy of Departement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartementCopyWith<_Departement> get copyWith => __$DepartementCopyWithImpl<_Departement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Departement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.region, region) || other.region == region)&&(identical(other.district, district) || other.district == district));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,region,district);

@override
String toString() {
  return 'Departement(id: $id, nom: $nom, region: $region, district: $district)';
}


}

/// @nodoc
abstract mixin class _$DepartementCopyWith<$Res> implements $DepartementCopyWith<$Res> {
  factory _$DepartementCopyWith(_Departement value, $Res Function(_Departement) _then) = __$DepartementCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String region, String district
});




}
/// @nodoc
class __$DepartementCopyWithImpl<$Res>
    implements _$DepartementCopyWith<$Res> {
  __$DepartementCopyWithImpl(this._self, this._then);

  final _Departement _self;
  final $Res Function(_Departement) _then;

/// Create a copy of Departement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? region = null,Object? district = null,}) {
  return _then(_Departement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
