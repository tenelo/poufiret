// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livraison_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GpsPoint {

 double? get latitude; double? get longitude;
/// Create a copy of GpsPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpsPointCopyWith<GpsPoint> get copyWith => _$GpsPointCopyWithImpl<GpsPoint>(this as GpsPoint, _$identity);

  /// Serializes this GpsPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsPoint&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'GpsPoint(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $GpsPointCopyWith<$Res>  {
  factory $GpsPointCopyWith(GpsPoint value, $Res Function(GpsPoint) _then) = _$GpsPointCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude
});




}
/// @nodoc
class _$GpsPointCopyWithImpl<$Res>
    implements $GpsPointCopyWith<$Res> {
  _$GpsPointCopyWithImpl(this._self, this._then);

  final GpsPoint _self;
  final $Res Function(GpsPoint) _then;

/// Create a copy of GpsPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GpsPoint].
extension GpsPointPatterns on GpsPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GpsPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GpsPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GpsPoint value)  $default,){
final _that = this;
switch (_that) {
case _GpsPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GpsPoint value)?  $default,){
final _that = this;
switch (_that) {
case _GpsPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GpsPoint() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _GpsPoint():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _GpsPoint() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GpsPoint implements GpsPoint {
  const _GpsPoint({this.latitude, this.longitude});
  factory _GpsPoint.fromJson(Map<String, dynamic> json) => _$GpsPointFromJson(json);

@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of GpsPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GpsPointCopyWith<_GpsPoint> get copyWith => __$GpsPointCopyWithImpl<_GpsPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GpsPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GpsPoint&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'GpsPoint(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$GpsPointCopyWith<$Res> implements $GpsPointCopyWith<$Res> {
  factory _$GpsPointCopyWith(_GpsPoint value, $Res Function(_GpsPoint) _then) = __$GpsPointCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude
});




}
/// @nodoc
class __$GpsPointCopyWithImpl<$Res>
    implements _$GpsPointCopyWith<$Res> {
  __$GpsPointCopyWithImpl(this._self, this._then);

  final _GpsPoint _self;
  final $Res Function(_GpsPoint) _then;

/// Create a copy of GpsPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_GpsPoint(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$PointLivraison {

 String get quartier;@JsonKey(name: 'nom_contact') String get nomContact;@JsonKey(name: 'telephone_contact') String get telephoneContact; GpsPoint? get gps;
/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointLivraisonCopyWith<PointLivraison> get copyWith => _$PointLivraisonCopyWithImpl<PointLivraison>(this as PointLivraison, _$identity);

  /// Serializes this PointLivraison to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointLivraison&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.nomContact, nomContact) || other.nomContact == nomContact)&&(identical(other.telephoneContact, telephoneContact) || other.telephoneContact == telephoneContact)&&(identical(other.gps, gps) || other.gps == gps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quartier,nomContact,telephoneContact,gps);

@override
String toString() {
  return 'PointLivraison(quartier: $quartier, nomContact: $nomContact, telephoneContact: $telephoneContact, gps: $gps)';
}


}

/// @nodoc
abstract mixin class $PointLivraisonCopyWith<$Res>  {
  factory $PointLivraisonCopyWith(PointLivraison value, $Res Function(PointLivraison) _then) = _$PointLivraisonCopyWithImpl;
@useResult
$Res call({
 String quartier,@JsonKey(name: 'nom_contact') String nomContact,@JsonKey(name: 'telephone_contact') String telephoneContact, GpsPoint? gps
});


$GpsPointCopyWith<$Res>? get gps;

}
/// @nodoc
class _$PointLivraisonCopyWithImpl<$Res>
    implements $PointLivraisonCopyWith<$Res> {
  _$PointLivraisonCopyWithImpl(this._self, this._then);

  final PointLivraison _self;
  final $Res Function(PointLivraison) _then;

/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quartier = null,Object? nomContact = null,Object? telephoneContact = null,Object? gps = freezed,}) {
  return _then(_self.copyWith(
quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,nomContact: null == nomContact ? _self.nomContact : nomContact // ignore: cast_nullable_to_non_nullable
as String,telephoneContact: null == telephoneContact ? _self.telephoneContact : telephoneContact // ignore: cast_nullable_to_non_nullable
as String,gps: freezed == gps ? _self.gps : gps // ignore: cast_nullable_to_non_nullable
as GpsPoint?,
  ));
}
/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsPointCopyWith<$Res>? get gps {
    if (_self.gps == null) {
    return null;
  }

  return $GpsPointCopyWith<$Res>(_self.gps!, (value) {
    return _then(_self.copyWith(gps: value));
  });
}
}


/// Adds pattern-matching-related methods to [PointLivraison].
extension PointLivraisonPatterns on PointLivraison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointLivraison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointLivraison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointLivraison value)  $default,){
final _that = this;
switch (_that) {
case _PointLivraison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointLivraison value)?  $default,){
final _that = this;
switch (_that) {
case _PointLivraison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quartier, @JsonKey(name: 'nom_contact')  String nomContact, @JsonKey(name: 'telephone_contact')  String telephoneContact,  GpsPoint? gps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointLivraison() when $default != null:
return $default(_that.quartier,_that.nomContact,_that.telephoneContact,_that.gps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quartier, @JsonKey(name: 'nom_contact')  String nomContact, @JsonKey(name: 'telephone_contact')  String telephoneContact,  GpsPoint? gps)  $default,) {final _that = this;
switch (_that) {
case _PointLivraison():
return $default(_that.quartier,_that.nomContact,_that.telephoneContact,_that.gps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quartier, @JsonKey(name: 'nom_contact')  String nomContact, @JsonKey(name: 'telephone_contact')  String telephoneContact,  GpsPoint? gps)?  $default,) {final _that = this;
switch (_that) {
case _PointLivraison() when $default != null:
return $default(_that.quartier,_that.nomContact,_that.telephoneContact,_that.gps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointLivraison implements PointLivraison {
  const _PointLivraison({this.quartier = '', @JsonKey(name: 'nom_contact') this.nomContact = '', @JsonKey(name: 'telephone_contact') this.telephoneContact = '', this.gps});
  factory _PointLivraison.fromJson(Map<String, dynamic> json) => _$PointLivraisonFromJson(json);

@override@JsonKey() final  String quartier;
@override@JsonKey(name: 'nom_contact') final  String nomContact;
@override@JsonKey(name: 'telephone_contact') final  String telephoneContact;
@override final  GpsPoint? gps;

/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointLivraisonCopyWith<_PointLivraison> get copyWith => __$PointLivraisonCopyWithImpl<_PointLivraison>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointLivraisonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointLivraison&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.nomContact, nomContact) || other.nomContact == nomContact)&&(identical(other.telephoneContact, telephoneContact) || other.telephoneContact == telephoneContact)&&(identical(other.gps, gps) || other.gps == gps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quartier,nomContact,telephoneContact,gps);

@override
String toString() {
  return 'PointLivraison(quartier: $quartier, nomContact: $nomContact, telephoneContact: $telephoneContact, gps: $gps)';
}


}

/// @nodoc
abstract mixin class _$PointLivraisonCopyWith<$Res> implements $PointLivraisonCopyWith<$Res> {
  factory _$PointLivraisonCopyWith(_PointLivraison value, $Res Function(_PointLivraison) _then) = __$PointLivraisonCopyWithImpl;
@override @useResult
$Res call({
 String quartier,@JsonKey(name: 'nom_contact') String nomContact,@JsonKey(name: 'telephone_contact') String telephoneContact, GpsPoint? gps
});


@override $GpsPointCopyWith<$Res>? get gps;

}
/// @nodoc
class __$PointLivraisonCopyWithImpl<$Res>
    implements _$PointLivraisonCopyWith<$Res> {
  __$PointLivraisonCopyWithImpl(this._self, this._then);

  final _PointLivraison _self;
  final $Res Function(_PointLivraison) _then;

/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quartier = null,Object? nomContact = null,Object? telephoneContact = null,Object? gps = freezed,}) {
  return _then(_PointLivraison(
quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,nomContact: null == nomContact ? _self.nomContact : nomContact // ignore: cast_nullable_to_non_nullable
as String,telephoneContact: null == telephoneContact ? _self.telephoneContact : telephoneContact // ignore: cast_nullable_to_non_nullable
as String,gps: freezed == gps ? _self.gps : gps // ignore: cast_nullable_to_non_nullable
as GpsPoint?,
  ));
}

/// Create a copy of PointLivraison
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GpsPointCopyWith<$Res>? get gps {
    if (_self.gps == null) {
    return null;
  }

  return $GpsPointCopyWith<$Res>(_self.gps!, (value) {
    return _then(_self.copyWith(gps: value));
  });
}
}


/// @nodoc
mixin _$LivreurPosition {

 double? get latitude; double? get longitude;@JsonKey(name: 'type_vehicule') String get typeVehicule;@JsonKey(name: 'maj_le') String? get majLe;
/// Create a copy of LivreurPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivreurPositionCopyWith<LivreurPosition> get copyWith => _$LivreurPositionCopyWithImpl<LivreurPosition>(this as LivreurPosition, _$identity);

  /// Serializes this LivreurPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivreurPosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.typeVehicule, typeVehicule) || other.typeVehicule == typeVehicule)&&(identical(other.majLe, majLe) || other.majLe == majLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,typeVehicule,majLe);

@override
String toString() {
  return 'LivreurPosition(latitude: $latitude, longitude: $longitude, typeVehicule: $typeVehicule, majLe: $majLe)';
}


}

/// @nodoc
abstract mixin class $LivreurPositionCopyWith<$Res>  {
  factory $LivreurPositionCopyWith(LivreurPosition value, $Res Function(LivreurPosition) _then) = _$LivreurPositionCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude,@JsonKey(name: 'type_vehicule') String typeVehicule,@JsonKey(name: 'maj_le') String? majLe
});




}
/// @nodoc
class _$LivreurPositionCopyWithImpl<$Res>
    implements $LivreurPositionCopyWith<$Res> {
  _$LivreurPositionCopyWithImpl(this._self, this._then);

  final LivreurPosition _self;
  final $Res Function(LivreurPosition) _then;

/// Create a copy of LivreurPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? typeVehicule = null,Object? majLe = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,typeVehicule: null == typeVehicule ? _self.typeVehicule : typeVehicule // ignore: cast_nullable_to_non_nullable
as String,majLe: freezed == majLe ? _self.majLe : majLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivreurPosition].
extension LivreurPositionPatterns on LivreurPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivreurPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivreurPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivreurPosition value)  $default,){
final _that = this;
switch (_that) {
case _LivreurPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivreurPosition value)?  $default,){
final _that = this;
switch (_that) {
case _LivreurPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude, @JsonKey(name: 'type_vehicule')  String typeVehicule, @JsonKey(name: 'maj_le')  String? majLe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivreurPosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.typeVehicule,_that.majLe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude, @JsonKey(name: 'type_vehicule')  String typeVehicule, @JsonKey(name: 'maj_le')  String? majLe)  $default,) {final _that = this;
switch (_that) {
case _LivreurPosition():
return $default(_that.latitude,_that.longitude,_that.typeVehicule,_that.majLe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude, @JsonKey(name: 'type_vehicule')  String typeVehicule, @JsonKey(name: 'maj_le')  String? majLe)?  $default,) {final _that = this;
switch (_that) {
case _LivreurPosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.typeVehicule,_that.majLe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivreurPosition implements LivreurPosition {
  const _LivreurPosition({this.latitude, this.longitude, @JsonKey(name: 'type_vehicule') this.typeVehicule = 'moto', @JsonKey(name: 'maj_le') this.majLe});
  factory _LivreurPosition.fromJson(Map<String, dynamic> json) => _$LivreurPositionFromJson(json);

@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'type_vehicule') final  String typeVehicule;
@override@JsonKey(name: 'maj_le') final  String? majLe;

/// Create a copy of LivreurPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivreurPositionCopyWith<_LivreurPosition> get copyWith => __$LivreurPositionCopyWithImpl<_LivreurPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivreurPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivreurPosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.typeVehicule, typeVehicule) || other.typeVehicule == typeVehicule)&&(identical(other.majLe, majLe) || other.majLe == majLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,typeVehicule,majLe);

@override
String toString() {
  return 'LivreurPosition(latitude: $latitude, longitude: $longitude, typeVehicule: $typeVehicule, majLe: $majLe)';
}


}

/// @nodoc
abstract mixin class _$LivreurPositionCopyWith<$Res> implements $LivreurPositionCopyWith<$Res> {
  factory _$LivreurPositionCopyWith(_LivreurPosition value, $Res Function(_LivreurPosition) _then) = __$LivreurPositionCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude,@JsonKey(name: 'type_vehicule') String typeVehicule,@JsonKey(name: 'maj_le') String? majLe
});




}
/// @nodoc
class __$LivreurPositionCopyWithImpl<$Res>
    implements _$LivreurPositionCopyWith<$Res> {
  __$LivreurPositionCopyWithImpl(this._self, this._then);

  final _LivreurPosition _self;
  final $Res Function(_LivreurPosition) _then;

/// Create a copy of LivreurPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? typeVehicule = null,Object? majLe = freezed,}) {
  return _then(_LivreurPosition(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,typeVehicule: null == typeVehicule ? _self.typeVehicule : typeVehicule // ignore: cast_nullable_to_non_nullable
as String,majLe: freezed == majLe ? _self.majLe : majLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Course {

 String get id; String get numero; String get statut; String get ville;@JsonKey(name: 'description_colis') String get descriptionColis;@JsonKey(fromJson: _versInt) int get prix;@JsonKey(name: 'point_a') PointLivraison get pointA;@JsonKey(name: 'point_b') PointLivraison get pointB; String? get livreur;@JsonKey(name: 'livreur_position') LivreurPosition? get livreurPosition;@JsonKey(name: 'cree_le') String? get creeLe;
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCopyWith<Course> get copyWith => _$CourseCopyWithImpl<Course>(this as Course, _$identity);

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Course&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.descriptionColis, descriptionColis) || other.descriptionColis == descriptionColis)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.pointA, pointA) || other.pointA == pointA)&&(identical(other.pointB, pointB) || other.pointB == pointB)&&(identical(other.livreur, livreur) || other.livreur == livreur)&&(identical(other.livreurPosition, livreurPosition) || other.livreurPosition == livreurPosition)&&(identical(other.creeLe, creeLe) || other.creeLe == creeLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,statut,ville,descriptionColis,prix,pointA,pointB,livreur,livreurPosition,creeLe);

@override
String toString() {
  return 'Course(id: $id, numero: $numero, statut: $statut, ville: $ville, descriptionColis: $descriptionColis, prix: $prix, pointA: $pointA, pointB: $pointB, livreur: $livreur, livreurPosition: $livreurPosition, creeLe: $creeLe)';
}


}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res>  {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) = _$CourseCopyWithImpl;
@useResult
$Res call({
 String id, String numero, String statut, String ville,@JsonKey(name: 'description_colis') String descriptionColis,@JsonKey(fromJson: _versInt) int prix,@JsonKey(name: 'point_a') PointLivraison pointA,@JsonKey(name: 'point_b') PointLivraison pointB, String? livreur,@JsonKey(name: 'livreur_position') LivreurPosition? livreurPosition,@JsonKey(name: 'cree_le') String? creeLe
});


$PointLivraisonCopyWith<$Res> get pointA;$PointLivraisonCopyWith<$Res> get pointB;$LivreurPositionCopyWith<$Res>? get livreurPosition;

}
/// @nodoc
class _$CourseCopyWithImpl<$Res>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? numero = null,Object? statut = null,Object? ville = null,Object? descriptionColis = null,Object? prix = null,Object? pointA = null,Object? pointB = null,Object? livreur = freezed,Object? livreurPosition = freezed,Object? creeLe = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,descriptionColis: null == descriptionColis ? _self.descriptionColis : descriptionColis // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,pointA: null == pointA ? _self.pointA : pointA // ignore: cast_nullable_to_non_nullable
as PointLivraison,pointB: null == pointB ? _self.pointB : pointB // ignore: cast_nullable_to_non_nullable
as PointLivraison,livreur: freezed == livreur ? _self.livreur : livreur // ignore: cast_nullable_to_non_nullable
as String?,livreurPosition: freezed == livreurPosition ? _self.livreurPosition : livreurPosition // ignore: cast_nullable_to_non_nullable
as LivreurPosition?,creeLe: freezed == creeLe ? _self.creeLe : creeLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointLivraisonCopyWith<$Res> get pointA {
  
  return $PointLivraisonCopyWith<$Res>(_self.pointA, (value) {
    return _then(_self.copyWith(pointA: value));
  });
}/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointLivraisonCopyWith<$Res> get pointB {
  
  return $PointLivraisonCopyWith<$Res>(_self.pointB, (value) {
    return _then(_self.copyWith(pointB: value));
  });
}/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivreurPositionCopyWith<$Res>? get livreurPosition {
    if (_self.livreurPosition == null) {
    return null;
  }

  return $LivreurPositionCopyWith<$Res>(_self.livreurPosition!, (value) {
    return _then(_self.copyWith(livreurPosition: value));
  });
}
}


/// Adds pattern-matching-related methods to [Course].
extension CoursePatterns on Course {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Course value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Course value)  $default,){
final _that = this;
switch (_that) {
case _Course():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Course value)?  $default,){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String numero,  String statut,  String ville, @JsonKey(name: 'description_colis')  String descriptionColis, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'point_a')  PointLivraison pointA, @JsonKey(name: 'point_b')  PointLivraison pointB,  String? livreur, @JsonKey(name: 'livreur_position')  LivreurPosition? livreurPosition, @JsonKey(name: 'cree_le')  String? creeLe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.numero,_that.statut,_that.ville,_that.descriptionColis,_that.prix,_that.pointA,_that.pointB,_that.livreur,_that.livreurPosition,_that.creeLe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String numero,  String statut,  String ville, @JsonKey(name: 'description_colis')  String descriptionColis, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'point_a')  PointLivraison pointA, @JsonKey(name: 'point_b')  PointLivraison pointB,  String? livreur, @JsonKey(name: 'livreur_position')  LivreurPosition? livreurPosition, @JsonKey(name: 'cree_le')  String? creeLe)  $default,) {final _that = this;
switch (_that) {
case _Course():
return $default(_that.id,_that.numero,_that.statut,_that.ville,_that.descriptionColis,_that.prix,_that.pointA,_that.pointB,_that.livreur,_that.livreurPosition,_that.creeLe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String numero,  String statut,  String ville, @JsonKey(name: 'description_colis')  String descriptionColis, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'point_a')  PointLivraison pointA, @JsonKey(name: 'point_b')  PointLivraison pointB,  String? livreur, @JsonKey(name: 'livreur_position')  LivreurPosition? livreurPosition, @JsonKey(name: 'cree_le')  String? creeLe)?  $default,) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.numero,_that.statut,_that.ville,_that.descriptionColis,_that.prix,_that.pointA,_that.pointB,_that.livreur,_that.livreurPosition,_that.creeLe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Course implements Course {
  const _Course({this.id = '', this.numero = '', this.statut = 'demandee', this.ville = '', @JsonKey(name: 'description_colis') this.descriptionColis = '', @JsonKey(fromJson: _versInt) this.prix = 0, @JsonKey(name: 'point_a') required this.pointA, @JsonKey(name: 'point_b') required this.pointB, this.livreur, @JsonKey(name: 'livreur_position') this.livreurPosition, @JsonKey(name: 'cree_le') this.creeLe});
  factory _Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String numero;
@override@JsonKey() final  String statut;
@override@JsonKey() final  String ville;
@override@JsonKey(name: 'description_colis') final  String descriptionColis;
@override@JsonKey(fromJson: _versInt) final  int prix;
@override@JsonKey(name: 'point_a') final  PointLivraison pointA;
@override@JsonKey(name: 'point_b') final  PointLivraison pointB;
@override final  String? livreur;
@override@JsonKey(name: 'livreur_position') final  LivreurPosition? livreurPosition;
@override@JsonKey(name: 'cree_le') final  String? creeLe;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCopyWith<_Course> get copyWith => __$CourseCopyWithImpl<_Course>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Course&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.descriptionColis, descriptionColis) || other.descriptionColis == descriptionColis)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.pointA, pointA) || other.pointA == pointA)&&(identical(other.pointB, pointB) || other.pointB == pointB)&&(identical(other.livreur, livreur) || other.livreur == livreur)&&(identical(other.livreurPosition, livreurPosition) || other.livreurPosition == livreurPosition)&&(identical(other.creeLe, creeLe) || other.creeLe == creeLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,statut,ville,descriptionColis,prix,pointA,pointB,livreur,livreurPosition,creeLe);

@override
String toString() {
  return 'Course(id: $id, numero: $numero, statut: $statut, ville: $ville, descriptionColis: $descriptionColis, prix: $prix, pointA: $pointA, pointB: $pointB, livreur: $livreur, livreurPosition: $livreurPosition, creeLe: $creeLe)';
}


}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) = __$CourseCopyWithImpl;
@override @useResult
$Res call({
 String id, String numero, String statut, String ville,@JsonKey(name: 'description_colis') String descriptionColis,@JsonKey(fromJson: _versInt) int prix,@JsonKey(name: 'point_a') PointLivraison pointA,@JsonKey(name: 'point_b') PointLivraison pointB, String? livreur,@JsonKey(name: 'livreur_position') LivreurPosition? livreurPosition,@JsonKey(name: 'cree_le') String? creeLe
});


@override $PointLivraisonCopyWith<$Res> get pointA;@override $PointLivraisonCopyWith<$Res> get pointB;@override $LivreurPositionCopyWith<$Res>? get livreurPosition;

}
/// @nodoc
class __$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? numero = null,Object? statut = null,Object? ville = null,Object? descriptionColis = null,Object? prix = null,Object? pointA = null,Object? pointB = null,Object? livreur = freezed,Object? livreurPosition = freezed,Object? creeLe = freezed,}) {
  return _then(_Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,descriptionColis: null == descriptionColis ? _self.descriptionColis : descriptionColis // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,pointA: null == pointA ? _self.pointA : pointA // ignore: cast_nullable_to_non_nullable
as PointLivraison,pointB: null == pointB ? _self.pointB : pointB // ignore: cast_nullable_to_non_nullable
as PointLivraison,livreur: freezed == livreur ? _self.livreur : livreur // ignore: cast_nullable_to_non_nullable
as String?,livreurPosition: freezed == livreurPosition ? _self.livreurPosition : livreurPosition // ignore: cast_nullable_to_non_nullable
as LivreurPosition?,creeLe: freezed == creeLe ? _self.creeLe : creeLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointLivraisonCopyWith<$Res> get pointA {
  
  return $PointLivraisonCopyWith<$Res>(_self.pointA, (value) {
    return _then(_self.copyWith(pointA: value));
  });
}/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointLivraisonCopyWith<$Res> get pointB {
  
  return $PointLivraisonCopyWith<$Res>(_self.pointB, (value) {
    return _then(_self.copyWith(pointB: value));
  });
}/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivreurPositionCopyWith<$Res>? get livreurPosition {
    if (_self.livreurPosition == null) {
    return null;
  }

  return $LivreurPositionCopyWith<$Res>(_self.livreurPosition!, (value) {
    return _then(_self.copyWith(livreurPosition: value));
  });
}
}


/// @nodoc
mixin _$ResultatCreationCourse {

 Course get course; bool get assigne; String get message;
/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultatCreationCourseCopyWith<ResultatCreationCourse> get copyWith => _$ResultatCreationCourseCopyWithImpl<ResultatCreationCourse>(this as ResultatCreationCourse, _$identity);

  /// Serializes this ResultatCreationCourse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultatCreationCourse&&(identical(other.course, course) || other.course == course)&&(identical(other.assigne, assigne) || other.assigne == assigne)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,course,assigne,message);

@override
String toString() {
  return 'ResultatCreationCourse(course: $course, assigne: $assigne, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResultatCreationCourseCopyWith<$Res>  {
  factory $ResultatCreationCourseCopyWith(ResultatCreationCourse value, $Res Function(ResultatCreationCourse) _then) = _$ResultatCreationCourseCopyWithImpl;
@useResult
$Res call({
 Course course, bool assigne, String message
});


$CourseCopyWith<$Res> get course;

}
/// @nodoc
class _$ResultatCreationCourseCopyWithImpl<$Res>
    implements $ResultatCreationCourseCopyWith<$Res> {
  _$ResultatCreationCourseCopyWithImpl(this._self, this._then);

  final ResultatCreationCourse _self;
  final $Res Function(ResultatCreationCourse) _then;

/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? course = null,Object? assigne = null,Object? message = null,}) {
  return _then(_self.copyWith(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course,assigne: null == assigne ? _self.assigne : assigne // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res> get course {
  
  return $CourseCopyWith<$Res>(_self.course, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResultatCreationCourse].
extension ResultatCreationCoursePatterns on ResultatCreationCourse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultatCreationCourse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultatCreationCourse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultatCreationCourse value)  $default,){
final _that = this;
switch (_that) {
case _ResultatCreationCourse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultatCreationCourse value)?  $default,){
final _that = this;
switch (_that) {
case _ResultatCreationCourse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Course course,  bool assigne,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultatCreationCourse() when $default != null:
return $default(_that.course,_that.assigne,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Course course,  bool assigne,  String message)  $default,) {final _that = this;
switch (_that) {
case _ResultatCreationCourse():
return $default(_that.course,_that.assigne,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Course course,  bool assigne,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ResultatCreationCourse() when $default != null:
return $default(_that.course,_that.assigne,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResultatCreationCourse implements ResultatCreationCourse {
  const _ResultatCreationCourse({required this.course, this.assigne = false, this.message = ''});
  factory _ResultatCreationCourse.fromJson(Map<String, dynamic> json) => _$ResultatCreationCourseFromJson(json);

@override final  Course course;
@override@JsonKey() final  bool assigne;
@override@JsonKey() final  String message;

/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultatCreationCourseCopyWith<_ResultatCreationCourse> get copyWith => __$ResultatCreationCourseCopyWithImpl<_ResultatCreationCourse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResultatCreationCourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultatCreationCourse&&(identical(other.course, course) || other.course == course)&&(identical(other.assigne, assigne) || other.assigne == assigne)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,course,assigne,message);

@override
String toString() {
  return 'ResultatCreationCourse(course: $course, assigne: $assigne, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResultatCreationCourseCopyWith<$Res> implements $ResultatCreationCourseCopyWith<$Res> {
  factory _$ResultatCreationCourseCopyWith(_ResultatCreationCourse value, $Res Function(_ResultatCreationCourse) _then) = __$ResultatCreationCourseCopyWithImpl;
@override @useResult
$Res call({
 Course course, bool assigne, String message
});


@override $CourseCopyWith<$Res> get course;

}
/// @nodoc
class __$ResultatCreationCourseCopyWithImpl<$Res>
    implements _$ResultatCreationCourseCopyWith<$Res> {
  __$ResultatCreationCourseCopyWithImpl(this._self, this._then);

  final _ResultatCreationCourse _self;
  final $Res Function(_ResultatCreationCourse) _then;

/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? course = null,Object? assigne = null,Object? message = null,}) {
  return _then(_ResultatCreationCourse(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course,assigne: null == assigne ? _self.assigne : assigne // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ResultatCreationCourse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res> get course {
  
  return $CourseCopyWith<$Res>(_self.course, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}


/// @nodoc
mixin _$LivreurProche {

 String get id; String get nom;@JsonKey(name: 'type_vehicule') String get typeVehicule; double? get latitude; double? get longitude;@JsonKey(name: 'position_maj_le') String? get positionMajLe;
/// Create a copy of LivreurProche
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivreurProcheCopyWith<LivreurProche> get copyWith => _$LivreurProcheCopyWithImpl<LivreurProche>(this as LivreurProche, _$identity);

  /// Serializes this LivreurProche to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivreurProche&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.typeVehicule, typeVehicule) || other.typeVehicule == typeVehicule)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.positionMajLe, positionMajLe) || other.positionMajLe == positionMajLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,typeVehicule,latitude,longitude,positionMajLe);

@override
String toString() {
  return 'LivreurProche(id: $id, nom: $nom, typeVehicule: $typeVehicule, latitude: $latitude, longitude: $longitude, positionMajLe: $positionMajLe)';
}


}

/// @nodoc
abstract mixin class $LivreurProcheCopyWith<$Res>  {
  factory $LivreurProcheCopyWith(LivreurProche value, $Res Function(LivreurProche) _then) = _$LivreurProcheCopyWithImpl;
@useResult
$Res call({
 String id, String nom,@JsonKey(name: 'type_vehicule') String typeVehicule, double? latitude, double? longitude,@JsonKey(name: 'position_maj_le') String? positionMajLe
});




}
/// @nodoc
class _$LivreurProcheCopyWithImpl<$Res>
    implements $LivreurProcheCopyWith<$Res> {
  _$LivreurProcheCopyWithImpl(this._self, this._then);

  final LivreurProche _self;
  final $Res Function(LivreurProche) _then;

/// Create a copy of LivreurProche
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? typeVehicule = null,Object? latitude = freezed,Object? longitude = freezed,Object? positionMajLe = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,typeVehicule: null == typeVehicule ? _self.typeVehicule : typeVehicule // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,positionMajLe: freezed == positionMajLe ? _self.positionMajLe : positionMajLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivreurProche].
extension LivreurProchePatterns on LivreurProche {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivreurProche value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivreurProche() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivreurProche value)  $default,){
final _that = this;
switch (_that) {
case _LivreurProche():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivreurProche value)?  $default,){
final _that = this;
switch (_that) {
case _LivreurProche() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nom, @JsonKey(name: 'type_vehicule')  String typeVehicule,  double? latitude,  double? longitude, @JsonKey(name: 'position_maj_le')  String? positionMajLe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivreurProche() when $default != null:
return $default(_that.id,_that.nom,_that.typeVehicule,_that.latitude,_that.longitude,_that.positionMajLe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nom, @JsonKey(name: 'type_vehicule')  String typeVehicule,  double? latitude,  double? longitude, @JsonKey(name: 'position_maj_le')  String? positionMajLe)  $default,) {final _that = this;
switch (_that) {
case _LivreurProche():
return $default(_that.id,_that.nom,_that.typeVehicule,_that.latitude,_that.longitude,_that.positionMajLe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nom, @JsonKey(name: 'type_vehicule')  String typeVehicule,  double? latitude,  double? longitude, @JsonKey(name: 'position_maj_le')  String? positionMajLe)?  $default,) {final _that = this;
switch (_that) {
case _LivreurProche() when $default != null:
return $default(_that.id,_that.nom,_that.typeVehicule,_that.latitude,_that.longitude,_that.positionMajLe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivreurProche implements LivreurProche {
  const _LivreurProche({this.id = '', this.nom = '', @JsonKey(name: 'type_vehicule') this.typeVehicule = 'moto', this.latitude, this.longitude, @JsonKey(name: 'position_maj_le') this.positionMajLe});
  factory _LivreurProche.fromJson(Map<String, dynamic> json) => _$LivreurProcheFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String nom;
@override@JsonKey(name: 'type_vehicule') final  String typeVehicule;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'position_maj_le') final  String? positionMajLe;

/// Create a copy of LivreurProche
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivreurProcheCopyWith<_LivreurProche> get copyWith => __$LivreurProcheCopyWithImpl<_LivreurProche>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivreurProcheToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivreurProche&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.typeVehicule, typeVehicule) || other.typeVehicule == typeVehicule)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.positionMajLe, positionMajLe) || other.positionMajLe == positionMajLe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,typeVehicule,latitude,longitude,positionMajLe);

@override
String toString() {
  return 'LivreurProche(id: $id, nom: $nom, typeVehicule: $typeVehicule, latitude: $latitude, longitude: $longitude, positionMajLe: $positionMajLe)';
}


}

/// @nodoc
abstract mixin class _$LivreurProcheCopyWith<$Res> implements $LivreurProcheCopyWith<$Res> {
  factory _$LivreurProcheCopyWith(_LivreurProche value, $Res Function(_LivreurProche) _then) = __$LivreurProcheCopyWithImpl;
@override @useResult
$Res call({
 String id, String nom,@JsonKey(name: 'type_vehicule') String typeVehicule, double? latitude, double? longitude,@JsonKey(name: 'position_maj_le') String? positionMajLe
});




}
/// @nodoc
class __$LivreurProcheCopyWithImpl<$Res>
    implements _$LivreurProcheCopyWith<$Res> {
  __$LivreurProcheCopyWithImpl(this._self, this._then);

  final _LivreurProche _self;
  final $Res Function(_LivreurProche) _then;

/// Create a copy of LivreurProche
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? typeVehicule = null,Object? latitude = freezed,Object? longitude = freezed,Object? positionMajLe = freezed,}) {
  return _then(_LivreurProche(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,typeVehicule: null == typeVehicule ? _self.typeVehicule : typeVehicule // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,positionMajLe: freezed == positionMajLe ? _self.positionMajLe : positionMajLe // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
