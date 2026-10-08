// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hebergement_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Etablissement {

@JsonKey(fromJson: versInt) int get id; String get nom; String get logo; String get couverture;@JsonKey(name: 'telephone_pro') String get telephonePro; String get whatsapp;@JsonKey(name: 'type_etablissement') String get typeEtablissement;@JsonKey(name: 'type_etablissement_libelle') String get typeEtablissementLibelle; String get description; List<String> get galerie; List<Panorama> get panoramas;@JsonKey(fromJson: versIntNullable) int? get etoiles;@JsonKey(name: 'localisation_texte') String get localisationTexte;@JsonKey(fromJson: versDoubleNullable) double? get latitude;@JsonKey(fromJson: versDoubleNullable) double? get longitude;@JsonKey(name: 'heure_arrivee') String get heureArrivee;@JsonKey(name: 'heure_depart') String get heureDepart;@JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes) List<String> get equipements;/// inclus | en_option | non (ou booléen côté serveur).
@JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner) String get petitDejeuner;@JsonKey(name: 'petit_dejeuner_libelle') String get petitDejeunerLibelle;@JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable) int? get prixPetitDejeuner;@JsonKey(name: 'politique_annulation') String get politiqueAnnulation;@JsonKey(name: 'politique_annulation_libelle') String get politiqueAnnulationLibelle; String get conditions;
/// Create a copy of Etablissement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EtablissementCopyWith<Etablissement> get copyWith => _$EtablissementCopyWithImpl<Etablissement>(this as Etablissement, _$identity);

  /// Serializes this Etablissement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Etablissement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.typeEtablissement, typeEtablissement) || other.typeEtablissement == typeEtablissement)&&(identical(other.typeEtablissementLibelle, typeEtablissementLibelle) || other.typeEtablissementLibelle == typeEtablissementLibelle)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.galerie, galerie)&&const DeepCollectionEquality().equals(other.panoramas, panoramas)&&(identical(other.etoiles, etoiles) || other.etoiles == etoiles)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heureArrivee, heureArrivee) || other.heureArrivee == heureArrivee)&&(identical(other.heureDepart, heureDepart) || other.heureDepart == heureDepart)&&const DeepCollectionEquality().equals(other.equipements, equipements)&&(identical(other.petitDejeuner, petitDejeuner) || other.petitDejeuner == petitDejeuner)&&(identical(other.petitDejeunerLibelle, petitDejeunerLibelle) || other.petitDejeunerLibelle == petitDejeunerLibelle)&&(identical(other.prixPetitDejeuner, prixPetitDejeuner) || other.prixPetitDejeuner == prixPetitDejeuner)&&(identical(other.politiqueAnnulation, politiqueAnnulation) || other.politiqueAnnulation == politiqueAnnulation)&&(identical(other.politiqueAnnulationLibelle, politiqueAnnulationLibelle) || other.politiqueAnnulationLibelle == politiqueAnnulationLibelle)&&(identical(other.conditions, conditions) || other.conditions == conditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,logo,couverture,telephonePro,whatsapp,typeEtablissement,typeEtablissementLibelle,description,const DeepCollectionEquality().hash(galerie),const DeepCollectionEquality().hash(panoramas),etoiles,localisationTexte,latitude,longitude,heureArrivee,heureDepart,const DeepCollectionEquality().hash(equipements),petitDejeuner,petitDejeunerLibelle,prixPetitDejeuner,politiqueAnnulation,politiqueAnnulationLibelle,conditions]);

@override
String toString() {
  return 'Etablissement(id: $id, nom: $nom, logo: $logo, couverture: $couverture, telephonePro: $telephonePro, whatsapp: $whatsapp, typeEtablissement: $typeEtablissement, typeEtablissementLibelle: $typeEtablissementLibelle, description: $description, galerie: $galerie, panoramas: $panoramas, etoiles: $etoiles, localisationTexte: $localisationTexte, latitude: $latitude, longitude: $longitude, heureArrivee: $heureArrivee, heureDepart: $heureDepart, equipements: $equipements, petitDejeuner: $petitDejeuner, petitDejeunerLibelle: $petitDejeunerLibelle, prixPetitDejeuner: $prixPetitDejeuner, politiqueAnnulation: $politiqueAnnulation, politiqueAnnulationLibelle: $politiqueAnnulationLibelle, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class $EtablissementCopyWith<$Res>  {
  factory $EtablissementCopyWith(Etablissement value, $Res Function(Etablissement) _then) = _$EtablissementCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: versInt) int id, String nom, String logo, String couverture,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(name: 'type_etablissement') String typeEtablissement,@JsonKey(name: 'type_etablissement_libelle') String typeEtablissementLibelle, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(fromJson: versIntNullable) int? etoiles,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude,@JsonKey(name: 'heure_arrivee') String heureArrivee,@JsonKey(name: 'heure_depart') String heureDepart,@JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes) List<String> equipements,@JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner) String petitDejeuner,@JsonKey(name: 'petit_dejeuner_libelle') String petitDejeunerLibelle,@JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable) int? prixPetitDejeuner,@JsonKey(name: 'politique_annulation') String politiqueAnnulation,@JsonKey(name: 'politique_annulation_libelle') String politiqueAnnulationLibelle, String conditions
});




}
/// @nodoc
class _$EtablissementCopyWithImpl<$Res>
    implements $EtablissementCopyWith<$Res> {
  _$EtablissementCopyWithImpl(this._self, this._then);

  final Etablissement _self;
  final $Res Function(Etablissement) _then;

/// Create a copy of Etablissement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? logo = null,Object? couverture = null,Object? telephonePro = null,Object? whatsapp = null,Object? typeEtablissement = null,Object? typeEtablissementLibelle = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? etoiles = freezed,Object? localisationTexte = null,Object? latitude = freezed,Object? longitude = freezed,Object? heureArrivee = null,Object? heureDepart = null,Object? equipements = null,Object? petitDejeuner = null,Object? petitDejeunerLibelle = null,Object? prixPetitDejeuner = freezed,Object? politiqueAnnulation = null,Object? politiqueAnnulationLibelle = null,Object? conditions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,typeEtablissement: null == typeEtablissement ? _self.typeEtablissement : typeEtablissement // ignore: cast_nullable_to_non_nullable
as String,typeEtablissementLibelle: null == typeEtablissementLibelle ? _self.typeEtablissementLibelle : typeEtablissementLibelle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self.galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self.panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,etoiles: freezed == etoiles ? _self.etoiles : etoiles // ignore: cast_nullable_to_non_nullable
as int?,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,heureArrivee: null == heureArrivee ? _self.heureArrivee : heureArrivee // ignore: cast_nullable_to_non_nullable
as String,heureDepart: null == heureDepart ? _self.heureDepart : heureDepart // ignore: cast_nullable_to_non_nullable
as String,equipements: null == equipements ? _self.equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,petitDejeuner: null == petitDejeuner ? _self.petitDejeuner : petitDejeuner // ignore: cast_nullable_to_non_nullable
as String,petitDejeunerLibelle: null == petitDejeunerLibelle ? _self.petitDejeunerLibelle : petitDejeunerLibelle // ignore: cast_nullable_to_non_nullable
as String,prixPetitDejeuner: freezed == prixPetitDejeuner ? _self.prixPetitDejeuner : prixPetitDejeuner // ignore: cast_nullable_to_non_nullable
as int?,politiqueAnnulation: null == politiqueAnnulation ? _self.politiqueAnnulation : politiqueAnnulation // ignore: cast_nullable_to_non_nullable
as String,politiqueAnnulationLibelle: null == politiqueAnnulationLibelle ? _self.politiqueAnnulationLibelle : politiqueAnnulationLibelle // ignore: cast_nullable_to_non_nullable
as String,conditions: null == conditions ? _self.conditions : conditions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Etablissement].
extension EtablissementPatterns on Etablissement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Etablissement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Etablissement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Etablissement value)  $default,){
final _that = this;
switch (_that) {
case _Etablissement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Etablissement value)?  $default,){
final _that = this;
switch (_that) {
case _Etablissement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: versInt)  int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'type_etablissement')  String typeEtablissement, @JsonKey(name: 'type_etablissement_libelle')  String typeEtablissementLibelle,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(fromJson: versIntNullable)  int? etoiles, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart, @JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner)  String petitDejeuner, @JsonKey(name: 'petit_dejeuner_libelle')  String petitDejeunerLibelle, @JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable)  int? prixPetitDejeuner, @JsonKey(name: 'politique_annulation')  String politiqueAnnulation, @JsonKey(name: 'politique_annulation_libelle')  String politiqueAnnulationLibelle,  String conditions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Etablissement() when $default != null:
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp,_that.typeEtablissement,_that.typeEtablissementLibelle,_that.description,_that.galerie,_that.panoramas,_that.etoiles,_that.localisationTexte,_that.latitude,_that.longitude,_that.heureArrivee,_that.heureDepart,_that.equipements,_that.petitDejeuner,_that.petitDejeunerLibelle,_that.prixPetitDejeuner,_that.politiqueAnnulation,_that.politiqueAnnulationLibelle,_that.conditions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: versInt)  int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'type_etablissement')  String typeEtablissement, @JsonKey(name: 'type_etablissement_libelle')  String typeEtablissementLibelle,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(fromJson: versIntNullable)  int? etoiles, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart, @JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner)  String petitDejeuner, @JsonKey(name: 'petit_dejeuner_libelle')  String petitDejeunerLibelle, @JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable)  int? prixPetitDejeuner, @JsonKey(name: 'politique_annulation')  String politiqueAnnulation, @JsonKey(name: 'politique_annulation_libelle')  String politiqueAnnulationLibelle,  String conditions)  $default,) {final _that = this;
switch (_that) {
case _Etablissement():
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp,_that.typeEtablissement,_that.typeEtablissementLibelle,_that.description,_that.galerie,_that.panoramas,_that.etoiles,_that.localisationTexte,_that.latitude,_that.longitude,_that.heureArrivee,_that.heureDepart,_that.equipements,_that.petitDejeuner,_that.petitDejeunerLibelle,_that.prixPetitDejeuner,_that.politiqueAnnulation,_that.politiqueAnnulationLibelle,_that.conditions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: versInt)  int id,  String nom,  String logo,  String couverture, @JsonKey(name: 'telephone_pro')  String telephonePro,  String whatsapp, @JsonKey(name: 'type_etablissement')  String typeEtablissement, @JsonKey(name: 'type_etablissement_libelle')  String typeEtablissementLibelle,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(fromJson: versIntNullable)  int? etoiles, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart, @JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner)  String petitDejeuner, @JsonKey(name: 'petit_dejeuner_libelle')  String petitDejeunerLibelle, @JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable)  int? prixPetitDejeuner, @JsonKey(name: 'politique_annulation')  String politiqueAnnulation, @JsonKey(name: 'politique_annulation_libelle')  String politiqueAnnulationLibelle,  String conditions)?  $default,) {final _that = this;
switch (_that) {
case _Etablissement() when $default != null:
return $default(_that.id,_that.nom,_that.logo,_that.couverture,_that.telephonePro,_that.whatsapp,_that.typeEtablissement,_that.typeEtablissementLibelle,_that.description,_that.galerie,_that.panoramas,_that.etoiles,_that.localisationTexte,_that.latitude,_that.longitude,_that.heureArrivee,_that.heureDepart,_that.equipements,_that.petitDejeuner,_that.petitDejeunerLibelle,_that.prixPetitDejeuner,_that.politiqueAnnulation,_that.politiqueAnnulationLibelle,_that.conditions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Etablissement extends Etablissement {
  const _Etablissement({@JsonKey(fromJson: versInt) this.id = 0, this.nom = '', this.logo = '', this.couverture = '', @JsonKey(name: 'telephone_pro') this.telephonePro = '', this.whatsapp = '', @JsonKey(name: 'type_etablissement') this.typeEtablissement = '', @JsonKey(name: 'type_etablissement_libelle') this.typeEtablissementLibelle = '', this.description = '', final  List<String> galerie = const <String>[], final  List<Panorama> panoramas = const <Panorama>[], @JsonKey(fromJson: versIntNullable) this.etoiles, @JsonKey(name: 'localisation_texte') this.localisationTexte = '', @JsonKey(fromJson: versDoubleNullable) this.latitude, @JsonKey(fromJson: versDoubleNullable) this.longitude, @JsonKey(name: 'heure_arrivee') this.heureArrivee = '', @JsonKey(name: 'heure_depart') this.heureDepart = '', @JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes) final  List<String> equipements = const <String>[], @JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner) this.petitDejeuner = '', @JsonKey(name: 'petit_dejeuner_libelle') this.petitDejeunerLibelle = '', @JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable) this.prixPetitDejeuner, @JsonKey(name: 'politique_annulation') this.politiqueAnnulation = '', @JsonKey(name: 'politique_annulation_libelle') this.politiqueAnnulationLibelle = '', this.conditions = ''}): _galerie = galerie,_panoramas = panoramas,_equipements = equipements,super._();
  factory _Etablissement.fromJson(Map<String, dynamic> json) => _$EtablissementFromJson(json);

@override@JsonKey(fromJson: versInt) final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String logo;
@override@JsonKey() final  String couverture;
@override@JsonKey(name: 'telephone_pro') final  String telephonePro;
@override@JsonKey() final  String whatsapp;
@override@JsonKey(name: 'type_etablissement') final  String typeEtablissement;
@override@JsonKey(name: 'type_etablissement_libelle') final  String typeEtablissementLibelle;
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

@override@JsonKey(fromJson: versIntNullable) final  int? etoiles;
@override@JsonKey(name: 'localisation_texte') final  String localisationTexte;
@override@JsonKey(fromJson: versDoubleNullable) final  double? latitude;
@override@JsonKey(fromJson: versDoubleNullable) final  double? longitude;
@override@JsonKey(name: 'heure_arrivee') final  String heureArrivee;
@override@JsonKey(name: 'heure_depart') final  String heureDepart;
 final  List<String> _equipements;
@override@JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes) List<String> get equipements {
  if (_equipements is EqualUnmodifiableListView) return _equipements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipements);
}

/// inclus | en_option | non (ou booléen côté serveur).
@override@JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner) final  String petitDejeuner;
@override@JsonKey(name: 'petit_dejeuner_libelle') final  String petitDejeunerLibelle;
@override@JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable) final  int? prixPetitDejeuner;
@override@JsonKey(name: 'politique_annulation') final  String politiqueAnnulation;
@override@JsonKey(name: 'politique_annulation_libelle') final  String politiqueAnnulationLibelle;
@override@JsonKey() final  String conditions;

/// Create a copy of Etablissement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EtablissementCopyWith<_Etablissement> get copyWith => __$EtablissementCopyWithImpl<_Etablissement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EtablissementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Etablissement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.couverture, couverture) || other.couverture == couverture)&&(identical(other.telephonePro, telephonePro) || other.telephonePro == telephonePro)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.typeEtablissement, typeEtablissement) || other.typeEtablissement == typeEtablissement)&&(identical(other.typeEtablissementLibelle, typeEtablissementLibelle) || other.typeEtablissementLibelle == typeEtablissementLibelle)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._galerie, _galerie)&&const DeepCollectionEquality().equals(other._panoramas, _panoramas)&&(identical(other.etoiles, etoiles) || other.etoiles == etoiles)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heureArrivee, heureArrivee) || other.heureArrivee == heureArrivee)&&(identical(other.heureDepart, heureDepart) || other.heureDepart == heureDepart)&&const DeepCollectionEquality().equals(other._equipements, _equipements)&&(identical(other.petitDejeuner, petitDejeuner) || other.petitDejeuner == petitDejeuner)&&(identical(other.petitDejeunerLibelle, petitDejeunerLibelle) || other.petitDejeunerLibelle == petitDejeunerLibelle)&&(identical(other.prixPetitDejeuner, prixPetitDejeuner) || other.prixPetitDejeuner == prixPetitDejeuner)&&(identical(other.politiqueAnnulation, politiqueAnnulation) || other.politiqueAnnulation == politiqueAnnulation)&&(identical(other.politiqueAnnulationLibelle, politiqueAnnulationLibelle) || other.politiqueAnnulationLibelle == politiqueAnnulationLibelle)&&(identical(other.conditions, conditions) || other.conditions == conditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,logo,couverture,telephonePro,whatsapp,typeEtablissement,typeEtablissementLibelle,description,const DeepCollectionEquality().hash(_galerie),const DeepCollectionEquality().hash(_panoramas),etoiles,localisationTexte,latitude,longitude,heureArrivee,heureDepart,const DeepCollectionEquality().hash(_equipements),petitDejeuner,petitDejeunerLibelle,prixPetitDejeuner,politiqueAnnulation,politiqueAnnulationLibelle,conditions]);

@override
String toString() {
  return 'Etablissement(id: $id, nom: $nom, logo: $logo, couverture: $couverture, telephonePro: $telephonePro, whatsapp: $whatsapp, typeEtablissement: $typeEtablissement, typeEtablissementLibelle: $typeEtablissementLibelle, description: $description, galerie: $galerie, panoramas: $panoramas, etoiles: $etoiles, localisationTexte: $localisationTexte, latitude: $latitude, longitude: $longitude, heureArrivee: $heureArrivee, heureDepart: $heureDepart, equipements: $equipements, petitDejeuner: $petitDejeuner, petitDejeunerLibelle: $petitDejeunerLibelle, prixPetitDejeuner: $prixPetitDejeuner, politiqueAnnulation: $politiqueAnnulation, politiqueAnnulationLibelle: $politiqueAnnulationLibelle, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class _$EtablissementCopyWith<$Res> implements $EtablissementCopyWith<$Res> {
  factory _$EtablissementCopyWith(_Etablissement value, $Res Function(_Etablissement) _then) = __$EtablissementCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: versInt) int id, String nom, String logo, String couverture,@JsonKey(name: 'telephone_pro') String telephonePro, String whatsapp,@JsonKey(name: 'type_etablissement') String typeEtablissement,@JsonKey(name: 'type_etablissement_libelle') String typeEtablissementLibelle, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(fromJson: versIntNullable) int? etoiles,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude,@JsonKey(name: 'heure_arrivee') String heureArrivee,@JsonKey(name: 'heure_depart') String heureDepart,@JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes) List<String> equipements,@JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner) String petitDejeuner,@JsonKey(name: 'petit_dejeuner_libelle') String petitDejeunerLibelle,@JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable) int? prixPetitDejeuner,@JsonKey(name: 'politique_annulation') String politiqueAnnulation,@JsonKey(name: 'politique_annulation_libelle') String politiqueAnnulationLibelle, String conditions
});




}
/// @nodoc
class __$EtablissementCopyWithImpl<$Res>
    implements _$EtablissementCopyWith<$Res> {
  __$EtablissementCopyWithImpl(this._self, this._then);

  final _Etablissement _self;
  final $Res Function(_Etablissement) _then;

/// Create a copy of Etablissement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? logo = null,Object? couverture = null,Object? telephonePro = null,Object? whatsapp = null,Object? typeEtablissement = null,Object? typeEtablissementLibelle = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? etoiles = freezed,Object? localisationTexte = null,Object? latitude = freezed,Object? longitude = freezed,Object? heureArrivee = null,Object? heureDepart = null,Object? equipements = null,Object? petitDejeuner = null,Object? petitDejeunerLibelle = null,Object? prixPetitDejeuner = freezed,Object? politiqueAnnulation = null,Object? politiqueAnnulationLibelle = null,Object? conditions = null,}) {
  return _then(_Etablissement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,couverture: null == couverture ? _self.couverture : couverture // ignore: cast_nullable_to_non_nullable
as String,telephonePro: null == telephonePro ? _self.telephonePro : telephonePro // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,typeEtablissement: null == typeEtablissement ? _self.typeEtablissement : typeEtablissement // ignore: cast_nullable_to_non_nullable
as String,typeEtablissementLibelle: null == typeEtablissementLibelle ? _self.typeEtablissementLibelle : typeEtablissementLibelle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self._galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self._panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,etoiles: freezed == etoiles ? _self.etoiles : etoiles // ignore: cast_nullable_to_non_nullable
as int?,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,heureArrivee: null == heureArrivee ? _self.heureArrivee : heureArrivee // ignore: cast_nullable_to_non_nullable
as String,heureDepart: null == heureDepart ? _self.heureDepart : heureDepart // ignore: cast_nullable_to_non_nullable
as String,equipements: null == equipements ? _self._equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,petitDejeuner: null == petitDejeuner ? _self.petitDejeuner : petitDejeuner // ignore: cast_nullable_to_non_nullable
as String,petitDejeunerLibelle: null == petitDejeunerLibelle ? _self.petitDejeunerLibelle : petitDejeunerLibelle // ignore: cast_nullable_to_non_nullable
as String,prixPetitDejeuner: freezed == prixPetitDejeuner ? _self.prixPetitDejeuner : prixPetitDejeuner // ignore: cast_nullable_to_non_nullable
as int?,politiqueAnnulation: null == politiqueAnnulation ? _self.politiqueAnnulation : politiqueAnnulation // ignore: cast_nullable_to_non_nullable
as String,politiqueAnnulationLibelle: null == politiqueAnnulationLibelle ? _self.politiqueAnnulationLibelle : politiqueAnnulationLibelle // ignore: cast_nullable_to_non_nullable
as String,conditions: null == conditions ? _self.conditions : conditions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HebergementResume {

 int get id; String get titre; String get photo;@JsonKey(name: 'type_hebergement') String get typeHebergement;@JsonKey(name: 'type_hebergement_libelle') String get typeHebergementLibelle;@JsonKey(name: 'capacite_adultes', fromJson: versInt) int get capaciteAdultes;@JsonKey(name: 'capacite_enfants', fromJson: versInt) int get capaciteEnfants;@JsonKey(fromJson: versTexteLits) String get lits;@JsonKey(name: 'prix_nuit', fromJson: versInt) int get prixNuit;@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? get prixSemaine;@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? get prixMois; String get disponibilite;
/// Create a copy of HebergementResume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HebergementResumeCopyWith<HebergementResume> get copyWith => _$HebergementResumeCopyWithImpl<HebergementResume>(this as HebergementResume, _$identity);

  /// Serializes this HebergementResume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HebergementResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.typeHebergement, typeHebergement) || other.typeHebergement == typeHebergement)&&(identical(other.typeHebergementLibelle, typeHebergementLibelle) || other.typeHebergementLibelle == typeHebergementLibelle)&&(identical(other.capaciteAdultes, capaciteAdultes) || other.capaciteAdultes == capaciteAdultes)&&(identical(other.capaciteEnfants, capaciteEnfants) || other.capaciteEnfants == capaciteEnfants)&&(identical(other.lits, lits) || other.lits == lits)&&(identical(other.prixNuit, prixNuit) || other.prixNuit == prixNuit)&&(identical(other.prixSemaine, prixSemaine) || other.prixSemaine == prixSemaine)&&(identical(other.prixMois, prixMois) || other.prixMois == prixMois)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,typeHebergement,typeHebergementLibelle,capaciteAdultes,capaciteEnfants,lits,prixNuit,prixSemaine,prixMois,disponibilite);

@override
String toString() {
  return 'HebergementResume(id: $id, titre: $titre, photo: $photo, typeHebergement: $typeHebergement, typeHebergementLibelle: $typeHebergementLibelle, capaciteAdultes: $capaciteAdultes, capaciteEnfants: $capaciteEnfants, lits: $lits, prixNuit: $prixNuit, prixSemaine: $prixSemaine, prixMois: $prixMois, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class $HebergementResumeCopyWith<$Res>  {
  factory $HebergementResumeCopyWith(HebergementResume value, $Res Function(HebergementResume) _then) = _$HebergementResumeCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String photo,@JsonKey(name: 'type_hebergement') String typeHebergement,@JsonKey(name: 'type_hebergement_libelle') String typeHebergementLibelle,@JsonKey(name: 'capacite_adultes', fromJson: versInt) int capaciteAdultes,@JsonKey(name: 'capacite_enfants', fromJson: versInt) int capaciteEnfants,@JsonKey(fromJson: versTexteLits) String lits,@JsonKey(name: 'prix_nuit', fromJson: versInt) int prixNuit,@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois, String disponibilite
});




}
/// @nodoc
class _$HebergementResumeCopyWithImpl<$Res>
    implements $HebergementResumeCopyWith<$Res> {
  _$HebergementResumeCopyWithImpl(this._self, this._then);

  final HebergementResume _self;
  final $Res Function(HebergementResume) _then;

/// Create a copy of HebergementResume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? typeHebergement = null,Object? typeHebergementLibelle = null,Object? capaciteAdultes = null,Object? capaciteEnfants = null,Object? lits = null,Object? prixNuit = null,Object? prixSemaine = freezed,Object? prixMois = freezed,Object? disponibilite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,typeHebergement: null == typeHebergement ? _self.typeHebergement : typeHebergement // ignore: cast_nullable_to_non_nullable
as String,typeHebergementLibelle: null == typeHebergementLibelle ? _self.typeHebergementLibelle : typeHebergementLibelle // ignore: cast_nullable_to_non_nullable
as String,capaciteAdultes: null == capaciteAdultes ? _self.capaciteAdultes : capaciteAdultes // ignore: cast_nullable_to_non_nullable
as int,capaciteEnfants: null == capaciteEnfants ? _self.capaciteEnfants : capaciteEnfants // ignore: cast_nullable_to_non_nullable
as int,lits: null == lits ? _self.lits : lits // ignore: cast_nullable_to_non_nullable
as String,prixNuit: null == prixNuit ? _self.prixNuit : prixNuit // ignore: cast_nullable_to_non_nullable
as int,prixSemaine: freezed == prixSemaine ? _self.prixSemaine : prixSemaine // ignore: cast_nullable_to_non_nullable
as int?,prixMois: freezed == prixMois ? _self.prixMois : prixMois // ignore: cast_nullable_to_non_nullable
as int?,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HebergementResume].
extension HebergementResumePatterns on HebergementResume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HebergementResume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HebergementResume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HebergementResume value)  $default,){
final _that = this;
switch (_that) {
case _HebergementResume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HebergementResume value)?  $default,){
final _that = this;
switch (_that) {
case _HebergementResume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String photo, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois,  String disponibilite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HebergementResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.disponibilite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String photo, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois,  String disponibilite)  $default,) {final _that = this;
switch (_that) {
case _HebergementResume():
return $default(_that.id,_that.titre,_that.photo,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.disponibilite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String photo, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois,  String disponibilite)?  $default,) {final _that = this;
switch (_that) {
case _HebergementResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.disponibilite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HebergementResume extends HebergementResume {
  const _HebergementResume({required this.id, this.titre = '', this.photo = '', @JsonKey(name: 'type_hebergement') this.typeHebergement = '', @JsonKey(name: 'type_hebergement_libelle') this.typeHebergementLibelle = '', @JsonKey(name: 'capacite_adultes', fromJson: versInt) this.capaciteAdultes = 0, @JsonKey(name: 'capacite_enfants', fromJson: versInt) this.capaciteEnfants = 0, @JsonKey(fromJson: versTexteLits) this.lits = '', @JsonKey(name: 'prix_nuit', fromJson: versInt) this.prixNuit = 0, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable) this.prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable) this.prixMois, this.disponibilite = ''}): super._();
  factory _HebergementResume.fromJson(Map<String, dynamic> json) => _$HebergementResumeFromJson(json);

@override final  int id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String photo;
@override@JsonKey(name: 'type_hebergement') final  String typeHebergement;
@override@JsonKey(name: 'type_hebergement_libelle') final  String typeHebergementLibelle;
@override@JsonKey(name: 'capacite_adultes', fromJson: versInt) final  int capaciteAdultes;
@override@JsonKey(name: 'capacite_enfants', fromJson: versInt) final  int capaciteEnfants;
@override@JsonKey(fromJson: versTexteLits) final  String lits;
@override@JsonKey(name: 'prix_nuit', fromJson: versInt) final  int prixNuit;
@override@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) final  int? prixSemaine;
@override@JsonKey(name: 'prix_mois', fromJson: versIntNullable) final  int? prixMois;
@override@JsonKey() final  String disponibilite;

/// Create a copy of HebergementResume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HebergementResumeCopyWith<_HebergementResume> get copyWith => __$HebergementResumeCopyWithImpl<_HebergementResume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HebergementResumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HebergementResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.typeHebergement, typeHebergement) || other.typeHebergement == typeHebergement)&&(identical(other.typeHebergementLibelle, typeHebergementLibelle) || other.typeHebergementLibelle == typeHebergementLibelle)&&(identical(other.capaciteAdultes, capaciteAdultes) || other.capaciteAdultes == capaciteAdultes)&&(identical(other.capaciteEnfants, capaciteEnfants) || other.capaciteEnfants == capaciteEnfants)&&(identical(other.lits, lits) || other.lits == lits)&&(identical(other.prixNuit, prixNuit) || other.prixNuit == prixNuit)&&(identical(other.prixSemaine, prixSemaine) || other.prixSemaine == prixSemaine)&&(identical(other.prixMois, prixMois) || other.prixMois == prixMois)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,typeHebergement,typeHebergementLibelle,capaciteAdultes,capaciteEnfants,lits,prixNuit,prixSemaine,prixMois,disponibilite);

@override
String toString() {
  return 'HebergementResume(id: $id, titre: $titre, photo: $photo, typeHebergement: $typeHebergement, typeHebergementLibelle: $typeHebergementLibelle, capaciteAdultes: $capaciteAdultes, capaciteEnfants: $capaciteEnfants, lits: $lits, prixNuit: $prixNuit, prixSemaine: $prixSemaine, prixMois: $prixMois, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class _$HebergementResumeCopyWith<$Res> implements $HebergementResumeCopyWith<$Res> {
  factory _$HebergementResumeCopyWith(_HebergementResume value, $Res Function(_HebergementResume) _then) = __$HebergementResumeCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String photo,@JsonKey(name: 'type_hebergement') String typeHebergement,@JsonKey(name: 'type_hebergement_libelle') String typeHebergementLibelle,@JsonKey(name: 'capacite_adultes', fromJson: versInt) int capaciteAdultes,@JsonKey(name: 'capacite_enfants', fromJson: versInt) int capaciteEnfants,@JsonKey(fromJson: versTexteLits) String lits,@JsonKey(name: 'prix_nuit', fromJson: versInt) int prixNuit,@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois, String disponibilite
});




}
/// @nodoc
class __$HebergementResumeCopyWithImpl<$Res>
    implements _$HebergementResumeCopyWith<$Res> {
  __$HebergementResumeCopyWithImpl(this._self, this._then);

  final _HebergementResume _self;
  final $Res Function(_HebergementResume) _then;

/// Create a copy of HebergementResume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? typeHebergement = null,Object? typeHebergementLibelle = null,Object? capaciteAdultes = null,Object? capaciteEnfants = null,Object? lits = null,Object? prixNuit = null,Object? prixSemaine = freezed,Object? prixMois = freezed,Object? disponibilite = null,}) {
  return _then(_HebergementResume(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,typeHebergement: null == typeHebergement ? _self.typeHebergement : typeHebergement // ignore: cast_nullable_to_non_nullable
as String,typeHebergementLibelle: null == typeHebergementLibelle ? _self.typeHebergementLibelle : typeHebergementLibelle // ignore: cast_nullable_to_non_nullable
as String,capaciteAdultes: null == capaciteAdultes ? _self.capaciteAdultes : capaciteAdultes // ignore: cast_nullable_to_non_nullable
as int,capaciteEnfants: null == capaciteEnfants ? _self.capaciteEnfants : capaciteEnfants // ignore: cast_nullable_to_non_nullable
as int,lits: null == lits ? _self.lits : lits // ignore: cast_nullable_to_non_nullable
as String,prixNuit: null == prixNuit ? _self.prixNuit : prixNuit // ignore: cast_nullable_to_non_nullable
as int,prixSemaine: freezed == prixSemaine ? _self.prixSemaine : prixSemaine // ignore: cast_nullable_to_non_nullable
as int?,prixMois: freezed == prixMois ? _self.prixMois : prixMois // ignore: cast_nullable_to_non_nullable
as int?,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PageEtablissement {

 Etablissement get etablissement; List<HebergementResume> get hebergements;
/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageEtablissementCopyWith<PageEtablissement> get copyWith => _$PageEtablissementCopyWithImpl<PageEtablissement>(this as PageEtablissement, _$identity);

  /// Serializes this PageEtablissement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageEtablissement&&(identical(other.etablissement, etablissement) || other.etablissement == etablissement)&&const DeepCollectionEquality().equals(other.hebergements, hebergements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,etablissement,const DeepCollectionEquality().hash(hebergements));

@override
String toString() {
  return 'PageEtablissement(etablissement: $etablissement, hebergements: $hebergements)';
}


}

/// @nodoc
abstract mixin class $PageEtablissementCopyWith<$Res>  {
  factory $PageEtablissementCopyWith(PageEtablissement value, $Res Function(PageEtablissement) _then) = _$PageEtablissementCopyWithImpl;
@useResult
$Res call({
 Etablissement etablissement, List<HebergementResume> hebergements
});


$EtablissementCopyWith<$Res> get etablissement;

}
/// @nodoc
class _$PageEtablissementCopyWithImpl<$Res>
    implements $PageEtablissementCopyWith<$Res> {
  _$PageEtablissementCopyWithImpl(this._self, this._then);

  final PageEtablissement _self;
  final $Res Function(PageEtablissement) _then;

/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? etablissement = null,Object? hebergements = null,}) {
  return _then(_self.copyWith(
etablissement: null == etablissement ? _self.etablissement : etablissement // ignore: cast_nullable_to_non_nullable
as Etablissement,hebergements: null == hebergements ? _self.hebergements : hebergements // ignore: cast_nullable_to_non_nullable
as List<HebergementResume>,
  ));
}
/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EtablissementCopyWith<$Res> get etablissement {
  
  return $EtablissementCopyWith<$Res>(_self.etablissement, (value) {
    return _then(_self.copyWith(etablissement: value));
  });
}
}


/// Adds pattern-matching-related methods to [PageEtablissement].
extension PageEtablissementPatterns on PageEtablissement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageEtablissement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageEtablissement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageEtablissement value)  $default,){
final _that = this;
switch (_that) {
case _PageEtablissement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageEtablissement value)?  $default,){
final _that = this;
switch (_that) {
case _PageEtablissement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Etablissement etablissement,  List<HebergementResume> hebergements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageEtablissement() when $default != null:
return $default(_that.etablissement,_that.hebergements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Etablissement etablissement,  List<HebergementResume> hebergements)  $default,) {final _that = this;
switch (_that) {
case _PageEtablissement():
return $default(_that.etablissement,_that.hebergements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Etablissement etablissement,  List<HebergementResume> hebergements)?  $default,) {final _that = this;
switch (_that) {
case _PageEtablissement() when $default != null:
return $default(_that.etablissement,_that.hebergements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageEtablissement extends PageEtablissement {
  const _PageEtablissement({required this.etablissement, final  List<HebergementResume> hebergements = const <HebergementResume>[]}): _hebergements = hebergements,super._();
  factory _PageEtablissement.fromJson(Map<String, dynamic> json) => _$PageEtablissementFromJson(json);

@override final  Etablissement etablissement;
 final  List<HebergementResume> _hebergements;
@override@JsonKey() List<HebergementResume> get hebergements {
  if (_hebergements is EqualUnmodifiableListView) return _hebergements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hebergements);
}


/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageEtablissementCopyWith<_PageEtablissement> get copyWith => __$PageEtablissementCopyWithImpl<_PageEtablissement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageEtablissementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageEtablissement&&(identical(other.etablissement, etablissement) || other.etablissement == etablissement)&&const DeepCollectionEquality().equals(other._hebergements, _hebergements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,etablissement,const DeepCollectionEquality().hash(_hebergements));

@override
String toString() {
  return 'PageEtablissement(etablissement: $etablissement, hebergements: $hebergements)';
}


}

/// @nodoc
abstract mixin class _$PageEtablissementCopyWith<$Res> implements $PageEtablissementCopyWith<$Res> {
  factory _$PageEtablissementCopyWith(_PageEtablissement value, $Res Function(_PageEtablissement) _then) = __$PageEtablissementCopyWithImpl;
@override @useResult
$Res call({
 Etablissement etablissement, List<HebergementResume> hebergements
});


@override $EtablissementCopyWith<$Res> get etablissement;

}
/// @nodoc
class __$PageEtablissementCopyWithImpl<$Res>
    implements _$PageEtablissementCopyWith<$Res> {
  __$PageEtablissementCopyWithImpl(this._self, this._then);

  final _PageEtablissement _self;
  final $Res Function(_PageEtablissement) _then;

/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? etablissement = null,Object? hebergements = null,}) {
  return _then(_PageEtablissement(
etablissement: null == etablissement ? _self.etablissement : etablissement // ignore: cast_nullable_to_non_nullable
as Etablissement,hebergements: null == hebergements ? _self._hebergements : hebergements // ignore: cast_nullable_to_non_nullable
as List<HebergementResume>,
  ));
}

/// Create a copy of PageEtablissement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EtablissementCopyWith<$Res> get etablissement {
  
  return $EtablissementCopyWith<$Res>(_self.etablissement, (value) {
    return _then(_self.copyWith(etablissement: value));
  });
}
}


/// @nodoc
mixin _$Hebergement {

 int get id; String get titre; String get description; List<String> get galerie; List<Panorama> get panoramas;@JsonKey(name: 'type_hebergement') String get typeHebergement;@JsonKey(name: 'type_hebergement_libelle') String get typeHebergementLibelle;@JsonKey(name: 'capacite_adultes', fromJson: versInt) int get capaciteAdultes;@JsonKey(name: 'capacite_enfants', fromJson: versInt) int get capaciteEnfants;@JsonKey(fromJson: versTexteLits) String get lits;@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? get surfaceM2;@JsonKey(fromJson: versListeTextes) List<String> get equipements;@JsonKey(name: 'prix_nuit', fromJson: versInt) int get prixNuit;@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? get prixSemaine;@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? get prixMois;@JsonKey(readValue: lireDureeMin, fromJson: versInt) int get dureeMinNuits;/// Nombre total d'unités (chambres) de ce type.
@JsonKey(name: 'nb_unites', fromJson: versInt) int get nbUnites;/// Unités libres sur les dates demandées (si elles l'ont été).
@JsonKey(name: 'unites_disponibles', fromJson: versIntNullable) int? get unitesDisponibles;@JsonKey(name: 'heure_arrivee') String get heureArrivee;@JsonKey(name: 'heure_depart') String get heureDepart; String get disponibilite; Etablissement? get etablissement;
/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HebergementCopyWith<Hebergement> get copyWith => _$HebergementCopyWithImpl<Hebergement>(this as Hebergement, _$identity);

  /// Serializes this Hebergement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hebergement&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.galerie, galerie)&&const DeepCollectionEquality().equals(other.panoramas, panoramas)&&(identical(other.typeHebergement, typeHebergement) || other.typeHebergement == typeHebergement)&&(identical(other.typeHebergementLibelle, typeHebergementLibelle) || other.typeHebergementLibelle == typeHebergementLibelle)&&(identical(other.capaciteAdultes, capaciteAdultes) || other.capaciteAdultes == capaciteAdultes)&&(identical(other.capaciteEnfants, capaciteEnfants) || other.capaciteEnfants == capaciteEnfants)&&(identical(other.lits, lits) || other.lits == lits)&&(identical(other.surfaceM2, surfaceM2) || other.surfaceM2 == surfaceM2)&&const DeepCollectionEquality().equals(other.equipements, equipements)&&(identical(other.prixNuit, prixNuit) || other.prixNuit == prixNuit)&&(identical(other.prixSemaine, prixSemaine) || other.prixSemaine == prixSemaine)&&(identical(other.prixMois, prixMois) || other.prixMois == prixMois)&&(identical(other.dureeMinNuits, dureeMinNuits) || other.dureeMinNuits == dureeMinNuits)&&(identical(other.nbUnites, nbUnites) || other.nbUnites == nbUnites)&&(identical(other.unitesDisponibles, unitesDisponibles) || other.unitesDisponibles == unitesDisponibles)&&(identical(other.heureArrivee, heureArrivee) || other.heureArrivee == heureArrivee)&&(identical(other.heureDepart, heureDepart) || other.heureDepart == heureDepart)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.etablissement, etablissement) || other.etablissement == etablissement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(galerie),const DeepCollectionEquality().hash(panoramas),typeHebergement,typeHebergementLibelle,capaciteAdultes,capaciteEnfants,lits,surfaceM2,const DeepCollectionEquality().hash(equipements),prixNuit,prixSemaine,prixMois,dureeMinNuits,nbUnites,unitesDisponibles,heureArrivee,heureDepart,disponibilite,etablissement]);

@override
String toString() {
  return 'Hebergement(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, typeHebergement: $typeHebergement, typeHebergementLibelle: $typeHebergementLibelle, capaciteAdultes: $capaciteAdultes, capaciteEnfants: $capaciteEnfants, lits: $lits, surfaceM2: $surfaceM2, equipements: $equipements, prixNuit: $prixNuit, prixSemaine: $prixSemaine, prixMois: $prixMois, dureeMinNuits: $dureeMinNuits, nbUnites: $nbUnites, unitesDisponibles: $unitesDisponibles, heureArrivee: $heureArrivee, heureDepart: $heureDepart, disponibilite: $disponibilite, etablissement: $etablissement)';
}


}

/// @nodoc
abstract mixin class $HebergementCopyWith<$Res>  {
  factory $HebergementCopyWith(Hebergement value, $Res Function(Hebergement) _then) = _$HebergementCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(name: 'type_hebergement') String typeHebergement,@JsonKey(name: 'type_hebergement_libelle') String typeHebergementLibelle,@JsonKey(name: 'capacite_adultes', fromJson: versInt) int capaciteAdultes,@JsonKey(name: 'capacite_enfants', fromJson: versInt) int capaciteEnfants,@JsonKey(fromJson: versTexteLits) String lits,@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2,@JsonKey(fromJson: versListeTextes) List<String> equipements,@JsonKey(name: 'prix_nuit', fromJson: versInt) int prixNuit,@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois,@JsonKey(readValue: lireDureeMin, fromJson: versInt) int dureeMinNuits,@JsonKey(name: 'nb_unites', fromJson: versInt) int nbUnites,@JsonKey(name: 'unites_disponibles', fromJson: versIntNullable) int? unitesDisponibles,@JsonKey(name: 'heure_arrivee') String heureArrivee,@JsonKey(name: 'heure_depart') String heureDepart, String disponibilite, Etablissement? etablissement
});


$EtablissementCopyWith<$Res>? get etablissement;

}
/// @nodoc
class _$HebergementCopyWithImpl<$Res>
    implements $HebergementCopyWith<$Res> {
  _$HebergementCopyWithImpl(this._self, this._then);

  final Hebergement _self;
  final $Res Function(Hebergement) _then;

/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? typeHebergement = null,Object? typeHebergementLibelle = null,Object? capaciteAdultes = null,Object? capaciteEnfants = null,Object? lits = null,Object? surfaceM2 = freezed,Object? equipements = null,Object? prixNuit = null,Object? prixSemaine = freezed,Object? prixMois = freezed,Object? dureeMinNuits = null,Object? nbUnites = null,Object? unitesDisponibles = freezed,Object? heureArrivee = null,Object? heureDepart = null,Object? disponibilite = null,Object? etablissement = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self.galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self.panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,typeHebergement: null == typeHebergement ? _self.typeHebergement : typeHebergement // ignore: cast_nullable_to_non_nullable
as String,typeHebergementLibelle: null == typeHebergementLibelle ? _self.typeHebergementLibelle : typeHebergementLibelle // ignore: cast_nullable_to_non_nullable
as String,capaciteAdultes: null == capaciteAdultes ? _self.capaciteAdultes : capaciteAdultes // ignore: cast_nullable_to_non_nullable
as int,capaciteEnfants: null == capaciteEnfants ? _self.capaciteEnfants : capaciteEnfants // ignore: cast_nullable_to_non_nullable
as int,lits: null == lits ? _self.lits : lits // ignore: cast_nullable_to_non_nullable
as String,surfaceM2: freezed == surfaceM2 ? _self.surfaceM2 : surfaceM2 // ignore: cast_nullable_to_non_nullable
as int?,equipements: null == equipements ? _self.equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,prixNuit: null == prixNuit ? _self.prixNuit : prixNuit // ignore: cast_nullable_to_non_nullable
as int,prixSemaine: freezed == prixSemaine ? _self.prixSemaine : prixSemaine // ignore: cast_nullable_to_non_nullable
as int?,prixMois: freezed == prixMois ? _self.prixMois : prixMois // ignore: cast_nullable_to_non_nullable
as int?,dureeMinNuits: null == dureeMinNuits ? _self.dureeMinNuits : dureeMinNuits // ignore: cast_nullable_to_non_nullable
as int,nbUnites: null == nbUnites ? _self.nbUnites : nbUnites // ignore: cast_nullable_to_non_nullable
as int,unitesDisponibles: freezed == unitesDisponibles ? _self.unitesDisponibles : unitesDisponibles // ignore: cast_nullable_to_non_nullable
as int?,heureArrivee: null == heureArrivee ? _self.heureArrivee : heureArrivee // ignore: cast_nullable_to_non_nullable
as String,heureDepart: null == heureDepart ? _self.heureDepart : heureDepart // ignore: cast_nullable_to_non_nullable
as String,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,etablissement: freezed == etablissement ? _self.etablissement : etablissement // ignore: cast_nullable_to_non_nullable
as Etablissement?,
  ));
}
/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EtablissementCopyWith<$Res>? get etablissement {
    if (_self.etablissement == null) {
    return null;
  }

  return $EtablissementCopyWith<$Res>(_self.etablissement!, (value) {
    return _then(_self.copyWith(etablissement: value));
  });
}
}


/// Adds pattern-matching-related methods to [Hebergement].
extension HebergementPatterns on Hebergement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hebergement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hebergement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hebergement value)  $default,){
final _that = this;
switch (_that) {
case _Hebergement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hebergement value)?  $default,){
final _that = this;
switch (_that) {
case _Hebergement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2, @JsonKey(fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois, @JsonKey(readValue: lireDureeMin, fromJson: versInt)  int dureeMinNuits, @JsonKey(name: 'nb_unites', fromJson: versInt)  int nbUnites, @JsonKey(name: 'unites_disponibles', fromJson: versIntNullable)  int? unitesDisponibles, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart,  String disponibilite,  Etablissement? etablissement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hebergement() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.surfaceM2,_that.equipements,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.dureeMinNuits,_that.nbUnites,_that.unitesDisponibles,_that.heureArrivee,_that.heureDepart,_that.disponibilite,_that.etablissement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2, @JsonKey(fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois, @JsonKey(readValue: lireDureeMin, fromJson: versInt)  int dureeMinNuits, @JsonKey(name: 'nb_unites', fromJson: versInt)  int nbUnites, @JsonKey(name: 'unites_disponibles', fromJson: versIntNullable)  int? unitesDisponibles, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart,  String disponibilite,  Etablissement? etablissement)  $default,) {final _that = this;
switch (_that) {
case _Hebergement():
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.surfaceM2,_that.equipements,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.dureeMinNuits,_that.nbUnites,_that.unitesDisponibles,_that.heureArrivee,_that.heureDepart,_that.disponibilite,_that.etablissement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas, @JsonKey(name: 'type_hebergement')  String typeHebergement, @JsonKey(name: 'type_hebergement_libelle')  String typeHebergementLibelle, @JsonKey(name: 'capacite_adultes', fromJson: versInt)  int capaciteAdultes, @JsonKey(name: 'capacite_enfants', fromJson: versInt)  int capaciteEnfants, @JsonKey(fromJson: versTexteLits)  String lits, @JsonKey(name: 'surface_m2', fromJson: versIntNullable)  int? surfaceM2, @JsonKey(fromJson: versListeTextes)  List<String> equipements, @JsonKey(name: 'prix_nuit', fromJson: versInt)  int prixNuit, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable)  int? prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable)  int? prixMois, @JsonKey(readValue: lireDureeMin, fromJson: versInt)  int dureeMinNuits, @JsonKey(name: 'nb_unites', fromJson: versInt)  int nbUnites, @JsonKey(name: 'unites_disponibles', fromJson: versIntNullable)  int? unitesDisponibles, @JsonKey(name: 'heure_arrivee')  String heureArrivee, @JsonKey(name: 'heure_depart')  String heureDepart,  String disponibilite,  Etablissement? etablissement)?  $default,) {final _that = this;
switch (_that) {
case _Hebergement() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.typeHebergement,_that.typeHebergementLibelle,_that.capaciteAdultes,_that.capaciteEnfants,_that.lits,_that.surfaceM2,_that.equipements,_that.prixNuit,_that.prixSemaine,_that.prixMois,_that.dureeMinNuits,_that.nbUnites,_that.unitesDisponibles,_that.heureArrivee,_that.heureDepart,_that.disponibilite,_that.etablissement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hebergement extends Hebergement {
  const _Hebergement({required this.id, this.titre = '', this.description = '', final  List<String> galerie = const <String>[], final  List<Panorama> panoramas = const <Panorama>[], @JsonKey(name: 'type_hebergement') this.typeHebergement = '', @JsonKey(name: 'type_hebergement_libelle') this.typeHebergementLibelle = '', @JsonKey(name: 'capacite_adultes', fromJson: versInt) this.capaciteAdultes = 0, @JsonKey(name: 'capacite_enfants', fromJson: versInt) this.capaciteEnfants = 0, @JsonKey(fromJson: versTexteLits) this.lits = '', @JsonKey(name: 'surface_m2', fromJson: versIntNullable) this.surfaceM2, @JsonKey(fromJson: versListeTextes) final  List<String> equipements = const <String>[], @JsonKey(name: 'prix_nuit', fromJson: versInt) this.prixNuit = 0, @JsonKey(name: 'prix_semaine', fromJson: versIntNullable) this.prixSemaine, @JsonKey(name: 'prix_mois', fromJson: versIntNullable) this.prixMois, @JsonKey(readValue: lireDureeMin, fromJson: versInt) this.dureeMinNuits = 1, @JsonKey(name: 'nb_unites', fromJson: versInt) this.nbUnites = 0, @JsonKey(name: 'unites_disponibles', fromJson: versIntNullable) this.unitesDisponibles, @JsonKey(name: 'heure_arrivee') this.heureArrivee = '', @JsonKey(name: 'heure_depart') this.heureDepart = '', this.disponibilite = '', this.etablissement}): _galerie = galerie,_panoramas = panoramas,_equipements = equipements,super._();
  factory _Hebergement.fromJson(Map<String, dynamic> json) => _$HebergementFromJson(json);

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

@override@JsonKey(name: 'type_hebergement') final  String typeHebergement;
@override@JsonKey(name: 'type_hebergement_libelle') final  String typeHebergementLibelle;
@override@JsonKey(name: 'capacite_adultes', fromJson: versInt) final  int capaciteAdultes;
@override@JsonKey(name: 'capacite_enfants', fromJson: versInt) final  int capaciteEnfants;
@override@JsonKey(fromJson: versTexteLits) final  String lits;
@override@JsonKey(name: 'surface_m2', fromJson: versIntNullable) final  int? surfaceM2;
 final  List<String> _equipements;
@override@JsonKey(fromJson: versListeTextes) List<String> get equipements {
  if (_equipements is EqualUnmodifiableListView) return _equipements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipements);
}

@override@JsonKey(name: 'prix_nuit', fromJson: versInt) final  int prixNuit;
@override@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) final  int? prixSemaine;
@override@JsonKey(name: 'prix_mois', fromJson: versIntNullable) final  int? prixMois;
@override@JsonKey(readValue: lireDureeMin, fromJson: versInt) final  int dureeMinNuits;
/// Nombre total d'unités (chambres) de ce type.
@override@JsonKey(name: 'nb_unites', fromJson: versInt) final  int nbUnites;
/// Unités libres sur les dates demandées (si elles l'ont été).
@override@JsonKey(name: 'unites_disponibles', fromJson: versIntNullable) final  int? unitesDisponibles;
@override@JsonKey(name: 'heure_arrivee') final  String heureArrivee;
@override@JsonKey(name: 'heure_depart') final  String heureDepart;
@override@JsonKey() final  String disponibilite;
@override final  Etablissement? etablissement;

/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HebergementCopyWith<_Hebergement> get copyWith => __$HebergementCopyWithImpl<_Hebergement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HebergementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hebergement&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._galerie, _galerie)&&const DeepCollectionEquality().equals(other._panoramas, _panoramas)&&(identical(other.typeHebergement, typeHebergement) || other.typeHebergement == typeHebergement)&&(identical(other.typeHebergementLibelle, typeHebergementLibelle) || other.typeHebergementLibelle == typeHebergementLibelle)&&(identical(other.capaciteAdultes, capaciteAdultes) || other.capaciteAdultes == capaciteAdultes)&&(identical(other.capaciteEnfants, capaciteEnfants) || other.capaciteEnfants == capaciteEnfants)&&(identical(other.lits, lits) || other.lits == lits)&&(identical(other.surfaceM2, surfaceM2) || other.surfaceM2 == surfaceM2)&&const DeepCollectionEquality().equals(other._equipements, _equipements)&&(identical(other.prixNuit, prixNuit) || other.prixNuit == prixNuit)&&(identical(other.prixSemaine, prixSemaine) || other.prixSemaine == prixSemaine)&&(identical(other.prixMois, prixMois) || other.prixMois == prixMois)&&(identical(other.dureeMinNuits, dureeMinNuits) || other.dureeMinNuits == dureeMinNuits)&&(identical(other.nbUnites, nbUnites) || other.nbUnites == nbUnites)&&(identical(other.unitesDisponibles, unitesDisponibles) || other.unitesDisponibles == unitesDisponibles)&&(identical(other.heureArrivee, heureArrivee) || other.heureArrivee == heureArrivee)&&(identical(other.heureDepart, heureDepart) || other.heureDepart == heureDepart)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.etablissement, etablissement) || other.etablissement == etablissement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(_galerie),const DeepCollectionEquality().hash(_panoramas),typeHebergement,typeHebergementLibelle,capaciteAdultes,capaciteEnfants,lits,surfaceM2,const DeepCollectionEquality().hash(_equipements),prixNuit,prixSemaine,prixMois,dureeMinNuits,nbUnites,unitesDisponibles,heureArrivee,heureDepart,disponibilite,etablissement]);

@override
String toString() {
  return 'Hebergement(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, typeHebergement: $typeHebergement, typeHebergementLibelle: $typeHebergementLibelle, capaciteAdultes: $capaciteAdultes, capaciteEnfants: $capaciteEnfants, lits: $lits, surfaceM2: $surfaceM2, equipements: $equipements, prixNuit: $prixNuit, prixSemaine: $prixSemaine, prixMois: $prixMois, dureeMinNuits: $dureeMinNuits, nbUnites: $nbUnites, unitesDisponibles: $unitesDisponibles, heureArrivee: $heureArrivee, heureDepart: $heureDepart, disponibilite: $disponibilite, etablissement: $etablissement)';
}


}

/// @nodoc
abstract mixin class _$HebergementCopyWith<$Res> implements $HebergementCopyWith<$Res> {
  factory _$HebergementCopyWith(_Hebergement value, $Res Function(_Hebergement) _then) = __$HebergementCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas,@JsonKey(name: 'type_hebergement') String typeHebergement,@JsonKey(name: 'type_hebergement_libelle') String typeHebergementLibelle,@JsonKey(name: 'capacite_adultes', fromJson: versInt) int capaciteAdultes,@JsonKey(name: 'capacite_enfants', fromJson: versInt) int capaciteEnfants,@JsonKey(fromJson: versTexteLits) String lits,@JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2,@JsonKey(fromJson: versListeTextes) List<String> equipements,@JsonKey(name: 'prix_nuit', fromJson: versInt) int prixNuit,@JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,@JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois,@JsonKey(readValue: lireDureeMin, fromJson: versInt) int dureeMinNuits,@JsonKey(name: 'nb_unites', fromJson: versInt) int nbUnites,@JsonKey(name: 'unites_disponibles', fromJson: versIntNullable) int? unitesDisponibles,@JsonKey(name: 'heure_arrivee') String heureArrivee,@JsonKey(name: 'heure_depart') String heureDepart, String disponibilite, Etablissement? etablissement
});


@override $EtablissementCopyWith<$Res>? get etablissement;

}
/// @nodoc
class __$HebergementCopyWithImpl<$Res>
    implements _$HebergementCopyWith<$Res> {
  __$HebergementCopyWithImpl(this._self, this._then);

  final _Hebergement _self;
  final $Res Function(_Hebergement) _then;

/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? typeHebergement = null,Object? typeHebergementLibelle = null,Object? capaciteAdultes = null,Object? capaciteEnfants = null,Object? lits = null,Object? surfaceM2 = freezed,Object? equipements = null,Object? prixNuit = null,Object? prixSemaine = freezed,Object? prixMois = freezed,Object? dureeMinNuits = null,Object? nbUnites = null,Object? unitesDisponibles = freezed,Object? heureArrivee = null,Object? heureDepart = null,Object? disponibilite = null,Object? etablissement = freezed,}) {
  return _then(_Hebergement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self._galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self._panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,typeHebergement: null == typeHebergement ? _self.typeHebergement : typeHebergement // ignore: cast_nullable_to_non_nullable
as String,typeHebergementLibelle: null == typeHebergementLibelle ? _self.typeHebergementLibelle : typeHebergementLibelle // ignore: cast_nullable_to_non_nullable
as String,capaciteAdultes: null == capaciteAdultes ? _self.capaciteAdultes : capaciteAdultes // ignore: cast_nullable_to_non_nullable
as int,capaciteEnfants: null == capaciteEnfants ? _self.capaciteEnfants : capaciteEnfants // ignore: cast_nullable_to_non_nullable
as int,lits: null == lits ? _self.lits : lits // ignore: cast_nullable_to_non_nullable
as String,surfaceM2: freezed == surfaceM2 ? _self.surfaceM2 : surfaceM2 // ignore: cast_nullable_to_non_nullable
as int?,equipements: null == equipements ? _self._equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,prixNuit: null == prixNuit ? _self.prixNuit : prixNuit // ignore: cast_nullable_to_non_nullable
as int,prixSemaine: freezed == prixSemaine ? _self.prixSemaine : prixSemaine // ignore: cast_nullable_to_non_nullable
as int?,prixMois: freezed == prixMois ? _self.prixMois : prixMois // ignore: cast_nullable_to_non_nullable
as int?,dureeMinNuits: null == dureeMinNuits ? _self.dureeMinNuits : dureeMinNuits // ignore: cast_nullable_to_non_nullable
as int,nbUnites: null == nbUnites ? _self.nbUnites : nbUnites // ignore: cast_nullable_to_non_nullable
as int,unitesDisponibles: freezed == unitesDisponibles ? _self.unitesDisponibles : unitesDisponibles // ignore: cast_nullable_to_non_nullable
as int?,heureArrivee: null == heureArrivee ? _self.heureArrivee : heureArrivee // ignore: cast_nullable_to_non_nullable
as String,heureDepart: null == heureDepart ? _self.heureDepart : heureDepart // ignore: cast_nullable_to_non_nullable
as String,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,etablissement: freezed == etablissement ? _self.etablissement : etablissement // ignore: cast_nullable_to_non_nullable
as Etablissement?,
  ));
}

/// Create a copy of Hebergement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EtablissementCopyWith<$Res>? get etablissement {
    if (_self.etablissement == null) {
    return null;
  }

  return $EtablissementCopyWith<$Res>(_self.etablissement!, (value) {
    return _then(_self.copyWith(etablissement: value));
  });
}
}

// dart format on
