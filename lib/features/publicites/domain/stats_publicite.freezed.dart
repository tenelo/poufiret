// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_publicite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatsPublicite {

 String get id; String get titre; String get formule; String get statut;@JsonKey(name: 'stats_disponibles') bool get statsDisponibles;@JsonKey(name: 'nb_personnes_touchees') int get personnesTouchees;@JsonKey(name: 'nb_impressions') int get impressions;@JsonKey(name: 'nb_clics') int get clics;@JsonKey(name: 'taux_clic') num get tauxClic;@JsonKey(name: 'impressions_par_type') Map<String, dynamic> get impressionsParType;@JsonKey(name: 'cible_pourcentage') int? get ciblePourcentage;@JsonKey(name: 'cible_atteinte') bool get cibleAtteinte;@JsonKey(name: 'debut_diffusion') String? get debutDiffusion;@JsonKey(name: 'fin_diffusion') String? get finDiffusion; String? get message;
/// Create a copy of StatsPublicite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsPubliciteCopyWith<StatsPublicite> get copyWith => _$StatsPubliciteCopyWithImpl<StatsPublicite>(this as StatsPublicite, _$identity);

  /// Serializes this StatsPublicite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsPublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.formule, formule) || other.formule == formule)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.statsDisponibles, statsDisponibles) || other.statsDisponibles == statsDisponibles)&&(identical(other.personnesTouchees, personnesTouchees) || other.personnesTouchees == personnesTouchees)&&(identical(other.impressions, impressions) || other.impressions == impressions)&&(identical(other.clics, clics) || other.clics == clics)&&(identical(other.tauxClic, tauxClic) || other.tauxClic == tauxClic)&&const DeepCollectionEquality().equals(other.impressionsParType, impressionsParType)&&(identical(other.ciblePourcentage, ciblePourcentage) || other.ciblePourcentage == ciblePourcentage)&&(identical(other.cibleAtteinte, cibleAtteinte) || other.cibleAtteinte == cibleAtteinte)&&(identical(other.debutDiffusion, debutDiffusion) || other.debutDiffusion == debutDiffusion)&&(identical(other.finDiffusion, finDiffusion) || other.finDiffusion == finDiffusion)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,formule,statut,statsDisponibles,personnesTouchees,impressions,clics,tauxClic,const DeepCollectionEquality().hash(impressionsParType),ciblePourcentage,cibleAtteinte,debutDiffusion,finDiffusion,message);

@override
String toString() {
  return 'StatsPublicite(id: $id, titre: $titre, formule: $formule, statut: $statut, statsDisponibles: $statsDisponibles, personnesTouchees: $personnesTouchees, impressions: $impressions, clics: $clics, tauxClic: $tauxClic, impressionsParType: $impressionsParType, ciblePourcentage: $ciblePourcentage, cibleAtteinte: $cibleAtteinte, debutDiffusion: $debutDiffusion, finDiffusion: $finDiffusion, message: $message)';
}


}

/// @nodoc
abstract mixin class $StatsPubliciteCopyWith<$Res>  {
  factory $StatsPubliciteCopyWith(StatsPublicite value, $Res Function(StatsPublicite) _then) = _$StatsPubliciteCopyWithImpl;
@useResult
$Res call({
 String id, String titre, String formule, String statut,@JsonKey(name: 'stats_disponibles') bool statsDisponibles,@JsonKey(name: 'nb_personnes_touchees') int personnesTouchees,@JsonKey(name: 'nb_impressions') int impressions,@JsonKey(name: 'nb_clics') int clics,@JsonKey(name: 'taux_clic') num tauxClic,@JsonKey(name: 'impressions_par_type') Map<String, dynamic> impressionsParType,@JsonKey(name: 'cible_pourcentage') int? ciblePourcentage,@JsonKey(name: 'cible_atteinte') bool cibleAtteinte,@JsonKey(name: 'debut_diffusion') String? debutDiffusion,@JsonKey(name: 'fin_diffusion') String? finDiffusion, String? message
});




}
/// @nodoc
class _$StatsPubliciteCopyWithImpl<$Res>
    implements $StatsPubliciteCopyWith<$Res> {
  _$StatsPubliciteCopyWithImpl(this._self, this._then);

  final StatsPublicite _self;
  final $Res Function(StatsPublicite) _then;

/// Create a copy of StatsPublicite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? formule = null,Object? statut = null,Object? statsDisponibles = null,Object? personnesTouchees = null,Object? impressions = null,Object? clics = null,Object? tauxClic = null,Object? impressionsParType = null,Object? ciblePourcentage = freezed,Object? cibleAtteinte = null,Object? debutDiffusion = freezed,Object? finDiffusion = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,formule: null == formule ? _self.formule : formule // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,statsDisponibles: null == statsDisponibles ? _self.statsDisponibles : statsDisponibles // ignore: cast_nullable_to_non_nullable
as bool,personnesTouchees: null == personnesTouchees ? _self.personnesTouchees : personnesTouchees // ignore: cast_nullable_to_non_nullable
as int,impressions: null == impressions ? _self.impressions : impressions // ignore: cast_nullable_to_non_nullable
as int,clics: null == clics ? _self.clics : clics // ignore: cast_nullable_to_non_nullable
as int,tauxClic: null == tauxClic ? _self.tauxClic : tauxClic // ignore: cast_nullable_to_non_nullable
as num,impressionsParType: null == impressionsParType ? _self.impressionsParType : impressionsParType // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ciblePourcentage: freezed == ciblePourcentage ? _self.ciblePourcentage : ciblePourcentage // ignore: cast_nullable_to_non_nullable
as int?,cibleAtteinte: null == cibleAtteinte ? _self.cibleAtteinte : cibleAtteinte // ignore: cast_nullable_to_non_nullable
as bool,debutDiffusion: freezed == debutDiffusion ? _self.debutDiffusion : debutDiffusion // ignore: cast_nullable_to_non_nullable
as String?,finDiffusion: freezed == finDiffusion ? _self.finDiffusion : finDiffusion // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsPublicite].
extension StatsPublicitePatterns on StatsPublicite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsPublicite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsPublicite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsPublicite value)  $default,){
final _that = this;
switch (_that) {
case _StatsPublicite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsPublicite value)?  $default,){
final _that = this;
switch (_that) {
case _StatsPublicite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titre,  String formule,  String statut, @JsonKey(name: 'stats_disponibles')  bool statsDisponibles, @JsonKey(name: 'nb_personnes_touchees')  int personnesTouchees, @JsonKey(name: 'nb_impressions')  int impressions, @JsonKey(name: 'nb_clics')  int clics, @JsonKey(name: 'taux_clic')  num tauxClic, @JsonKey(name: 'impressions_par_type')  Map<String, dynamic> impressionsParType, @JsonKey(name: 'cible_pourcentage')  int? ciblePourcentage, @JsonKey(name: 'cible_atteinte')  bool cibleAtteinte, @JsonKey(name: 'debut_diffusion')  String? debutDiffusion, @JsonKey(name: 'fin_diffusion')  String? finDiffusion,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsPublicite() when $default != null:
return $default(_that.id,_that.titre,_that.formule,_that.statut,_that.statsDisponibles,_that.personnesTouchees,_that.impressions,_that.clics,_that.tauxClic,_that.impressionsParType,_that.ciblePourcentage,_that.cibleAtteinte,_that.debutDiffusion,_that.finDiffusion,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titre,  String formule,  String statut, @JsonKey(name: 'stats_disponibles')  bool statsDisponibles, @JsonKey(name: 'nb_personnes_touchees')  int personnesTouchees, @JsonKey(name: 'nb_impressions')  int impressions, @JsonKey(name: 'nb_clics')  int clics, @JsonKey(name: 'taux_clic')  num tauxClic, @JsonKey(name: 'impressions_par_type')  Map<String, dynamic> impressionsParType, @JsonKey(name: 'cible_pourcentage')  int? ciblePourcentage, @JsonKey(name: 'cible_atteinte')  bool cibleAtteinte, @JsonKey(name: 'debut_diffusion')  String? debutDiffusion, @JsonKey(name: 'fin_diffusion')  String? finDiffusion,  String? message)  $default,) {final _that = this;
switch (_that) {
case _StatsPublicite():
return $default(_that.id,_that.titre,_that.formule,_that.statut,_that.statsDisponibles,_that.personnesTouchees,_that.impressions,_that.clics,_that.tauxClic,_that.impressionsParType,_that.ciblePourcentage,_that.cibleAtteinte,_that.debutDiffusion,_that.finDiffusion,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titre,  String formule,  String statut, @JsonKey(name: 'stats_disponibles')  bool statsDisponibles, @JsonKey(name: 'nb_personnes_touchees')  int personnesTouchees, @JsonKey(name: 'nb_impressions')  int impressions, @JsonKey(name: 'nb_clics')  int clics, @JsonKey(name: 'taux_clic')  num tauxClic, @JsonKey(name: 'impressions_par_type')  Map<String, dynamic> impressionsParType, @JsonKey(name: 'cible_pourcentage')  int? ciblePourcentage, @JsonKey(name: 'cible_atteinte')  bool cibleAtteinte, @JsonKey(name: 'debut_diffusion')  String? debutDiffusion, @JsonKey(name: 'fin_diffusion')  String? finDiffusion,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _StatsPublicite() when $default != null:
return $default(_that.id,_that.titre,_that.formule,_that.statut,_that.statsDisponibles,_that.personnesTouchees,_that.impressions,_that.clics,_that.tauxClic,_that.impressionsParType,_that.ciblePourcentage,_that.cibleAtteinte,_that.debutDiffusion,_that.finDiffusion,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatsPublicite extends StatsPublicite {
  const _StatsPublicite({required this.id, this.titre = '', this.formule = '', this.statut = '', @JsonKey(name: 'stats_disponibles') this.statsDisponibles = true, @JsonKey(name: 'nb_personnes_touchees') this.personnesTouchees = 0, @JsonKey(name: 'nb_impressions') this.impressions = 0, @JsonKey(name: 'nb_clics') this.clics = 0, @JsonKey(name: 'taux_clic') this.tauxClic = 0, @JsonKey(name: 'impressions_par_type') final  Map<String, dynamic> impressionsParType = const <String, dynamic>{}, @JsonKey(name: 'cible_pourcentage') this.ciblePourcentage, @JsonKey(name: 'cible_atteinte') this.cibleAtteinte = false, @JsonKey(name: 'debut_diffusion') this.debutDiffusion, @JsonKey(name: 'fin_diffusion') this.finDiffusion, this.message}): _impressionsParType = impressionsParType,super._();
  factory _StatsPublicite.fromJson(Map<String, dynamic> json) => _$StatsPubliciteFromJson(json);

@override final  String id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String formule;
@override@JsonKey() final  String statut;
@override@JsonKey(name: 'stats_disponibles') final  bool statsDisponibles;
@override@JsonKey(name: 'nb_personnes_touchees') final  int personnesTouchees;
@override@JsonKey(name: 'nb_impressions') final  int impressions;
@override@JsonKey(name: 'nb_clics') final  int clics;
@override@JsonKey(name: 'taux_clic') final  num tauxClic;
 final  Map<String, dynamic> _impressionsParType;
@override@JsonKey(name: 'impressions_par_type') Map<String, dynamic> get impressionsParType {
  if (_impressionsParType is EqualUnmodifiableMapView) return _impressionsParType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_impressionsParType);
}

@override@JsonKey(name: 'cible_pourcentage') final  int? ciblePourcentage;
@override@JsonKey(name: 'cible_atteinte') final  bool cibleAtteinte;
@override@JsonKey(name: 'debut_diffusion') final  String? debutDiffusion;
@override@JsonKey(name: 'fin_diffusion') final  String? finDiffusion;
@override final  String? message;

/// Create a copy of StatsPublicite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsPubliciteCopyWith<_StatsPublicite> get copyWith => __$StatsPubliciteCopyWithImpl<_StatsPublicite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsPubliciteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsPublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.formule, formule) || other.formule == formule)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.statsDisponibles, statsDisponibles) || other.statsDisponibles == statsDisponibles)&&(identical(other.personnesTouchees, personnesTouchees) || other.personnesTouchees == personnesTouchees)&&(identical(other.impressions, impressions) || other.impressions == impressions)&&(identical(other.clics, clics) || other.clics == clics)&&(identical(other.tauxClic, tauxClic) || other.tauxClic == tauxClic)&&const DeepCollectionEquality().equals(other._impressionsParType, _impressionsParType)&&(identical(other.ciblePourcentage, ciblePourcentage) || other.ciblePourcentage == ciblePourcentage)&&(identical(other.cibleAtteinte, cibleAtteinte) || other.cibleAtteinte == cibleAtteinte)&&(identical(other.debutDiffusion, debutDiffusion) || other.debutDiffusion == debutDiffusion)&&(identical(other.finDiffusion, finDiffusion) || other.finDiffusion == finDiffusion)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,formule,statut,statsDisponibles,personnesTouchees,impressions,clics,tauxClic,const DeepCollectionEquality().hash(_impressionsParType),ciblePourcentage,cibleAtteinte,debutDiffusion,finDiffusion,message);

@override
String toString() {
  return 'StatsPublicite(id: $id, titre: $titre, formule: $formule, statut: $statut, statsDisponibles: $statsDisponibles, personnesTouchees: $personnesTouchees, impressions: $impressions, clics: $clics, tauxClic: $tauxClic, impressionsParType: $impressionsParType, ciblePourcentage: $ciblePourcentage, cibleAtteinte: $cibleAtteinte, debutDiffusion: $debutDiffusion, finDiffusion: $finDiffusion, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StatsPubliciteCopyWith<$Res> implements $StatsPubliciteCopyWith<$Res> {
  factory _$StatsPubliciteCopyWith(_StatsPublicite value, $Res Function(_StatsPublicite) _then) = __$StatsPubliciteCopyWithImpl;
@override @useResult
$Res call({
 String id, String titre, String formule, String statut,@JsonKey(name: 'stats_disponibles') bool statsDisponibles,@JsonKey(name: 'nb_personnes_touchees') int personnesTouchees,@JsonKey(name: 'nb_impressions') int impressions,@JsonKey(name: 'nb_clics') int clics,@JsonKey(name: 'taux_clic') num tauxClic,@JsonKey(name: 'impressions_par_type') Map<String, dynamic> impressionsParType,@JsonKey(name: 'cible_pourcentage') int? ciblePourcentage,@JsonKey(name: 'cible_atteinte') bool cibleAtteinte,@JsonKey(name: 'debut_diffusion') String? debutDiffusion,@JsonKey(name: 'fin_diffusion') String? finDiffusion, String? message
});




}
/// @nodoc
class __$StatsPubliciteCopyWithImpl<$Res>
    implements _$StatsPubliciteCopyWith<$Res> {
  __$StatsPubliciteCopyWithImpl(this._self, this._then);

  final _StatsPublicite _self;
  final $Res Function(_StatsPublicite) _then;

/// Create a copy of StatsPublicite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? formule = null,Object? statut = null,Object? statsDisponibles = null,Object? personnesTouchees = null,Object? impressions = null,Object? clics = null,Object? tauxClic = null,Object? impressionsParType = null,Object? ciblePourcentage = freezed,Object? cibleAtteinte = null,Object? debutDiffusion = freezed,Object? finDiffusion = freezed,Object? message = freezed,}) {
  return _then(_StatsPublicite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,formule: null == formule ? _self.formule : formule // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,statsDisponibles: null == statsDisponibles ? _self.statsDisponibles : statsDisponibles // ignore: cast_nullable_to_non_nullable
as bool,personnesTouchees: null == personnesTouchees ? _self.personnesTouchees : personnesTouchees // ignore: cast_nullable_to_non_nullable
as int,impressions: null == impressions ? _self.impressions : impressions // ignore: cast_nullable_to_non_nullable
as int,clics: null == clics ? _self.clics : clics // ignore: cast_nullable_to_non_nullable
as int,tauxClic: null == tauxClic ? _self.tauxClic : tauxClic // ignore: cast_nullable_to_non_nullable
as num,impressionsParType: null == impressionsParType ? _self._impressionsParType : impressionsParType // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ciblePourcentage: freezed == ciblePourcentage ? _self.ciblePourcentage : ciblePourcentage // ignore: cast_nullable_to_non_nullable
as int?,cibleAtteinte: null == cibleAtteinte ? _self.cibleAtteinte : cibleAtteinte // ignore: cast_nullable_to_non_nullable
as bool,debutDiffusion: freezed == debutDiffusion ? _self.debutDiffusion : debutDiffusion // ignore: cast_nullable_to_non_nullable
as String?,finDiffusion: freezed == finDiffusion ? _self.finDiffusion : finDiffusion // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
