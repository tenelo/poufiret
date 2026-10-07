// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OptionMeta {

 String get valeur; String get libelle;
/// Create a copy of OptionMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OptionMetaCopyWith<OptionMeta> get copyWith => _$OptionMetaCopyWithImpl<OptionMeta>(this as OptionMeta, _$identity);

  /// Serializes this OptionMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptionMeta&&(identical(other.valeur, valeur) || other.valeur == valeur)&&(identical(other.libelle, libelle) || other.libelle == libelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,valeur,libelle);

@override
String toString() {
  return 'OptionMeta(valeur: $valeur, libelle: $libelle)';
}


}

/// @nodoc
abstract mixin class $OptionMetaCopyWith<$Res>  {
  factory $OptionMetaCopyWith(OptionMeta value, $Res Function(OptionMeta) _then) = _$OptionMetaCopyWithImpl;
@useResult
$Res call({
 String valeur, String libelle
});




}
/// @nodoc
class _$OptionMetaCopyWithImpl<$Res>
    implements $OptionMetaCopyWith<$Res> {
  _$OptionMetaCopyWithImpl(this._self, this._then);

  final OptionMeta _self;
  final $Res Function(OptionMeta) _then;

/// Create a copy of OptionMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? valeur = null,Object? libelle = null,}) {
  return _then(_self.copyWith(
valeur: null == valeur ? _self.valeur : valeur // ignore: cast_nullable_to_non_nullable
as String,libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OptionMeta].
extension OptionMetaPatterns on OptionMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OptionMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OptionMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OptionMeta value)  $default,){
final _that = this;
switch (_that) {
case _OptionMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OptionMeta value)?  $default,){
final _that = this;
switch (_that) {
case _OptionMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String valeur,  String libelle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OptionMeta() when $default != null:
return $default(_that.valeur,_that.libelle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String valeur,  String libelle)  $default,) {final _that = this;
switch (_that) {
case _OptionMeta():
return $default(_that.valeur,_that.libelle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String valeur,  String libelle)?  $default,) {final _that = this;
switch (_that) {
case _OptionMeta() when $default != null:
return $default(_that.valeur,_that.libelle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OptionMeta implements OptionMeta {
  const _OptionMeta({this.valeur = '', this.libelle = ''});
  factory _OptionMeta.fromJson(Map<String, dynamic> json) => _$OptionMetaFromJson(json);

@override@JsonKey() final  String valeur;
@override@JsonKey() final  String libelle;

/// Create a copy of OptionMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OptionMetaCopyWith<_OptionMeta> get copyWith => __$OptionMetaCopyWithImpl<_OptionMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OptionMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OptionMeta&&(identical(other.valeur, valeur) || other.valeur == valeur)&&(identical(other.libelle, libelle) || other.libelle == libelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,valeur,libelle);

@override
String toString() {
  return 'OptionMeta(valeur: $valeur, libelle: $libelle)';
}


}

/// @nodoc
abstract mixin class _$OptionMetaCopyWith<$Res> implements $OptionMetaCopyWith<$Res> {
  factory _$OptionMetaCopyWith(_OptionMeta value, $Res Function(_OptionMeta) _then) = __$OptionMetaCopyWithImpl;
@override @useResult
$Res call({
 String valeur, String libelle
});




}
/// @nodoc
class __$OptionMetaCopyWithImpl<$Res>
    implements _$OptionMetaCopyWith<$Res> {
  __$OptionMetaCopyWithImpl(this._self, this._then);

  final _OptionMeta _self;
  final $Res Function(_OptionMeta) _then;

/// Create a copy of OptionMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? valeur = null,Object? libelle = null,}) {
  return _then(_OptionMeta(
valeur: null == valeur ? _self.valeur : valeur // ignore: cast_nullable_to_non_nullable
as String,libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MetaLocations {

@JsonKey(name: 'types_logement') List<OptionMeta> get typesLogement; List<OptionMeta> get equipements; List<OptionMeta> get disponibilites;
/// Create a copy of MetaLocations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetaLocationsCopyWith<MetaLocations> get copyWith => _$MetaLocationsCopyWithImpl<MetaLocations>(this as MetaLocations, _$identity);

  /// Serializes this MetaLocations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetaLocations&&const DeepCollectionEquality().equals(other.typesLogement, typesLogement)&&const DeepCollectionEquality().equals(other.equipements, equipements)&&const DeepCollectionEquality().equals(other.disponibilites, disponibilites));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(typesLogement),const DeepCollectionEquality().hash(equipements),const DeepCollectionEquality().hash(disponibilites));

@override
String toString() {
  return 'MetaLocations(typesLogement: $typesLogement, equipements: $equipements, disponibilites: $disponibilites)';
}


}

/// @nodoc
abstract mixin class $MetaLocationsCopyWith<$Res>  {
  factory $MetaLocationsCopyWith(MetaLocations value, $Res Function(MetaLocations) _then) = _$MetaLocationsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'types_logement') List<OptionMeta> typesLogement, List<OptionMeta> equipements, List<OptionMeta> disponibilites
});




}
/// @nodoc
class _$MetaLocationsCopyWithImpl<$Res>
    implements $MetaLocationsCopyWith<$Res> {
  _$MetaLocationsCopyWithImpl(this._self, this._then);

  final MetaLocations _self;
  final $Res Function(MetaLocations) _then;

/// Create a copy of MetaLocations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? typesLogement = null,Object? equipements = null,Object? disponibilites = null,}) {
  return _then(_self.copyWith(
typesLogement: null == typesLogement ? _self.typesLogement : typesLogement // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,equipements: null == equipements ? _self.equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,disponibilites: null == disponibilites ? _self.disponibilites : disponibilites // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,
  ));
}

}


/// Adds pattern-matching-related methods to [MetaLocations].
extension MetaLocationsPatterns on MetaLocations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MetaLocations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetaLocations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MetaLocations value)  $default,){
final _that = this;
switch (_that) {
case _MetaLocations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MetaLocations value)?  $default,){
final _that = this;
switch (_that) {
case _MetaLocations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'types_logement')  List<OptionMeta> typesLogement,  List<OptionMeta> equipements,  List<OptionMeta> disponibilites)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetaLocations() when $default != null:
return $default(_that.typesLogement,_that.equipements,_that.disponibilites);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'types_logement')  List<OptionMeta> typesLogement,  List<OptionMeta> equipements,  List<OptionMeta> disponibilites)  $default,) {final _that = this;
switch (_that) {
case _MetaLocations():
return $default(_that.typesLogement,_that.equipements,_that.disponibilites);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'types_logement')  List<OptionMeta> typesLogement,  List<OptionMeta> equipements,  List<OptionMeta> disponibilites)?  $default,) {final _that = this;
switch (_that) {
case _MetaLocations() when $default != null:
return $default(_that.typesLogement,_that.equipements,_that.disponibilites);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MetaLocations extends MetaLocations {
  const _MetaLocations({@JsonKey(name: 'types_logement') final  List<OptionMeta> typesLogement = const <OptionMeta>[], final  List<OptionMeta> equipements = const <OptionMeta>[], final  List<OptionMeta> disponibilites = const <OptionMeta>[]}): _typesLogement = typesLogement,_equipements = equipements,_disponibilites = disponibilites,super._();
  factory _MetaLocations.fromJson(Map<String, dynamic> json) => _$MetaLocationsFromJson(json);

 final  List<OptionMeta> _typesLogement;
@override@JsonKey(name: 'types_logement') List<OptionMeta> get typesLogement {
  if (_typesLogement is EqualUnmodifiableListView) return _typesLogement;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_typesLogement);
}

 final  List<OptionMeta> _equipements;
@override@JsonKey() List<OptionMeta> get equipements {
  if (_equipements is EqualUnmodifiableListView) return _equipements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipements);
}

 final  List<OptionMeta> _disponibilites;
@override@JsonKey() List<OptionMeta> get disponibilites {
  if (_disponibilites is EqualUnmodifiableListView) return _disponibilites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disponibilites);
}


/// Create a copy of MetaLocations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetaLocationsCopyWith<_MetaLocations> get copyWith => __$MetaLocationsCopyWithImpl<_MetaLocations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetaLocationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetaLocations&&const DeepCollectionEquality().equals(other._typesLogement, _typesLogement)&&const DeepCollectionEquality().equals(other._equipements, _equipements)&&const DeepCollectionEquality().equals(other._disponibilites, _disponibilites));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_typesLogement),const DeepCollectionEquality().hash(_equipements),const DeepCollectionEquality().hash(_disponibilites));

@override
String toString() {
  return 'MetaLocations(typesLogement: $typesLogement, equipements: $equipements, disponibilites: $disponibilites)';
}


}

/// @nodoc
abstract mixin class _$MetaLocationsCopyWith<$Res> implements $MetaLocationsCopyWith<$Res> {
  factory _$MetaLocationsCopyWith(_MetaLocations value, $Res Function(_MetaLocations) _then) = __$MetaLocationsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'types_logement') List<OptionMeta> typesLogement, List<OptionMeta> equipements, List<OptionMeta> disponibilites
});




}
/// @nodoc
class __$MetaLocationsCopyWithImpl<$Res>
    implements _$MetaLocationsCopyWith<$Res> {
  __$MetaLocationsCopyWithImpl(this._self, this._then);

  final _MetaLocations _self;
  final $Res Function(_MetaLocations) _then;

/// Create a copy of MetaLocations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? typesLogement = null,Object? equipements = null,Object? disponibilites = null,}) {
  return _then(_MetaLocations(
typesLogement: null == typesLogement ? _self._typesLogement : typesLogement // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,equipements: null == equipements ? _self._equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,disponibilites: null == disponibilites ? _self._disponibilites : disponibilites // ignore: cast_nullable_to_non_nullable
as List<OptionMeta>,
  ));
}


}


/// @nodoc
mixin _$Loueur {

 int get id; String get nom; String get logo; String get couverture;@JsonKey(name: 'telephone_pro') String get telephonePro; String get whatsapp;
/// Create a copy of Loueur
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoueurCopyWith<Loueur> get copyWith => _$LoueurCopyWithImpl<Loueur>(this as Loueur, _$identity);

  /// Serializes this Loueur to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loueur&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,logo,couverture,telephonePro,whatsapp);

@override
String toString() {
  return 'Loueur(id: $id, nom: $nom, logo: $logo, couverture: $couverture, telephonePro: $telephonePro, whatsapp: $whatsapp)';
}


}

/// @nodoc
abstract mixin class $LoueurCopyWith<$Res>  {
  factory $LoueurCopyWith(Loueur value, $Res Function(Loueur) _then) = _$LoueurCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String logo, String couverture,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp
});




}
/// @nodoc
class _$LoueurCopyWithImpl<$Res>
    implements $LoueurCopyWith<$Res> {
  _$LoueurCopyWithImpl(this._self, this._then);

  final Loueur _self;
  final $Res Function(Loueur) _then;

/// Create a copy of Loueur
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? logo = null,Object? couverture = null,Object? telephonePro = null,Object? whatsapp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Loueur].
extension LoueurPatterns on Loueur {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Loueur value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loueur() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Loueur value)  $default,){
final _that = this;
switch (_that) {
case _Loueur():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Loueur value)?  $default,){
final _that = this;
switch (_that) {
case _Loueur() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loueur() when $default != null:
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp)  $default,) {final _that = this;
switch (_that) {
case _Loueur():
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp)?  $default,) {final _that = this;
switch (_that) {
case _Loueur() when $default != null:
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Loueur implements Loueur {
  const _Loueur({required this.id, this.nom = '', this.logo = '', this.couverture = '', @JsonKey(name: 'telephone_pro') this.telephonePro = '', this.whatsapp = ''});
  factory _Loueur.fromJson(Map<String, dynamic> json) => _$LoueurFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String logo;
@override@JsonKey() final  String couverture;
@override@JsonKey(name: 'telephone_pro') final  String telephonePro;
@override@JsonKey() final  String whatsapp;

/// Create a copy of Loueur
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoueurCopyWith<_Loueur> get copyWith => __$LoueurCopyWithImpl<_Loueur>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoueurToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loueur&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,logo,couverture,telephonePro,whatsapp);

@override
String toString() {
  return 'Loueur(id: $id, nom: $nom, logo: $logo, couverture: $couverture, telephonePro: $telephonePro, whatsapp: $whatsapp)';
}


}

/// @nodoc
abstract mixin class _$LoueurCopyWith<$Res> implements $LoueurCopyWith<$Res> {
  factory _$LoueurCopyWith(_Loueur value, $Res Function(_Loueur) _then) = __$LoueurCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String logo, String couverture,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp
});




}
/// @nodoc
class __$LoueurCopyWithImpl<$Res>
    implements _$LoueurCopyWith<$Res> {
  __$LoueurCopyWithImpl(this._self, this._then);

  final _Loueur _self;
  final $Res Function(_Loueur) _then;

/// Create a copy of Loueur
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? logo = null,Object? couverture = null,Object? telephonePro = null,Object? whatsapp = null,}) {
  return _then(_Loueur(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LogementResume {

 int get id; String get titre; String get photo;@JsonKey(name: 'type_logement') String get typeLogement;@JsonKey(name: 'type_logement_libelle') String get typeLogementLibelle;@JsonKey(name: 'localisation_texte') String get localisationTexte;@JsonKey(fromJson: versInt) int get loyer;@JsonKey(name: 'nb_chambres', fromJson: versInt) int get nbChambres;@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int get nbSallesDeBain; bool get meuble; String get disponibilite;
/// Create a copy of LogementResume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogementResumeCopyWith<LogementResume> get copyWith => _$LogementResumeCopyWithImpl<LogementResume>(this as LogementResume, _$identity);

  /// Serializes this LogementResume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogementResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.typeLogement, typeLogement) || other.typeLogement == typeLogement)&&(identical(other.typeLogementLibelle, typeLogementLibelle) || other.typeLogementLibelle == typeLogementLibelle)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.loyer, loyer) || other.loyer == loyer)&&(identical(other.nbChambres, nbChambres) || other.nbChambres == nbChambres)&&(identical(other.nbSallesDeBain, nbSallesDeBain) || other.nbSallesDeBain == nbSallesDeBain)&&(identical(other.meuble, meuble) || other.meuble == meuble)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,typeLogement,typeLogementLibelle,localisationTexte,loyer,nbChambres,nbSallesDeBain,meuble,disponibilite);

@override
String toString() {
  return 'LogementResume(id: $id, titre: $titre, photo: $photo, typeLogement: $typeLogement, typeLogementLibelle: $typeLogementLibelle, localisationTexte: $localisationTexte, loyer: $loyer, nbChambres: $nbChambres, nbSallesDeBain: $nbSallesDeBain, meuble: $meuble, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class $LogementResumeCopyWith<$Res>  {
  factory $LogementResumeCopyWith(LogementResume value, $Res Function(LogementResume) _then) = _$LogementResumeCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String photo,@JsonKey(name: 'type_logement') String typeLogement,@JsonKey(name: 'type_logement_libelle') String typeLogementLibelle,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versInt) int loyer,@JsonKey(name: 'nb_chambres', fromJson: versInt) int nbChambres,@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int nbSallesDeBain, bool meuble, String disponibilite
});




}
/// @nodoc
class _$LogementResumeCopyWithImpl<$Res>
    implements $LogementResumeCopyWith<$Res> {
  _$LogementResumeCopyWithImpl(this._self, this._then);

  final LogementResume _self;
  final $Res Function(LogementResume) _then;

/// Create a copy of LogementResume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? typeLogement = null,Object? typeLogementLibelle = null,Object? localisationTexte = null,Object? loyer = null,Object? nbChambres = null,Object? nbSallesDeBain = null,Object? meuble = null,Object? disponibilite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,typeLogement: null == typeLogement ? _self.typeLogement : typeLogement // ignore: cast_nullable_to_non_nullable
as String,typeLogementLibelle: null == typeLogementLibelle ? _self.typeLogementLibelle : typeLogementLibelle // ignore: cast_nullable_to_non_nullable
as String,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,loyer: null == loyer ? _self.loyer : loyer // ignore: cast_nullable_to_non_nullable
as int,nbChambres: null == nbChambres ? _self.nbChambres : nbChambres // ignore: cast_nullable_to_non_nullable
as int,nbSallesDeBain: null == nbSallesDeBain ? _self.nbSallesDeBain : nbSallesDeBain // ignore: cast_nullable_to_non_nullable
as int,meuble: null == meuble ? _self.meuble : meuble // ignore: cast_nullable_to_non_nullable
as bool,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LogementResume].
extension LogementResumePatterns on LogementResume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogementResume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogementResume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogementResume value)  $default,){
final _that = this;
switch (_that) {
case _LogementResume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogementResume value)?  $default,){
final _that = this;
switch (_that) {
case _LogementResume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String photo, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain,  bool meuble,  String disponibilite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogementResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.typeLogement,_that.typeLogementLibelle,_that.localisationTexte,_that.loyer,_that.nbChambres,_that.nbSallesDeBain,_that.meuble,_that.disponibilite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String photo, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain,  bool meuble,  String disponibilite)  $default,) {final _that = this;
switch (_that) {
case _LogementResume():
return $default(_that.id,_that.titre,_that.photo,_that.typeLogement,_that.typeLogementLibelle,_that.localisationTexte,_that.loyer,_that.nbChambres,_that.nbSallesDeBain,_that.meuble,_that.disponibilite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String photo, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain,  bool meuble,  String disponibilite)?  $default,) {final _that = this;
switch (_that) {
case _LogementResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.typeLogement,_that.typeLogementLibelle,_that.localisationTexte,_that.loyer,_that.nbChambres,_that.nbSallesDeBain,_that.meuble,_that.disponibilite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LogementResume extends LogementResume {
  const _LogementResume({required this.id, this.titre = '', this.photo = '', @JsonKey(name: 'type_logement') this.typeLogement = '', @JsonKey(name: 'type_logement_libelle') this.typeLogementLibelle = '', @JsonKey(name: 'localisation_texte') this.localisationTexte = '', @JsonKey(fromJson: versInt) this.loyer = 0, @JsonKey(name: 'nb_chambres', fromJson: versInt) this.nbChambres = 0, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) this.nbSallesDeBain = 0, this.meuble = false, this.disponibilite = ''}): super._();
  factory _LogementResume.fromJson(Map<String, dynamic> json) => _$LogementResumeFromJson(json);

@override final  int id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String photo;
@override@JsonKey(name: 'type_logement') final  String typeLogement;
@override@JsonKey(name: 'type_logement_libelle') final  String typeLogementLibelle;
@override@JsonKey(name: 'localisation_texte') final  String localisationTexte;
@override@JsonKey(fromJson: versInt) final  int loyer;
@override@JsonKey(name: 'nb_chambres', fromJson: versInt) final  int nbChambres;
@override@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) final  int nbSallesDeBain;
@override@JsonKey() final  bool meuble;
@override@JsonKey() final  String disponibilite;

/// Create a copy of LogementResume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogementResumeCopyWith<_LogementResume> get copyWith => __$LogementResumeCopyWithImpl<_LogementResume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogementResumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogementResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.typeLogement, typeLogement) || other.typeLogement == typeLogement)&&(identical(other.typeLogementLibelle, typeLogementLibelle) || other.typeLogementLibelle == typeLogementLibelle)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.loyer, loyer) || other.loyer == loyer)&&(identical(other.nbChambres, nbChambres) || other.nbChambres == nbChambres)&&(identical(other.nbSallesDeBain, nbSallesDeBain) || other.nbSallesDeBain == nbSallesDeBain)&&(identical(other.meuble, meuble) || other.meuble == meuble)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,typeLogement,typeLogementLibelle,localisationTexte,loyer,nbChambres,nbSallesDeBain,meuble,disponibilite);

@override
String toString() {
  return 'LogementResume(id: $id, titre: $titre, photo: $photo, typeLogement: $typeLogement, typeLogementLibelle: $typeLogementLibelle, localisationTexte: $localisationTexte, loyer: $loyer, nbChambres: $nbChambres, nbSallesDeBain: $nbSallesDeBain, meuble: $meuble, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class _$LogementResumeCopyWith<$Res> implements $LogementResumeCopyWith<$Res> {
  factory _$LogementResumeCopyWith(_LogementResume value, $Res Function(_LogementResume) _then) = __$LogementResumeCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String photo,@JsonKey(name: 'type_logement') String typeLogement,@JsonKey(name: 'type_logement_libelle') String typeLogementLibelle,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versInt) int loyer,@JsonKey(name: 'nb_chambres', fromJson: versInt) int nbChambres,@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int nbSallesDeBain, bool meuble, String disponibilite
});




}
/// @nodoc
class __$LogementResumeCopyWithImpl<$Res>
    implements _$LogementResumeCopyWith<$Res> {
  __$LogementResumeCopyWithImpl(this._self, this._then);

  final _LogementResume _self;
  final $Res Function(_LogementResume) _then;

/// Create a copy of LogementResume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? typeLogement = null,Object? typeLogementLibelle = null,Object? localisationTexte = null,Object? loyer = null,Object? nbChambres = null,Object? nbSallesDeBain = null,Object? meuble = null,Object? disponibilite = null,}) {
  return _then(_LogementResume(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,typeLogement: null == typeLogement ? _self.typeLogement : typeLogement // ignore: cast_nullable_to_non_nullable
as String,typeLogementLibelle: null == typeLogementLibelle ? _self.typeLogementLibelle : typeLogementLibelle // ignore: cast_nullable_to_non_nullable
as String,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,loyer: null == loyer ? _self.loyer : loyer // ignore: cast_nullable_to_non_nullable
as int,nbChambres: null == nbChambres ? _self.nbChambres : nbChambres // ignore: cast_nullable_to_non_nullable
as int,nbSallesDeBain: null == nbSallesDeBain ? _self.nbSallesDeBain : nbSallesDeBain // ignore: cast_nullable_to_non_nullable
as int,meuble: null == meuble ? _self.meuble : meuble // ignore: cast_nullable_to_non_nullable
as bool,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PageLoueur {

 Loueur get loueur; List<LogementResume> get resultats;
/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageLoueurCopyWith<PageLoueur> get copyWith => _$PageLoueurCopyWithImpl<PageLoueur>(this as PageLoueur, _$identity);

  /// Serializes this PageLoueur to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageLoueur&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other.resultats, resultats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loueur,const DeepCollectionEquality().hash(resultats));

@override
String toString() {
  return 'PageLoueur(loueur: $loueur, resultats: $resultats)';
}


}

/// @nodoc
abstract mixin class $PageLoueurCopyWith<$Res>  {
  factory $PageLoueurCopyWith(PageLoueur value, $Res Function(PageLoueur) _then) = _$PageLoueurCopyWithImpl;
@useResult
$Res call({
 Loueur loueur, List<LogementResume> resultats
});


$LoueurCopyWith<$Res> get loueur;

}
/// @nodoc
class _$PageLoueurCopyWithImpl<$Res>
    implements $PageLoueurCopyWith<$Res> {
  _$PageLoueurCopyWithImpl(this._self, this._then);

  final PageLoueur _self;
  final $Res Function(PageLoueur) _then;

/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loueur = null,Object? resultats = null,}) {
  return _then(_self.copyWith(
loueur: null == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur,resultats: null == resultats ? _self.resultats : resultats // ignore: cast_nullable_to_non_nullable
as List<LogementResume>,
  ));
}
/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoueurCopyWith<$Res> get loueur {
  
  return $LoueurCopyWith<$Res>(_self.loueur, (value) {
    return _then(_self.copyWith(loueur: value));
  });
}
}


/// Adds pattern-matching-related methods to [PageLoueur].
extension PageLoueurPatterns on PageLoueur {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageLoueur value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageLoueur() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageLoueur value)  $default,){
final _that = this;
switch (_that) {
case _PageLoueur():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageLoueur value)?  $default,){
final _that = this;
switch (_that) {
case _PageLoueur() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Loueur loueur,  List<LogementResume> resultats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageLoueur() when $default != null:
return $default(_that.loueur,_that.resultats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Loueur loueur,  List<LogementResume> resultats)  $default,) {final _that = this;
switch (_that) {
case _PageLoueur():
return $default(_that.loueur,_that.resultats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Loueur loueur,  List<LogementResume> resultats)?  $default,) {final _that = this;
switch (_that) {
case _PageLoueur() when $default != null:
return $default(_that.loueur,_that.resultats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageLoueur implements PageLoueur {
  const _PageLoueur({required this.loueur, final  List<LogementResume> resultats = const <LogementResume>[]}): _resultats = resultats;
  factory _PageLoueur.fromJson(Map<String, dynamic> json) => _$PageLoueurFromJson(json);

@override final  Loueur loueur;
 final  List<LogementResume> _resultats;
@override@JsonKey() List<LogementResume> get resultats {
  if (_resultats is EqualUnmodifiableListView) return _resultats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultats);
}


/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageLoueurCopyWith<_PageLoueur> get copyWith => __$PageLoueurCopyWithImpl<_PageLoueur>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageLoueurToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageLoueur&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other._resultats, _resultats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loueur,const DeepCollectionEquality().hash(_resultats));

@override
String toString() {
  return 'PageLoueur(loueur: $loueur, resultats: $resultats)';
}


}

/// @nodoc
abstract mixin class _$PageLoueurCopyWith<$Res> implements $PageLoueurCopyWith<$Res> {
  factory _$PageLoueurCopyWith(_PageLoueur value, $Res Function(_PageLoueur) _then) = __$PageLoueurCopyWithImpl;
@override @useResult
$Res call({
 Loueur loueur, List<LogementResume> resultats
});


@override $LoueurCopyWith<$Res> get loueur;

}
/// @nodoc
class __$PageLoueurCopyWithImpl<$Res>
    implements _$PageLoueurCopyWith<$Res> {
  __$PageLoueurCopyWithImpl(this._self, this._then);

  final _PageLoueur _self;
  final $Res Function(_PageLoueur) _then;

/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loueur = null,Object? resultats = null,}) {
  return _then(_PageLoueur(
loueur: null == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur,resultats: null == resultats ? _self._resultats : resultats // ignore: cast_nullable_to_non_nullable
as List<LogementResume>,
  ));
}

/// Create a copy of PageLoueur
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoueurCopyWith<$Res> get loueur {
  
  return $LoueurCopyWith<$Res>(_self.loueur, (value) {
    return _then(_self.copyWith(loueur: value));
  });
}
}


/// @nodoc
mixin _$Panorama {

 int get id; String get image; String get titre;/// photo_360 | panoramique
@JsonKey(name: 'type_vue') String get typeVue;@JsonKey(fromJson: versInt) int get ordre;@JsonKey(name: 'est_active') bool get estActive;
/// Create a copy of Panorama
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanoramaCopyWith<Panorama> get copyWith => _$PanoramaCopyWithImpl<Panorama>(this as Panorama, _$identity);

  /// Serializes this Panorama to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Panorama&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.typeVue, typeVue) || other.typeVue == typeVue)&&(identical(other.ordre, ordre) || other.ordre == ordre)&&(identical(other.estActive, estActive) || other.estActive == estActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,titre,typeVue,ordre,estActive);

@override
String toString() {
  return 'Panorama(id: $id, image: $image, titre: $titre, typeVue: $typeVue, ordre: $ordre, estActive: $estActive)';
}


}

/// @nodoc
abstract mixin class $PanoramaCopyWith<$Res>  {
  factory $PanoramaCopyWith(Panorama value, $Res Function(Panorama) _then) = _$PanoramaCopyWithImpl;
@useResult
$Res call({
 int id, String image, String titre,@JsonKey(name: 'type_vue') String typeVue,@JsonKey(fromJson: versInt) int ordre,@JsonKey(name: 'est_active') bool estActive
});




}
/// @nodoc
class _$PanoramaCopyWithImpl<$Res>
    implements $PanoramaCopyWith<$Res> {
  _$PanoramaCopyWithImpl(this._self, this._then);

  final Panorama _self;
  final $Res Function(Panorama) _then;

/// Create a copy of Panorama
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = null,Object? titre = null,Object? typeVue = null,Object? ordre = null,Object? estActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,typeVue: null == typeVue ? _self.typeVue : typeVue // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Panorama].
extension PanoramaPatterns on Panorama {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Panorama value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Panorama() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Panorama value)  $default,){
final _that = this;
switch (_that) {
case _Panorama():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Panorama value)?  $default,){
final _that = this;
switch (_that) {
case _Panorama() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String image,  String titre, @JsonKey(name: 'type_vue')  String typeVue, @JsonKey(fromJson: versInt)  int ordre, @JsonKey(name: 'est_active')  bool estActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Panorama() when $default != null:
return $default(_that.id,_that.image,_that.titre,_that.typeVue,_that.ordre,_that.estActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String image,  String titre, @JsonKey(name: 'type_vue')  String typeVue, @JsonKey(fromJson: versInt)  int ordre, @JsonKey(name: 'est_active')  bool estActive)  $default,) {final _that = this;
switch (_that) {
case _Panorama():
return $default(_that.id,_that.image,_that.titre,_that.typeVue,_that.ordre,_that.estActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String image,  String titre, @JsonKey(name: 'type_vue')  String typeVue, @JsonKey(fromJson: versInt)  int ordre, @JsonKey(name: 'est_active')  bool estActive)?  $default,) {final _that = this;
switch (_that) {
case _Panorama() when $default != null:
return $default(_that.id,_that.image,_that.titre,_that.typeVue,_that.ordre,_that.estActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Panorama extends Panorama {
  const _Panorama({required this.id, this.image = '', this.titre = '', @JsonKey(name: 'type_vue') this.typeVue = 'panoramique', @JsonKey(fromJson: versInt) this.ordre = 0, @JsonKey(name: 'est_active') this.estActive = true}): super._();
  factory _Panorama.fromJson(Map<String, dynamic> json) => _$PanoramaFromJson(json);

@override final  int id;
@override@JsonKey() final  String image;
@override@JsonKey() final  String titre;
/// photo_360 | panoramique
@override@JsonKey(name: 'type_vue') final  String typeVue;
@override@JsonKey(fromJson: versInt) final  int ordre;
@override@JsonKey(name: 'est_active') final  bool estActive;

/// Create a copy of Panorama
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanoramaCopyWith<_Panorama> get copyWith => __$PanoramaCopyWithImpl<_Panorama>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PanoramaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Panorama&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.typeVue, typeVue) || other.typeVue == typeVue)&&(identical(other.ordre, ordre) || other.ordre == ordre)&&(identical(other.estActive, estActive) || other.estActive == estActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,titre,typeVue,ordre,estActive);

@override
String toString() {
  return 'Panorama(id: $id, image: $image, titre: $titre, typeVue: $typeVue, ordre: $ordre, estActive: $estActive)';
}


}

/// @nodoc
abstract mixin class _$PanoramaCopyWith<$Res> implements $PanoramaCopyWith<$Res> {
  factory _$PanoramaCopyWith(_Panorama value, $Res Function(_Panorama) _then) = __$PanoramaCopyWithImpl;
@override @useResult
$Res call({
 int id, String image, String titre,@JsonKey(name: 'type_vue') String typeVue,@JsonKey(fromJson: versInt) int ordre,@JsonKey(name: 'est_active') bool estActive
});




}
/// @nodoc
class __$PanoramaCopyWithImpl<$Res>
    implements _$PanoramaCopyWith<$Res> {
  __$PanoramaCopyWithImpl(this._self, this._then);

  final _Panorama _self;
  final $Res Function(_Panorama) _then;

/// Create a copy of Panorama
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = null,Object? titre = null,Object? typeVue = null,Object? ordre = null,Object? estActive = null,}) {
  return _then(_Panorama(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,typeVue: null == typeVue ? _self.typeVue : typeVue // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Logement {

 int get id; String get titre; String get description; List<String> get galerie; List<Panorama> get panoramas;@JsonKey(name: 'type_logement') String get typeLogement;@JsonKey(name: 'type_logement_libelle') String get typeLogementLibelle;@JsonKey(name: 'nb_chambres', fromJson: versInt) int get nbChambres;@JsonKey(name: 'nb_salons', fromJson: versInt) int get nbSalons;@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int get nbSallesDeBain;@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? get surfaceM2; bool get meuble;@JsonKey(fromJson: versInt) int get loyer;@JsonKey(name: 'caution_mois', fromJson: versIntNullable) int? get cautionMois;@JsonKey(name: 'avance_mois', fromJson: versIntNullable) int? get avanceMois;@JsonKey(name: 'frais_agence', fromJson: versIntNullable) int? get fraisAgence;@JsonKey(name: 'compteur_eau_individuel') bool get compteurEauIndividuel;@JsonKey(name: 'compteur_electricite_individuel') bool get compteurElectriciteIndividuel; List<String> get equipements; String get disponibilite;@JsonKey(name: 'disponible_a_partir_du') String? get disponibleAPartirDu;@JsonKey(name: 'localite_nom') String? get localiteNom;@JsonKey(name: 'quartier_nom') String? get quartierNom; String get secteur;@JsonKey(name: 'adresse_reperes') String get adresseReperes;@JsonKey(fromJson: versDoubleNullable) double? get latitude;@JsonKey(fromJson: versDoubleNullable) double? get longitude; Loueur? get loueur;@JsonKey(name: 'autres_logements') List<LogementResume> get autresLogements;
/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogementCopyWith<Logement> get copyWith => _$LogementCopyWithImpl<Logement>(this as Logement, _$identity);

  /// Serializes this Logement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Logement&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.galerie, galerie)&&const DeepCollectionEquality().equals(other.panoramas, panoramas)&&(identical(other.typeLogement, typeLogement) || other.typeLogement == typeLogement)&&(identical(other.typeLogementLibelle, typeLogementLibelle) || other.typeLogementLibelle == typeLogementLibelle)&&(identical(other.nbChambres, nbChambres) || other.nbChambres == nbChambres)&&(identical(other.nbSalons, nbSalons) || other.nbSalons == nbSalons)&&(identical(other.nbSallesDeBain, nbSallesDeBain) || other.nbSallesDeBain == nbSallesDeBain)&&(identical(other.surfaceM2, surfaceM2) || other.surfaceM2 == surfaceM2)&&(identical(other.meuble, meuble) || other.meuble == meuble)&&(identical(other.loyer, loyer) || other.loyer == loyer)&&(identical(other.cautionMois, cautionMois) || other.cautionMois == cautionMois)&&(identical(other.avanceMois, avanceMois) || other.avanceMois == avanceMois)&&(identical(other.fraisAgence, fraisAgence) || other.fraisAgence == fraisAgence)&&(identical(other.compteurEauIndividuel, compteurEauIndividuel) || other.compteurEauIndividuel == compteurEauIndividuel)&&(identical(other.compteurElectriciteIndividuel, compteurElectriciteIndividuel) || other.compteurElectriciteIndividuel == compteurElectriciteIndividuel)&&const DeepCollectionEquality().equals(other.equipements, equipements)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.disponibleAPartirDu, disponibleAPartirDu) || other.disponibleAPartirDu == disponibleAPartirDu)&&(identical(other.localiteNom, localiteNom) || other.localiteNom == localiteNom)&&(identical(other.quartierNom, quartierNom) || other.quartierNom == quartierNom)&&(identical(other.secteur, secteur) || other.secteur == secteur)&&(identical(other.adresseReperes, adresseReperes) || other.adresseReperes == adresseReperes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other.autresLogements, autresLogements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(galerie),const DeepCollectionEquality().hash(panoramas),typeLogement,typeLogementLibelle,nbChambres,nbSalons,nbSallesDeBain,surfaceM2,meuble,loyer,cautionMois,avanceMois,fraisAgence,compteurEauIndividuel,compteurElectriciteIndividuel,const DeepCollectionEquality().hash(equipements),disponibilite,disponibleAPartirDu,localiteNom,quartierNom,secteur,adresseReperes,latitude,longitude,loueur,const DeepCollectionEquality().hash(autresLogements)]);

@override
String toString() {
  return 'Logement(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, typeLogement: $typeLogement, typeLogementLibelle: $typeLogementLibelle, nbChambres: $nbChambres, nbSalons: $nbSalons, nbSallesDeBain: $nbSallesDeBain, surfaceM2: $surfaceM2, meuble: $meuble, loyer: $loyer, cautionMois: $cautionMois, avanceMois: $avanceMois, fraisAgence: $fraisAgence, compteurEauIndividuel: $compteurEauIndividuel, compteurElectriciteIndividuel: $compteurElectriciteIndividuel, equipements: $equipements, disponibilite: $disponibilite, disponibleAPartirDu: $disponibleAPartirDu, localiteNom: $localiteNom, quartierNom: $quartierNom, secteur: $secteur, adresseReperes: $adresseReperes, latitude: $latitude, longitude: $longitude, loueur: $loueur, autresLogements: $autresLogements)';
}


}

/// @nodoc
abstract mixin class $LogementCopyWith<$Res>  {
  factory $LogementCopyWith(Logement value, $Res Function(Logement) _then) = _$LogementCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(name: 'type_logement') String typeLogement,@JsonKey(name: 'type_logement_libelle') String typeLogementLibelle,@JsonKey(name: 'nb_chambres', fromJson: versInt) int nbChambres,@JsonKey(name: 'nb_salons', fromJson: versInt) int nbSalons,@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int nbSallesDeBain,@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2, bool meuble,@JsonKey(fromJson: versInt) int loyer,@JsonKey(name: 'caution_mois', fromJson: versIntNullable) int? cautionMois,@JsonKey(name: 'avance_mois', fromJson: versIntNullable) int? avanceMois,@JsonKey(name: 'frais_agence', fromJson: versIntNullable) int? fraisAgence,@JsonKey(name: 'compteur_eau_individuel') bool compteurEauIndividuel,@JsonKey(name: 'compteur_electricite_individuel') bool compteurElectriciteIndividuel, List<String> equipements, String disponibilite,@JsonKey(name: 'disponible_a_partir_du') String? disponibleAPartirDu,@JsonKey(name: 'localite_nom') String? localiteNom,@JsonKey(name: 'quartier_nom') String? quartierNom, String secteur,@JsonKey(name: 'adresse_reperes') String adresseReperes,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude, Loueur? loueur,@JsonKey(name: 'autres_logements') List<LogementResume> autresLogements
});


$LoueurCopyWith<$Res>? get loueur;

}
/// @nodoc
class _$LogementCopyWithImpl<$Res>
    implements $LogementCopyWith<$Res> {
  _$LogementCopyWithImpl(this._self, this._then);

  final Logement _self;
  final $Res Function(Logement) _then;

/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? typeLogement = null,Object? typeLogementLibelle = null,Object? nbChambres = null,Object? nbSalons = null,Object? nbSallesDeBain = null,Object? surfaceM2 = freezed,Object? meuble = null,Object? loyer = null,Object? cautionMois = freezed,Object? avanceMois = freezed,Object? fraisAgence = freezed,Object? compteurEauIndividuel = null,Object? compteurElectriciteIndividuel = null,Object? equipements = null,Object? disponibilite = null,Object? disponibleAPartirDu = freezed,Object? localiteNom = freezed,Object? quartierNom = freezed,Object? secteur = null,Object? adresseReperes = null,Object? latitude = freezed,Object? longitude = freezed,Object? loueur = freezed,Object? autresLogements = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self.galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self.panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,typeLogement: null == typeLogement ? _self.typeLogement : typeLogement // ignore: cast_nullable_to_non_nullable
as String,typeLogementLibelle: null == typeLogementLibelle ? _self.typeLogementLibelle : typeLogementLibelle // ignore: cast_nullable_to_non_nullable
as String,nbChambres: null == nbChambres ? _self.nbChambres : nbChambres // ignore: cast_nullable_to_non_nullable
as int,nbSalons: null == nbSalons ? _self.nbSalons : nbSalons // ignore: cast_nullable_to_non_nullable
as int,nbSallesDeBain: null == nbSallesDeBain ? _self.nbSallesDeBain : nbSallesDeBain // ignore: cast_nullable_to_non_nullable
as int,surfaceM2: freezed == surfaceM2 ? _self.surfaceM2 : surfaceM2 // ignore: cast_nullable_to_non_nullable
as int?,meuble: null == meuble ? _self.meuble : meuble // ignore: cast_nullable_to_non_nullable
as bool,loyer: null == loyer ? _self.loyer : loyer // ignore: cast_nullable_to_non_nullable
as int,cautionMois: freezed == cautionMois ? _self.cautionMois : cautionMois // ignore: cast_nullable_to_non_nullable
as int?,avanceMois: freezed == avanceMois ? _self.avanceMois : avanceMois // ignore: cast_nullable_to_non_nullable
as int?,fraisAgence: freezed == fraisAgence ? _self.fraisAgence : fraisAgence // ignore: cast_nullable_to_non_nullable
as int?,compteurEauIndividuel: null == compteurEauIndividuel ? _self.compteurEauIndividuel : compteurEauIndividuel // ignore: cast_nullable_to_non_nullable
as bool,compteurElectriciteIndividuel: null == compteurElectriciteIndividuel ? _self.compteurElectriciteIndividuel : compteurElectriciteIndividuel // ignore: cast_nullable_to_non_nullable
as bool,equipements: null == equipements ? _self.equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,disponibleAPartirDu: freezed == disponibleAPartirDu ? _self.disponibleAPartirDu : disponibleAPartirDu // ignore: cast_nullable_to_non_nullable
as String?,localiteNom: freezed == localiteNom ? _self.localiteNom : localiteNom // ignore: cast_nullable_to_non_nullable
as String?,quartierNom: freezed == quartierNom ? _self.quartierNom : quartierNom // ignore: cast_nullable_to_non_nullable
as String?,secteur: null == secteur ? _self.secteur : secteur // ignore: cast_nullable_to_non_nullable
as String,adresseReperes: null == adresseReperes ? _self.adresseReperes : adresseReperes // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,loueur: freezed == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur?,autresLogements: null == autresLogements ? _self.autresLogements : autresLogements // ignore: cast_nullable_to_non_nullable
as List<LogementResume>,
  ));
}
/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoueurCopyWith<$Res>? get loueur {
    if (_self.loueur == null) {
    return null;
  }

  return $LoueurCopyWith<$Res>(_self.loueur!, (value) {
    return _then(_self.copyWith(loueur: value));
  });
}
}


/// Adds pattern-matching-related methods to [Logement].
extension LogementPatterns on Logement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Logement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Logement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Logement value)  $default,){
final _that = this;
switch (_that) {
case _Logement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Logement value)?  $default,){
final _that = this;
switch (_that) {
case _Logement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salons', fromJson: versInt)  int nbSalons, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2,  bool meuble, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'caution_mois', fromJson: versIntNullable)  int? cautionMois, @JsonKey(name: 'avance_mois', fromJson: versIntNullable)  int? avanceMois, @JsonKey(name: 'frais_agence', fromJson: versIntNullable)  int? fraisAgence, @JsonKey(name: 'compteur_eau_individuel')  bool compteurEauIndividuel, @JsonKey(name: 'compteur_electricite_individuel')  bool compteurElectriciteIndividuel,  List<String> equipements,  String disponibilite, @JsonKey(name: 'disponible_a_partir_du')  String? disponibleAPartirDu, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom,  String secteur, @JsonKey(name: 'adresse_reperes')  String adresseReperes, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_logements')  List<LogementResume> autresLogements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Logement() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeLogement,_that.typeLogementLibelle,_that.nbChambres,_that.nbSalons,_that.nbSallesDeBain,_that.surfaceM2,_that.meuble,_that.loyer,_that.cautionMois,_that.avanceMois,_that.fraisAgence,_that.compteurEauIndividuel,_that.compteurElectriciteIndividuel,_that.equipements,_that.disponibilite,_that.disponibleAPartirDu,_that.localiteNom,_that.quartierNom,_that.secteur,_that.adresseReperes,_that.latitude,_that.longitude,_that.loueur,_that.autresLogements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salons', fromJson: versInt)  int nbSalons, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2,  bool meuble, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'caution_mois', fromJson: versIntNullable)  int? cautionMois, @JsonKey(name: 'avance_mois', fromJson: versIntNullable)  int? avanceMois, @JsonKey(name: 'frais_agence', fromJson: versIntNullable)  int? fraisAgence, @JsonKey(name: 'compteur_eau_individuel')  bool compteurEauIndividuel, @JsonKey(name: 'compteur_electricite_individuel')  bool compteurElectriciteIndividuel,  List<String> equipements,  String disponibilite, @JsonKey(name: 'disponible_a_partir_du')  String? disponibleAPartirDu, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom,  String secteur, @JsonKey(name: 'adresse_reperes')  String adresseReperes, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_logements')  List<LogementResume> autresLogements)  $default,) {final _that = this;
switch (_that) {
case _Logement():
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeLogement,_that.typeLogementLibelle,_that.nbChambres,_that.nbSalons,_that.nbSallesDeBain,_that.surfaceM2,_that.meuble,_that.loyer,_that.cautionMois,_that.avanceMois,_that.fraisAgence,_that.compteurEauIndividuel,_that.compteurElectriciteIndividuel,_that.equipements,_that.disponibilite,_that.disponibleAPartirDu,_that.localiteNom,_that.quartierNom,_that.secteur,_that.adresseReperes,_that.latitude,_that.longitude,_that.loueur,_that.autresLogements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_logement')  String typeLogement, @JsonKey(name: 'type_logement_libelle')  String typeLogementLibelle, @JsonKey(name: 'nb_chambres', fromJson: versInt)  int nbChambres, @JsonKey(name: 'nb_salons', fromJson: versInt)  int nbSalons, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)  int nbSallesDeBain, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2,  bool meuble, @JsonKey(fromJson: versInt)  int loyer, @JsonKey(name: 'caution_mois', fromJson: versIntNullable)  int? cautionMois, @JsonKey(name: 'avance_mois', fromJson: versIntNullable)  int? avanceMois, @JsonKey(name: 'frais_agence', fromJson: versIntNullable)  int? fraisAgence, @JsonKey(name: 'compteur_eau_individuel')  bool compteurEauIndividuel, @JsonKey(name: 'compteur_electricite_individuel')  bool compteurElectriciteIndividuel,  List<String> equipements,  String disponibilite, @JsonKey(name: 'disponible_a_partir_du')  String? disponibleAPartirDu, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom,  String secteur, @JsonKey(name: 'adresse_reperes')  String adresseReperes, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_logements')  List<LogementResume> autresLogements)?  $default,) {final _that = this;
switch (_that) {
case _Logement() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeLogement,_that.typeLogementLibelle,_that.nbChambres,_that.nbSalons,_that.nbSallesDeBain,_that.surfaceM2,_that.meuble,_that.loyer,_that.cautionMois,_that.avanceMois,_that.fraisAgence,_that.compteurEauIndividuel,_that.compteurElectriciteIndividuel,_that.equipements,_that.disponibilite,_that.disponibleAPartirDu,_that.localiteNom,_that.quartierNom,_that.secteur,_that.adresseReperes,_that.latitude,_that.longitude,_that.loueur,_that.autresLogements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Logement extends Logement {
  const _Logement({required this.id, this.titre = '', this.description = '', final  List<String> galerie = const <String>[], final  List<Panorama> panoramas = const <Panorama>[], @JsonKey(name: 'type_logement') this.typeLogement = '', @JsonKey(name: 'type_logement_libelle') this.typeLogementLibelle = '', @JsonKey(name: 'nb_chambres', fromJson: versInt) this.nbChambres = 0, @JsonKey(name: 'nb_salons', fromJson: versInt) this.nbSalons = 0, @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) this.nbSallesDeBain = 0, @JsonKey(name: 'surface_m2', fromJson: versIntNullable) this.surfaceM2, this.meuble = false, @JsonKey(fromJson: versInt) this.loyer = 0, @JsonKey(name: 'caution_mois', fromJson: versIntNullable) this.cautionMois, @JsonKey(name: 'avance_mois', fromJson: versIntNullable) this.avanceMois, @JsonKey(name: 'frais_agence', fromJson: versIntNullable) this.fraisAgence, @JsonKey(name: 'compteur_eau_individuel') this.compteurEauIndividuel = false, @JsonKey(name: 'compteur_electricite_individuel') this.compteurElectriciteIndividuel = false, final  List<String> equipements = const <String>[], this.disponibilite = '', @JsonKey(name: 'disponible_a_partir_du') this.disponibleAPartirDu, @JsonKey(name: 'localite_nom') this.localiteNom, @JsonKey(name: 'quartier_nom') this.quartierNom, this.secteur = '', @JsonKey(name: 'adresse_reperes') this.adresseReperes = '', @JsonKey(fromJson: versDoubleNullable) this.latitude, @JsonKey(fromJson: versDoubleNullable) this.longitude, this.loueur, @JsonKey(name: 'autres_logements') final  List<LogementResume> autresLogements = const <LogementResume>[]}): _galerie = galerie,_panoramas = panoramas,_equipements = equipements,_autresLogements = autresLogements,super._();
  factory _Logement.fromJson(Map<String, dynamic> json) => _$LogementFromJson(json);

@override final  int id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String description;
 final  List<String> _galerie;
@override@JsonKey() List<String> get galerie {
  if (_galerie is EqualUnmodifiableListView) return _galerie;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_galerie);
}

 final  List<Panorama> _panoramas;
@override@JsonKey() List<Panorama> get panoramas {
  if (_panoramas is EqualUnmodifiableListView) return _panoramas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_panoramas);
}

@override@JsonKey(name: 'type_logement') final  String typeLogement;
@override@JsonKey(name: 'type_logement_libelle') final  String typeLogementLibelle;
@override@JsonKey(name: 'nb_chambres', fromJson: versInt) final  int nbChambres;
@override@JsonKey(name: 'nb_salons', fromJson: versInt) final  int nbSalons;
@override@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) final  int nbSallesDeBain;
@override@JsonKey(name: 'surface_m2', fromJson: versIntNullable) final  int? surfaceM2;
@override@JsonKey() final  bool meuble;
@override@JsonKey(fromJson: versInt) final  int loyer;
@override@JsonKey(name: 'caution_mois', fromJson: versIntNullable) final  int? cautionMois;
@override@JsonKey(name: 'avance_mois', fromJson: versIntNullable) final  int? avanceMois;
@override@JsonKey(name: 'frais_agence', fromJson: versIntNullable) final  int? fraisAgence;
@override@JsonKey(name: 'compteur_eau_individuel') final  bool compteurEauIndividuel;
@override@JsonKey(name: 'compteur_electricite_individuel') final  bool compteurElectriciteIndividuel;
 final  List<String> _equipements;
@override@JsonKey() List<String> get equipements {
  if (_equipements is EqualUnmodifiableListView) return _equipements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipements);
}

@override@JsonKey() final  String disponibilite;
@override@JsonKey(name: 'disponible_a_partir_du') final  String? disponibleAPartirDu;
@override@JsonKey(name: 'localite_nom') final  String? localiteNom;
@override@JsonKey(name: 'quartier_nom') final  String? quartierNom;
@override@JsonKey() final  String secteur;
@override@JsonKey(name: 'adresse_reperes') final  String adresseReperes;
@override@JsonKey(fromJson: versDoubleNullable) final  double? latitude;
@override@JsonKey(fromJson: versDoubleNullable) final  double? longitude;
@override final  Loueur? loueur;
 final  List<LogementResume> _autresLogements;
@override@JsonKey(name: 'autres_logements') List<LogementResume> get autresLogements {
  if (_autresLogements is EqualUnmodifiableListView) return _autresLogements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autresLogements);
}


/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogementCopyWith<_Logement> get copyWith => __$LogementCopyWithImpl<_Logement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Logement&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._galerie, _galerie)&&const DeepCollectionEquality().equals(other._panoramas, _panoramas)&&(identical(other.typeLogement, typeLogement) || other.typeLogement == typeLogement)&&(identical(other.typeLogementLibelle, typeLogementLibelle) || other.typeLogementLibelle == typeLogementLibelle)&&(identical(other.nbChambres, nbChambres) || other.nbChambres == nbChambres)&&(identical(other.nbSalons, nbSalons) || other.nbSalons == nbSalons)&&(identical(other.nbSallesDeBain, nbSallesDeBain) || other.nbSallesDeBain == nbSallesDeBain)&&(identical(other.surfaceM2, surfaceM2) || other.surfaceM2 == surfaceM2)&&(identical(other.meuble, meuble) || other.meuble == meuble)&&(identical(other.loyer, loyer) || other.loyer == loyer)&&(identical(other.cautionMois, cautionMois) || other.cautionMois == cautionMois)&&(identical(other.avanceMois, avanceMois) || other.avanceMois == avanceMois)&&(identical(other.fraisAgence, fraisAgence) || other.fraisAgence == fraisAgence)&&(identical(other.compteurEauIndividuel, compteurEauIndividuel) || other.compteurEauIndividuel == compteurEauIndividuel)&&(identical(other.compteurElectriciteIndividuel, compteurElectriciteIndividuel) || other.compteurElectriciteIndividuel == compteurElectriciteIndividuel)&&const DeepCollectionEquality().equals(other._equipements, _equipements)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.disponibleAPartirDu, disponibleAPartirDu) || other.disponibleAPartirDu == disponibleAPartirDu)&&(identical(other.localiteNom, localiteNom) || other.localiteNom == localiteNom)&&(identical(other.quartierNom, quartierNom) || other.quartierNom == quartierNom)&&(identical(other.secteur, secteur) || other.secteur == secteur)&&(identical(other.adresseReperes, adresseReperes) || other.adresseReperes == adresseReperes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other._autresLogements, _autresLogements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(_galerie),const DeepCollectionEquality().hash(_panoramas),typeLogement,typeLogementLibelle,nbChambres,nbSalons,nbSallesDeBain,surfaceM2,meuble,loyer,cautionMois,avanceMois,fraisAgence,compteurEauIndividuel,compteurElectriciteIndividuel,const DeepCollectionEquality().hash(_equipements),disponibilite,disponibleAPartirDu,localiteNom,quartierNom,secteur,adresseReperes,latitude,longitude,loueur,const DeepCollectionEquality().hash(_autresLogements)]);

@override
String toString() {
  return 'Logement(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, typeLogement: $typeLogement, typeLogementLibelle: $typeLogementLibelle, nbChambres: $nbChambres, nbSalons: $nbSalons, nbSallesDeBain: $nbSallesDeBain, surfaceM2: $surfaceM2, meuble: $meuble, loyer: $loyer, cautionMois: $cautionMois, avanceMois: $avanceMois, fraisAgence: $fraisAgence, compteurEauIndividuel: $compteurEauIndividuel, compteurElectriciteIndividuel: $compteurElectriciteIndividuel, equipements: $equipements, disponibilite: $disponibilite, disponibleAPartirDu: $disponibleAPartirDu, localiteNom: $localiteNom, quartierNom: $quartierNom, secteur: $secteur, adresseReperes: $adresseReperes, latitude: $latitude, longitude: $longitude, loueur: $loueur, autresLogements: $autresLogements)';
}


}

/// @nodoc
abstract mixin class _$LogementCopyWith<$Res> implements $LogementCopyWith<$Res> {
  factory _$LogementCopyWith(_Logement value, $Res Function(_Logement) _then) = __$LogementCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(name: 'type_logement') String typeLogement,@JsonKey(name: 'type_logement_libelle') String typeLogementLibelle,@JsonKey(name: 'nb_chambres', fromJson: versInt) int nbChambres,@JsonKey(name: 'nb_salons', fromJson: versInt) int nbSalons,@JsonKey(name: 'nb_salles_de_bain', fromJson: versInt) int nbSallesDeBain,@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2, bool meuble,@JsonKey(fromJson: versInt) int loyer,@JsonKey(name: 'caution_mois', fromJson: versIntNullable) int? cautionMois,@JsonKey(name: 'avance_mois', fromJson: versIntNullable) int? avanceMois,@JsonKey(name: 'frais_agence', fromJson: versIntNullable) int? fraisAgence,@JsonKey(name: 'compteur_eau_individuel') bool compteurEauIndividuel,@JsonKey(name: 'compteur_electricite_individuel') bool compteurElectriciteIndividuel, List<String> equipements, String disponibilite,@JsonKey(name: 'disponible_a_partir_du') String? disponibleAPartirDu,@JsonKey(name: 'localite_nom') String? localiteNom,@JsonKey(name: 'quartier_nom') String? quartierNom, String secteur,@JsonKey(name: 'adresse_reperes') String adresseReperes,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude, Loueur? loueur,@JsonKey(name: 'autres_logements') List<LogementResume> autresLogements
});


@override $LoueurCopyWith<$Res>? get loueur;

}
/// @nodoc
class __$LogementCopyWithImpl<$Res>
    implements _$LogementCopyWith<$Res> {
  __$LogementCopyWithImpl(this._self, this._then);

  final _Logement _self;
  final $Res Function(_Logement) _then;

/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? typeLogement = null,Object? typeLogementLibelle = null,Object? nbChambres = null,Object? nbSalons = null,Object? nbSallesDeBain = null,Object? surfaceM2 = freezed,Object? meuble = null,Object? loyer = null,Object? cautionMois = freezed,Object? avanceMois = freezed,Object? fraisAgence = freezed,Object? compteurEauIndividuel = null,Object? compteurElectriciteIndividuel = null,Object? equipements = null,Object? disponibilite = null,Object? disponibleAPartirDu = freezed,Object? localiteNom = freezed,Object? quartierNom = freezed,Object? secteur = null,Object? adresseReperes = null,Object? latitude = freezed,Object? longitude = freezed,Object? loueur = freezed,Object? autresLogements = null,}) {
  return _then(_Logement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self._galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self._panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,typeLogement: null == typeLogement ? _self.typeLogement : typeLogement // ignore: cast_nullable_to_non_nullable
as String,typeLogementLibelle: null == typeLogementLibelle ? _self.typeLogementLibelle : typeLogementLibelle // ignore: cast_nullable_to_non_nullable
as String,nbChambres: null == nbChambres ? _self.nbChambres : nbChambres // ignore: cast_nullable_to_non_nullable
as int,nbSalons: null == nbSalons ? _self.nbSalons : nbSalons // ignore: cast_nullable_to_non_nullable
as int,nbSallesDeBain: null == nbSallesDeBain ? _self.nbSallesDeBain : nbSallesDeBain // ignore: cast_nullable_to_non_nullable
as int,surfaceM2: freezed == surfaceM2 ? _self.surfaceM2 : surfaceM2 // ignore: cast_nullable_to_non_nullable
as int?,meuble: null == meuble ? _self.meuble : meuble // ignore: cast_nullable_to_non_nullable
as bool,loyer: null == loyer ? _self.loyer : loyer // ignore: cast_nullable_to_non_nullable
as int,cautionMois: freezed == cautionMois ? _self.cautionMois : cautionMois // ignore: cast_nullable_to_non_nullable
as int?,avanceMois: freezed == avanceMois ? _self.avanceMois : avanceMois // ignore: cast_nullable_to_non_nullable
as int?,fraisAgence: freezed == fraisAgence ? _self.fraisAgence : fraisAgence // ignore: cast_nullable_to_non_nullable
as int?,compteurEauIndividuel: null == compteurEauIndividuel ? _self.compteurEauIndividuel : compteurEauIndividuel // ignore: cast_nullable_to_non_nullable
as bool,compteurElectriciteIndividuel: null == compteurElectriciteIndividuel ? _self.compteurElectriciteIndividuel : compteurElectriciteIndividuel // ignore: cast_nullable_to_non_nullable
as bool,equipements: null == equipements ? _self._equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,disponibleAPartirDu: freezed == disponibleAPartirDu ? _self.disponibleAPartirDu : disponibleAPartirDu // ignore: cast_nullable_to_non_nullable
as String?,localiteNom: freezed == localiteNom ? _self.localiteNom : localiteNom // ignore: cast_nullable_to_non_nullable
as String?,quartierNom: freezed == quartierNom ? _self.quartierNom : quartierNom // ignore: cast_nullable_to_non_nullable
as String?,secteur: null == secteur ? _self.secteur : secteur // ignore: cast_nullable_to_non_nullable
as String,adresseReperes: null == adresseReperes ? _self.adresseReperes : adresseReperes // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,loueur: freezed == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur?,autresLogements: null == autresLogements ? _self._autresLogements : autresLogements // ignore: cast_nullable_to_non_nullable
as List<LogementResume>,
  ));
}

/// Create a copy of Logement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoueurCopyWith<$Res>? get loueur {
    if (_self.loueur == null) {
    return null;
  }

  return $LoueurCopyWith<$Res>(_self.loueur!, (value) {
    return _then(_self.copyWith(loueur: value));
  });
}
}


/// @nodoc
mixin _$DemandeReservation {

 int get id; String get numero;@JsonKey(name: 'nature_libelle') String get natureLibelle;@JsonKey(name: 'objet_nom') String get objetNom;@JsonKey(name: 'partenaire_nom') String get partenaireNom;@JsonKey(name: 'date_souhaitee') String? get dateSouhaitee; String get statut;@JsonKey(name: 'statut_libelle') String get statutLibelle;@JsonKey(name: 'raison_refus') String get raisonRefus;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of DemandeReservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemandeReservationCopyWith<DemandeReservation> get copyWith => _$DemandeReservationCopyWithImpl<DemandeReservation>(this as DemandeReservation, _$identity);

  /// Serializes this DemandeReservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemandeReservation&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.natureLibelle, natureLibelle) || other.natureLibelle == natureLibelle)&&(identical(other.objetNom, objetNom) || other.objetNom == objetNom)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.dateSouhaitee, dateSouhaitee) || other.dateSouhaitee == dateSouhaitee)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.statutLibelle, statutLibelle) || other.statutLibelle == statutLibelle)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,natureLibelle,objetNom,partenaireNom,dateSouhaitee,statut,statutLibelle,raisonRefus,createdAt);

@override
String toString() {
  return 'DemandeReservation(id: $id, numero: $numero, natureLibelle: $natureLibelle, objetNom: $objetNom, partenaireNom: $partenaireNom, dateSouhaitee: $dateSouhaitee, statut: $statut, statutLibelle: $statutLibelle, raisonRefus: $raisonRefus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DemandeReservationCopyWith<$Res>  {
  factory $DemandeReservationCopyWith(DemandeReservation value, $Res Function(DemandeReservation) _then) = _$DemandeReservationCopyWithImpl;
@useResult
$Res call({
 int id, String numero,@JsonKey(name: 'nature_libelle') String natureLibelle,@JsonKey(name: 'objet_nom') String objetNom,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'date_souhaitee') String? dateSouhaitee, String statut,@JsonKey(name: 'statut_libelle') String statutLibelle,@JsonKey(name: 'raison_refus') String raisonRefus,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$DemandeReservationCopyWithImpl<$Res>
    implements $DemandeReservationCopyWith<$Res> {
  _$DemandeReservationCopyWithImpl(this._self, this._then);

  final DemandeReservation _self;
  final $Res Function(DemandeReservation) _then;

/// Create a copy of DemandeReservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? numero = null,Object? natureLibelle = null,Object? objetNom = null,Object? partenaireNom = null,Object? dateSouhaitee = freezed,Object? statut = null,Object? statutLibelle = null,Object? raisonRefus = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,natureLibelle: null == natureLibelle ? _self.natureLibelle : natureLibelle // ignore: cast_nullable_to_non_nullable
as String,objetNom: null == objetNom ? _self.objetNom : objetNom // ignore: cast_nullable_to_non_nullable
as String,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,dateSouhaitee: freezed == dateSouhaitee ? _self.dateSouhaitee : dateSouhaitee // ignore: cast_nullable_to_non_nullable
as String?,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,statutLibelle: null == statutLibelle ? _self.statutLibelle : statutLibelle // ignore: cast_nullable_to_non_nullable
as String,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DemandeReservation].
extension DemandeReservationPatterns on DemandeReservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DemandeReservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DemandeReservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DemandeReservation value)  $default,){
final _that = this;
switch (_that) {
case _DemandeReservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DemandeReservation value)?  $default,){
final _that = this;
switch (_that) {
case _DemandeReservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String numero, @JsonKey(name: 'nature_libelle')  String natureLibelle, @JsonKey(name: 'objet_nom')  String objetNom, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'date_souhaitee')  String? dateSouhaitee,  String statut, @JsonKey(name: 'statut_libelle')  String statutLibelle, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DemandeReservation() when $default != null:
return $default(_that.id,_that.numero,_that.natureLibelle,_that.objetNom,_that.partenaireNom,_that.dateSouhaitee,_that.statut,_that.statutLibelle,_that.raisonRefus,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String numero, @JsonKey(name: 'nature_libelle')  String natureLibelle, @JsonKey(name: 'objet_nom')  String objetNom, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'date_souhaitee')  String? dateSouhaitee,  String statut, @JsonKey(name: 'statut_libelle')  String statutLibelle, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DemandeReservation():
return $default(_that.id,_that.numero,_that.natureLibelle,_that.objetNom,_that.partenaireNom,_that.dateSouhaitee,_that.statut,_that.statutLibelle,_that.raisonRefus,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String numero, @JsonKey(name: 'nature_libelle')  String natureLibelle, @JsonKey(name: 'objet_nom')  String objetNom, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'date_souhaitee')  String? dateSouhaitee,  String statut, @JsonKey(name: 'statut_libelle')  String statutLibelle, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DemandeReservation() when $default != null:
return $default(_that.id,_that.numero,_that.natureLibelle,_that.objetNom,_that.partenaireNom,_that.dateSouhaitee,_that.statut,_that.statutLibelle,_that.raisonRefus,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DemandeReservation extends DemandeReservation {
  const _DemandeReservation({required this.id, this.numero = '', @JsonKey(name: 'nature_libelle') this.natureLibelle = '', @JsonKey(name: 'objet_nom') this.objetNom = '', @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', @JsonKey(name: 'date_souhaitee') this.dateSouhaitee, this.statut = '', @JsonKey(name: 'statut_libelle') this.statutLibelle = '', @JsonKey(name: 'raison_refus') this.raisonRefus = '', @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _DemandeReservation.fromJson(Map<String, dynamic> json) => _$DemandeReservationFromJson(json);

@override final  int id;
@override@JsonKey() final  String numero;
@override@JsonKey(name: 'nature_libelle') final  String natureLibelle;
@override@JsonKey(name: 'objet_nom') final  String objetNom;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override@JsonKey(name: 'date_souhaitee') final  String? dateSouhaitee;
@override@JsonKey() final  String statut;
@override@JsonKey(name: 'statut_libelle') final  String statutLibelle;
@override@JsonKey(name: 'raison_refus') final  String raisonRefus;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of DemandeReservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DemandeReservationCopyWith<_DemandeReservation> get copyWith => __$DemandeReservationCopyWithImpl<_DemandeReservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DemandeReservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DemandeReservation&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.natureLibelle, natureLibelle) || other.natureLibelle == natureLibelle)&&(identical(other.objetNom, objetNom) || other.objetNom == objetNom)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.dateSouhaitee, dateSouhaitee) || other.dateSouhaitee == dateSouhaitee)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.statutLibelle, statutLibelle) || other.statutLibelle == statutLibelle)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,natureLibelle,objetNom,partenaireNom,dateSouhaitee,statut,statutLibelle,raisonRefus,createdAt);

@override
String toString() {
  return 'DemandeReservation(id: $id, numero: $numero, natureLibelle: $natureLibelle, objetNom: $objetNom, partenaireNom: $partenaireNom, dateSouhaitee: $dateSouhaitee, statut: $statut, statutLibelle: $statutLibelle, raisonRefus: $raisonRefus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DemandeReservationCopyWith<$Res> implements $DemandeReservationCopyWith<$Res> {
  factory _$DemandeReservationCopyWith(_DemandeReservation value, $Res Function(_DemandeReservation) _then) = __$DemandeReservationCopyWithImpl;
@override @useResult
$Res call({
 int id, String numero,@JsonKey(name: 'nature_libelle') String natureLibelle,@JsonKey(name: 'objet_nom') String objetNom,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'date_souhaitee') String? dateSouhaitee, String statut,@JsonKey(name: 'statut_libelle') String statutLibelle,@JsonKey(name: 'raison_refus') String raisonRefus,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$DemandeReservationCopyWithImpl<$Res>
    implements _$DemandeReservationCopyWith<$Res> {
  __$DemandeReservationCopyWithImpl(this._self, this._then);

  final _DemandeReservation _self;
  final $Res Function(_DemandeReservation) _then;

/// Create a copy of DemandeReservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? numero = null,Object? natureLibelle = null,Object? objetNom = null,Object? partenaireNom = null,Object? dateSouhaitee = freezed,Object? statut = null,Object? statutLibelle = null,Object? raisonRefus = null,Object? createdAt = freezed,}) {
  return _then(_DemandeReservation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,natureLibelle: null == natureLibelle ? _self.natureLibelle : natureLibelle // ignore: cast_nullable_to_non_nullable
as String,objetNom: null == objetNom ? _self.objetNom : objetNom // ignore: cast_nullable_to_non_nullable
as String,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,dateSouhaitee: freezed == dateSouhaitee ? _self.dateSouhaitee : dateSouhaitee // ignore: cast_nullable_to_non_nullable
as String?,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,statutLibelle: null == statutLibelle ? _self.statutLibelle : statutLibelle // ignore: cast_nullable_to_non_nullable
as String,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
