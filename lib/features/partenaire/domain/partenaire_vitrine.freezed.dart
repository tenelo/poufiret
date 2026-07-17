// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partenaire_vitrine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartenaireVitrine {

 int get id;@JsonKey(name: 'nom_commerce') String get nomCommerce;@JsonKey(name: 'type_partenaire') String get typePartenaire;@JsonKey(name: 'type_partenaire_libelle') String get typeLibelle; String get description; String? get logo;@JsonKey(name: 'photo_couverture') String? get photoCouverture; String get adresse; String get quartier; String get secteur; String get ville;@JsonKey(name: 'description_acces') String get descriptionAcces;@JsonKey(name: 'telephone_pro') String get telephonePro; String get whatsapp;@JsonKey(name: 'email_pro') String get emailPro;@JsonKey(name: 'nombre_likes') int get nombreLikes;@JsonKey(name: 'est_like_par_moi') bool get estLikeParMoi;@JsonKey(name: 'est_favori_par_moi') bool get estFavoriParMoi;
/// Create a copy of PartenaireVitrine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartenaireVitrineCopyWith<PartenaireVitrine> get copyWith => _$PartenaireVitrineCopyWithImpl<PartenaireVitrine>(this as PartenaireVitrine, _$identity);

  /// Serializes this PartenaireVitrine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartenaireVitrine&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire)&&(identical(other.typeLibelle, typeLibelle) || other.typeLibelle == typeLibelle)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.secteur, secteur) || other.secteur == secteur)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.descriptionAcces, descriptionAcces) || other.descriptionAcces == descriptionAcces)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.emailPro, emailPro) || other.emailPro == emailPro)&&(identical(other.nombreLikes, nombreLikes) || other.nombreLikes == nombreLikes)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&(identical(other.estFavoriParMoi, estFavoriParMoi) || other.estFavoriParMoi == estFavoriParMoi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,typePartenaire,typeLibelle,description,logo,photoCouverture,adresse,quartier,secteur,ville,descriptionAcces,telephonePro,whatsapp,emailPro,nombreLikes,estLikeParMoi,estFavoriParMoi);

@override
String toString() {
  return 'PartenaireVitrine(id: $id, nomCommerce: $nomCommerce, typePartenaire: $typePartenaire, typeLibelle: $typeLibelle, description: $description, logo: $logo, photoCouverture: $photoCouverture, adresse: $adresse, quartier: $quartier, secteur: $secteur, ville: $ville, descriptionAcces: $descriptionAcces, telephonePro: $telephonePro, whatsapp: $whatsapp, emailPro: $emailPro, nombreLikes: $nombreLikes, estLikeParMoi: $estLikeParMoi, estFavoriParMoi: $estFavoriParMoi)';
}


}

/// @nodoc
abstract mixin class $PartenaireVitrineCopyWith<$Res>  {
  factory $PartenaireVitrineCopyWith(PartenaireVitrine value, $Res Function(PartenaireVitrine) _then) = _$PartenaireVitrineCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce,@JsonKey(name: 'type_partenaire') String typePartenaire,@JsonKey(name: 'type_partenaire_libelle') String typeLibelle, String description, String? logo,@JsonKey(name: 'photo_couverture') String? photoCouverture, String adresse, String quartier, String secteur, String ville,@JsonKey(name: 'description_acces') String descriptionAcces,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(name: 'email_pro') String emailPro,@JsonKey(name: 'nombre_likes') int nombreLikes,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi,@JsonKey(name: 'est_favori_par_moi') bool estFavoriParMoi
});




}
/// @nodoc
class _$PartenaireVitrineCopyWithImpl<$Res>
    implements $PartenaireVitrineCopyWith<$Res> {
  _$PartenaireVitrineCopyWithImpl(this._self, this._then);

  final PartenaireVitrine _self;
  final $Res Function(PartenaireVitrine) _then;

/// Create a copy of PartenaireVitrine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nomCommerce = null,Object? typePartenaire = null,Object? typeLibelle = null,Object? description = null,Object? logo = freezed,Object? photoCouverture = freezed,Object? adresse = null,Object? quartier = null,Object? secteur = null,Object? ville = null,Object? descriptionAcces = null,Object? telephonePro = null,Object? whatsapp = null,Object? emailPro = null,Object? nombreLikes = null,Object? estLikeParMoi = null,Object? estFavoriParMoi = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,typeLibelle: null == typeLibelle ? _self.typeLibelle : typeLibelle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,photoCouverture: freezed == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String?,adresse: null == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,secteur: null == secteur ? _self.secteur : secteur // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,descriptionAcces: null == descriptionAcces ? _self.descriptionAcces : descriptionAcces // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,emailPro: null == emailPro ? _self.emailPro : emailPro // ignore: cast_nullable_to_non_nullable
as String,nombreLikes: null == nombreLikes ? _self.nombreLikes : nombreLikes // ignore: cast_nullable_to_non_nullable
as int,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,estFavoriParMoi: null == estFavoriParMoi ? _self.estFavoriParMoi : estFavoriParMoi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PartenaireVitrine].
extension PartenaireVitrinePatterns on PartenaireVitrine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartenaireVitrine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartenaireVitrine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartenaireVitrine value)  $default,){
final _that = this;
switch (_that) {
case _PartenaireVitrine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartenaireVitrine value)?  $default,){
final _that = this;
switch (_that) {
case _PartenaireVitrine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire, @JsonKey(name: 'type_partenaire_libelle')  String typeLibelle,  String description,  String? logo, @JsonKey(name: 'photo_couverture')  String? photoCouverture,  String adresse,  String quartier,  String secteur,  String ville, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'email_pro')  String emailPro, @JsonKey(name: 'nombre_likes')  int nombreLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartenaireVitrine() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.typeLibelle,_that.description,_that.logo,_that.photoCouverture,_that.adresse,_that.quartier,_that.secteur,_that.ville,_that.descriptionAcces,_that.telephonePro,_that.whatsapp,_that.emailPro,_that.nombreLikes,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire, @JsonKey(name: 'type_partenaire_libelle')  String typeLibelle,  String description,  String? logo, @JsonKey(name: 'photo_couverture')  String? photoCouverture,  String adresse,  String quartier,  String secteur,  String ville, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'email_pro')  String emailPro, @JsonKey(name: 'nombre_likes')  int nombreLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)  $default,) {final _that = this;
switch (_that) {
case _PartenaireVitrine():
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.typeLibelle,_that.description,_that.logo,_that.photoCouverture,_that.adresse,_that.quartier,_that.secteur,_that.ville,_that.descriptionAcces,_that.telephonePro,_that.whatsapp,_that.emailPro,_that.nombreLikes,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire, @JsonKey(name: 'type_partenaire_libelle')  String typeLibelle,  String description,  String? logo, @JsonKey(name: 'photo_couverture')  String? photoCouverture,  String adresse,  String quartier,  String secteur,  String ville, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'email_pro')  String emailPro, @JsonKey(name: 'nombre_likes')  int nombreLikes, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)?  $default,) {final _that = this;
switch (_that) {
case _PartenaireVitrine() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.typeLibelle,_that.description,_that.logo,_that.photoCouverture,_that.adresse,_that.quartier,_that.secteur,_that.ville,_that.descriptionAcces,_that.telephonePro,_that.whatsapp,_that.emailPro,_that.nombreLikes,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartenaireVitrine extends PartenaireVitrine {
  const _PartenaireVitrine({required this.id, @JsonKey(name: 'nom_commerce') this.nomCommerce = '', @JsonKey(name: 'type_partenaire') this.typePartenaire = '', @JsonKey(name: 'type_partenaire_libelle') this.typeLibelle = '', this.description = '', this.logo, @JsonKey(name: 'photo_couverture') this.photoCouverture, this.adresse = '', this.quartier = '', this.secteur = '', this.ville = '', @JsonKey(name: 'description_acces') this.descriptionAcces = '', @JsonKey(name: 'telephone_pro') this.telephonePro = '', this.whatsapp = '', @JsonKey(name: 'email_pro') this.emailPro = '', @JsonKey(name: 'nombre_likes') this.nombreLikes = 0, @JsonKey(name: 'est_like_par_moi') this.estLikeParMoi = false, @JsonKey(name: 'est_favori_par_moi') this.estFavoriParMoi = false}): super._();
  factory _PartenaireVitrine.fromJson(Map<String, dynamic> json) => _$PartenaireVitrineFromJson(json);

@override final  int id;
@override@JsonKey(name: 'nom_commerce') final  String nomCommerce;
@override@JsonKey(name: 'type_partenaire') final  String typePartenaire;
@override@JsonKey(name: 'type_partenaire_libelle') final  String typeLibelle;
@override@JsonKey() final  String description;
@override final  String? logo;
@override@JsonKey(name: 'photo_couverture') final  String? photoCouverture;
@override@JsonKey() final  String adresse;
@override@JsonKey() final  String quartier;
@override@JsonKey() final  String secteur;
@override@JsonKey() final  String ville;
@override@JsonKey(name: 'description_acces') final  String descriptionAcces;
@override@JsonKey(name: 'telephone_pro') final  String telephonePro;
@override@JsonKey() final  String whatsapp;
@override@JsonKey(name: 'email_pro') final  String emailPro;
@override@JsonKey(name: 'nombre_likes') final  int nombreLikes;
@override@JsonKey(name: 'est_like_par_moi') final  bool estLikeParMoi;
@override@JsonKey(name: 'est_favori_par_moi') final  bool estFavoriParMoi;

/// Create a copy of PartenaireVitrine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartenaireVitrineCopyWith<_PartenaireVitrine> get copyWith => __$PartenaireVitrineCopyWithImpl<_PartenaireVitrine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartenaireVitrineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartenaireVitrine&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire)&&(identical(other.typeLibelle, typeLibelle) || other.typeLibelle == typeLibelle)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.secteur, secteur) || other.secteur == secteur)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.descriptionAcces, descriptionAcces) || other.descriptionAcces == descriptionAcces)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.emailPro, emailPro) || other.emailPro == emailPro)&&(identical(other.nombreLikes, nombreLikes) || other.nombreLikes == nombreLikes)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&(identical(other.estFavoriParMoi, estFavoriParMoi) || other.estFavoriParMoi == estFavoriParMoi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,typePartenaire,typeLibelle,description,logo,photoCouverture,adresse,quartier,secteur,ville,descriptionAcces,telephonePro,whatsapp,emailPro,nombreLikes,estLikeParMoi,estFavoriParMoi);

@override
String toString() {
  return 'PartenaireVitrine(id: $id, nomCommerce: $nomCommerce, typePartenaire: $typePartenaire, typeLibelle: $typeLibelle, description: $description, logo: $logo, photoCouverture: $photoCouverture, adresse: $adresse, quartier: $quartier, secteur: $secteur, ville: $ville, descriptionAcces: $descriptionAcces, telephonePro: $telephonePro, whatsapp: $whatsapp, emailPro: $emailPro, nombreLikes: $nombreLikes, estLikeParMoi: $estLikeParMoi, estFavoriParMoi: $estFavoriParMoi)';
}


}

/// @nodoc
abstract mixin class _$PartenaireVitrineCopyWith<$Res> implements $PartenaireVitrineCopyWith<$Res> {
  factory _$PartenaireVitrineCopyWith(_PartenaireVitrine value, $Res Function(_PartenaireVitrine) _then) = __$PartenaireVitrineCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce,@JsonKey(name: 'type_partenaire') String typePartenaire,@JsonKey(name: 'type_partenaire_libelle') String typeLibelle, String description, String? logo,@JsonKey(name: 'photo_couverture') String? photoCouverture, String adresse, String quartier, String secteur, String ville,@JsonKey(name: 'description_acces') String descriptionAcces,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(name: 'email_pro') String emailPro,@JsonKey(name: 'nombre_likes') int nombreLikes,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi,@JsonKey(name: 'est_favori_par_moi') bool estFavoriParMoi
});




}
/// @nodoc
class __$PartenaireVitrineCopyWithImpl<$Res>
    implements _$PartenaireVitrineCopyWith<$Res> {
  __$PartenaireVitrineCopyWithImpl(this._self, this._then);

  final _PartenaireVitrine _self;
  final $Res Function(_PartenaireVitrine) _then;

/// Create a copy of PartenaireVitrine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nomCommerce = null,Object? typePartenaire = null,Object? typeLibelle = null,Object? description = null,Object? logo = freezed,Object? photoCouverture = freezed,Object? adresse = null,Object? quartier = null,Object? secteur = null,Object? ville = null,Object? descriptionAcces = null,Object? telephonePro = null,Object? whatsapp = null,Object? emailPro = null,Object? nombreLikes = null,Object? estLikeParMoi = null,Object? estFavoriParMoi = null,}) {
  return _then(_PartenaireVitrine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,typeLibelle: null == typeLibelle ? _self.typeLibelle : typeLibelle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,photoCouverture: freezed == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String?,adresse: null == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,secteur: null == secteur ? _self.secteur : secteur // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,descriptionAcces: null == descriptionAcces ? _self.descriptionAcces : descriptionAcces // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,emailPro: null == emailPro ? _self.emailPro : emailPro // ignore: cast_nullable_to_non_nullable
as String,nombreLikes: null == nombreLikes ? _self.nombreLikes : nombreLikes // ignore: cast_nullable_to_non_nullable
as int,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,estFavoriParMoi: null == estFavoriParMoi ? _self.estFavoriParMoi : estFavoriParMoi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
