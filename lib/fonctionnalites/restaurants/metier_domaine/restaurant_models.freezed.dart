// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HoraireJour {

@JsonKey(name: 'jour_semaine') int get jourSemaine; bool get ouvert;@JsonKey(name: 'heure_ouverture') String? get heureOuverture;@JsonKey(name: 'heure_fermeture') String? get heureFermeture;@JsonKey(name: 'pause_debut') String? get pauseDebut;@JsonKey(name: 'pause_fin') String? get pauseFin; String get note;
/// Create a copy of HoraireJour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoraireJourCopyWith<HoraireJour> get copyWith => _$HoraireJourCopyWithImpl<HoraireJour>(this as HoraireJour, _$identity);

  /// Serializes this HoraireJour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoraireJour&&(identical(other.jourSemaine, jourSemaine) || other.jourSemaine == jourSemaine)&&(identical(other.ouvert, ouvert) || other.ouvert == ouvert)&&(identical(other.heureOuverture, heureOuverture) || other.heureOuverture == heureOuverture)&&(identical(other.heureFermeture, heureFermeture) || other.heureFermeture == heureFermeture)&&(identical(other.pauseDebut, pauseDebut) || other.pauseDebut == pauseDebut)&&(identical(other.pauseFin, pauseFin) || other.pauseFin == pauseFin)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jourSemaine,ouvert,heureOuverture,heureFermeture,pauseDebut,pauseFin,note);

@override
String toString() {
  return 'HoraireJour(jourSemaine: $jourSemaine, ouvert: $ouvert, heureOuverture: $heureOuverture, heureFermeture: $heureFermeture, pauseDebut: $pauseDebut, pauseFin: $pauseFin, note: $note)';
}


}

/// @nodoc
abstract mixin class $HoraireJourCopyWith<$Res>  {
  factory $HoraireJourCopyWith(HoraireJour value, $Res Function(HoraireJour) _then) = _$HoraireJourCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'jour_semaine') int jourSemaine, bool ouvert,@JsonKey(name: 'heure_ouverture') String? heureOuverture,@JsonKey(name: 'heure_fermeture') String? heureFermeture,@JsonKey(name: 'pause_debut') String? pauseDebut,@JsonKey(name: 'pause_fin') String? pauseFin, String note
});




}
/// @nodoc
class _$HoraireJourCopyWithImpl<$Res>
    implements $HoraireJourCopyWith<$Res> {
  _$HoraireJourCopyWithImpl(this._self, this._then);

  final HoraireJour _self;
  final $Res Function(HoraireJour) _then;

/// Create a copy of HoraireJour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jourSemaine = null,Object? ouvert = null,Object? heureOuverture = freezed,Object? heureFermeture = freezed,Object? pauseDebut = freezed,Object? pauseFin = freezed,Object? note = null,}) {
  return _then(_self.copyWith(
jourSemaine: null == jourSemaine ? _self.jourSemaine : jourSemaine // ignore: cast_nullable_to_non_nullable
as int,ouvert: null == ouvert ? _self.ouvert : ouvert // ignore: cast_nullable_to_non_nullable
as bool,heureOuverture: freezed == heureOuverture ? _self.heureOuverture : heureOuverture // ignore: cast_nullable_to_non_nullable
as String?,heureFermeture: freezed == heureFermeture ? _self.heureFermeture : heureFermeture // ignore: cast_nullable_to_non_nullable
as String?,pauseDebut: freezed == pauseDebut ? _self.pauseDebut : pauseDebut // ignore: cast_nullable_to_non_nullable
as String?,pauseFin: freezed == pauseFin ? _self.pauseFin : pauseFin // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HoraireJour].
extension HoraireJourPatterns on HoraireJour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HoraireJour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HoraireJour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HoraireJour value)  $default,){
final _that = this;
switch (_that) {
case _HoraireJour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HoraireJour value)?  $default,){
final _that = this;
switch (_that) {
case _HoraireJour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'jour_semaine')  int jourSemaine,  bool ouvert, @JsonKey(name: 'heure_ouverture')  String? heureOuverture, @JsonKey(name: 'heure_fermeture')  String? heureFermeture, @JsonKey(name: 'pause_debut')  String? pauseDebut, @JsonKey(name: 'pause_fin')  String? pauseFin,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HoraireJour() when $default != null:
return $default(_that.jourSemaine,_that.ouvert,_that.heureOuverture,_that.heureFermeture,_that.pauseDebut,_that.pauseFin,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'jour_semaine')  int jourSemaine,  bool ouvert, @JsonKey(name: 'heure_ouverture')  String? heureOuverture, @JsonKey(name: 'heure_fermeture')  String? heureFermeture, @JsonKey(name: 'pause_debut')  String? pauseDebut, @JsonKey(name: 'pause_fin')  String? pauseFin,  String note)  $default,) {final _that = this;
switch (_that) {
case _HoraireJour():
return $default(_that.jourSemaine,_that.ouvert,_that.heureOuverture,_that.heureFermeture,_that.pauseDebut,_that.pauseFin,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'jour_semaine')  int jourSemaine,  bool ouvert, @JsonKey(name: 'heure_ouverture')  String? heureOuverture, @JsonKey(name: 'heure_fermeture')  String? heureFermeture, @JsonKey(name: 'pause_debut')  String? pauseDebut, @JsonKey(name: 'pause_fin')  String? pauseFin,  String note)?  $default,) {final _that = this;
switch (_that) {
case _HoraireJour() when $default != null:
return $default(_that.jourSemaine,_that.ouvert,_that.heureOuverture,_that.heureFermeture,_that.pauseDebut,_that.pauseFin,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HoraireJour implements HoraireJour {
  const _HoraireJour({@JsonKey(name: 'jour_semaine') this.jourSemaine = 0, this.ouvert = false, @JsonKey(name: 'heure_ouverture') this.heureOuverture, @JsonKey(name: 'heure_fermeture') this.heureFermeture, @JsonKey(name: 'pause_debut') this.pauseDebut, @JsonKey(name: 'pause_fin') this.pauseFin, this.note = ''});
  factory _HoraireJour.fromJson(Map<String, dynamic> json) => _$HoraireJourFromJson(json);

@override@JsonKey(name: 'jour_semaine') final  int jourSemaine;
@override@JsonKey() final  bool ouvert;
@override@JsonKey(name: 'heure_ouverture') final  String? heureOuverture;
@override@JsonKey(name: 'heure_fermeture') final  String? heureFermeture;
@override@JsonKey(name: 'pause_debut') final  String? pauseDebut;
@override@JsonKey(name: 'pause_fin') final  String? pauseFin;
@override@JsonKey() final  String note;

/// Create a copy of HoraireJour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoraireJourCopyWith<_HoraireJour> get copyWith => __$HoraireJourCopyWithImpl<_HoraireJour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoraireJourToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoraireJour&&(identical(other.jourSemaine, jourSemaine) || other.jourSemaine == jourSemaine)&&(identical(other.ouvert, ouvert) || other.ouvert == ouvert)&&(identical(other.heureOuverture, heureOuverture) || other.heureOuverture == heureOuverture)&&(identical(other.heureFermeture, heureFermeture) || other.heureFermeture == heureFermeture)&&(identical(other.pauseDebut, pauseDebut) || other.pauseDebut == pauseDebut)&&(identical(other.pauseFin, pauseFin) || other.pauseFin == pauseFin)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jourSemaine,ouvert,heureOuverture,heureFermeture,pauseDebut,pauseFin,note);

@override
String toString() {
  return 'HoraireJour(jourSemaine: $jourSemaine, ouvert: $ouvert, heureOuverture: $heureOuverture, heureFermeture: $heureFermeture, pauseDebut: $pauseDebut, pauseFin: $pauseFin, note: $note)';
}


}

/// @nodoc
abstract mixin class _$HoraireJourCopyWith<$Res> implements $HoraireJourCopyWith<$Res> {
  factory _$HoraireJourCopyWith(_HoraireJour value, $Res Function(_HoraireJour) _then) = __$HoraireJourCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'jour_semaine') int jourSemaine, bool ouvert,@JsonKey(name: 'heure_ouverture') String? heureOuverture,@JsonKey(name: 'heure_fermeture') String? heureFermeture,@JsonKey(name: 'pause_debut') String? pauseDebut,@JsonKey(name: 'pause_fin') String? pauseFin, String note
});




}
/// @nodoc
class __$HoraireJourCopyWithImpl<$Res>
    implements _$HoraireJourCopyWith<$Res> {
  __$HoraireJourCopyWithImpl(this._self, this._then);

  final _HoraireJour _self;
  final $Res Function(_HoraireJour) _then;

/// Create a copy of HoraireJour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jourSemaine = null,Object? ouvert = null,Object? heureOuverture = freezed,Object? heureFermeture = freezed,Object? pauseDebut = freezed,Object? pauseFin = freezed,Object? note = null,}) {
  return _then(_HoraireJour(
jourSemaine: null == jourSemaine ? _self.jourSemaine : jourSemaine // ignore: cast_nullable_to_non_nullable
as int,ouvert: null == ouvert ? _self.ouvert : ouvert // ignore: cast_nullable_to_non_nullable
as bool,heureOuverture: freezed == heureOuverture ? _self.heureOuverture : heureOuverture // ignore: cast_nullable_to_non_nullable
as String?,heureFermeture: freezed == heureFermeture ? _self.heureFermeture : heureFermeture // ignore: cast_nullable_to_non_nullable
as String?,pauseDebut: freezed == pauseDebut ? _self.pauseDebut : pauseDebut // ignore: cast_nullable_to_non_nullable
as String?,pauseFin: freezed == pauseFin ? _self.pauseFin : pauseFin // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TelephoneRestaurant {

 String get libelle; String get numero;
/// Create a copy of TelephoneRestaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelephoneRestaurantCopyWith<TelephoneRestaurant> get copyWith => _$TelephoneRestaurantCopyWithImpl<TelephoneRestaurant>(this as TelephoneRestaurant, _$identity);

  /// Serializes this TelephoneRestaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelephoneRestaurant&&(identical(other.libelle, libelle) || other.libelle == libelle)&&(identical(other.numero, numero) || other.numero == numero));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,libelle,numero);

@override
String toString() {
  return 'TelephoneRestaurant(libelle: $libelle, numero: $numero)';
}


}

/// @nodoc
abstract mixin class $TelephoneRestaurantCopyWith<$Res>  {
  factory $TelephoneRestaurantCopyWith(TelephoneRestaurant value, $Res Function(TelephoneRestaurant) _then) = _$TelephoneRestaurantCopyWithImpl;
@useResult
$Res call({
 String libelle, String numero
});




}
/// @nodoc
class _$TelephoneRestaurantCopyWithImpl<$Res>
    implements $TelephoneRestaurantCopyWith<$Res> {
  _$TelephoneRestaurantCopyWithImpl(this._self, this._then);

  final TelephoneRestaurant _self;
  final $Res Function(TelephoneRestaurant) _then;

/// Create a copy of TelephoneRestaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? libelle = null,Object? numero = null,}) {
  return _then(_self.copyWith(
libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TelephoneRestaurant].
extension TelephoneRestaurantPatterns on TelephoneRestaurant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelephoneRestaurant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelephoneRestaurant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelephoneRestaurant value)  $default,){
final _that = this;
switch (_that) {
case _TelephoneRestaurant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelephoneRestaurant value)?  $default,){
final _that = this;
switch (_that) {
case _TelephoneRestaurant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String libelle,  String numero)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelephoneRestaurant() when $default != null:
return $default(_that.libelle,_that.numero);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String libelle,  String numero)  $default,) {final _that = this;
switch (_that) {
case _TelephoneRestaurant():
return $default(_that.libelle,_that.numero);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String libelle,  String numero)?  $default,) {final _that = this;
switch (_that) {
case _TelephoneRestaurant() when $default != null:
return $default(_that.libelle,_that.numero);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelephoneRestaurant implements TelephoneRestaurant {
  const _TelephoneRestaurant({this.libelle = '', this.numero = ''});
  factory _TelephoneRestaurant.fromJson(Map<String, dynamic> json) => _$TelephoneRestaurantFromJson(json);

@override@JsonKey() final  String libelle;
@override@JsonKey() final  String numero;

/// Create a copy of TelephoneRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelephoneRestaurantCopyWith<_TelephoneRestaurant> get copyWith => __$TelephoneRestaurantCopyWithImpl<_TelephoneRestaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelephoneRestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelephoneRestaurant&&(identical(other.libelle, libelle) || other.libelle == libelle)&&(identical(other.numero, numero) || other.numero == numero));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,libelle,numero);

@override
String toString() {
  return 'TelephoneRestaurant(libelle: $libelle, numero: $numero)';
}


}

/// @nodoc
abstract mixin class _$TelephoneRestaurantCopyWith<$Res> implements $TelephoneRestaurantCopyWith<$Res> {
  factory _$TelephoneRestaurantCopyWith(_TelephoneRestaurant value, $Res Function(_TelephoneRestaurant) _then) = __$TelephoneRestaurantCopyWithImpl;
@override @useResult
$Res call({
 String libelle, String numero
});




}
/// @nodoc
class __$TelephoneRestaurantCopyWithImpl<$Res>
    implements _$TelephoneRestaurantCopyWith<$Res> {
  __$TelephoneRestaurantCopyWithImpl(this._self, this._then);

  final _TelephoneRestaurant _self;
  final $Res Function(_TelephoneRestaurant) _then;

/// Create a copy of TelephoneRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? libelle = null,Object? numero = null,}) {
  return _then(_TelephoneRestaurant(
libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FicheRestaurant {

 List<String> get services;@JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable) int? get delaiPreparationMin;@JsonKey(name: 'adresse_reperes') String get adresseReperes; String get facebook; String get instagram; String get tiktok; List<String> get specialites; List<HoraireJour> get horaires; List<TelephoneRestaurant> get telephones;
/// Create a copy of FicheRestaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FicheRestaurantCopyWith<FicheRestaurant> get copyWith => _$FicheRestaurantCopyWithImpl<FicheRestaurant>(this as FicheRestaurant, _$identity);

  /// Serializes this FicheRestaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FicheRestaurant&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.delaiPreparationMin, delaiPreparationMin) || other.delaiPreparationMin == delaiPreparationMin)&&(identical(other.adresseReperes, adresseReperes) || other.adresseReperes == adresseReperes)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.tiktok, tiktok) || other.tiktok == tiktok)&&const DeepCollectionEquality().equals(other.specialites, specialites)&&const DeepCollectionEquality().equals(other.horaires, horaires)&&const DeepCollectionEquality().equals(other.telephones, telephones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(services),delaiPreparationMin,adresseReperes,facebook,instagram,tiktok,const DeepCollectionEquality().hash(specialites),const DeepCollectionEquality().hash(horaires),const DeepCollectionEquality().hash(telephones));

@override
String toString() {
  return 'FicheRestaurant(services: $services, delaiPreparationMin: $delaiPreparationMin, adresseReperes: $adresseReperes, facebook: $facebook, instagram: $instagram, tiktok: $tiktok, specialites: $specialites, horaires: $horaires, telephones: $telephones)';
}


}

/// @nodoc
abstract mixin class $FicheRestaurantCopyWith<$Res>  {
  factory $FicheRestaurantCopyWith(FicheRestaurant value, $Res Function(FicheRestaurant) _then) = _$FicheRestaurantCopyWithImpl;
@useResult
$Res call({
 List<String> services,@JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable) int? delaiPreparationMin,@JsonKey(name: 'adresse_reperes') String adresseReperes, String facebook, String instagram, String tiktok, List<String> specialites, List<HoraireJour> horaires, List<TelephoneRestaurant> telephones
});




}
/// @nodoc
class _$FicheRestaurantCopyWithImpl<$Res>
    implements $FicheRestaurantCopyWith<$Res> {
  _$FicheRestaurantCopyWithImpl(this._self, this._then);

  final FicheRestaurant _self;
  final $Res Function(FicheRestaurant) _then;

/// Create a copy of FicheRestaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? services = null,Object? delaiPreparationMin = freezed,Object? adresseReperes = null,Object? facebook = null,Object? instagram = null,Object? tiktok = null,Object? specialites = null,Object? horaires = null,Object? telephones = null,}) {
  return _then(_self.copyWith(
services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<String>,delaiPreparationMin: freezed == delaiPreparationMin ? _self.delaiPreparationMin : delaiPreparationMin // ignore: cast_nullable_to_non_nullable
as int?,adresseReperes: null == adresseReperes ? _self.adresseReperes : adresseReperes // ignore: cast_nullable_to_non_nullable
as String,facebook: null == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,tiktok: null == tiktok ? _self.tiktok : tiktok // ignore: cast_nullable_to_non_nullable
as String,specialites: null == specialites ? _self.specialites : specialites // ignore: cast_nullable_to_non_nullable
as List<String>,horaires: null == horaires ? _self.horaires : horaires // ignore: cast_nullable_to_non_nullable
as List<HoraireJour>,telephones: null == telephones ? _self.telephones : telephones // ignore: cast_nullable_to_non_nullable
as List<TelephoneRestaurant>,
  ));
}

}


/// Adds pattern-matching-related methods to [FicheRestaurant].
extension FicheRestaurantPatterns on FicheRestaurant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FicheRestaurant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FicheRestaurant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FicheRestaurant value)  $default,){
final _that = this;
switch (_that) {
case _FicheRestaurant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FicheRestaurant value)?  $default,){
final _that = this;
switch (_that) {
case _FicheRestaurant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> services, @JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable)  int? delaiPreparationMin, @JsonKey(name: 'adresse_reperes')  String adresseReperes,  String facebook,  String instagram,  String tiktok,  List<String> specialites,  List<HoraireJour> horaires,  List<TelephoneRestaurant> telephones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FicheRestaurant() when $default != null:
return $default(_that.services,_that.delaiPreparationMin,_that.adresseReperes,_that.facebook,_that.instagram,_that.tiktok,_that.specialites,_that.horaires,_that.telephones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> services, @JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable)  int? delaiPreparationMin, @JsonKey(name: 'adresse_reperes')  String adresseReperes,  String facebook,  String instagram,  String tiktok,  List<String> specialites,  List<HoraireJour> horaires,  List<TelephoneRestaurant> telephones)  $default,) {final _that = this;
switch (_that) {
case _FicheRestaurant():
return $default(_that.services,_that.delaiPreparationMin,_that.adresseReperes,_that.facebook,_that.instagram,_that.tiktok,_that.specialites,_that.horaires,_that.telephones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> services, @JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable)  int? delaiPreparationMin, @JsonKey(name: 'adresse_reperes')  String adresseReperes,  String facebook,  String instagram,  String tiktok,  List<String> specialites,  List<HoraireJour> horaires,  List<TelephoneRestaurant> telephones)?  $default,) {final _that = this;
switch (_that) {
case _FicheRestaurant() when $default != null:
return $default(_that.services,_that.delaiPreparationMin,_that.adresseReperes,_that.facebook,_that.instagram,_that.tiktok,_that.specialites,_that.horaires,_that.telephones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FicheRestaurant implements FicheRestaurant {
  const _FicheRestaurant({final  List<String> services = const <String>[], @JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable) this.delaiPreparationMin, @JsonKey(name: 'adresse_reperes') this.adresseReperes = '', this.facebook = '', this.instagram = '', this.tiktok = '', final  List<String> specialites = const <String>[], final  List<HoraireJour> horaires = const <HoraireJour>[], final  List<TelephoneRestaurant> telephones = const <TelephoneRestaurant>[]}): _services = services,_specialites = specialites,_horaires = horaires,_telephones = telephones;
  factory _FicheRestaurant.fromJson(Map<String, dynamic> json) => _$FicheRestaurantFromJson(json);

 final  List<String> _services;
@override@JsonKey() List<String> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

@override@JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable) final  int? delaiPreparationMin;
@override@JsonKey(name: 'adresse_reperes') final  String adresseReperes;
@override@JsonKey() final  String facebook;
@override@JsonKey() final  String instagram;
@override@JsonKey() final  String tiktok;
 final  List<String> _specialites;
@override@JsonKey() List<String> get specialites {
  if (_specialites is EqualUnmodifiableListView) return _specialites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialites);
}

 final  List<HoraireJour> _horaires;
@override@JsonKey() List<HoraireJour> get horaires {
  if (_horaires is EqualUnmodifiableListView) return _horaires;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_horaires);
}

 final  List<TelephoneRestaurant> _telephones;
@override@JsonKey() List<TelephoneRestaurant> get telephones {
  if (_telephones is EqualUnmodifiableListView) return _telephones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telephones);
}


/// Create a copy of FicheRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FicheRestaurantCopyWith<_FicheRestaurant> get copyWith => __$FicheRestaurantCopyWithImpl<_FicheRestaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FicheRestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FicheRestaurant&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.delaiPreparationMin, delaiPreparationMin) || other.delaiPreparationMin == delaiPreparationMin)&&(identical(other.adresseReperes, adresseReperes) || other.adresseReperes == adresseReperes)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.tiktok, tiktok) || other.tiktok == tiktok)&&const DeepCollectionEquality().equals(other._specialites, _specialites)&&const DeepCollectionEquality().equals(other._horaires, _horaires)&&const DeepCollectionEquality().equals(other._telephones, _telephones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_services),delaiPreparationMin,adresseReperes,facebook,instagram,tiktok,const DeepCollectionEquality().hash(_specialites),const DeepCollectionEquality().hash(_horaires),const DeepCollectionEquality().hash(_telephones));

@override
String toString() {
  return 'FicheRestaurant(services: $services, delaiPreparationMin: $delaiPreparationMin, adresseReperes: $adresseReperes, facebook: $facebook, instagram: $instagram, tiktok: $tiktok, specialites: $specialites, horaires: $horaires, telephones: $telephones)';
}


}

/// @nodoc
abstract mixin class _$FicheRestaurantCopyWith<$Res> implements $FicheRestaurantCopyWith<$Res> {
  factory _$FicheRestaurantCopyWith(_FicheRestaurant value, $Res Function(_FicheRestaurant) _then) = __$FicheRestaurantCopyWithImpl;
@override @useResult
$Res call({
 List<String> services,@JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable) int? delaiPreparationMin,@JsonKey(name: 'adresse_reperes') String adresseReperes, String facebook, String instagram, String tiktok, List<String> specialites, List<HoraireJour> horaires, List<TelephoneRestaurant> telephones
});




}
/// @nodoc
class __$FicheRestaurantCopyWithImpl<$Res>
    implements _$FicheRestaurantCopyWith<$Res> {
  __$FicheRestaurantCopyWithImpl(this._self, this._then);

  final _FicheRestaurant _self;
  final $Res Function(_FicheRestaurant) _then;

/// Create a copy of FicheRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? services = null,Object? delaiPreparationMin = freezed,Object? adresseReperes = null,Object? facebook = null,Object? instagram = null,Object? tiktok = null,Object? specialites = null,Object? horaires = null,Object? telephones = null,}) {
  return _then(_FicheRestaurant(
services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<String>,delaiPreparationMin: freezed == delaiPreparationMin ? _self.delaiPreparationMin : delaiPreparationMin // ignore: cast_nullable_to_non_nullable
as int?,adresseReperes: null == adresseReperes ? _self.adresseReperes : adresseReperes // ignore: cast_nullable_to_non_nullable
as String,facebook: null == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,tiktok: null == tiktok ? _self.tiktok : tiktok // ignore: cast_nullable_to_non_nullable
as String,specialites: null == specialites ? _self._specialites : specialites // ignore: cast_nullable_to_non_nullable
as List<String>,horaires: null == horaires ? _self._horaires : horaires // ignore: cast_nullable_to_non_nullable
as List<HoraireJour>,telephones: null == telephones ? _self._telephones : telephones // ignore: cast_nullable_to_non_nullable
as List<TelephoneRestaurant>,
  ));
}


}


/// @nodoc
mixin _$OptionPlat {

 int get id; String get nom;@JsonKey(name: 'prix_supplement', fromJson: versInt) int get prixSupplement;@JsonKey(name: 'est_actif') bool get estActif;
/// Create a copy of OptionPlat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OptionPlatCopyWith<OptionPlat> get copyWith => _$OptionPlatCopyWithImpl<OptionPlat>(this as OptionPlat, _$identity);

  /// Serializes this OptionPlat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptionPlat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estActif, estActif) || other.estActif == estActif));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estActif);

@override
String toString() {
  return 'OptionPlat(id: $id, nom: $nom, prixSupplement: $prixSupplement, estActif: $estActif)';
}


}

/// @nodoc
abstract mixin class $OptionPlatCopyWith<$Res>  {
  factory $OptionPlatCopyWith(OptionPlat value, $Res Function(OptionPlat) _then) = _$OptionPlatCopyWithImpl;
@useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement', fromJson: versInt) int prixSupplement,@JsonKey(name: 'est_actif') bool estActif
});




}
/// @nodoc
class _$OptionPlatCopyWithImpl<$Res>
    implements $OptionPlatCopyWith<$Res> {
  _$OptionPlatCopyWithImpl(this._self, this._then);

  final OptionPlat _self;
  final $Res Function(OptionPlat) _then;

/// Create a copy of OptionPlat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estActif = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as int,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OptionPlat].
extension OptionPlatPatterns on OptionPlat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OptionPlat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OptionPlat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OptionPlat value)  $default,){
final _that = this;
switch (_that) {
case _OptionPlat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OptionPlat value)?  $default,){
final _that = this;
switch (_that) {
case _OptionPlat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_actif')  bool estActif)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OptionPlat() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estActif);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_actif')  bool estActif)  $default,) {final _that = this;
switch (_that) {
case _OptionPlat():
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estActif);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_actif')  bool estActif)?  $default,) {final _that = this;
switch (_that) {
case _OptionPlat() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estActif);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OptionPlat implements OptionPlat {
  const _OptionPlat({required this.id, this.nom = '', @JsonKey(name: 'prix_supplement', fromJson: versInt) this.prixSupplement = 0, @JsonKey(name: 'est_actif') this.estActif = true});
  factory _OptionPlat.fromJson(Map<String, dynamic> json) => _$OptionPlatFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey(name: 'prix_supplement', fromJson: versInt) final  int prixSupplement;
@override@JsonKey(name: 'est_actif') final  bool estActif;

/// Create a copy of OptionPlat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OptionPlatCopyWith<_OptionPlat> get copyWith => __$OptionPlatCopyWithImpl<_OptionPlat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OptionPlatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OptionPlat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estActif, estActif) || other.estActif == estActif));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estActif);

@override
String toString() {
  return 'OptionPlat(id: $id, nom: $nom, prixSupplement: $prixSupplement, estActif: $estActif)';
}


}

/// @nodoc
abstract mixin class _$OptionPlatCopyWith<$Res> implements $OptionPlatCopyWith<$Res> {
  factory _$OptionPlatCopyWith(_OptionPlat value, $Res Function(_OptionPlat) _then) = __$OptionPlatCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement', fromJson: versInt) int prixSupplement,@JsonKey(name: 'est_actif') bool estActif
});




}
/// @nodoc
class __$OptionPlatCopyWithImpl<$Res>
    implements _$OptionPlatCopyWith<$Res> {
  __$OptionPlatCopyWithImpl(this._self, this._then);

  final _OptionPlat _self;
  final $Res Function(_OptionPlat) _then;

/// Create a copy of OptionPlat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estActif = null,}) {
  return _then(_OptionPlat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as int,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$GroupeOptions {

 int get id; String get libelle;@JsonKey(name: 'min_choix', fromJson: versInt) int get minChoix;/// null = pas de plafond.
@JsonKey(name: 'max_choix', fromJson: versIntNullable) int? get maxChoix;@JsonKey(name: 'est_actif') bool get estActif; List<OptionPlat> get options;
/// Create a copy of GroupeOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupeOptionsCopyWith<GroupeOptions> get copyWith => _$GroupeOptionsCopyWithImpl<GroupeOptions>(this as GroupeOptions, _$identity);

  /// Serializes this GroupeOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupeOptions&&(identical(other.id, id) || other.id == id)&&(identical(other.libelle, libelle) || other.libelle == libelle)&&(identical(other.minChoix, minChoix) || other.minChoix == minChoix)&&(identical(other.maxChoix, maxChoix) || other.maxChoix == maxChoix)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,libelle,minChoix,maxChoix,estActif,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'GroupeOptions(id: $id, libelle: $libelle, minChoix: $minChoix, maxChoix: $maxChoix, estActif: $estActif, options: $options)';
}


}

/// @nodoc
abstract mixin class $GroupeOptionsCopyWith<$Res>  {
  factory $GroupeOptionsCopyWith(GroupeOptions value, $Res Function(GroupeOptions) _then) = _$GroupeOptionsCopyWithImpl;
@useResult
$Res call({
 int id, String libelle,@JsonKey(name: 'min_choix', fromJson: versInt) int minChoix,@JsonKey(name: 'max_choix', fromJson: versIntNullable) int? maxChoix,@JsonKey(name: 'est_actif') bool estActif, List<OptionPlat> options
});




}
/// @nodoc
class _$GroupeOptionsCopyWithImpl<$Res>
    implements $GroupeOptionsCopyWith<$Res> {
  _$GroupeOptionsCopyWithImpl(this._self, this._then);

  final GroupeOptions _self;
  final $Res Function(GroupeOptions) _then;

/// Create a copy of GroupeOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? libelle = null,Object? minChoix = null,Object? maxChoix = freezed,Object? estActif = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,minChoix: null == minChoix ? _self.minChoix : minChoix // ignore: cast_nullable_to_non_nullable
as int,maxChoix: freezed == maxChoix ? _self.maxChoix : maxChoix // ignore: cast_nullable_to_non_nullable
as int?,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<OptionPlat>,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupeOptions].
extension GroupeOptionsPatterns on GroupeOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupeOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupeOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupeOptions value)  $default,){
final _that = this;
switch (_that) {
case _GroupeOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupeOptions value)?  $default,){
final _that = this;
switch (_that) {
case _GroupeOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String libelle, @JsonKey(name: 'min_choix', fromJson: versInt)  int minChoix, @JsonKey(name: 'max_choix', fromJson: versIntNullable)  int? maxChoix, @JsonKey(name: 'est_actif')  bool estActif,  List<OptionPlat> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupeOptions() when $default != null:
return $default(_that.id,_that.libelle,_that.minChoix,_that.maxChoix,_that.estActif,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String libelle, @JsonKey(name: 'min_choix', fromJson: versInt)  int minChoix, @JsonKey(name: 'max_choix', fromJson: versIntNullable)  int? maxChoix, @JsonKey(name: 'est_actif')  bool estActif,  List<OptionPlat> options)  $default,) {final _that = this;
switch (_that) {
case _GroupeOptions():
return $default(_that.id,_that.libelle,_that.minChoix,_that.maxChoix,_that.estActif,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String libelle, @JsonKey(name: 'min_choix', fromJson: versInt)  int minChoix, @JsonKey(name: 'max_choix', fromJson: versIntNullable)  int? maxChoix, @JsonKey(name: 'est_actif')  bool estActif,  List<OptionPlat> options)?  $default,) {final _that = this;
switch (_that) {
case _GroupeOptions() when $default != null:
return $default(_that.id,_that.libelle,_that.minChoix,_that.maxChoix,_that.estActif,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupeOptions implements GroupeOptions {
  const _GroupeOptions({required this.id, this.libelle = '', @JsonKey(name: 'min_choix', fromJson: versInt) this.minChoix = 0, @JsonKey(name: 'max_choix', fromJson: versIntNullable) this.maxChoix, @JsonKey(name: 'est_actif') this.estActif = true, final  List<OptionPlat> options = const <OptionPlat>[]}): _options = options;
  factory _GroupeOptions.fromJson(Map<String, dynamic> json) => _$GroupeOptionsFromJson(json);

@override final  int id;
@override@JsonKey() final  String libelle;
@override@JsonKey(name: 'min_choix', fromJson: versInt) final  int minChoix;
/// null = pas de plafond.
@override@JsonKey(name: 'max_choix', fromJson: versIntNullable) final  int? maxChoix;
@override@JsonKey(name: 'est_actif') final  bool estActif;
 final  List<OptionPlat> _options;
@override@JsonKey() List<OptionPlat> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of GroupeOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupeOptionsCopyWith<_GroupeOptions> get copyWith => __$GroupeOptionsCopyWithImpl<_GroupeOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupeOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupeOptions&&(identical(other.id, id) || other.id == id)&&(identical(other.libelle, libelle) || other.libelle == libelle)&&(identical(other.minChoix, minChoix) || other.minChoix == minChoix)&&(identical(other.maxChoix, maxChoix) || other.maxChoix == maxChoix)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,libelle,minChoix,maxChoix,estActif,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'GroupeOptions(id: $id, libelle: $libelle, minChoix: $minChoix, maxChoix: $maxChoix, estActif: $estActif, options: $options)';
}


}

/// @nodoc
abstract mixin class _$GroupeOptionsCopyWith<$Res> implements $GroupeOptionsCopyWith<$Res> {
  factory _$GroupeOptionsCopyWith(_GroupeOptions value, $Res Function(_GroupeOptions) _then) = __$GroupeOptionsCopyWithImpl;
@override @useResult
$Res call({
 int id, String libelle,@JsonKey(name: 'min_choix', fromJson: versInt) int minChoix,@JsonKey(name: 'max_choix', fromJson: versIntNullable) int? maxChoix,@JsonKey(name: 'est_actif') bool estActif, List<OptionPlat> options
});




}
/// @nodoc
class __$GroupeOptionsCopyWithImpl<$Res>
    implements _$GroupeOptionsCopyWith<$Res> {
  __$GroupeOptionsCopyWithImpl(this._self, this._then);

  final _GroupeOptions _self;
  final $Res Function(_GroupeOptions) _then;

/// Create a copy of GroupeOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? libelle = null,Object? minChoix = null,Object? maxChoix = freezed,Object? estActif = null,Object? options = null,}) {
  return _then(_GroupeOptions(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,libelle: null == libelle ? _self.libelle : libelle // ignore: cast_nullable_to_non_nullable
as String,minChoix: null == minChoix ? _self.minChoix : minChoix // ignore: cast_nullable_to_non_nullable
as int,maxChoix: freezed == maxChoix ? _self.maxChoix : maxChoix // ignore: cast_nullable_to_non_nullable
as int?,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<OptionPlat>,
  ));
}


}


/// @nodoc
mixin _$VariantePlat {

 int get id; String get nom;@JsonKey(name: 'prix_supplement', fromJson: versInt) int get prixSupplement;@JsonKey(name: 'est_par_defaut') bool get estParDefaut;@JsonKey(name: 'est_active') bool get estActive;
/// Create a copy of VariantePlat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantePlatCopyWith<VariantePlat> get copyWith => _$VariantePlatCopyWithImpl<VariantePlat>(this as VariantePlat, _$identity);

  /// Serializes this VariantePlat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantePlat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estParDefaut, estParDefaut) || other.estParDefaut == estParDefaut)&&(identical(other.estActive, estActive) || other.estActive == estActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estParDefaut,estActive);

@override
String toString() {
  return 'VariantePlat(id: $id, nom: $nom, prixSupplement: $prixSupplement, estParDefaut: $estParDefaut, estActive: $estActive)';
}


}

/// @nodoc
abstract mixin class $VariantePlatCopyWith<$Res>  {
  factory $VariantePlatCopyWith(VariantePlat value, $Res Function(VariantePlat) _then) = _$VariantePlatCopyWithImpl;
@useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement', fromJson: versInt) int prixSupplement,@JsonKey(name: 'est_par_defaut') bool estParDefaut,@JsonKey(name: 'est_active') bool estActive
});




}
/// @nodoc
class _$VariantePlatCopyWithImpl<$Res>
    implements $VariantePlatCopyWith<$Res> {
  _$VariantePlatCopyWithImpl(this._self, this._then);

  final VariantePlat _self;
  final $Res Function(VariantePlat) _then;

/// Create a copy of VariantePlat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estParDefaut = null,Object? estActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as int,estParDefaut: null == estParDefaut ? _self.estParDefaut : estParDefaut // ignore: cast_nullable_to_non_nullable
as bool,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VariantePlat].
extension VariantePlatPatterns on VariantePlat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VariantePlat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VariantePlat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VariantePlat value)  $default,){
final _that = this;
switch (_that) {
case _VariantePlat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VariantePlat value)?  $default,){
final _that = this;
switch (_that) {
case _VariantePlat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut, @JsonKey(name: 'est_active')  bool estActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VariantePlat() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut,_that.estActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut, @JsonKey(name: 'est_active')  bool estActive)  $default,) {final _that = this;
switch (_that) {
case _VariantePlat():
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut,_that.estActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom, @JsonKey(name: 'prix_supplement', fromJson: versInt)  int prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut, @JsonKey(name: 'est_active')  bool estActive)?  $default,) {final _that = this;
switch (_that) {
case _VariantePlat() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut,_that.estActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VariantePlat implements VariantePlat {
  const _VariantePlat({required this.id, this.nom = '', @JsonKey(name: 'prix_supplement', fromJson: versInt) this.prixSupplement = 0, @JsonKey(name: 'est_par_defaut') this.estParDefaut = false, @JsonKey(name: 'est_active') this.estActive = true});
  factory _VariantePlat.fromJson(Map<String, dynamic> json) => _$VariantePlatFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey(name: 'prix_supplement', fromJson: versInt) final  int prixSupplement;
@override@JsonKey(name: 'est_par_defaut') final  bool estParDefaut;
@override@JsonKey(name: 'est_active') final  bool estActive;

/// Create a copy of VariantePlat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VariantePlatCopyWith<_VariantePlat> get copyWith => __$VariantePlatCopyWithImpl<_VariantePlat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantePlatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VariantePlat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estParDefaut, estParDefaut) || other.estParDefaut == estParDefaut)&&(identical(other.estActive, estActive) || other.estActive == estActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estParDefaut,estActive);

@override
String toString() {
  return 'VariantePlat(id: $id, nom: $nom, prixSupplement: $prixSupplement, estParDefaut: $estParDefaut, estActive: $estActive)';
}


}

/// @nodoc
abstract mixin class _$VariantePlatCopyWith<$Res> implements $VariantePlatCopyWith<$Res> {
  factory _$VariantePlatCopyWith(_VariantePlat value, $Res Function(_VariantePlat) _then) = __$VariantePlatCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement', fromJson: versInt) int prixSupplement,@JsonKey(name: 'est_par_defaut') bool estParDefaut,@JsonKey(name: 'est_active') bool estActive
});




}
/// @nodoc
class __$VariantePlatCopyWithImpl<$Res>
    implements _$VariantePlatCopyWith<$Res> {
  __$VariantePlatCopyWithImpl(this._self, this._then);

  final _VariantePlat _self;
  final $Res Function(_VariantePlat) _then;

/// Create a copy of VariantePlat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estParDefaut = null,Object? estActive = null,}) {
  return _then(_VariantePlat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as int,estParDefaut: null == estParDefaut ? _self.estParDefaut : estParDefaut // ignore: cast_nullable_to_non_nullable
as bool,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Plat {

 int get id; String get nom; String get description;@JsonKey(fromJson: versInt) int get prix;@JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt) int get prixEffectif;@JsonKey(name: 'est_en_promotion') bool get estEnPromotion;@JsonKey(name: 'est_disponible') bool get estDisponible;@JsonKey(name: 'est_epuise') bool get estEpuise;@JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable) int? get tempsPreparationMin;@JsonKey(readValue: _lireImages) List<String> get images; List<VariantePlat> get variantes;@JsonKey(name: 'groupes_options') List<GroupeOptions> get groupesOptions;
/// Create a copy of Plat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatCopyWith<Plat> get copyWith => _$PlatCopyWithImpl<Plat>(this as Plat, _$identity);

  /// Serializes this Plat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixEffectif, prixEffectif) || other.prixEffectif == prixEffectif)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.estEpuise, estEpuise) || other.estEpuise == estEpuise)&&(identical(other.tempsPreparationMin, tempsPreparationMin) || other.tempsPreparationMin == tempsPreparationMin)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.variantes, variantes)&&const DeepCollectionEquality().equals(other.groupesOptions, groupesOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,prix,prixEffectif,estEnPromotion,estDisponible,estEpuise,tempsPreparationMin,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(variantes),const DeepCollectionEquality().hash(groupesOptions));

@override
String toString() {
  return 'Plat(id: $id, nom: $nom, description: $description, prix: $prix, prixEffectif: $prixEffectif, estEnPromotion: $estEnPromotion, estDisponible: $estDisponible, estEpuise: $estEpuise, tempsPreparationMin: $tempsPreparationMin, images: $images, variantes: $variantes, groupesOptions: $groupesOptions)';
}


}

/// @nodoc
abstract mixin class $PlatCopyWith<$Res>  {
  factory $PlatCopyWith(Plat value, $Res Function(Plat) _then) = _$PlatCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String description,@JsonKey(fromJson: versInt) int prix,@JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt) int prixEffectif,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'est_epuise') bool estEpuise,@JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable) int? tempsPreparationMin,@JsonKey(readValue: _lireImages) List<String> images, List<VariantePlat> variantes,@JsonKey(name: 'groupes_options') List<GroupeOptions> groupesOptions
});




}
/// @nodoc
class _$PlatCopyWithImpl<$Res>
    implements $PlatCopyWith<$Res> {
  _$PlatCopyWithImpl(this._self, this._then);

  final Plat _self;
  final $Res Function(Plat) _then;

/// Create a copy of Plat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? prix = null,Object? prixEffectif = null,Object? estEnPromotion = null,Object? estDisponible = null,Object? estEpuise = null,Object? tempsPreparationMin = freezed,Object? images = null,Object? variantes = null,Object? groupesOptions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,prixEffectif: null == prixEffectif ? _self.prixEffectif : prixEffectif // ignore: cast_nullable_to_non_nullable
as int,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,estEpuise: null == estEpuise ? _self.estEpuise : estEpuise // ignore: cast_nullable_to_non_nullable
as bool,tempsPreparationMin: freezed == tempsPreparationMin ? _self.tempsPreparationMin : tempsPreparationMin // ignore: cast_nullable_to_non_nullable
as int?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variantes: null == variantes ? _self.variantes : variantes // ignore: cast_nullable_to_non_nullable
as List<VariantePlat>,groupesOptions: null == groupesOptions ? _self.groupesOptions : groupesOptions // ignore: cast_nullable_to_non_nullable
as List<GroupeOptions>,
  ));
}

}


/// Adds pattern-matching-related methods to [Plat].
extension PlatPatterns on Plat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plat value)  $default,){
final _that = this;
switch (_that) {
case _Plat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plat value)?  $default,){
final _that = this;
switch (_that) {
case _Plat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String description, @JsonKey(fromJson: versInt)  int prix, @JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt)  int prixEffectif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_epuise')  bool estEpuise, @JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable)  int? tempsPreparationMin, @JsonKey(readValue: _lireImages)  List<String> images,  List<VariantePlat> variantes, @JsonKey(name: 'groupes_options')  List<GroupeOptions> groupesOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plat() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.prix,_that.prixEffectif,_that.estEnPromotion,_that.estDisponible,_that.estEpuise,_that.tempsPreparationMin,_that.images,_that.variantes,_that.groupesOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String description, @JsonKey(fromJson: versInt)  int prix, @JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt)  int prixEffectif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_epuise')  bool estEpuise, @JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable)  int? tempsPreparationMin, @JsonKey(readValue: _lireImages)  List<String> images,  List<VariantePlat> variantes, @JsonKey(name: 'groupes_options')  List<GroupeOptions> groupesOptions)  $default,) {final _that = this;
switch (_that) {
case _Plat():
return $default(_that.id,_that.nom,_that.description,_that.prix,_that.prixEffectif,_that.estEnPromotion,_that.estDisponible,_that.estEpuise,_that.tempsPreparationMin,_that.images,_that.variantes,_that.groupesOptions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String description, @JsonKey(fromJson: versInt)  int prix, @JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt)  int prixEffectif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_epuise')  bool estEpuise, @JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable)  int? tempsPreparationMin, @JsonKey(readValue: _lireImages)  List<String> images,  List<VariantePlat> variantes, @JsonKey(name: 'groupes_options')  List<GroupeOptions> groupesOptions)?  $default,) {final _that = this;
switch (_that) {
case _Plat() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.prix,_that.prixEffectif,_that.estEnPromotion,_that.estDisponible,_that.estEpuise,_that.tempsPreparationMin,_that.images,_that.variantes,_that.groupesOptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plat extends Plat {
  const _Plat({required this.id, this.nom = '', this.description = '', @JsonKey(fromJson: versInt) this.prix = 0, @JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt) this.prixEffectif = 0, @JsonKey(name: 'est_en_promotion') this.estEnPromotion = false, @JsonKey(name: 'est_disponible') this.estDisponible = true, @JsonKey(name: 'est_epuise') this.estEpuise = false, @JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable) this.tempsPreparationMin, @JsonKey(readValue: _lireImages) final  List<String> images = const <String>[], final  List<VariantePlat> variantes = const <VariantePlat>[], @JsonKey(name: 'groupes_options') final  List<GroupeOptions> groupesOptions = const <GroupeOptions>[]}): _images = images,_variantes = variantes,_groupesOptions = groupesOptions,super._();
  factory _Plat.fromJson(Map<String, dynamic> json) => _$PlatFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String description;
@override@JsonKey(fromJson: versInt) final  int prix;
@override@JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt) final  int prixEffectif;
@override@JsonKey(name: 'est_en_promotion') final  bool estEnPromotion;
@override@JsonKey(name: 'est_disponible') final  bool estDisponible;
@override@JsonKey(name: 'est_epuise') final  bool estEpuise;
@override@JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable) final  int? tempsPreparationMin;
 final  List<String> _images;
@override@JsonKey(readValue: _lireImages) List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<VariantePlat> _variantes;
@override@JsonKey() List<VariantePlat> get variantes {
  if (_variantes is EqualUnmodifiableListView) return _variantes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variantes);
}

 final  List<GroupeOptions> _groupesOptions;
@override@JsonKey(name: 'groupes_options') List<GroupeOptions> get groupesOptions {
  if (_groupesOptions is EqualUnmodifiableListView) return _groupesOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupesOptions);
}


/// Create a copy of Plat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatCopyWith<_Plat> get copyWith => __$PlatCopyWithImpl<_Plat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plat&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixEffectif, prixEffectif) || other.prixEffectif == prixEffectif)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.estEpuise, estEpuise) || other.estEpuise == estEpuise)&&(identical(other.tempsPreparationMin, tempsPreparationMin) || other.tempsPreparationMin == tempsPreparationMin)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._variantes, _variantes)&&const DeepCollectionEquality().equals(other._groupesOptions, _groupesOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,prix,prixEffectif,estEnPromotion,estDisponible,estEpuise,tempsPreparationMin,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_variantes),const DeepCollectionEquality().hash(_groupesOptions));

@override
String toString() {
  return 'Plat(id: $id, nom: $nom, description: $description, prix: $prix, prixEffectif: $prixEffectif, estEnPromotion: $estEnPromotion, estDisponible: $estDisponible, estEpuise: $estEpuise, tempsPreparationMin: $tempsPreparationMin, images: $images, variantes: $variantes, groupesOptions: $groupesOptions)';
}


}

/// @nodoc
abstract mixin class _$PlatCopyWith<$Res> implements $PlatCopyWith<$Res> {
  factory _$PlatCopyWith(_Plat value, $Res Function(_Plat) _then) = __$PlatCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String description,@JsonKey(fromJson: versInt) int prix,@JsonKey(name: 'prix_effectif', readValue: _lirePrixEffectif, fromJson: versInt) int prixEffectif,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'est_epuise') bool estEpuise,@JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable) int? tempsPreparationMin,@JsonKey(readValue: _lireImages) List<String> images, List<VariantePlat> variantes,@JsonKey(name: 'groupes_options') List<GroupeOptions> groupesOptions
});




}
/// @nodoc
class __$PlatCopyWithImpl<$Res>
    implements _$PlatCopyWith<$Res> {
  __$PlatCopyWithImpl(this._self, this._then);

  final _Plat _self;
  final $Res Function(_Plat) _then;

/// Create a copy of Plat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? prix = null,Object? prixEffectif = null,Object? estEnPromotion = null,Object? estDisponible = null,Object? estEpuise = null,Object? tempsPreparationMin = freezed,Object? images = null,Object? variantes = null,Object? groupesOptions = null,}) {
  return _then(_Plat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,prixEffectif: null == prixEffectif ? _self.prixEffectif : prixEffectif // ignore: cast_nullable_to_non_nullable
as int,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,estEpuise: null == estEpuise ? _self.estEpuise : estEpuise // ignore: cast_nullable_to_non_nullable
as bool,tempsPreparationMin: freezed == tempsPreparationMin ? _self.tempsPreparationMin : tempsPreparationMin // ignore: cast_nullable_to_non_nullable
as int?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variantes: null == variantes ? _self._variantes : variantes // ignore: cast_nullable_to_non_nullable
as List<VariantePlat>,groupesOptions: null == groupesOptions ? _self._groupesOptions : groupesOptions // ignore: cast_nullable_to_non_nullable
as List<GroupeOptions>,
  ));
}


}


/// @nodoc
mixin _$SectionCarte {

 int get id; String get nom; String get description; String get icone; List<Plat> get plats;
/// Create a copy of SectionCarte
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionCarteCopyWith<SectionCarte> get copyWith => _$SectionCarteCopyWithImpl<SectionCarte>(this as SectionCarte, _$identity);

  /// Serializes this SectionCarte to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionCarte&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.icone, icone) || other.icone == icone)&&const DeepCollectionEquality().equals(other.plats, plats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,icone,const DeepCollectionEquality().hash(plats));

@override
String toString() {
  return 'SectionCarte(id: $id, nom: $nom, description: $description, icone: $icone, plats: $plats)';
}


}

/// @nodoc
abstract mixin class $SectionCarteCopyWith<$Res>  {
  factory $SectionCarteCopyWith(SectionCarte value, $Res Function(SectionCarte) _then) = _$SectionCarteCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String description, String icone, List<Plat> plats
});




}
/// @nodoc
class _$SectionCarteCopyWithImpl<$Res>
    implements $SectionCarteCopyWith<$Res> {
  _$SectionCarteCopyWithImpl(this._self, this._then);

  final SectionCarte _self;
  final $Res Function(SectionCarte) _then;

/// Create a copy of SectionCarte
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? icone = null,Object? plats = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,plats: null == plats ? _self.plats : plats // ignore: cast_nullable_to_non_nullable
as List<Plat>,
  ));
}

}


/// Adds pattern-matching-related methods to [SectionCarte].
extension SectionCartePatterns on SectionCarte {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionCarte value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionCarte() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionCarte value)  $default,){
final _that = this;
switch (_that) {
case _SectionCarte():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionCarte value)?  $default,){
final _that = this;
switch (_that) {
case _SectionCarte() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String description,  String icone,  List<Plat> plats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionCarte() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.icone,_that.plats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String description,  String icone,  List<Plat> plats)  $default,) {final _that = this;
switch (_that) {
case _SectionCarte():
return $default(_that.id,_that.nom,_that.description,_that.icone,_that.plats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String description,  String icone,  List<Plat> plats)?  $default,) {final _that = this;
switch (_that) {
case _SectionCarte() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.icone,_that.plats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectionCarte implements SectionCarte {
  const _SectionCarte({required this.id, this.nom = '', this.description = '', this.icone = '', final  List<Plat> plats = const <Plat>[]}): _plats = plats;
  factory _SectionCarte.fromJson(Map<String, dynamic> json) => _$SectionCarteFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String description;
@override@JsonKey() final  String icone;
 final  List<Plat> _plats;
@override@JsonKey() List<Plat> get plats {
  if (_plats is EqualUnmodifiableListView) return _plats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plats);
}


/// Create a copy of SectionCarte
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionCarteCopyWith<_SectionCarte> get copyWith => __$SectionCarteCopyWithImpl<_SectionCarte>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectionCarteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionCarte&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.icone, icone) || other.icone == icone)&&const DeepCollectionEquality().equals(other._plats, _plats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,icone,const DeepCollectionEquality().hash(_plats));

@override
String toString() {
  return 'SectionCarte(id: $id, nom: $nom, description: $description, icone: $icone, plats: $plats)';
}


}

/// @nodoc
abstract mixin class _$SectionCarteCopyWith<$Res> implements $SectionCarteCopyWith<$Res> {
  factory _$SectionCarteCopyWith(_SectionCarte value, $Res Function(_SectionCarte) _then) = __$SectionCarteCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String description, String icone, List<Plat> plats
});




}
/// @nodoc
class __$SectionCarteCopyWithImpl<$Res>
    implements _$SectionCarteCopyWith<$Res> {
  __$SectionCarteCopyWithImpl(this._self, this._then);

  final _SectionCarte _self;
  final $Res Function(_SectionCarte) _then;

/// Create a copy of SectionCarte
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? icone = null,Object? plats = null,}) {
  return _then(_SectionCarte(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,plats: null == plats ? _self._plats : plats // ignore: cast_nullable_to_non_nullable
as List<Plat>,
  ));
}


}


/// @nodoc
mixin _$LigneMenu {

 int get id;/// Plat de la carte auquel la ligne renvoie.
@JsonKey(name: 'plat', fromJson: _versIdPlat) int? get platId;@JsonKey(name: 'plat_nom') String get platNom;@JsonKey(name: 'plat_image') String get image;@JsonKey(name: 'prix_effectif', fromJson: versInt) int get prixEffectif;/// null = stock non suivi (illimité).
@JsonKey(name: 'stock_restant', fromJson: versIntNullable) int? get stockRestant;@JsonKey(name: 'est_epuise') bool get estEpuise;
/// Create a copy of LigneMenu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LigneMenuCopyWith<LigneMenu> get copyWith => _$LigneMenuCopyWithImpl<LigneMenu>(this as LigneMenu, _$identity);

  /// Serializes this LigneMenu to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LigneMenu&&(identical(other.id, id) || other.id == id)&&(identical(other.platId, platId) || other.platId == platId)&&(identical(other.platNom, platNom) || other.platNom == platNom)&&(identical(other.image, image) || other.image == image)&&(identical(other.prixEffectif, prixEffectif) || other.prixEffectif == prixEffectif)&&(identical(other.stockRestant, stockRestant) || other.stockRestant == stockRestant)&&(identical(other.estEpuise, estEpuise) || other.estEpuise == estEpuise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platId,platNom,image,prixEffectif,stockRestant,estEpuise);

@override
String toString() {
  return 'LigneMenu(id: $id, platId: $platId, platNom: $platNom, image: $image, prixEffectif: $prixEffectif, stockRestant: $stockRestant, estEpuise: $estEpuise)';
}


}

/// @nodoc
abstract mixin class $LigneMenuCopyWith<$Res>  {
  factory $LigneMenuCopyWith(LigneMenu value, $Res Function(LigneMenu) _then) = _$LigneMenuCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'plat', fromJson: _versIdPlat) int? platId,@JsonKey(name: 'plat_nom') String platNom,@JsonKey(name: 'plat_image') String image,@JsonKey(name: 'prix_effectif', fromJson: versInt) int prixEffectif,@JsonKey(name: 'stock_restant', fromJson: versIntNullable) int? stockRestant,@JsonKey(name: 'est_epuise') bool estEpuise
});




}
/// @nodoc
class _$LigneMenuCopyWithImpl<$Res>
    implements $LigneMenuCopyWith<$Res> {
  _$LigneMenuCopyWithImpl(this._self, this._then);

  final LigneMenu _self;
  final $Res Function(LigneMenu) _then;

/// Create a copy of LigneMenu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? platId = freezed,Object? platNom = null,Object? image = null,Object? prixEffectif = null,Object? stockRestant = freezed,Object? estEpuise = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,platId: freezed == platId ? _self.platId : platId // ignore: cast_nullable_to_non_nullable
as int?,platNom: null == platNom ? _self.platNom : platNom // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,prixEffectif: null == prixEffectif ? _self.prixEffectif : prixEffectif // ignore: cast_nullable_to_non_nullable
as int,stockRestant: freezed == stockRestant ? _self.stockRestant : stockRestant // ignore: cast_nullable_to_non_nullable
as int?,estEpuise: null == estEpuise ? _self.estEpuise : estEpuise // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LigneMenu].
extension LigneMenuPatterns on LigneMenu {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LigneMenu value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LigneMenu() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LigneMenu value)  $default,){
final _that = this;
switch (_that) {
case _LigneMenu():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LigneMenu value)?  $default,){
final _that = this;
switch (_that) {
case _LigneMenu() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'plat', fromJson: _versIdPlat)  int? platId, @JsonKey(name: 'plat_nom')  String platNom, @JsonKey(name: 'plat_image')  String image, @JsonKey(name: 'prix_effectif', fromJson: versInt)  int prixEffectif, @JsonKey(name: 'stock_restant', fromJson: versIntNullable)  int? stockRestant, @JsonKey(name: 'est_epuise')  bool estEpuise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LigneMenu() when $default != null:
return $default(_that.id,_that.platId,_that.platNom,_that.image,_that.prixEffectif,_that.stockRestant,_that.estEpuise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'plat', fromJson: _versIdPlat)  int? platId, @JsonKey(name: 'plat_nom')  String platNom, @JsonKey(name: 'plat_image')  String image, @JsonKey(name: 'prix_effectif', fromJson: versInt)  int prixEffectif, @JsonKey(name: 'stock_restant', fromJson: versIntNullable)  int? stockRestant, @JsonKey(name: 'est_epuise')  bool estEpuise)  $default,) {final _that = this;
switch (_that) {
case _LigneMenu():
return $default(_that.id,_that.platId,_that.platNom,_that.image,_that.prixEffectif,_that.stockRestant,_that.estEpuise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'plat', fromJson: _versIdPlat)  int? platId, @JsonKey(name: 'plat_nom')  String platNom, @JsonKey(name: 'plat_image')  String image, @JsonKey(name: 'prix_effectif', fromJson: versInt)  int prixEffectif, @JsonKey(name: 'stock_restant', fromJson: versIntNullable)  int? stockRestant, @JsonKey(name: 'est_epuise')  bool estEpuise)?  $default,) {final _that = this;
switch (_that) {
case _LigneMenu() when $default != null:
return $default(_that.id,_that.platId,_that.platNom,_that.image,_that.prixEffectif,_that.stockRestant,_that.estEpuise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LigneMenu extends LigneMenu {
  const _LigneMenu({required this.id, @JsonKey(name: 'plat', fromJson: _versIdPlat) this.platId, @JsonKey(name: 'plat_nom') this.platNom = '', @JsonKey(name: 'plat_image') this.image = '', @JsonKey(name: 'prix_effectif', fromJson: versInt) this.prixEffectif = 0, @JsonKey(name: 'stock_restant', fromJson: versIntNullable) this.stockRestant, @JsonKey(name: 'est_epuise') this.estEpuise = false}): super._();
  factory _LigneMenu.fromJson(Map<String, dynamic> json) => _$LigneMenuFromJson(json);

@override final  int id;
/// Plat de la carte auquel la ligne renvoie.
@override@JsonKey(name: 'plat', fromJson: _versIdPlat) final  int? platId;
@override@JsonKey(name: 'plat_nom') final  String platNom;
@override@JsonKey(name: 'plat_image') final  String image;
@override@JsonKey(name: 'prix_effectif', fromJson: versInt) final  int prixEffectif;
/// null = stock non suivi (illimité).
@override@JsonKey(name: 'stock_restant', fromJson: versIntNullable) final  int? stockRestant;
@override@JsonKey(name: 'est_epuise') final  bool estEpuise;

/// Create a copy of LigneMenu
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LigneMenuCopyWith<_LigneMenu> get copyWith => __$LigneMenuCopyWithImpl<_LigneMenu>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LigneMenuToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LigneMenu&&(identical(other.id, id) || other.id == id)&&(identical(other.platId, platId) || other.platId == platId)&&(identical(other.platNom, platNom) || other.platNom == platNom)&&(identical(other.image, image) || other.image == image)&&(identical(other.prixEffectif, prixEffectif) || other.prixEffectif == prixEffectif)&&(identical(other.stockRestant, stockRestant) || other.stockRestant == stockRestant)&&(identical(other.estEpuise, estEpuise) || other.estEpuise == estEpuise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platId,platNom,image,prixEffectif,stockRestant,estEpuise);

@override
String toString() {
  return 'LigneMenu(id: $id, platId: $platId, platNom: $platNom, image: $image, prixEffectif: $prixEffectif, stockRestant: $stockRestant, estEpuise: $estEpuise)';
}


}

/// @nodoc
abstract mixin class _$LigneMenuCopyWith<$Res> implements $LigneMenuCopyWith<$Res> {
  factory _$LigneMenuCopyWith(_LigneMenu value, $Res Function(_LigneMenu) _then) = __$LigneMenuCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'plat', fromJson: _versIdPlat) int? platId,@JsonKey(name: 'plat_nom') String platNom,@JsonKey(name: 'plat_image') String image,@JsonKey(name: 'prix_effectif', fromJson: versInt) int prixEffectif,@JsonKey(name: 'stock_restant', fromJson: versIntNullable) int? stockRestant,@JsonKey(name: 'est_epuise') bool estEpuise
});




}
/// @nodoc
class __$LigneMenuCopyWithImpl<$Res>
    implements _$LigneMenuCopyWith<$Res> {
  __$LigneMenuCopyWithImpl(this._self, this._then);

  final _LigneMenu _self;
  final $Res Function(_LigneMenu) _then;

/// Create a copy of LigneMenu
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? platId = freezed,Object? platNom = null,Object? image = null,Object? prixEffectif = null,Object? stockRestant = freezed,Object? estEpuise = null,}) {
  return _then(_LigneMenu(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,platId: freezed == platId ? _self.platId : platId // ignore: cast_nullable_to_non_nullable
as int?,platNom: null == platNom ? _self.platNom : platNom // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,prixEffectif: null == prixEffectif ? _self.prixEffectif : prixEffectif // ignore: cast_nullable_to_non_nullable
as int,stockRestant: freezed == stockRestant ? _self.stockRestant : stockRestant // ignore: cast_nullable_to_non_nullable
as int?,estEpuise: null == estEpuise ? _self.estEpuise : estEpuise // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MenuDuJour {

 int get id;/// midi | soir | journee
 String get service; String get titre;@JsonKey(name: 'heure_debut') String? get heureDebut;@JsonKey(name: 'heure_fin') String? get heureFin;@JsonKey(name: 'heure_limite_commande') String? get heureLimiteCommande; bool get commandable; List<LigneMenu> get lignes;
/// Create a copy of MenuDuJour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuDuJourCopyWith<MenuDuJour> get copyWith => _$MenuDuJourCopyWithImpl<MenuDuJour>(this as MenuDuJour, _$identity);

  /// Serializes this MenuDuJour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuDuJour&&(identical(other.id, id) || other.id == id)&&(identical(other.service, service) || other.service == service)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.heureDebut, heureDebut) || other.heureDebut == heureDebut)&&(identical(other.heureFin, heureFin) || other.heureFin == heureFin)&&(identical(other.heureLimiteCommande, heureLimiteCommande) || other.heureLimiteCommande == heureLimiteCommande)&&(identical(other.commandable, commandable) || other.commandable == commandable)&&const DeepCollectionEquality().equals(other.lignes, lignes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,service,titre,heureDebut,heureFin,heureLimiteCommande,commandable,const DeepCollectionEquality().hash(lignes));

@override
String toString() {
  return 'MenuDuJour(id: $id, service: $service, titre: $titre, heureDebut: $heureDebut, heureFin: $heureFin, heureLimiteCommande: $heureLimiteCommande, commandable: $commandable, lignes: $lignes)';
}


}

/// @nodoc
abstract mixin class $MenuDuJourCopyWith<$Res>  {
  factory $MenuDuJourCopyWith(MenuDuJour value, $Res Function(MenuDuJour) _then) = _$MenuDuJourCopyWithImpl;
@useResult
$Res call({
 int id, String service, String titre,@JsonKey(name: 'heure_debut') String? heureDebut,@JsonKey(name: 'heure_fin') String? heureFin,@JsonKey(name: 'heure_limite_commande') String? heureLimiteCommande, bool commandable, List<LigneMenu> lignes
});




}
/// @nodoc
class _$MenuDuJourCopyWithImpl<$Res>
    implements $MenuDuJourCopyWith<$Res> {
  _$MenuDuJourCopyWithImpl(this._self, this._then);

  final MenuDuJour _self;
  final $Res Function(MenuDuJour) _then;

/// Create a copy of MenuDuJour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? service = null,Object? titre = null,Object? heureDebut = freezed,Object? heureFin = freezed,Object? heureLimiteCommande = freezed,Object? commandable = null,Object? lignes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,heureDebut: freezed == heureDebut ? _self.heureDebut : heureDebut // ignore: cast_nullable_to_non_nullable
as String?,heureFin: freezed == heureFin ? _self.heureFin : heureFin // ignore: cast_nullable_to_non_nullable
as String?,heureLimiteCommande: freezed == heureLimiteCommande ? _self.heureLimiteCommande : heureLimiteCommande // ignore: cast_nullable_to_non_nullable
as String?,commandable: null == commandable ? _self.commandable : commandable // ignore: cast_nullable_to_non_nullable
as bool,lignes: null == lignes ? _self.lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LigneMenu>,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuDuJour].
extension MenuDuJourPatterns on MenuDuJour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuDuJour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuDuJour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuDuJour value)  $default,){
final _that = this;
switch (_that) {
case _MenuDuJour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuDuJour value)?  $default,){
final _that = this;
switch (_that) {
case _MenuDuJour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String service,  String titre, @JsonKey(name: 'heure_debut')  String? heureDebut, @JsonKey(name: 'heure_fin')  String? heureFin, @JsonKey(name: 'heure_limite_commande')  String? heureLimiteCommande,  bool commandable,  List<LigneMenu> lignes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuDuJour() when $default != null:
return $default(_that.id,_that.service,_that.titre,_that.heureDebut,_that.heureFin,_that.heureLimiteCommande,_that.commandable,_that.lignes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String service,  String titre, @JsonKey(name: 'heure_debut')  String? heureDebut, @JsonKey(name: 'heure_fin')  String? heureFin, @JsonKey(name: 'heure_limite_commande')  String? heureLimiteCommande,  bool commandable,  List<LigneMenu> lignes)  $default,) {final _that = this;
switch (_that) {
case _MenuDuJour():
return $default(_that.id,_that.service,_that.titre,_that.heureDebut,_that.heureFin,_that.heureLimiteCommande,_that.commandable,_that.lignes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String service,  String titre, @JsonKey(name: 'heure_debut')  String? heureDebut, @JsonKey(name: 'heure_fin')  String? heureFin, @JsonKey(name: 'heure_limite_commande')  String? heureLimiteCommande,  bool commandable,  List<LigneMenu> lignes)?  $default,) {final _that = this;
switch (_that) {
case _MenuDuJour() when $default != null:
return $default(_that.id,_that.service,_that.titre,_that.heureDebut,_that.heureFin,_that.heureLimiteCommande,_that.commandable,_that.lignes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuDuJour implements MenuDuJour {
  const _MenuDuJour({required this.id, this.service = 'journee', this.titre = '', @JsonKey(name: 'heure_debut') this.heureDebut, @JsonKey(name: 'heure_fin') this.heureFin, @JsonKey(name: 'heure_limite_commande') this.heureLimiteCommande, this.commandable = true, final  List<LigneMenu> lignes = const <LigneMenu>[]}): _lignes = lignes;
  factory _MenuDuJour.fromJson(Map<String, dynamic> json) => _$MenuDuJourFromJson(json);

@override final  int id;
/// midi | soir | journee
@override@JsonKey() final  String service;
@override@JsonKey() final  String titre;
@override@JsonKey(name: 'heure_debut') final  String? heureDebut;
@override@JsonKey(name: 'heure_fin') final  String? heureFin;
@override@JsonKey(name: 'heure_limite_commande') final  String? heureLimiteCommande;
@override@JsonKey() final  bool commandable;
 final  List<LigneMenu> _lignes;
@override@JsonKey() List<LigneMenu> get lignes {
  if (_lignes is EqualUnmodifiableListView) return _lignes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lignes);
}


/// Create a copy of MenuDuJour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuDuJourCopyWith<_MenuDuJour> get copyWith => __$MenuDuJourCopyWithImpl<_MenuDuJour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuDuJourToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuDuJour&&(identical(other.id, id) || other.id == id)&&(identical(other.service, service) || other.service == service)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.heureDebut, heureDebut) || other.heureDebut == heureDebut)&&(identical(other.heureFin, heureFin) || other.heureFin == heureFin)&&(identical(other.heureLimiteCommande, heureLimiteCommande) || other.heureLimiteCommande == heureLimiteCommande)&&(identical(other.commandable, commandable) || other.commandable == commandable)&&const DeepCollectionEquality().equals(other._lignes, _lignes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,service,titre,heureDebut,heureFin,heureLimiteCommande,commandable,const DeepCollectionEquality().hash(_lignes));

@override
String toString() {
  return 'MenuDuJour(id: $id, service: $service, titre: $titre, heureDebut: $heureDebut, heureFin: $heureFin, heureLimiteCommande: $heureLimiteCommande, commandable: $commandable, lignes: $lignes)';
}


}

/// @nodoc
abstract mixin class _$MenuDuJourCopyWith<$Res> implements $MenuDuJourCopyWith<$Res> {
  factory _$MenuDuJourCopyWith(_MenuDuJour value, $Res Function(_MenuDuJour) _then) = __$MenuDuJourCopyWithImpl;
@override @useResult
$Res call({
 int id, String service, String titre,@JsonKey(name: 'heure_debut') String? heureDebut,@JsonKey(name: 'heure_fin') String? heureFin,@JsonKey(name: 'heure_limite_commande') String? heureLimiteCommande, bool commandable, List<LigneMenu> lignes
});




}
/// @nodoc
class __$MenuDuJourCopyWithImpl<$Res>
    implements _$MenuDuJourCopyWith<$Res> {
  __$MenuDuJourCopyWithImpl(this._self, this._then);

  final _MenuDuJour _self;
  final $Res Function(_MenuDuJour) _then;

/// Create a copy of MenuDuJour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? service = null,Object? titre = null,Object? heureDebut = freezed,Object? heureFin = freezed,Object? heureLimiteCommande = freezed,Object? commandable = null,Object? lignes = null,}) {
  return _then(_MenuDuJour(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,heureDebut: freezed == heureDebut ? _self.heureDebut : heureDebut // ignore: cast_nullable_to_non_nullable
as String?,heureFin: freezed == heureFin ? _self.heureFin : heureFin // ignore: cast_nullable_to_non_nullable
as String?,heureLimiteCommande: freezed == heureLimiteCommande ? _self.heureLimiteCommande : heureLimiteCommande // ignore: cast_nullable_to_non_nullable
as String?,commandable: null == commandable ? _self.commandable : commandable // ignore: cast_nullable_to_non_nullable
as bool,lignes: null == lignes ? _self._lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LigneMenu>,
  ));
}


}


/// @nodoc
mixin _$Restaurant {

 int get id; String get nom; String get description; String get logo; String get couverture; String get adresse; String get quartier; String get ville;@JsonKey(name: 'localite_nom') String? get localiteNom;@JsonKey(name: 'quartier_nom') String? get quartierNom;@JsonKey(name: 'telephone_pro') String get telephonePro; String get whatsapp;@JsonKey(fromJson: versDoubleNullable) double? get latitude;@JsonKey(fromJson: versDoubleNullable) double? get longitude;/// Toujours fourni par le serveur (liste, fiche, flux). Sans horaires
/// renseignés : fermé, avec « Horaires non renseignés » en message. Non
/// affiché : sert seulement à expliquer un refus de commande.
@JsonKey(name: 'est_ouvert') bool get estOuvert;@JsonKey(name: 'message_statut') String get messageStatut;@JsonKey(name: 'prochaine_ouverture') String? get prochaineOuverture; FicheRestaurant get fiche;/// Menus du jour présents, dans l'ordre midi, soir, journée.
 List<MenuDuJour> get menus;/// Services dont le menu est en vigueur en ce moment.
@JsonKey(name: 'services_en_vigueur') List<String> get servicesEnVigueur; List<SectionCarte> get carte;
/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantCopyWith<Restaurant> get copyWith => _$RestaurantCopyWithImpl<Restaurant>(this as Restaurant, _$identity);

  /// Serializes this Restaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Restaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.localiteNom, localiteNom) || other.localiteNom == localiteNom)&&(identical(other.quartierNom, quartierNom) || other.quartierNom == quartierNom)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.estOuvert, estOuvert) || other.estOuvert == estOuvert)&&(identical(other.messageStatut, messageStatut) || other.messageStatut == messageStatut)&&(identical(other.prochaineOuverture, prochaineOuverture) || other.prochaineOuverture == prochaineOuverture)&&(identical(other.fiche, fiche) || other.fiche == fiche)&&const DeepCollectionEquality().equals(other.menus, menus)&&const DeepCollectionEquality().equals(other.servicesEnVigueur, servicesEnVigueur)&&const DeepCollectionEquality().equals(other.carte, carte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,description,logo,couverture,adresse,quartier,ville,localiteNom,quartierNom,telephonePro,whatsapp,latitude,longitude,estOuvert,messageStatut,prochaineOuverture,fiche,const DeepCollectionEquality().hash(menus),const DeepCollectionEquality().hash(servicesEnVigueur),const DeepCollectionEquality().hash(carte)]);

@override
String toString() {
  return 'Restaurant(id: $id, nom: $nom, description: $description, logo: $logo, couverture: $couverture, adresse: $adresse, quartier: $quartier, ville: $ville, localiteNom: $localiteNom, quartierNom: $quartierNom, telephonePro: $telephonePro, whatsapp: $whatsapp, latitude: $latitude, longitude: $longitude, estOuvert: $estOuvert, messageStatut: $messageStatut, prochaineOuverture: $prochaineOuverture, fiche: $fiche, menus: $menus, servicesEnVigueur: $servicesEnVigueur, carte: $carte)';
}


}

/// @nodoc
abstract mixin class $RestaurantCopyWith<$Res>  {
  factory $RestaurantCopyWith(Restaurant value, $Res Function(Restaurant) _then) = _$RestaurantCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String description, String logo, String couverture, String adresse, String quartier, String ville,@JsonKey(name: 'localite_nom') String? localiteNom,@JsonKey(name: 'quartier_nom') String? quartierNom,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude,@JsonKey(name: 'est_ouvert') bool estOuvert,@JsonKey(name: 'message_statut') String messageStatut,@JsonKey(name: 'prochaine_ouverture') String? prochaineOuverture, FicheRestaurant fiche, List<MenuDuJour> menus,@JsonKey(name: 'services_en_vigueur') List<String> servicesEnVigueur, List<SectionCarte> carte
});


$FicheRestaurantCopyWith<$Res> get fiche;

}
/// @nodoc
class _$RestaurantCopyWithImpl<$Res>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._self, this._then);

  final Restaurant _self;
  final $Res Function(Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? logo = null,Object? couverture = null,Object? adresse = null,Object? quartier = null,Object? ville = null,Object? localiteNom = freezed,Object? quartierNom = freezed,Object? telephonePro = null,Object? whatsapp = null,Object? latitude = freezed,Object? longitude = freezed,Object? estOuvert = null,Object? messageStatut = null,Object? prochaineOuverture = freezed,Object? fiche = null,Object? menus = null,Object? servicesEnVigueur = null,Object? carte = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,adresse: null == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,localiteNom: freezed == localiteNom ? _self.localiteNom : localiteNom // ignore: cast_nullable_to_non_nullable
as String?,quartierNom: freezed == quartierNom ? _self.quartierNom : quartierNom // ignore: cast_nullable_to_non_nullable
as String?,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,estOuvert: null == estOuvert ? _self.estOuvert : estOuvert // ignore: cast_nullable_to_non_nullable
as bool,messageStatut: null == messageStatut ? _self.messageStatut : messageStatut // ignore: cast_nullable_to_non_nullable
as String,prochaineOuverture: freezed == prochaineOuverture ? _self.prochaineOuverture : prochaineOuverture // ignore: cast_nullable_to_non_nullable
as String?,fiche: null == fiche ? _self.fiche : fiche // ignore: cast_nullable_to_non_nullable
as FicheRestaurant,menus: null == menus ? _self.menus : menus // ignore: cast_nullable_to_non_nullable
as List<MenuDuJour>,servicesEnVigueur: null == servicesEnVigueur ? _self.servicesEnVigueur : servicesEnVigueur // ignore: cast_nullable_to_non_nullable
as List<String>,carte: null == carte ? _self.carte : carte // ignore: cast_nullable_to_non_nullable
as List<SectionCarte>,
  ));
}
/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FicheRestaurantCopyWith<$Res> get fiche {
  
  return $FicheRestaurantCopyWith<$Res>(_self.fiche, (value) {
    return _then(_self.copyWith(fiche: value));
  });
}
}


/// Adds pattern-matching-related methods to [Restaurant].
extension RestaurantPatterns on Restaurant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Restaurant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Restaurant value)  $default,){
final _that = this;
switch (_that) {
case _Restaurant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Restaurant value)?  $default,){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String description,  String logo,  String couverture,  String adresse,  String quartier,  String ville, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'est_ouvert')  bool estOuvert, @JsonKey(name: 'message_statut')  String messageStatut, @JsonKey(name: 'prochaine_ouverture')  String? prochaineOuverture,  FicheRestaurant fiche,  List<MenuDuJour> menus, @JsonKey(name: 'services_en_vigueur')  List<String> servicesEnVigueur,  List<SectionCarte> carte)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.logo,_that.couverture,_that.adresse,_that.quartier,_that.ville,_that.localiteNom,_that.quartierNom,_that.telephonePro,_that.whatsapp,_that.latitude,_that.longitude,_that.estOuvert,_that.messageStatut,_that.prochaineOuverture,_that.fiche,_that.menus,_that.servicesEnVigueur,_that.carte);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String description,  String logo,  String couverture,  String adresse,  String quartier,  String ville, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'est_ouvert')  bool estOuvert, @JsonKey(name: 'message_statut')  String messageStatut, @JsonKey(name: 'prochaine_ouverture')  String? prochaineOuverture,  FicheRestaurant fiche,  List<MenuDuJour> menus, @JsonKey(name: 'services_en_vigueur')  List<String> servicesEnVigueur,  List<SectionCarte> carte)  $default,) {final _that = this;
switch (_that) {
case _Restaurant():
return $default(_that.id,_that.nom,_that.description,_that.logo,_that.couverture,_that.adresse,_that.quartier,_that.ville,_that.localiteNom,_that.quartierNom,_that.telephonePro,_that.whatsapp,_that.latitude,_that.longitude,_that.estOuvert,_that.messageStatut,_that.prochaineOuverture,_that.fiche,_that.menus,_that.servicesEnVigueur,_that.carte);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String description,  String logo,  String couverture,  String adresse,  String quartier,  String ville, @JsonKey(name: 'localite_nom')  String? localiteNom, @JsonKey(name: 'quartier_nom')  String? quartierNom, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'est_ouvert')  bool estOuvert, @JsonKey(name: 'message_statut')  String messageStatut, @JsonKey(name: 'prochaine_ouverture')  String? prochaineOuverture,  FicheRestaurant fiche,  List<MenuDuJour> menus, @JsonKey(name: 'services_en_vigueur')  List<String> servicesEnVigueur,  List<SectionCarte> carte)?  $default,) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.logo,_that.couverture,_that.adresse,_that.quartier,_that.ville,_that.localiteNom,_that.quartierNom,_that.telephonePro,_that.whatsapp,_that.latitude,_that.longitude,_that.estOuvert,_that.messageStatut,_that.prochaineOuverture,_that.fiche,_that.menus,_that.servicesEnVigueur,_that.carte);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Restaurant extends Restaurant {
  const _Restaurant({required this.id, this.nom = '', this.description = '', this.logo = '', this.couverture = '', this.adresse = '', this.quartier = '', this.ville = '', @JsonKey(name: 'localite_nom') this.localiteNom, @JsonKey(name: 'quartier_nom') this.quartierNom, @JsonKey(name: 'telephone_pro') this.telephonePro = '', this.whatsapp = '', @JsonKey(fromJson: versDoubleNullable) this.latitude, @JsonKey(fromJson: versDoubleNullable) this.longitude, @JsonKey(name: 'est_ouvert') required this.estOuvert, @JsonKey(name: 'message_statut') this.messageStatut = '', @JsonKey(name: 'prochaine_ouverture') this.prochaineOuverture, this.fiche = const FicheRestaurant(), final  List<MenuDuJour> menus = const <MenuDuJour>[], @JsonKey(name: 'services_en_vigueur') final  List<String> servicesEnVigueur = const <String>[], final  List<SectionCarte> carte = const <SectionCarte>[]}): _menus = menus,_servicesEnVigueur = servicesEnVigueur,_carte = carte,super._();
  factory _Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String description;
@override@JsonKey() final  String logo;
@override@JsonKey() final  String couverture;
@override@JsonKey() final  String adresse;
@override@JsonKey() final  String quartier;
@override@JsonKey() final  String ville;
@override@JsonKey(name: 'localite_nom') final  String? localiteNom;
@override@JsonKey(name: 'quartier_nom') final  String? quartierNom;
@override@JsonKey(name: 'telephone_pro') final  String telephonePro;
@override@JsonKey() final  String whatsapp;
@override@JsonKey(fromJson: versDoubleNullable) final  double? latitude;
@override@JsonKey(fromJson: versDoubleNullable) final  double? longitude;
/// Toujours fourni par le serveur (liste, fiche, flux). Sans horaires
/// renseignés : fermé, avec « Horaires non renseignés » en message. Non
/// affiché : sert seulement à expliquer un refus de commande.
@override@JsonKey(name: 'est_ouvert') final  bool estOuvert;
@override@JsonKey(name: 'message_statut') final  String messageStatut;
@override@JsonKey(name: 'prochaine_ouverture') final  String? prochaineOuverture;
@override@JsonKey() final  FicheRestaurant fiche;
/// Menus du jour présents, dans l'ordre midi, soir, journée.
 final  List<MenuDuJour> _menus;
/// Menus du jour présents, dans l'ordre midi, soir, journée.
@override@JsonKey() List<MenuDuJour> get menus {
  if (_menus is EqualUnmodifiableListView) return _menus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menus);
}

/// Services dont le menu est en vigueur en ce moment.
 final  List<String> _servicesEnVigueur;
/// Services dont le menu est en vigueur en ce moment.
@override@JsonKey(name: 'services_en_vigueur') List<String> get servicesEnVigueur {
  if (_servicesEnVigueur is EqualUnmodifiableListView) return _servicesEnVigueur;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servicesEnVigueur);
}

 final  List<SectionCarte> _carte;
@override@JsonKey() List<SectionCarte> get carte {
  if (_carte is EqualUnmodifiableListView) return _carte;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_carte);
}


/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantCopyWith<_Restaurant> get copyWith => __$RestaurantCopyWithImpl<_Restaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Restaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.localiteNom, localiteNom) || other.localiteNom == localiteNom)&&(identical(other.quartierNom, quartierNom) || other.quartierNom == quartierNom)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.estOuvert, estOuvert) || other.estOuvert == estOuvert)&&(identical(other.messageStatut, messageStatut) || other.messageStatut == messageStatut)&&(identical(other.prochaineOuverture, prochaineOuverture) || other.prochaineOuverture == prochaineOuverture)&&(identical(other.fiche, fiche) || other.fiche == fiche)&&const DeepCollectionEquality().equals(other._menus, _menus)&&const DeepCollectionEquality().equals(other._servicesEnVigueur, _servicesEnVigueur)&&const DeepCollectionEquality().equals(other._carte, _carte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,description,logo,couverture,adresse,quartier,ville,localiteNom,quartierNom,telephonePro,whatsapp,latitude,longitude,estOuvert,messageStatut,prochaineOuverture,fiche,const DeepCollectionEquality().hash(_menus),const DeepCollectionEquality().hash(_servicesEnVigueur),const DeepCollectionEquality().hash(_carte)]);

@override
String toString() {
  return 'Restaurant(id: $id, nom: $nom, description: $description, logo: $logo, couverture: $couverture, adresse: $adresse, quartier: $quartier, ville: $ville, localiteNom: $localiteNom, quartierNom: $quartierNom, telephonePro: $telephonePro, whatsapp: $whatsapp, latitude: $latitude, longitude: $longitude, estOuvert: $estOuvert, messageStatut: $messageStatut, prochaineOuverture: $prochaineOuverture, fiche: $fiche, menus: $menus, servicesEnVigueur: $servicesEnVigueur, carte: $carte)';
}


}

/// @nodoc
abstract mixin class _$RestaurantCopyWith<$Res> implements $RestaurantCopyWith<$Res> {
  factory _$RestaurantCopyWith(_Restaurant value, $Res Function(_Restaurant) _then) = __$RestaurantCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String description, String logo, String couverture, String adresse, String quartier, String ville,@JsonKey(name: 'localite_nom') String? localiteNom,@JsonKey(name: 'quartier_nom') String? quartierNom,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude,@JsonKey(name: 'est_ouvert') bool estOuvert,@JsonKey(name: 'message_statut') String messageStatut,@JsonKey(name: 'prochaine_ouverture') String? prochaineOuverture, FicheRestaurant fiche, List<MenuDuJour> menus,@JsonKey(name: 'services_en_vigueur') List<String> servicesEnVigueur, List<SectionCarte> carte
});


@override $FicheRestaurantCopyWith<$Res> get fiche;

}
/// @nodoc
class __$RestaurantCopyWithImpl<$Res>
    implements _$RestaurantCopyWith<$Res> {
  __$RestaurantCopyWithImpl(this._self, this._then);

  final _Restaurant _self;
  final $Res Function(_Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? description = null,Object? logo = null,Object? couverture = null,Object? adresse = null,Object? quartier = null,Object? ville = null,Object? localiteNom = freezed,Object? quartierNom = freezed,Object? telephonePro = null,Object? whatsapp = null,Object? latitude = freezed,Object? longitude = freezed,Object? estOuvert = null,Object? messageStatut = null,Object? prochaineOuverture = freezed,Object? fiche = null,Object? menus = null,Object? servicesEnVigueur = null,Object? carte = null,}) {
  return _then(_Restaurant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,adresse: null == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,localiteNom: freezed == localiteNom ? _self.localiteNom : localiteNom // ignore: cast_nullable_to_non_nullable
as String?,quartierNom: freezed == quartierNom ? _self.quartierNom : quartierNom // ignore: cast_nullable_to_non_nullable
as String?,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,estOuvert: null == estOuvert ? _self.estOuvert : estOuvert // ignore: cast_nullable_to_non_nullable
as bool,messageStatut: null == messageStatut ? _self.messageStatut : messageStatut // ignore: cast_nullable_to_non_nullable
as String,prochaineOuverture: freezed == prochaineOuverture ? _self.prochaineOuverture : prochaineOuverture // ignore: cast_nullable_to_non_nullable
as String?,fiche: null == fiche ? _self.fiche : fiche // ignore: cast_nullable_to_non_nullable
as FicheRestaurant,menus: null == menus ? _self._menus : menus // ignore: cast_nullable_to_non_nullable
as List<MenuDuJour>,servicesEnVigueur: null == servicesEnVigueur ? _self._servicesEnVigueur : servicesEnVigueur // ignore: cast_nullable_to_non_nullable
as List<String>,carte: null == carte ? _self._carte : carte // ignore: cast_nullable_to_non_nullable
as List<SectionCarte>,
  ));
}

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FicheRestaurantCopyWith<$Res> get fiche {
  
  return $FicheRestaurantCopyWith<$Res>(_self.fiche, (value) {
    return _then(_self.copyWith(fiche: value));
  });
}
}

// dart format on
