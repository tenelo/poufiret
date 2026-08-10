// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'utilisateur.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Utilisateur {

 int get id; String get telephone; String? get username;@JsonKey(name: 'first_name') String get prenom;@JsonKey(name: 'last_name') String get nom; String get role;@JsonKey(name: 'est_verifie') bool get estVerifie;@JsonKey(name: 'pin_par_defaut') bool get pinParDefaut;@JsonKey(name: 'langue_preferee') String get languePreferee;@JsonKey(name: 'token_fcm') String? get tokenFcm; int? get departement;@JsonKey(name: 'departement_nom') String get departementNom;@JsonKey(name: 'region_nom') String get regionNom;
/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UtilisateurCopyWith<Utilisateur> get copyWith => _$UtilisateurCopyWithImpl<Utilisateur>(this as Utilisateur, _$identity);

  /// Serializes this Utilisateur to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Utilisateur&&(identical(other.id, id) || other.id == id)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.username, username) || other.username == username)&&(identical(other.prenom, prenom) || other.prenom == prenom)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.role, role) || other.role == role)&&(identical(other.estVerifie, estVerifie) || other.estVerifie == estVerifie)&&(identical(other.pinParDefaut, pinParDefaut) || other.pinParDefaut == pinParDefaut)&&(identical(other.languePreferee, languePreferee) || other.languePreferee == languePreferee)&&(identical(other.tokenFcm, tokenFcm) || other.tokenFcm == tokenFcm)&&(identical(other.departement, departement) || other.departement == departement)&&(identical(other.departementNom, departementNom) || other.departementNom == departementNom)&&(identical(other.regionNom, regionNom) || other.regionNom == regionNom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,telephone,username,prenom,nom,role,estVerifie,pinParDefaut,languePreferee,tokenFcm,departement,departementNom,regionNom);

@override
String toString() {
  return 'Utilisateur(id: $id, telephone: $telephone, username: $username, prenom: $prenom, nom: $nom, role: $role, estVerifie: $estVerifie, pinParDefaut: $pinParDefaut, languePreferee: $languePreferee, tokenFcm: $tokenFcm, departement: $departement, departementNom: $departementNom, regionNom: $regionNom)';
}


}

/// @nodoc
abstract mixin class $UtilisateurCopyWith<$Res>  {
  factory $UtilisateurCopyWith(Utilisateur value, $Res Function(Utilisateur) _then) = _$UtilisateurCopyWithImpl;
@useResult
$Res call({
 int id, String telephone, String? username,@JsonKey(name: 'first_name') String prenom,@JsonKey(name: 'last_name') String nom, String role,@JsonKey(name: 'est_verifie') bool estVerifie,@JsonKey(name: 'pin_par_defaut') bool pinParDefaut,@JsonKey(name: 'langue_preferee') String languePreferee,@JsonKey(name: 'token_fcm') String? tokenFcm, int? departement,@JsonKey(name: 'departement_nom') String departementNom,@JsonKey(name: 'region_nom') String regionNom
});




}
/// @nodoc
class _$UtilisateurCopyWithImpl<$Res>
    implements $UtilisateurCopyWith<$Res> {
  _$UtilisateurCopyWithImpl(this._self, this._then);

  final Utilisateur _self;
  final $Res Function(Utilisateur) _then;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? telephone = null,Object? username = freezed,Object? prenom = null,Object? nom = null,Object? role = null,Object? estVerifie = null,Object? pinParDefaut = null,Object? languePreferee = null,Object? tokenFcm = freezed,Object? departement = freezed,Object? departementNom = null,Object? regionNom = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,telephone: null == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,prenom: null == prenom ? _self.prenom : prenom // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,estVerifie: null == estVerifie ? _self.estVerifie : estVerifie // ignore: cast_nullable_to_non_nullable
as bool,pinParDefaut: null == pinParDefaut ? _self.pinParDefaut : pinParDefaut // ignore: cast_nullable_to_non_nullable
as bool,languePreferee: null == languePreferee ? _self.languePreferee : languePreferee // ignore: cast_nullable_to_non_nullable
as String,tokenFcm: freezed == tokenFcm ? _self.tokenFcm : tokenFcm // ignore: cast_nullable_to_non_nullable
as String?,departement: freezed == departement ? _self.departement : departement // ignore: cast_nullable_to_non_nullable
as int?,departementNom: null == departementNom ? _self.departementNom : departementNom // ignore: cast_nullable_to_non_nullable
as String,regionNom: null == regionNom ? _self.regionNom : regionNom // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Utilisateur].
extension UtilisateurPatterns on Utilisateur {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Utilisateur value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Utilisateur value)  $default,){
final _that = this;
switch (_that) {
case _Utilisateur():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Utilisateur value)?  $default,){
final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String telephone,  String? username, @JsonKey(name: 'first_name')  String prenom, @JsonKey(name: 'last_name')  String nom,  String role, @JsonKey(name: 'est_verifie')  bool estVerifie, @JsonKey(name: 'pin_par_defaut')  bool pinParDefaut, @JsonKey(name: 'langue_preferee')  String languePreferee, @JsonKey(name: 'token_fcm')  String? tokenFcm,  int? departement, @JsonKey(name: 'departement_nom')  String departementNom, @JsonKey(name: 'region_nom')  String regionNom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
return $default(_that.id,_that.telephone,_that.username,_that.prenom,_that.nom,_that.role,_that.estVerifie,_that.pinParDefaut,_that.languePreferee,_that.tokenFcm,_that.departement,_that.departementNom,_that.regionNom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String telephone,  String? username, @JsonKey(name: 'first_name')  String prenom, @JsonKey(name: 'last_name')  String nom,  String role, @JsonKey(name: 'est_verifie')  bool estVerifie, @JsonKey(name: 'pin_par_defaut')  bool pinParDefaut, @JsonKey(name: 'langue_preferee')  String languePreferee, @JsonKey(name: 'token_fcm')  String? tokenFcm,  int? departement, @JsonKey(name: 'departement_nom')  String departementNom, @JsonKey(name: 'region_nom')  String regionNom)  $default,) {final _that = this;
switch (_that) {
case _Utilisateur():
return $default(_that.id,_that.telephone,_that.username,_that.prenom,_that.nom,_that.role,_that.estVerifie,_that.pinParDefaut,_that.languePreferee,_that.tokenFcm,_that.departement,_that.departementNom,_that.regionNom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String telephone,  String? username, @JsonKey(name: 'first_name')  String prenom, @JsonKey(name: 'last_name')  String nom,  String role, @JsonKey(name: 'est_verifie')  bool estVerifie, @JsonKey(name: 'pin_par_defaut')  bool pinParDefaut, @JsonKey(name: 'langue_preferee')  String languePreferee, @JsonKey(name: 'token_fcm')  String? tokenFcm,  int? departement, @JsonKey(name: 'departement_nom')  String departementNom, @JsonKey(name: 'region_nom')  String regionNom)?  $default,) {final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
return $default(_that.id,_that.telephone,_that.username,_that.prenom,_that.nom,_that.role,_that.estVerifie,_that.pinParDefaut,_that.languePreferee,_that.tokenFcm,_that.departement,_that.departementNom,_that.regionNom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Utilisateur extends Utilisateur {
  const _Utilisateur({required this.id, required this.telephone, this.username, @JsonKey(name: 'first_name') this.prenom = '', @JsonKey(name: 'last_name') this.nom = '', this.role = 'client', @JsonKey(name: 'est_verifie') this.estVerifie = false, @JsonKey(name: 'pin_par_defaut') this.pinParDefaut = false, @JsonKey(name: 'langue_preferee') this.languePreferee = 'fr', @JsonKey(name: 'token_fcm') this.tokenFcm, this.departement, @JsonKey(name: 'departement_nom') this.departementNom = '', @JsonKey(name: 'region_nom') this.regionNom = ''}): super._();
  factory _Utilisateur.fromJson(Map<String, dynamic> json) => _$UtilisateurFromJson(json);

@override final  int id;
@override final  String telephone;
@override final  String? username;
@override@JsonKey(name: 'first_name') final  String prenom;
@override@JsonKey(name: 'last_name') final  String nom;
@override@JsonKey() final  String role;
@override@JsonKey(name: 'est_verifie') final  bool estVerifie;
@override@JsonKey(name: 'pin_par_defaut') final  bool pinParDefaut;
@override@JsonKey(name: 'langue_preferee') final  String languePreferee;
@override@JsonKey(name: 'token_fcm') final  String? tokenFcm;
@override final  int? departement;
@override@JsonKey(name: 'departement_nom') final  String departementNom;
@override@JsonKey(name: 'region_nom') final  String regionNom;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UtilisateurCopyWith<_Utilisateur> get copyWith => __$UtilisateurCopyWithImpl<_Utilisateur>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UtilisateurToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Utilisateur&&(identical(other.id, id) || other.id == id)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.username, username) || other.username == username)&&(identical(other.prenom, prenom) || other.prenom == prenom)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.role, role) || other.role == role)&&(identical(other.estVerifie, estVerifie) || other.estVerifie == estVerifie)&&(identical(other.pinParDefaut, pinParDefaut) || other.pinParDefaut == pinParDefaut)&&(identical(other.languePreferee, languePreferee) || other.languePreferee == languePreferee)&&(identical(other.tokenFcm, tokenFcm) || other.tokenFcm == tokenFcm)&&(identical(other.departement, departement) || other.departement == departement)&&(identical(other.departementNom, departementNom) || other.departementNom == departementNom)&&(identical(other.regionNom, regionNom) || other.regionNom == regionNom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,telephone,username,prenom,nom,role,estVerifie,pinParDefaut,languePreferee,tokenFcm,departement,departementNom,regionNom);

@override
String toString() {
  return 'Utilisateur(id: $id, telephone: $telephone, username: $username, prenom: $prenom, nom: $nom, role: $role, estVerifie: $estVerifie, pinParDefaut: $pinParDefaut, languePreferee: $languePreferee, tokenFcm: $tokenFcm, departement: $departement, departementNom: $departementNom, regionNom: $regionNom)';
}


}

/// @nodoc
abstract mixin class _$UtilisateurCopyWith<$Res> implements $UtilisateurCopyWith<$Res> {
  factory _$UtilisateurCopyWith(_Utilisateur value, $Res Function(_Utilisateur) _then) = __$UtilisateurCopyWithImpl;
@override @useResult
$Res call({
 int id, String telephone, String? username,@JsonKey(name: 'first_name') String prenom,@JsonKey(name: 'last_name') String nom, String role,@JsonKey(name: 'est_verifie') bool estVerifie,@JsonKey(name: 'pin_par_defaut') bool pinParDefaut,@JsonKey(name: 'langue_preferee') String languePreferee,@JsonKey(name: 'token_fcm') String? tokenFcm, int? departement,@JsonKey(name: 'departement_nom') String departementNom,@JsonKey(name: 'region_nom') String regionNom
});




}
/// @nodoc
class __$UtilisateurCopyWithImpl<$Res>
    implements _$UtilisateurCopyWith<$Res> {
  __$UtilisateurCopyWithImpl(this._self, this._then);

  final _Utilisateur _self;
  final $Res Function(_Utilisateur) _then;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? telephone = null,Object? username = freezed,Object? prenom = null,Object? nom = null,Object? role = null,Object? estVerifie = null,Object? pinParDefaut = null,Object? languePreferee = null,Object? tokenFcm = freezed,Object? departement = freezed,Object? departementNom = null,Object? regionNom = null,}) {
  return _then(_Utilisateur(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,telephone: null == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,prenom: null == prenom ? _self.prenom : prenom // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,estVerifie: null == estVerifie ? _self.estVerifie : estVerifie // ignore: cast_nullable_to_non_nullable
as bool,pinParDefaut: null == pinParDefaut ? _self.pinParDefaut : pinParDefaut // ignore: cast_nullable_to_non_nullable
as bool,languePreferee: null == languePreferee ? _self.languePreferee : languePreferee // ignore: cast_nullable_to_non_nullable
as String,tokenFcm: freezed == tokenFcm ? _self.tokenFcm : tokenFcm // ignore: cast_nullable_to_non_nullable
as String?,departement: freezed == departement ? _self.departement : departement // ignore: cast_nullable_to_non_nullable
as int?,departementNom: null == departementNom ? _self.departementNom : departementNom // ignore: cast_nullable_to_non_nullable
as String,regionNom: null == regionNom ? _self.regionNom : regionNom // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
