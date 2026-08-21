// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_formule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditFormule {

 String get id;@JsonKey(name: 'formule_id') String get formuleId;@JsonKey(name: 'formule_nom') String get formuleNom;@JsonKey(name: 'formule_prix') int get formulePrix;@JsonKey(name: 'formule_types_affichage') List<String> get formuleTypesAffichage; String get statut;@JsonKey(name: 'cree_le') String? get creeLe;@JsonKey(name: 'consomme_le') String? get consommeLe;@JsonKey(name: 'publicite_consommatrice_id') String? get publiciteConsommatriceId;
/// Create a copy of CreditFormule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditFormuleCopyWith<CreditFormule> get copyWith => _$CreditFormuleCopyWithImpl<CreditFormule>(this as CreditFormule, _$identity);

  /// Serializes this CreditFormule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditFormule&&(identical(other.id, id) || other.id == id)&&(identical(other.formuleId, formuleId) || other.formuleId == formuleId)&&(identical(other.formuleNom, formuleNom) || other.formuleNom == formuleNom)&&(identical(other.formulePrix, formulePrix) || other.formulePrix == formulePrix)&&const DeepCollectionEquality().equals(other.formuleTypesAffichage, formuleTypesAffichage)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.creeLe, creeLe) || other.creeLe == creeLe)&&(identical(other.consommeLe, consommeLe) || other.consommeLe == consommeLe)&&(identical(other.publiciteConsommatriceId, publiciteConsommatriceId) || other.publiciteConsommatriceId == publiciteConsommatriceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,formuleId,formuleNom,formulePrix,const DeepCollectionEquality().hash(formuleTypesAffichage),statut,creeLe,consommeLe,publiciteConsommatriceId);

@override
String toString() {
  return 'CreditFormule(id: $id, formuleId: $formuleId, formuleNom: $formuleNom, formulePrix: $formulePrix, formuleTypesAffichage: $formuleTypesAffichage, statut: $statut, creeLe: $creeLe, consommeLe: $consommeLe, publiciteConsommatriceId: $publiciteConsommatriceId)';
}


}

/// @nodoc
abstract mixin class $CreditFormuleCopyWith<$Res>  {
  factory $CreditFormuleCopyWith(CreditFormule value, $Res Function(CreditFormule) _then) = _$CreditFormuleCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'formule_id') String formuleId,@JsonKey(name: 'formule_nom') String formuleNom,@JsonKey(name: 'formule_prix') int formulePrix,@JsonKey(name: 'formule_types_affichage') List<String> formuleTypesAffichage, String statut,@JsonKey(name: 'cree_le') String? creeLe,@JsonKey(name: 'consomme_le') String? consommeLe,@JsonKey(name: 'publicite_consommatrice_id') String? publiciteConsommatriceId
});




}
/// @nodoc
class _$CreditFormuleCopyWithImpl<$Res>
    implements $CreditFormuleCopyWith<$Res> {
  _$CreditFormuleCopyWithImpl(this._self, this._then);

  final CreditFormule _self;
  final $Res Function(CreditFormule) _then;

/// Create a copy of CreditFormule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? formuleId = null,Object? formuleNom = null,Object? formulePrix = null,Object? formuleTypesAffichage = null,Object? statut = null,Object? creeLe = freezed,Object? consommeLe = freezed,Object? publiciteConsommatriceId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formuleId: null == formuleId ? _self.formuleId : formuleId // ignore: cast_nullable_to_non_nullable
as String,formuleNom: null == formuleNom ? _self.formuleNom : formuleNom // ignore: cast_nullable_to_non_nullable
as String,formulePrix: null == formulePrix ? _self.formulePrix : formulePrix // ignore: cast_nullable_to_non_nullable
as int,formuleTypesAffichage: null == formuleTypesAffichage ? _self.formuleTypesAffichage : formuleTypesAffichage // ignore: cast_nullable_to_non_nullable
as List<String>,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,creeLe: freezed == creeLe ? _self.creeLe : creeLe // ignore: cast_nullable_to_non_nullable
as String?,consommeLe: freezed == consommeLe ? _self.consommeLe : consommeLe // ignore: cast_nullable_to_non_nullable
as String?,publiciteConsommatriceId: freezed == publiciteConsommatriceId ? _self.publiciteConsommatriceId : publiciteConsommatriceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditFormule].
extension CreditFormulePatterns on CreditFormule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditFormule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditFormule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditFormule value)  $default,){
final _that = this;
switch (_that) {
case _CreditFormule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditFormule value)?  $default,){
final _that = this;
switch (_that) {
case _CreditFormule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'formule_id')  String formuleId, @JsonKey(name: 'formule_nom')  String formuleNom, @JsonKey(name: 'formule_prix')  int formulePrix, @JsonKey(name: 'formule_types_affichage')  List<String> formuleTypesAffichage,  String statut, @JsonKey(name: 'cree_le')  String? creeLe, @JsonKey(name: 'consomme_le')  String? consommeLe, @JsonKey(name: 'publicite_consommatrice_id')  String? publiciteConsommatriceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditFormule() when $default != null:
return $default(_that.id,_that.formuleId,_that.formuleNom,_that.formulePrix,_that.formuleTypesAffichage,_that.statut,_that.creeLe,_that.consommeLe,_that.publiciteConsommatriceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'formule_id')  String formuleId, @JsonKey(name: 'formule_nom')  String formuleNom, @JsonKey(name: 'formule_prix')  int formulePrix, @JsonKey(name: 'formule_types_affichage')  List<String> formuleTypesAffichage,  String statut, @JsonKey(name: 'cree_le')  String? creeLe, @JsonKey(name: 'consomme_le')  String? consommeLe, @JsonKey(name: 'publicite_consommatrice_id')  String? publiciteConsommatriceId)  $default,) {final _that = this;
switch (_that) {
case _CreditFormule():
return $default(_that.id,_that.formuleId,_that.formuleNom,_that.formulePrix,_that.formuleTypesAffichage,_that.statut,_that.creeLe,_that.consommeLe,_that.publiciteConsommatriceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'formule_id')  String formuleId, @JsonKey(name: 'formule_nom')  String formuleNom, @JsonKey(name: 'formule_prix')  int formulePrix, @JsonKey(name: 'formule_types_affichage')  List<String> formuleTypesAffichage,  String statut, @JsonKey(name: 'cree_le')  String? creeLe, @JsonKey(name: 'consomme_le')  String? consommeLe, @JsonKey(name: 'publicite_consommatrice_id')  String? publiciteConsommatriceId)?  $default,) {final _that = this;
switch (_that) {
case _CreditFormule() when $default != null:
return $default(_that.id,_that.formuleId,_that.formuleNom,_that.formulePrix,_that.formuleTypesAffichage,_that.statut,_that.creeLe,_that.consommeLe,_that.publiciteConsommatriceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditFormule extends CreditFormule {
  const _CreditFormule({required this.id, @JsonKey(name: 'formule_id') required this.formuleId, @JsonKey(name: 'formule_nom') this.formuleNom = '', @JsonKey(name: 'formule_prix') this.formulePrix = 0, @JsonKey(name: 'formule_types_affichage') final  List<String> formuleTypesAffichage = const <String>[], this.statut = 'disponible', @JsonKey(name: 'cree_le') this.creeLe, @JsonKey(name: 'consomme_le') this.consommeLe, @JsonKey(name: 'publicite_consommatrice_id') this.publiciteConsommatriceId}): _formuleTypesAffichage = formuleTypesAffichage,super._();
  factory _CreditFormule.fromJson(Map<String, dynamic> json) => _$CreditFormuleFromJson(json);

@override final  String id;
@override@JsonKey(name: 'formule_id') final  String formuleId;
@override@JsonKey(name: 'formule_nom') final  String formuleNom;
@override@JsonKey(name: 'formule_prix') final  int formulePrix;
 final  List<String> _formuleTypesAffichage;
@override@JsonKey(name: 'formule_types_affichage') List<String> get formuleTypesAffichage {
  if (_formuleTypesAffichage is EqualUnmodifiableListView) return _formuleTypesAffichage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formuleTypesAffichage);
}

@override@JsonKey() final  String statut;
@override@JsonKey(name: 'cree_le') final  String? creeLe;
@override@JsonKey(name: 'consomme_le') final  String? consommeLe;
@override@JsonKey(name: 'publicite_consommatrice_id') final  String? publiciteConsommatriceId;

/// Create a copy of CreditFormule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditFormuleCopyWith<_CreditFormule> get copyWith => __$CreditFormuleCopyWithImpl<_CreditFormule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditFormuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditFormule&&(identical(other.id, id) || other.id == id)&&(identical(other.formuleId, formuleId) || other.formuleId == formuleId)&&(identical(other.formuleNom, formuleNom) || other.formuleNom == formuleNom)&&(identical(other.formulePrix, formulePrix) || other.formulePrix == formulePrix)&&const DeepCollectionEquality().equals(other._formuleTypesAffichage, _formuleTypesAffichage)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.creeLe, creeLe) || other.creeLe == creeLe)&&(identical(other.consommeLe, consommeLe) || other.consommeLe == consommeLe)&&(identical(other.publiciteConsommatriceId, publiciteConsommatriceId) || other.publiciteConsommatriceId == publiciteConsommatriceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,formuleId,formuleNom,formulePrix,const DeepCollectionEquality().hash(_formuleTypesAffichage),statut,creeLe,consommeLe,publiciteConsommatriceId);

@override
String toString() {
  return 'CreditFormule(id: $id, formuleId: $formuleId, formuleNom: $formuleNom, formulePrix: $formulePrix, formuleTypesAffichage: $formuleTypesAffichage, statut: $statut, creeLe: $creeLe, consommeLe: $consommeLe, publiciteConsommatriceId: $publiciteConsommatriceId)';
}


}

/// @nodoc
abstract mixin class _$CreditFormuleCopyWith<$Res> implements $CreditFormuleCopyWith<$Res> {
  factory _$CreditFormuleCopyWith(_CreditFormule value, $Res Function(_CreditFormule) _then) = __$CreditFormuleCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'formule_id') String formuleId,@JsonKey(name: 'formule_nom') String formuleNom,@JsonKey(name: 'formule_prix') int formulePrix,@JsonKey(name: 'formule_types_affichage') List<String> formuleTypesAffichage, String statut,@JsonKey(name: 'cree_le') String? creeLe,@JsonKey(name: 'consomme_le') String? consommeLe,@JsonKey(name: 'publicite_consommatrice_id') String? publiciteConsommatriceId
});




}
/// @nodoc
class __$CreditFormuleCopyWithImpl<$Res>
    implements _$CreditFormuleCopyWith<$Res> {
  __$CreditFormuleCopyWithImpl(this._self, this._then);

  final _CreditFormule _self;
  final $Res Function(_CreditFormule) _then;

/// Create a copy of CreditFormule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? formuleId = null,Object? formuleNom = null,Object? formulePrix = null,Object? formuleTypesAffichage = null,Object? statut = null,Object? creeLe = freezed,Object? consommeLe = freezed,Object? publiciteConsommatriceId = freezed,}) {
  return _then(_CreditFormule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formuleId: null == formuleId ? _self.formuleId : formuleId // ignore: cast_nullable_to_non_nullable
as String,formuleNom: null == formuleNom ? _self.formuleNom : formuleNom // ignore: cast_nullable_to_non_nullable
as String,formulePrix: null == formulePrix ? _self.formulePrix : formulePrix // ignore: cast_nullable_to_non_nullable
as int,formuleTypesAffichage: null == formuleTypesAffichage ? _self._formuleTypesAffichage : formuleTypesAffichage // ignore: cast_nullable_to_non_nullable
as List<String>,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,creeLe: freezed == creeLe ? _self.creeLe : creeLe // ignore: cast_nullable_to_non_nullable
as String?,consommeLe: freezed == consommeLe ? _self.consommeLe : consommeLe // ignore: cast_nullable_to_non_nullable
as String?,publiciteConsommatriceId: freezed == publiciteConsommatriceId ? _self.publiciteConsommatriceId : publiciteConsommatriceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
