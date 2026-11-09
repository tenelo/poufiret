// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vente_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfosVente {

@JsonKey(fromJson: _modeDepuis, toJson: _modeVers) ModeAnnonce get mode;@JsonKey(name: 'mode_libelle') String get modeLibelle;@JsonKey(name: 'prix_vente', fromJson: versIntNullable) int? get prixVente;@JsonKey(name: 'prix_negociable') bool get prixNegociable; bool get vendu;@JsonKey(name: 'vendu_le') String? get venduLe; String? get etat;@JsonKey(name: 'etat_libelle') String? get etatLibelle;@JsonKey(fromJson: versIntNullable) int? get kilometrage;@JsonKey(fromJson: _versBoolNullable) bool? get dedouane;@JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) bool? get carteGrise;@JsonKey(name: 'visite_technique_valide_jusqu_au') String? get visiteTechniqueValideJusquAu;@JsonKey(name: 'assurance_valide_jusqu_au') String? get assuranceValideJusquAu;@JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable) int? get nbProprietaires;@JsonKey(name: 'type_document') String? get typeDocument;@JsonKey(name: 'type_document_libelle') String? get typeDocumentLibelle;@JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable) int? get surfaceTerrainM2;@JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) bool? get estLotie;
/// Create a copy of InfosVente
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfosVenteCopyWith<InfosVente> get copyWith => _$InfosVenteCopyWithImpl<InfosVente>(this as InfosVente, _$identity);

  /// Serializes this InfosVente to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfosVente&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.modeLibelle, modeLibelle) || other.modeLibelle == modeLibelle)&&(identical(other.prixVente, prixVente) || other.prixVente == prixVente)&&(identical(other.prixNegociable, prixNegociable) || other.prixNegociable == prixNegociable)&&(identical(other.vendu, vendu) || other.vendu == vendu)&&(identical(other.venduLe, venduLe) || other.venduLe == venduLe)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.etatLibelle, etatLibelle) || other.etatLibelle == etatLibelle)&&(identical(other.kilometrage, kilometrage) || other.kilometrage == kilometrage)&&(identical(other.dedouane, dedouane) || other.dedouane == dedouane)&&(identical(other.carteGrise, carteGrise) || other.carteGrise == carteGrise)&&(identical(other.visiteTechniqueValideJusquAu, visiteTechniqueValideJusquAu) || other.visiteTechniqueValideJusquAu == visiteTechniqueValideJusquAu)&&(identical(other.assuranceValideJusquAu, assuranceValideJusquAu) || other.assuranceValideJusquAu == assuranceValideJusquAu)&&(identical(other.nbProprietaires, nbProprietaires) || other.nbProprietaires == nbProprietaires)&&(identical(other.typeDocument, typeDocument) || other.typeDocument == typeDocument)&&(identical(other.typeDocumentLibelle, typeDocumentLibelle) || other.typeDocumentLibelle == typeDocumentLibelle)&&(identical(other.surfaceTerrainM2, surfaceTerrainM2) || other.surfaceTerrainM2 == surfaceTerrainM2)&&(identical(other.estLotie, estLotie) || other.estLotie == estLotie));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,modeLibelle,prixVente,prixNegociable,vendu,venduLe,etat,etatLibelle,kilometrage,dedouane,carteGrise,visiteTechniqueValideJusquAu,assuranceValideJusquAu,nbProprietaires,typeDocument,typeDocumentLibelle,surfaceTerrainM2,estLotie);

@override
String toString() {
  return 'InfosVente(mode: $mode, modeLibelle: $modeLibelle, prixVente: $prixVente, prixNegociable: $prixNegociable, vendu: $vendu, venduLe: $venduLe, etat: $etat, etatLibelle: $etatLibelle, kilometrage: $kilometrage, dedouane: $dedouane, carteGrise: $carteGrise, visiteTechniqueValideJusquAu: $visiteTechniqueValideJusquAu, assuranceValideJusquAu: $assuranceValideJusquAu, nbProprietaires: $nbProprietaires, typeDocument: $typeDocument, typeDocumentLibelle: $typeDocumentLibelle, surfaceTerrainM2: $surfaceTerrainM2, estLotie: $estLotie)';
}


}

/// @nodoc
abstract mixin class $InfosVenteCopyWith<$Res>  {
  factory $InfosVenteCopyWith(InfosVente value, $Res Function(InfosVente) _then) = _$InfosVenteCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _modeDepuis, toJson: _modeVers) ModeAnnonce mode,@JsonKey(name: 'mode_libelle') String modeLibelle,@JsonKey(name: 'prix_vente', fromJson: versIntNullable) int? prixVente,@JsonKey(name: 'prix_negociable') bool prixNegociable, bool vendu,@JsonKey(name: 'vendu_le') String? venduLe, String? etat,@JsonKey(name: 'etat_libelle') String? etatLibelle,@JsonKey(fromJson: versIntNullable) int? kilometrage,@JsonKey(fromJson: _versBoolNullable) bool? dedouane,@JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) bool? carteGrise,@JsonKey(name: 'visite_technique_valide_jusqu_au') String? visiteTechniqueValideJusquAu,@JsonKey(name: 'assurance_valide_jusqu_au') String? assuranceValideJusquAu,@JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable) int? nbProprietaires,@JsonKey(name: 'type_document') String? typeDocument,@JsonKey(name: 'type_document_libelle') String? typeDocumentLibelle,@JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable) int? surfaceTerrainM2,@JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) bool? estLotie
});




}
/// @nodoc
class _$InfosVenteCopyWithImpl<$Res>
    implements $InfosVenteCopyWith<$Res> {
  _$InfosVenteCopyWithImpl(this._self, this._then);

  final InfosVente _self;
  final $Res Function(InfosVente) _then;

/// Create a copy of InfosVente
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? modeLibelle = null,Object? prixVente = freezed,Object? prixNegociable = null,Object? vendu = null,Object? venduLe = freezed,Object? etat = freezed,Object? etatLibelle = freezed,Object? kilometrage = freezed,Object? dedouane = freezed,Object? carteGrise = freezed,Object? visiteTechniqueValideJusquAu = freezed,Object? assuranceValideJusquAu = freezed,Object? nbProprietaires = freezed,Object? typeDocument = freezed,Object? typeDocumentLibelle = freezed,Object? surfaceTerrainM2 = freezed,Object? estLotie = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ModeAnnonce,modeLibelle: null == modeLibelle ? _self.modeLibelle : modeLibelle // ignore: cast_nullable_to_non_nullable
as String,prixVente: freezed == prixVente ? _self.prixVente : prixVente // ignore: cast_nullable_to_non_nullable
as int?,prixNegociable: null == prixNegociable ? _self.prixNegociable : prixNegociable // ignore: cast_nullable_to_non_nullable
as bool,vendu: null == vendu ? _self.vendu : vendu // ignore: cast_nullable_to_non_nullable
as bool,venduLe: freezed == venduLe ? _self.venduLe : venduLe // ignore: cast_nullable_to_non_nullable
as String?,etat: freezed == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String?,etatLibelle: freezed == etatLibelle ? _self.etatLibelle : etatLibelle // ignore: cast_nullable_to_non_nullable
as String?,kilometrage: freezed == kilometrage ? _self.kilometrage : kilometrage // ignore: cast_nullable_to_non_nullable
as int?,dedouane: freezed == dedouane ? _self.dedouane : dedouane // ignore: cast_nullable_to_non_nullable
as bool?,carteGrise: freezed == carteGrise ? _self.carteGrise : carteGrise // ignore: cast_nullable_to_non_nullable
as bool?,visiteTechniqueValideJusquAu: freezed == visiteTechniqueValideJusquAu ? _self.visiteTechniqueValideJusquAu : visiteTechniqueValideJusquAu // ignore: cast_nullable_to_non_nullable
as String?,assuranceValideJusquAu: freezed == assuranceValideJusquAu ? _self.assuranceValideJusquAu : assuranceValideJusquAu // ignore: cast_nullable_to_non_nullable
as String?,nbProprietaires: freezed == nbProprietaires ? _self.nbProprietaires : nbProprietaires // ignore: cast_nullable_to_non_nullable
as int?,typeDocument: freezed == typeDocument ? _self.typeDocument : typeDocument // ignore: cast_nullable_to_non_nullable
as String?,typeDocumentLibelle: freezed == typeDocumentLibelle ? _self.typeDocumentLibelle : typeDocumentLibelle // ignore: cast_nullable_to_non_nullable
as String?,surfaceTerrainM2: freezed == surfaceTerrainM2 ? _self.surfaceTerrainM2 : surfaceTerrainM2 // ignore: cast_nullable_to_non_nullable
as int?,estLotie: freezed == estLotie ? _self.estLotie : estLotie // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [InfosVente].
extension InfosVentePatterns on InfosVente {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfosVente value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfosVente() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfosVente value)  $default,){
final _that = this;
switch (_that) {
case _InfosVente():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfosVente value)?  $default,){
final _that = this;
switch (_that) {
case _InfosVente() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _modeDepuis, toJson: _modeVers)  ModeAnnonce mode, @JsonKey(name: 'mode_libelle')  String modeLibelle, @JsonKey(name: 'prix_vente', fromJson: versIntNullable)  int? prixVente, @JsonKey(name: 'prix_negociable')  bool prixNegociable,  bool vendu, @JsonKey(name: 'vendu_le')  String? venduLe,  String? etat, @JsonKey(name: 'etat_libelle')  String? etatLibelle, @JsonKey(fromJson: versIntNullable)  int? kilometrage, @JsonKey(fromJson: _versBoolNullable)  bool? dedouane, @JsonKey(name: 'carte_grise', fromJson: _versBoolNullable)  bool? carteGrise, @JsonKey(name: 'visite_technique_valide_jusqu_au')  String? visiteTechniqueValideJusquAu, @JsonKey(name: 'assurance_valide_jusqu_au')  String? assuranceValideJusquAu, @JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable)  int? nbProprietaires, @JsonKey(name: 'type_document')  String? typeDocument, @JsonKey(name: 'type_document_libelle')  String? typeDocumentLibelle, @JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable)  int? surfaceTerrainM2, @JsonKey(name: 'est_lotie', fromJson: _versBoolNullable)  bool? estLotie)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfosVente() when $default != null:
return $default(_that.mode,_that.modeLibelle,_that.prixVente,_that.prixNegociable,_that.vendu,_that.venduLe,_that.etat,_that.etatLibelle,_that.kilometrage,_that.dedouane,_that.carteGrise,_that.visiteTechniqueValideJusquAu,_that.assuranceValideJusquAu,_that.nbProprietaires,_that.typeDocument,_that.typeDocumentLibelle,_that.surfaceTerrainM2,_that.estLotie);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _modeDepuis, toJson: _modeVers)  ModeAnnonce mode, @JsonKey(name: 'mode_libelle')  String modeLibelle, @JsonKey(name: 'prix_vente', fromJson: versIntNullable)  int? prixVente, @JsonKey(name: 'prix_negociable')  bool prixNegociable,  bool vendu, @JsonKey(name: 'vendu_le')  String? venduLe,  String? etat, @JsonKey(name: 'etat_libelle')  String? etatLibelle, @JsonKey(fromJson: versIntNullable)  int? kilometrage, @JsonKey(fromJson: _versBoolNullable)  bool? dedouane, @JsonKey(name: 'carte_grise', fromJson: _versBoolNullable)  bool? carteGrise, @JsonKey(name: 'visite_technique_valide_jusqu_au')  String? visiteTechniqueValideJusquAu, @JsonKey(name: 'assurance_valide_jusqu_au')  String? assuranceValideJusquAu, @JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable)  int? nbProprietaires, @JsonKey(name: 'type_document')  String? typeDocument, @JsonKey(name: 'type_document_libelle')  String? typeDocumentLibelle, @JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable)  int? surfaceTerrainM2, @JsonKey(name: 'est_lotie', fromJson: _versBoolNullable)  bool? estLotie)  $default,) {final _that = this;
switch (_that) {
case _InfosVente():
return $default(_that.mode,_that.modeLibelle,_that.prixVente,_that.prixNegociable,_that.vendu,_that.venduLe,_that.etat,_that.etatLibelle,_that.kilometrage,_that.dedouane,_that.carteGrise,_that.visiteTechniqueValideJusquAu,_that.assuranceValideJusquAu,_that.nbProprietaires,_that.typeDocument,_that.typeDocumentLibelle,_that.surfaceTerrainM2,_that.estLotie);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _modeDepuis, toJson: _modeVers)  ModeAnnonce mode, @JsonKey(name: 'mode_libelle')  String modeLibelle, @JsonKey(name: 'prix_vente', fromJson: versIntNullable)  int? prixVente, @JsonKey(name: 'prix_negociable')  bool prixNegociable,  bool vendu, @JsonKey(name: 'vendu_le')  String? venduLe,  String? etat, @JsonKey(name: 'etat_libelle')  String? etatLibelle, @JsonKey(fromJson: versIntNullable)  int? kilometrage, @JsonKey(fromJson: _versBoolNullable)  bool? dedouane, @JsonKey(name: 'carte_grise', fromJson: _versBoolNullable)  bool? carteGrise, @JsonKey(name: 'visite_technique_valide_jusqu_au')  String? visiteTechniqueValideJusquAu, @JsonKey(name: 'assurance_valide_jusqu_au')  String? assuranceValideJusquAu, @JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable)  int? nbProprietaires, @JsonKey(name: 'type_document')  String? typeDocument, @JsonKey(name: 'type_document_libelle')  String? typeDocumentLibelle, @JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable)  int? surfaceTerrainM2, @JsonKey(name: 'est_lotie', fromJson: _versBoolNullable)  bool? estLotie)?  $default,) {final _that = this;
switch (_that) {
case _InfosVente() when $default != null:
return $default(_that.mode,_that.modeLibelle,_that.prixVente,_that.prixNegociable,_that.vendu,_that.venduLe,_that.etat,_that.etatLibelle,_that.kilometrage,_that.dedouane,_that.carteGrise,_that.visiteTechniqueValideJusquAu,_that.assuranceValideJusquAu,_that.nbProprietaires,_that.typeDocument,_that.typeDocumentLibelle,_that.surfaceTerrainM2,_that.estLotie);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfosVente extends InfosVente {
  const _InfosVente({@JsonKey(fromJson: _modeDepuis, toJson: _modeVers) this.mode = ModeAnnonce.location, @JsonKey(name: 'mode_libelle') this.modeLibelle = '', @JsonKey(name: 'prix_vente', fromJson: versIntNullable) this.prixVente, @JsonKey(name: 'prix_negociable') this.prixNegociable = false, this.vendu = false, @JsonKey(name: 'vendu_le') this.venduLe, this.etat, @JsonKey(name: 'etat_libelle') this.etatLibelle, @JsonKey(fromJson: versIntNullable) this.kilometrage, @JsonKey(fromJson: _versBoolNullable) this.dedouane, @JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) this.carteGrise, @JsonKey(name: 'visite_technique_valide_jusqu_au') this.visiteTechniqueValideJusquAu, @JsonKey(name: 'assurance_valide_jusqu_au') this.assuranceValideJusquAu, @JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable) this.nbProprietaires, @JsonKey(name: 'type_document') this.typeDocument, @JsonKey(name: 'type_document_libelle') this.typeDocumentLibelle, @JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable) this.surfaceTerrainM2, @JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) this.estLotie}): super._();
  factory _InfosVente.fromJson(Map<String, dynamic> json) => _$InfosVenteFromJson(json);

@override@JsonKey(fromJson: _modeDepuis, toJson: _modeVers) final  ModeAnnonce mode;
@override@JsonKey(name: 'mode_libelle') final  String modeLibelle;
@override@JsonKey(name: 'prix_vente', fromJson: versIntNullable) final  int? prixVente;
@override@JsonKey(name: 'prix_negociable') final  bool prixNegociable;
@override@JsonKey() final  bool vendu;
@override@JsonKey(name: 'vendu_le') final  String? venduLe;
@override final  String? etat;
@override@JsonKey(name: 'etat_libelle') final  String? etatLibelle;
@override@JsonKey(fromJson: versIntNullable) final  int? kilometrage;
@override@JsonKey(fromJson: _versBoolNullable) final  bool? dedouane;
@override@JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) final  bool? carteGrise;
@override@JsonKey(name: 'visite_technique_valide_jusqu_au') final  String? visiteTechniqueValideJusquAu;
@override@JsonKey(name: 'assurance_valide_jusqu_au') final  String? assuranceValideJusquAu;
@override@JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable) final  int? nbProprietaires;
@override@JsonKey(name: 'type_document') final  String? typeDocument;
@override@JsonKey(name: 'type_document_libelle') final  String? typeDocumentLibelle;
@override@JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable) final  int? surfaceTerrainM2;
@override@JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) final  bool? estLotie;

/// Create a copy of InfosVente
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfosVenteCopyWith<_InfosVente> get copyWith => __$InfosVenteCopyWithImpl<_InfosVente>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfosVenteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfosVente&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.modeLibelle, modeLibelle) || other.modeLibelle == modeLibelle)&&(identical(other.prixVente, prixVente) || other.prixVente == prixVente)&&(identical(other.prixNegociable, prixNegociable) || other.prixNegociable == prixNegociable)&&(identical(other.vendu, vendu) || other.vendu == vendu)&&(identical(other.venduLe, venduLe) || other.venduLe == venduLe)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.etatLibelle, etatLibelle) || other.etatLibelle == etatLibelle)&&(identical(other.kilometrage, kilometrage) || other.kilometrage == kilometrage)&&(identical(other.dedouane, dedouane) || other.dedouane == dedouane)&&(identical(other.carteGrise, carteGrise) || other.carteGrise == carteGrise)&&(identical(other.visiteTechniqueValideJusquAu, visiteTechniqueValideJusquAu) || other.visiteTechniqueValideJusquAu == visiteTechniqueValideJusquAu)&&(identical(other.assuranceValideJusquAu, assuranceValideJusquAu) || other.assuranceValideJusquAu == assuranceValideJusquAu)&&(identical(other.nbProprietaires, nbProprietaires) || other.nbProprietaires == nbProprietaires)&&(identical(other.typeDocument, typeDocument) || other.typeDocument == typeDocument)&&(identical(other.typeDocumentLibelle, typeDocumentLibelle) || other.typeDocumentLibelle == typeDocumentLibelle)&&(identical(other.surfaceTerrainM2, surfaceTerrainM2) || other.surfaceTerrainM2 == surfaceTerrainM2)&&(identical(other.estLotie, estLotie) || other.estLotie == estLotie));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,modeLibelle,prixVente,prixNegociable,vendu,venduLe,etat,etatLibelle,kilometrage,dedouane,carteGrise,visiteTechniqueValideJusquAu,assuranceValideJusquAu,nbProprietaires,typeDocument,typeDocumentLibelle,surfaceTerrainM2,estLotie);

@override
String toString() {
  return 'InfosVente(mode: $mode, modeLibelle: $modeLibelle, prixVente: $prixVente, prixNegociable: $prixNegociable, vendu: $vendu, venduLe: $venduLe, etat: $etat, etatLibelle: $etatLibelle, kilometrage: $kilometrage, dedouane: $dedouane, carteGrise: $carteGrise, visiteTechniqueValideJusquAu: $visiteTechniqueValideJusquAu, assuranceValideJusquAu: $assuranceValideJusquAu, nbProprietaires: $nbProprietaires, typeDocument: $typeDocument, typeDocumentLibelle: $typeDocumentLibelle, surfaceTerrainM2: $surfaceTerrainM2, estLotie: $estLotie)';
}


}

/// @nodoc
abstract mixin class _$InfosVenteCopyWith<$Res> implements $InfosVenteCopyWith<$Res> {
  factory _$InfosVenteCopyWith(_InfosVente value, $Res Function(_InfosVente) _then) = __$InfosVenteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _modeDepuis, toJson: _modeVers) ModeAnnonce mode,@JsonKey(name: 'mode_libelle') String modeLibelle,@JsonKey(name: 'prix_vente', fromJson: versIntNullable) int? prixVente,@JsonKey(name: 'prix_negociable') bool prixNegociable, bool vendu,@JsonKey(name: 'vendu_le') String? venduLe, String? etat,@JsonKey(name: 'etat_libelle') String? etatLibelle,@JsonKey(fromJson: versIntNullable) int? kilometrage,@JsonKey(fromJson: _versBoolNullable) bool? dedouane,@JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) bool? carteGrise,@JsonKey(name: 'visite_technique_valide_jusqu_au') String? visiteTechniqueValideJusquAu,@JsonKey(name: 'assurance_valide_jusqu_au') String? assuranceValideJusquAu,@JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable) int? nbProprietaires,@JsonKey(name: 'type_document') String? typeDocument,@JsonKey(name: 'type_document_libelle') String? typeDocumentLibelle,@JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable) int? surfaceTerrainM2,@JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) bool? estLotie
});




}
/// @nodoc
class __$InfosVenteCopyWithImpl<$Res>
    implements _$InfosVenteCopyWith<$Res> {
  __$InfosVenteCopyWithImpl(this._self, this._then);

  final _InfosVente _self;
  final $Res Function(_InfosVente) _then;

/// Create a copy of InfosVente
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? modeLibelle = null,Object? prixVente = freezed,Object? prixNegociable = null,Object? vendu = null,Object? venduLe = freezed,Object? etat = freezed,Object? etatLibelle = freezed,Object? kilometrage = freezed,Object? dedouane = freezed,Object? carteGrise = freezed,Object? visiteTechniqueValideJusquAu = freezed,Object? assuranceValideJusquAu = freezed,Object? nbProprietaires = freezed,Object? typeDocument = freezed,Object? typeDocumentLibelle = freezed,Object? surfaceTerrainM2 = freezed,Object? estLotie = freezed,}) {
  return _then(_InfosVente(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ModeAnnonce,modeLibelle: null == modeLibelle ? _self.modeLibelle : modeLibelle // ignore: cast_nullable_to_non_nullable
as String,prixVente: freezed == prixVente ? _self.prixVente : prixVente // ignore: cast_nullable_to_non_nullable
as int?,prixNegociable: null == prixNegociable ? _self.prixNegociable : prixNegociable // ignore: cast_nullable_to_non_nullable
as bool,vendu: null == vendu ? _self.vendu : vendu // ignore: cast_nullable_to_non_nullable
as bool,venduLe: freezed == venduLe ? _self.venduLe : venduLe // ignore: cast_nullable_to_non_nullable
as String?,etat: freezed == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String?,etatLibelle: freezed == etatLibelle ? _self.etatLibelle : etatLibelle // ignore: cast_nullable_to_non_nullable
as String?,kilometrage: freezed == kilometrage ? _self.kilometrage : kilometrage // ignore: cast_nullable_to_non_nullable
as int?,dedouane: freezed == dedouane ? _self.dedouane : dedouane // ignore: cast_nullable_to_non_nullable
as bool?,carteGrise: freezed == carteGrise ? _self.carteGrise : carteGrise // ignore: cast_nullable_to_non_nullable
as bool?,visiteTechniqueValideJusquAu: freezed == visiteTechniqueValideJusquAu ? _self.visiteTechniqueValideJusquAu : visiteTechniqueValideJusquAu // ignore: cast_nullable_to_non_nullable
as String?,assuranceValideJusquAu: freezed == assuranceValideJusquAu ? _self.assuranceValideJusquAu : assuranceValideJusquAu // ignore: cast_nullable_to_non_nullable
as String?,nbProprietaires: freezed == nbProprietaires ? _self.nbProprietaires : nbProprietaires // ignore: cast_nullable_to_non_nullable
as int?,typeDocument: freezed == typeDocument ? _self.typeDocument : typeDocument // ignore: cast_nullable_to_non_nullable
as String?,typeDocumentLibelle: freezed == typeDocumentLibelle ? _self.typeDocumentLibelle : typeDocumentLibelle // ignore: cast_nullable_to_non_nullable
as String?,surfaceTerrainM2: freezed == surfaceTerrainM2 ? _self.surfaceTerrainM2 : surfaceTerrainM2 // ignore: cast_nullable_to_non_nullable
as int?,estLotie: freezed == estLotie ? _self.estLotie : estLotie // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
