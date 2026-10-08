// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicule_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehiculeResume {

 int get id; String get titre; String get photo; String get categorie;@JsonKey(name: 'categorie_libelle') String get categorieLibelle; String get marque; String get modele;@JsonKey(fromJson: versIntNullable) int? get annee;@JsonKey(name: 'nb_places', fromJson: versInt) int get nbPlaces;@JsonKey(name: 'boite_libelle') String get boiteLibelle;@JsonKey(name: 'carburant_libelle') String get carburantLibelle; bool get climatisation;@JsonKey(name: 'prix_jour', fromJson: versInt) int get prixJour;@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? get prixJourAvecChauffeur;@JsonKey(name: 'chauffeur_disponible') bool get chauffeurDisponible;@JsonKey(name: 'chauffeur_obligatoire') bool get chauffeurObligatoire;@JsonKey(name: 'localisation_texte') String get localisationTexte; String get disponibilite;
/// Create a copy of VehiculeResume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiculeResumeCopyWith<VehiculeResume> get copyWith => _$VehiculeResumeCopyWithImpl<VehiculeResume>(this as VehiculeResume, _$identity);

  /// Serializes this VehiculeResume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiculeResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieLibelle, categorieLibelle) || other.categorieLibelle == categorieLibelle)&&(identical(other.marque, marque) || other.marque == marque)&&(identical(other.modele, modele) || other.modele == modele)&&(identical(other.annee, annee) || other.annee == annee)&&(identical(other.nbPlaces, nbPlaces) || other.nbPlaces == nbPlaces)&&(identical(other.boiteLibelle, boiteLibelle) || other.boiteLibelle == boiteLibelle)&&(identical(other.carburantLibelle, carburantLibelle) || other.carburantLibelle == carburantLibelle)&&(identical(other.climatisation, climatisation) || other.climatisation == climatisation)&&(identical(other.prixJour, prixJour) || other.prixJour == prixJour)&&(identical(other.prixJourAvecChauffeur, prixJourAvecChauffeur) || other.prixJourAvecChauffeur == prixJourAvecChauffeur)&&(identical(other.chauffeurDisponible, chauffeurDisponible) || other.chauffeurDisponible == chauffeurDisponible)&&(identical(other.chauffeurObligatoire, chauffeurObligatoire) || other.chauffeurObligatoire == chauffeurObligatoire)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,categorie,categorieLibelle,marque,modele,annee,nbPlaces,boiteLibelle,carburantLibelle,climatisation,prixJour,prixJourAvecChauffeur,chauffeurDisponible,chauffeurObligatoire,localisationTexte,disponibilite);

@override
String toString() {
  return 'VehiculeResume(id: $id, titre: $titre, photo: $photo, categorie: $categorie, categorieLibelle: $categorieLibelle, marque: $marque, modele: $modele, annee: $annee, nbPlaces: $nbPlaces, boiteLibelle: $boiteLibelle, carburantLibelle: $carburantLibelle, climatisation: $climatisation, prixJour: $prixJour, prixJourAvecChauffeur: $prixJourAvecChauffeur, chauffeurDisponible: $chauffeurDisponible, chauffeurObligatoire: $chauffeurObligatoire, localisationTexte: $localisationTexte, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class $VehiculeResumeCopyWith<$Res>  {
  factory $VehiculeResumeCopyWith(VehiculeResume value, $Res Function(VehiculeResume) _then) = _$VehiculeResumeCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String photo, String categorie,@JsonKey(name: 'categorie_libelle') String categorieLibelle, String marque, String modele,@JsonKey(fromJson: versIntNullable) int? annee,@JsonKey(name: 'nb_places', fromJson: versInt) int nbPlaces,@JsonKey(name: 'boite_libelle') String boiteLibelle,@JsonKey(name: 'carburant_libelle') String carburantLibelle, bool climatisation,@JsonKey(name: 'prix_jour', fromJson: versInt) int prixJour,@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? prixJourAvecChauffeur,@JsonKey(name: 'chauffeur_disponible') bool chauffeurDisponible,@JsonKey(name: 'chauffeur_obligatoire') bool chauffeurObligatoire,@JsonKey(name: 'localisation_texte') String localisationTexte, String disponibilite
});




}
/// @nodoc
class _$VehiculeResumeCopyWithImpl<$Res>
    implements $VehiculeResumeCopyWith<$Res> {
  _$VehiculeResumeCopyWithImpl(this._self, this._then);

  final VehiculeResume _self;
  final $Res Function(VehiculeResume) _then;

/// Create a copy of VehiculeResume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? categorie = null,Object? categorieLibelle = null,Object? marque = null,Object? modele = null,Object? annee = freezed,Object? nbPlaces = null,Object? boiteLibelle = null,Object? carburantLibelle = null,Object? climatisation = null,Object? prixJour = null,Object? prixJourAvecChauffeur = freezed,Object? chauffeurDisponible = null,Object? chauffeurObligatoire = null,Object? localisationTexte = null,Object? disponibilite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,categorie: null == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as String,categorieLibelle: null == categorieLibelle ? _self.categorieLibelle : categorieLibelle // ignore: cast_nullable_to_non_nullable
as String,marque: null == marque ? _self.marque : marque // ignore: cast_nullable_to_non_nullable
as String,modele: null == modele ? _self.modele : modele // ignore: cast_nullable_to_non_nullable
as String,annee: freezed == annee ? _self.annee : annee // ignore: cast_nullable_to_non_nullable
as int?,nbPlaces: null == nbPlaces ? _self.nbPlaces : nbPlaces // ignore: cast_nullable_to_non_nullable
as int,boiteLibelle: null == boiteLibelle ? _self.boiteLibelle : boiteLibelle // ignore: cast_nullable_to_non_nullable
as String,carburantLibelle: null == carburantLibelle ? _self.carburantLibelle : carburantLibelle // ignore: cast_nullable_to_non_nullable
as String,climatisation: null == climatisation ? _self.climatisation : climatisation // ignore: cast_nullable_to_non_nullable
as bool,prixJour: null == prixJour ? _self.prixJour : prixJour // ignore: cast_nullable_to_non_nullable
as int,prixJourAvecChauffeur: freezed == prixJourAvecChauffeur ? _self.prixJourAvecChauffeur : prixJourAvecChauffeur // ignore: cast_nullable_to_non_nullable
as int?,chauffeurDisponible: null == chauffeurDisponible ? _self.chauffeurDisponible : chauffeurDisponible // ignore: cast_nullable_to_non_nullable
as bool,chauffeurObligatoire: null == chauffeurObligatoire ? _self.chauffeurObligatoire : chauffeurObligatoire // ignore: cast_nullable_to_non_nullable
as bool,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VehiculeResume].
extension VehiculeResumePatterns on VehiculeResume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehiculeResume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehiculeResume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehiculeResume value)  $default,){
final _that = this;
switch (_that) {
case _VehiculeResume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehiculeResume value)?  $default,){
final _that = this;
switch (_that) {
case _VehiculeResume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String photo,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces, @JsonKey(name: 'boite_libelle')  String boiteLibelle, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(name: 'localisation_texte')  String localisationTexte,  String disponibilite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehiculeResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.nbPlaces,_that.boiteLibelle,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.localisationTexte,_that.disponibilite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String photo,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces, @JsonKey(name: 'boite_libelle')  String boiteLibelle, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(name: 'localisation_texte')  String localisationTexte,  String disponibilite)  $default,) {final _that = this;
switch (_that) {
case _VehiculeResume():
return $default(_that.id,_that.titre,_that.photo,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.nbPlaces,_that.boiteLibelle,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.localisationTexte,_that.disponibilite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String photo,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces, @JsonKey(name: 'boite_libelle')  String boiteLibelle, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(name: 'localisation_texte')  String localisationTexte,  String disponibilite)?  $default,) {final _that = this;
switch (_that) {
case _VehiculeResume() when $default != null:
return $default(_that.id,_that.titre,_that.photo,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.nbPlaces,_that.boiteLibelle,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.localisationTexte,_that.disponibilite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehiculeResume extends VehiculeResume {
  const _VehiculeResume({required this.id, this.titre = '', this.photo = '', this.categorie = '', @JsonKey(name: 'categorie_libelle') this.categorieLibelle = '', this.marque = '', this.modele = '', @JsonKey(fromJson: versIntNullable) this.annee, @JsonKey(name: 'nb_places', fromJson: versInt) this.nbPlaces = 0, @JsonKey(name: 'boite_libelle') this.boiteLibelle = '', @JsonKey(name: 'carburant_libelle') this.carburantLibelle = '', this.climatisation = false, @JsonKey(name: 'prix_jour', fromJson: versInt) this.prixJour = 0, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) this.prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible') this.chauffeurDisponible = false, @JsonKey(name: 'chauffeur_obligatoire') this.chauffeurObligatoire = false, @JsonKey(name: 'localisation_texte') this.localisationTexte = '', this.disponibilite = ''}): super._();
  factory _VehiculeResume.fromJson(Map<String, dynamic> json) => _$VehiculeResumeFromJson(json);

@override final  int id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String photo;
@override@JsonKey() final  String categorie;
@override@JsonKey(name: 'categorie_libelle') final  String categorieLibelle;
@override@JsonKey() final  String marque;
@override@JsonKey() final  String modele;
@override@JsonKey(fromJson: versIntNullable) final  int? annee;
@override@JsonKey(name: 'nb_places', fromJson: versInt) final  int nbPlaces;
@override@JsonKey(name: 'boite_libelle') final  String boiteLibelle;
@override@JsonKey(name: 'carburant_libelle') final  String carburantLibelle;
@override@JsonKey() final  bool climatisation;
@override@JsonKey(name: 'prix_jour', fromJson: versInt) final  int prixJour;
@override@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) final  int? prixJourAvecChauffeur;
@override@JsonKey(name: 'chauffeur_disponible') final  bool chauffeurDisponible;
@override@JsonKey(name: 'chauffeur_obligatoire') final  bool chauffeurObligatoire;
@override@JsonKey(name: 'localisation_texte') final  String localisationTexte;
@override@JsonKey() final  String disponibilite;

/// Create a copy of VehiculeResume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehiculeResumeCopyWith<_VehiculeResume> get copyWith => __$VehiculeResumeCopyWithImpl<_VehiculeResume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehiculeResumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehiculeResume&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieLibelle, categorieLibelle) || other.categorieLibelle == categorieLibelle)&&(identical(other.marque, marque) || other.marque == marque)&&(identical(other.modele, modele) || other.modele == modele)&&(identical(other.annee, annee) || other.annee == annee)&&(identical(other.nbPlaces, nbPlaces) || other.nbPlaces == nbPlaces)&&(identical(other.boiteLibelle, boiteLibelle) || other.boiteLibelle == boiteLibelle)&&(identical(other.carburantLibelle, carburantLibelle) || other.carburantLibelle == carburantLibelle)&&(identical(other.climatisation, climatisation) || other.climatisation == climatisation)&&(identical(other.prixJour, prixJour) || other.prixJour == prixJour)&&(identical(other.prixJourAvecChauffeur, prixJourAvecChauffeur) || other.prixJourAvecChauffeur == prixJourAvecChauffeur)&&(identical(other.chauffeurDisponible, chauffeurDisponible) || other.chauffeurDisponible == chauffeurDisponible)&&(identical(other.chauffeurObligatoire, chauffeurObligatoire) || other.chauffeurObligatoire == chauffeurObligatoire)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,photo,categorie,categorieLibelle,marque,modele,annee,nbPlaces,boiteLibelle,carburantLibelle,climatisation,prixJour,prixJourAvecChauffeur,chauffeurDisponible,chauffeurObligatoire,localisationTexte,disponibilite);

@override
String toString() {
  return 'VehiculeResume(id: $id, titre: $titre, photo: $photo, categorie: $categorie, categorieLibelle: $categorieLibelle, marque: $marque, modele: $modele, annee: $annee, nbPlaces: $nbPlaces, boiteLibelle: $boiteLibelle, carburantLibelle: $carburantLibelle, climatisation: $climatisation, prixJour: $prixJour, prixJourAvecChauffeur: $prixJourAvecChauffeur, chauffeurDisponible: $chauffeurDisponible, chauffeurObligatoire: $chauffeurObligatoire, localisationTexte: $localisationTexte, disponibilite: $disponibilite)';
}


}

/// @nodoc
abstract mixin class _$VehiculeResumeCopyWith<$Res> implements $VehiculeResumeCopyWith<$Res> {
  factory _$VehiculeResumeCopyWith(_VehiculeResume value, $Res Function(_VehiculeResume) _then) = __$VehiculeResumeCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String photo, String categorie,@JsonKey(name: 'categorie_libelle') String categorieLibelle, String marque, String modele,@JsonKey(fromJson: versIntNullable) int? annee,@JsonKey(name: 'nb_places', fromJson: versInt) int nbPlaces,@JsonKey(name: 'boite_libelle') String boiteLibelle,@JsonKey(name: 'carburant_libelle') String carburantLibelle, bool climatisation,@JsonKey(name: 'prix_jour', fromJson: versInt) int prixJour,@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? prixJourAvecChauffeur,@JsonKey(name: 'chauffeur_disponible') bool chauffeurDisponible,@JsonKey(name: 'chauffeur_obligatoire') bool chauffeurObligatoire,@JsonKey(name: 'localisation_texte') String localisationTexte, String disponibilite
});




}
/// @nodoc
class __$VehiculeResumeCopyWithImpl<$Res>
    implements _$VehiculeResumeCopyWith<$Res> {
  __$VehiculeResumeCopyWithImpl(this._self, this._then);

  final _VehiculeResume _self;
  final $Res Function(_VehiculeResume) _then;

/// Create a copy of VehiculeResume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? photo = null,Object? categorie = null,Object? categorieLibelle = null,Object? marque = null,Object? modele = null,Object? annee = freezed,Object? nbPlaces = null,Object? boiteLibelle = null,Object? carburantLibelle = null,Object? climatisation = null,Object? prixJour = null,Object? prixJourAvecChauffeur = freezed,Object? chauffeurDisponible = null,Object? chauffeurObligatoire = null,Object? localisationTexte = null,Object? disponibilite = null,}) {
  return _then(_VehiculeResume(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,categorie: null == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as String,categorieLibelle: null == categorieLibelle ? _self.categorieLibelle : categorieLibelle // ignore: cast_nullable_to_non_nullable
as String,marque: null == marque ? _self.marque : marque // ignore: cast_nullable_to_non_nullable
as String,modele: null == modele ? _self.modele : modele // ignore: cast_nullable_to_non_nullable
as String,annee: freezed == annee ? _self.annee : annee // ignore: cast_nullable_to_non_nullable
as int?,nbPlaces: null == nbPlaces ? _self.nbPlaces : nbPlaces // ignore: cast_nullable_to_non_nullable
as int,boiteLibelle: null == boiteLibelle ? _self.boiteLibelle : boiteLibelle // ignore: cast_nullable_to_non_nullable
as String,carburantLibelle: null == carburantLibelle ? _self.carburantLibelle : carburantLibelle // ignore: cast_nullable_to_non_nullable
as String,climatisation: null == climatisation ? _self.climatisation : climatisation // ignore: cast_nullable_to_non_nullable
as bool,prixJour: null == prixJour ? _self.prixJour : prixJour // ignore: cast_nullable_to_non_nullable
as int,prixJourAvecChauffeur: freezed == prixJourAvecChauffeur ? _self.prixJourAvecChauffeur : prixJourAvecChauffeur // ignore: cast_nullable_to_non_nullable
as int?,chauffeurDisponible: null == chauffeurDisponible ? _self.chauffeurDisponible : chauffeurDisponible // ignore: cast_nullable_to_non_nullable
as bool,chauffeurObligatoire: null == chauffeurObligatoire ? _self.chauffeurObligatoire : chauffeurObligatoire // ignore: cast_nullable_to_non_nullable
as bool,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PageLoueurVehicules {

 Loueur get loueur; List<VehiculeResume> get resultats;
/// Create a copy of PageLoueurVehicules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageLoueurVehiculesCopyWith<PageLoueurVehicules> get copyWith => _$PageLoueurVehiculesCopyWithImpl<PageLoueurVehicules>(this as PageLoueurVehicules, _$identity);

  /// Serializes this PageLoueurVehicules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageLoueurVehicules&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other.resultats, resultats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loueur,const DeepCollectionEquality().hash(resultats));

@override
String toString() {
  return 'PageLoueurVehicules(loueur: $loueur, resultats: $resultats)';
}


}

/// @nodoc
abstract mixin class $PageLoueurVehiculesCopyWith<$Res>  {
  factory $PageLoueurVehiculesCopyWith(PageLoueurVehicules value, $Res Function(PageLoueurVehicules) _then) = _$PageLoueurVehiculesCopyWithImpl;
@useResult
$Res call({
 Loueur loueur, List<VehiculeResume> resultats
});


$LoueurCopyWith<$Res> get loueur;

}
/// @nodoc
class _$PageLoueurVehiculesCopyWithImpl<$Res>
    implements $PageLoueurVehiculesCopyWith<$Res> {
  _$PageLoueurVehiculesCopyWithImpl(this._self, this._then);

  final PageLoueurVehicules _self;
  final $Res Function(PageLoueurVehicules) _then;

/// Create a copy of PageLoueurVehicules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loueur = null,Object? resultats = null,}) {
  return _then(_self.copyWith(
loueur: null == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur,resultats: null == resultats ? _self.resultats : resultats // ignore: cast_nullable_to_non_nullable
as List<VehiculeResume>,
  ));
}
/// Create a copy of PageLoueurVehicules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoueurCopyWith<$Res> get loueur {
  
  return $LoueurCopyWith<$Res>(_self.loueur, (value) {
    return _then(_self.copyWith(loueur: value));
  });
}
}


/// Adds pattern-matching-related methods to [PageLoueurVehicules].
extension PageLoueurVehiculesPatterns on PageLoueurVehicules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageLoueurVehicules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageLoueurVehicules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageLoueurVehicules value)  $default,){
final _that = this;
switch (_that) {
case _PageLoueurVehicules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageLoueurVehicules value)?  $default,){
final _that = this;
switch (_that) {
case _PageLoueurVehicules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Loueur loueur,  List<VehiculeResume> resultats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageLoueurVehicules() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Loueur loueur,  List<VehiculeResume> resultats)  $default,) {final _that = this;
switch (_that) {
case _PageLoueurVehicules():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Loueur loueur,  List<VehiculeResume> resultats)?  $default,) {final _that = this;
switch (_that) {
case _PageLoueurVehicules() when $default != null:
return $default(_that.loueur,_that.resultats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageLoueurVehicules implements PageLoueurVehicules {
  const _PageLoueurVehicules({required this.loueur, final  List<VehiculeResume> resultats = const <VehiculeResume>[]}): _resultats = resultats;
  factory _PageLoueurVehicules.fromJson(Map<String, dynamic> json) => _$PageLoueurVehiculesFromJson(json);

@override final  Loueur loueur;
 final  List<VehiculeResume> _resultats;
@override@JsonKey() List<VehiculeResume> get resultats {
  if (_resultats is EqualUnmodifiableListView) return _resultats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultats);
}


/// Create a copy of PageLoueurVehicules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageLoueurVehiculesCopyWith<_PageLoueurVehicules> get copyWith => __$PageLoueurVehiculesCopyWithImpl<_PageLoueurVehicules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageLoueurVehiculesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageLoueurVehicules&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other._resultats, _resultats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loueur,const DeepCollectionEquality().hash(_resultats));

@override
String toString() {
  return 'PageLoueurVehicules(loueur: $loueur, resultats: $resultats)';
}


}

/// @nodoc
abstract mixin class _$PageLoueurVehiculesCopyWith<$Res> implements $PageLoueurVehiculesCopyWith<$Res> {
  factory _$PageLoueurVehiculesCopyWith(_PageLoueurVehicules value, $Res Function(_PageLoueurVehicules) _then) = __$PageLoueurVehiculesCopyWithImpl;
@override @useResult
$Res call({
 Loueur loueur, List<VehiculeResume> resultats
});


@override $LoueurCopyWith<$Res> get loueur;

}
/// @nodoc
class __$PageLoueurVehiculesCopyWithImpl<$Res>
    implements _$PageLoueurVehiculesCopyWith<$Res> {
  __$PageLoueurVehiculesCopyWithImpl(this._self, this._then);

  final _PageLoueurVehicules _self;
  final $Res Function(_PageLoueurVehicules) _then;

/// Create a copy of PageLoueurVehicules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loueur = null,Object? resultats = null,}) {
  return _then(_PageLoueurVehicules(
loueur: null == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur,resultats: null == resultats ? _self._resultats : resultats // ignore: cast_nullable_to_non_nullable
as List<VehiculeResume>,
  ));
}

/// Create a copy of PageLoueurVehicules
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
mixin _$PeriodeIndisponible {

@JsonKey(name: 'date_debut') String get dateDebut;@JsonKey(name: 'date_fin') String get dateFin;
/// Create a copy of PeriodeIndisponible
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodeIndisponibleCopyWith<PeriodeIndisponible> get copyWith => _$PeriodeIndisponibleCopyWithImpl<PeriodeIndisponible>(this as PeriodeIndisponible, _$identity);

  /// Serializes this PeriodeIndisponible to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodeIndisponible&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFin, dateFin) || other.dateFin == dateFin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateDebut,dateFin);

@override
String toString() {
  return 'PeriodeIndisponible(dateDebut: $dateDebut, dateFin: $dateFin)';
}


}

/// @nodoc
abstract mixin class $PeriodeIndisponibleCopyWith<$Res>  {
  factory $PeriodeIndisponibleCopyWith(PeriodeIndisponible value, $Res Function(PeriodeIndisponible) _then) = _$PeriodeIndisponibleCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_debut') String dateDebut,@JsonKey(name: 'date_fin') String dateFin
});




}
/// @nodoc
class _$PeriodeIndisponibleCopyWithImpl<$Res>
    implements $PeriodeIndisponibleCopyWith<$Res> {
  _$PeriodeIndisponibleCopyWithImpl(this._self, this._then);

  final PeriodeIndisponible _self;
  final $Res Function(PeriodeIndisponible) _then;

/// Create a copy of PeriodeIndisponible
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateDebut = null,Object? dateFin = null,}) {
  return _then(_self.copyWith(
dateDebut: null == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as String,dateFin: null == dateFin ? _self.dateFin : dateFin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodeIndisponible].
extension PeriodeIndisponiblePatterns on PeriodeIndisponible {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodeIndisponible value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodeIndisponible() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodeIndisponible value)  $default,){
final _that = this;
switch (_that) {
case _PeriodeIndisponible():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodeIndisponible value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodeIndisponible() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_debut')  String dateDebut, @JsonKey(name: 'date_fin')  String dateFin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodeIndisponible() when $default != null:
return $default(_that.dateDebut,_that.dateFin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_debut')  String dateDebut, @JsonKey(name: 'date_fin')  String dateFin)  $default,) {final _that = this;
switch (_that) {
case _PeriodeIndisponible():
return $default(_that.dateDebut,_that.dateFin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_debut')  String dateDebut, @JsonKey(name: 'date_fin')  String dateFin)?  $default,) {final _that = this;
switch (_that) {
case _PeriodeIndisponible() when $default != null:
return $default(_that.dateDebut,_that.dateFin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodeIndisponible extends PeriodeIndisponible {
  const _PeriodeIndisponible({@JsonKey(name: 'date_debut') this.dateDebut = '', @JsonKey(name: 'date_fin') this.dateFin = ''}): super._();
  factory _PeriodeIndisponible.fromJson(Map<String, dynamic> json) => _$PeriodeIndisponibleFromJson(json);

@override@JsonKey(name: 'date_debut') final  String dateDebut;
@override@JsonKey(name: 'date_fin') final  String dateFin;

/// Create a copy of PeriodeIndisponible
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodeIndisponibleCopyWith<_PeriodeIndisponible> get copyWith => __$PeriodeIndisponibleCopyWithImpl<_PeriodeIndisponible>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodeIndisponibleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodeIndisponible&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFin, dateFin) || other.dateFin == dateFin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateDebut,dateFin);

@override
String toString() {
  return 'PeriodeIndisponible(dateDebut: $dateDebut, dateFin: $dateFin)';
}


}

/// @nodoc
abstract mixin class _$PeriodeIndisponibleCopyWith<$Res> implements $PeriodeIndisponibleCopyWith<$Res> {
  factory _$PeriodeIndisponibleCopyWith(_PeriodeIndisponible value, $Res Function(_PeriodeIndisponible) _then) = __$PeriodeIndisponibleCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_debut') String dateDebut,@JsonKey(name: 'date_fin') String dateFin
});




}
/// @nodoc
class __$PeriodeIndisponibleCopyWithImpl<$Res>
    implements _$PeriodeIndisponibleCopyWith<$Res> {
  __$PeriodeIndisponibleCopyWithImpl(this._self, this._then);

  final _PeriodeIndisponible _self;
  final $Res Function(_PeriodeIndisponible) _then;

/// Create a copy of PeriodeIndisponible
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateDebut = null,Object? dateFin = null,}) {
  return _then(_PeriodeIndisponible(
dateDebut: null == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as String,dateFin: null == dateFin ? _self.dateFin : dateFin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Vehicule {

 int get id; String get titre; String get description; List<String> get galerie; List<Panorama> get panoramas; String get categorie;@JsonKey(name: 'categorie_libelle') String get categorieLibelle; String get marque; String get modele;@JsonKey(fromJson: versIntNullable) int? get annee; String get couleur;@JsonKey(name: 'nb_places', fromJson: versInt) int get nbPlaces; String get boite;@JsonKey(name: 'boite_libelle') String get boiteLibelle; String get carburant;@JsonKey(name: 'carburant_libelle') String get carburantLibelle; bool get climatisation;@JsonKey(name: 'prix_jour', fromJson: versInt) int get prixJour;@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? get prixJourAvecChauffeur;@JsonKey(name: 'chauffeur_disponible') bool get chauffeurDisponible;@JsonKey(name: 'chauffeur_obligatoire') bool get chauffeurObligatoire;@JsonKey(fromJson: versIntNullable) int? get caution;/// 0 = kilométrage illimité.
@JsonKey(name: 'km_inclus_par_jour', fromJson: versInt) int get kmInclusParJour;@JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable) int? get prixKmSupplementaire;@JsonKey(name: 'carburant_inclus') bool get carburantInclus;@JsonKey(name: 'duree_min_jours', fromJson: versInt) int get dureeMinJours;@JsonKey(name: 'zone_circulation') String get zoneCirculation;@JsonKey(name: 'zone_circulation_libelle') String get zoneCirculationLibelle; List<String> get equipements; String get disponibilite;@JsonKey(name: 'localisation_texte') String get localisationTexte;@JsonKey(fromJson: versDoubleNullable) double? get latitude;@JsonKey(fromJson: versDoubleNullable) double? get longitude; Loueur? get loueur;@JsonKey(name: 'autres_vehicules') List<VehiculeResume> get autresVehicules;@JsonKey(name: 'periodes_indisponibles') List<PeriodeIndisponible> get periodesIndisponibles;
/// Create a copy of Vehicule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiculeCopyWith<Vehicule> get copyWith => _$VehiculeCopyWithImpl<Vehicule>(this as Vehicule, _$identity);

  /// Serializes this Vehicule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vehicule&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.galerie, galerie)&&const DeepCollectionEquality().equals(other.panoramas, panoramas)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieLibelle, categorieLibelle) || other.categorieLibelle == categorieLibelle)&&(identical(other.marque, marque) || other.marque == marque)&&(identical(other.modele, modele) || other.modele == modele)&&(identical(other.annee, annee) || other.annee == annee)&&(identical(other.couleur, couleur) || other.couleur == couleur)&&(identical(other.nbPlaces, nbPlaces) || other.nbPlaces == nbPlaces)&&(identical(other.boite, boite) || other.boite == boite)&&(identical(other.boiteLibelle, boiteLibelle) || other.boiteLibelle == boiteLibelle)&&(identical(other.carburant, carburant) || other.carburant == carburant)&&(identical(other.carburantLibelle, carburantLibelle) || other.carburantLibelle == carburantLibelle)&&(identical(other.climatisation, climatisation) || other.climatisation == climatisation)&&(identical(other.prixJour, prixJour) || other.prixJour == prixJour)&&(identical(other.prixJourAvecChauffeur, prixJourAvecChauffeur) || other.prixJourAvecChauffeur == prixJourAvecChauffeur)&&(identical(other.chauffeurDisponible, chauffeurDisponible) || other.chauffeurDisponible == chauffeurDisponible)&&(identical(other.chauffeurObligatoire, chauffeurObligatoire) || other.chauffeurObligatoire == chauffeurObligatoire)&&(identical(other.caution, caution) || other.caution == caution)&&(identical(other.kmInclusParJour, kmInclusParJour) || other.kmInclusParJour == kmInclusParJour)&&(identical(other.prixKmSupplementaire, prixKmSupplementaire) || other.prixKmSupplementaire == prixKmSupplementaire)&&(identical(other.carburantInclus, carburantInclus) || other.carburantInclus == carburantInclus)&&(identical(other.dureeMinJours, dureeMinJours) || other.dureeMinJours == dureeMinJours)&&(identical(other.zoneCirculation, zoneCirculation) || other.zoneCirculation == zoneCirculation)&&(identical(other.zoneCirculationLibelle, zoneCirculationLibelle) || other.zoneCirculationLibelle == zoneCirculationLibelle)&&const DeepCollectionEquality().equals(other.equipements, equipements)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other.autresVehicules, autresVehicules)&&const DeepCollectionEquality().equals(other.periodesIndisponibles, periodesIndisponibles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(galerie),const DeepCollectionEquality().hash(panoramas),categorie,categorieLibelle,marque,modele,annee,couleur,nbPlaces,boite,boiteLibelle,carburant,carburantLibelle,climatisation,prixJour,prixJourAvecChauffeur,chauffeurDisponible,chauffeurObligatoire,caution,kmInclusParJour,prixKmSupplementaire,carburantInclus,dureeMinJours,zoneCirculation,zoneCirculationLibelle,const DeepCollectionEquality().hash(equipements),disponibilite,localisationTexte,latitude,longitude,loueur,const DeepCollectionEquality().hash(autresVehicules),const DeepCollectionEquality().hash(periodesIndisponibles)]);

@override
String toString() {
  return 'Vehicule(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, categorie: $categorie, categorieLibelle: $categorieLibelle, marque: $marque, modele: $modele, annee: $annee, couleur: $couleur, nbPlaces: $nbPlaces, boite: $boite, boiteLibelle: $boiteLibelle, carburant: $carburant, carburantLibelle: $carburantLibelle, climatisation: $climatisation, prixJour: $prixJour, prixJourAvecChauffeur: $prixJourAvecChauffeur, chauffeurDisponible: $chauffeurDisponible, chauffeurObligatoire: $chauffeurObligatoire, caution: $caution, kmInclusParJour: $kmInclusParJour, prixKmSupplementaire: $prixKmSupplementaire, carburantInclus: $carburantInclus, dureeMinJours: $dureeMinJours, zoneCirculation: $zoneCirculation, zoneCirculationLibelle: $zoneCirculationLibelle, equipements: $equipements, disponibilite: $disponibilite, localisationTexte: $localisationTexte, latitude: $latitude, longitude: $longitude, loueur: $loueur, autresVehicules: $autresVehicules, periodesIndisponibles: $periodesIndisponibles)';
}


}

/// @nodoc
abstract mixin class $VehiculeCopyWith<$Res>  {
  factory $VehiculeCopyWith(Vehicule value, $Res Function(Vehicule) _then) = _$VehiculeCopyWithImpl;
@useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas, String categorie,@JsonKey(name: 'categorie_libelle') String categorieLibelle, String marque, String modele,@JsonKey(fromJson: versIntNullable) int? annee, String couleur,@JsonKey(name: 'nb_places', fromJson: versInt) int nbPlaces, String boite,@JsonKey(name: 'boite_libelle') String boiteLibelle, String carburant,@JsonKey(name: 'carburant_libelle') String carburantLibelle, bool climatisation,@JsonKey(name: 'prix_jour', fromJson: versInt) int prixJour,@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? prixJourAvecChauffeur,@JsonKey(name: 'chauffeur_disponible') bool chauffeurDisponible,@JsonKey(name: 'chauffeur_obligatoire') bool chauffeurObligatoire,@JsonKey(fromJson: versIntNullable) int? caution,@JsonKey(name: 'km_inclus_par_jour', fromJson: versInt) int kmInclusParJour,@JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable) int? prixKmSupplementaire,@JsonKey(name: 'carburant_inclus') bool carburantInclus,@JsonKey(name: 'duree_min_jours', fromJson: versInt) int dureeMinJours,@JsonKey(name: 'zone_circulation') String zoneCirculation,@JsonKey(name: 'zone_circulation_libelle') String zoneCirculationLibelle, List<String> equipements, String disponibilite,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude, Loueur? loueur,@JsonKey(name: 'autres_vehicules') List<VehiculeResume> autresVehicules,@JsonKey(name: 'periodes_indisponibles') List<PeriodeIndisponible> periodesIndisponibles
});


$LoueurCopyWith<$Res>? get loueur;

}
/// @nodoc
class _$VehiculeCopyWithImpl<$Res>
    implements $VehiculeCopyWith<$Res> {
  _$VehiculeCopyWithImpl(this._self, this._then);

  final Vehicule _self;
  final $Res Function(Vehicule) _then;

/// Create a copy of Vehicule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? categorie = null,Object? categorieLibelle = null,Object? marque = null,Object? modele = null,Object? annee = freezed,Object? couleur = null,Object? nbPlaces = null,Object? boite = null,Object? boiteLibelle = null,Object? carburant = null,Object? carburantLibelle = null,Object? climatisation = null,Object? prixJour = null,Object? prixJourAvecChauffeur = freezed,Object? chauffeurDisponible = null,Object? chauffeurObligatoire = null,Object? caution = freezed,Object? kmInclusParJour = null,Object? prixKmSupplementaire = freezed,Object? carburantInclus = null,Object? dureeMinJours = null,Object? zoneCirculation = null,Object? zoneCirculationLibelle = null,Object? equipements = null,Object? disponibilite = null,Object? localisationTexte = null,Object? latitude = freezed,Object? longitude = freezed,Object? loueur = freezed,Object? autresVehicules = null,Object? periodesIndisponibles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self.galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self.panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,categorie: null == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as String,categorieLibelle: null == categorieLibelle ? _self.categorieLibelle : categorieLibelle // ignore: cast_nullable_to_non_nullable
as String,marque: null == marque ? _self.marque : marque // ignore: cast_nullable_to_non_nullable
as String,modele: null == modele ? _self.modele : modele // ignore: cast_nullable_to_non_nullable
as String,annee: freezed == annee ? _self.annee : annee // ignore: cast_nullable_to_non_nullable
as int?,couleur: null == couleur ? _self.couleur : couleur // ignore: cast_nullable_to_non_nullable
as String,nbPlaces: null == nbPlaces ? _self.nbPlaces : nbPlaces // ignore: cast_nullable_to_non_nullable
as int,boite: null == boite ? _self.boite : boite // ignore: cast_nullable_to_non_nullable
as String,boiteLibelle: null == boiteLibelle ? _self.boiteLibelle : boiteLibelle // ignore: cast_nullable_to_non_nullable
as String,carburant: null == carburant ? _self.carburant : carburant // ignore: cast_nullable_to_non_nullable
as String,carburantLibelle: null == carburantLibelle ? _self.carburantLibelle : carburantLibelle // ignore: cast_nullable_to_non_nullable
as String,climatisation: null == climatisation ? _self.climatisation : climatisation // ignore: cast_nullable_to_non_nullable
as bool,prixJour: null == prixJour ? _self.prixJour : prixJour // ignore: cast_nullable_to_non_nullable
as int,prixJourAvecChauffeur: freezed == prixJourAvecChauffeur ? _self.prixJourAvecChauffeur : prixJourAvecChauffeur // ignore: cast_nullable_to_non_nullable
as int?,chauffeurDisponible: null == chauffeurDisponible ? _self.chauffeurDisponible : chauffeurDisponible // ignore: cast_nullable_to_non_nullable
as bool,chauffeurObligatoire: null == chauffeurObligatoire ? _self.chauffeurObligatoire : chauffeurObligatoire // ignore: cast_nullable_to_non_nullable
as bool,caution: freezed == caution ? _self.caution : caution // ignore: cast_nullable_to_non_nullable
as int?,kmInclusParJour: null == kmInclusParJour ? _self.kmInclusParJour : kmInclusParJour // ignore: cast_nullable_to_non_nullable
as int,prixKmSupplementaire: freezed == prixKmSupplementaire ? _self.prixKmSupplementaire : prixKmSupplementaire // ignore: cast_nullable_to_non_nullable
as int?,carburantInclus: null == carburantInclus ? _self.carburantInclus : carburantInclus // ignore: cast_nullable_to_non_nullable
as bool,dureeMinJours: null == dureeMinJours ? _self.dureeMinJours : dureeMinJours // ignore: cast_nullable_to_non_nullable
as int,zoneCirculation: null == zoneCirculation ? _self.zoneCirculation : zoneCirculation // ignore: cast_nullable_to_non_nullable
as String,zoneCirculationLibelle: null == zoneCirculationLibelle ? _self.zoneCirculationLibelle : zoneCirculationLibelle // ignore: cast_nullable_to_non_nullable
as String,equipements: null == equipements ? _self.equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,loueur: freezed == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur?,autresVehicules: null == autresVehicules ? _self.autresVehicules : autresVehicules // ignore: cast_nullable_to_non_nullable
as List<VehiculeResume>,periodesIndisponibles: null == periodesIndisponibles ? _self.periodesIndisponibles : periodesIndisponibles // ignore: cast_nullable_to_non_nullable
as List<PeriodeIndisponible>,
  ));
}
/// Create a copy of Vehicule
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


/// Adds pattern-matching-related methods to [Vehicule].
extension VehiculePatterns on Vehicule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vehicule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vehicule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vehicule value)  $default,){
final _that = this;
switch (_that) {
case _Vehicule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vehicule value)?  $default,){
final _that = this;
switch (_that) {
case _Vehicule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee,  String couleur, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces,  String boite, @JsonKey(name: 'boite_libelle')  String boiteLibelle,  String carburant, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(fromJson: versIntNullable)  int? caution, @JsonKey(name: 'km_inclus_par_jour', fromJson: versInt)  int kmInclusParJour, @JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable)  int? prixKmSupplementaire, @JsonKey(name: 'carburant_inclus')  bool carburantInclus, @JsonKey(name: 'duree_min_jours', fromJson: versInt)  int dureeMinJours, @JsonKey(name: 'zone_circulation')  String zoneCirculation, @JsonKey(name: 'zone_circulation_libelle')  String zoneCirculationLibelle,  List<String> equipements,  String disponibilite, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_vehicules')  List<VehiculeResume> autresVehicules, @JsonKey(name: 'periodes_indisponibles')  List<PeriodeIndisponible> periodesIndisponibles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vehicule() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.couleur,_that.nbPlaces,_that.boite,_that.boiteLibelle,_that.carburant,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.caution,_that.kmInclusParJour,_that.prixKmSupplementaire,_that.carburantInclus,_that.dureeMinJours,_that.zoneCirculation,_that.zoneCirculationLibelle,_that.equipements,_that.disponibilite,_that.localisationTexte,_that.latitude,_that.longitude,_that.loueur,_that.autresVehicules,_that.periodesIndisponibles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee,  String couleur, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces,  String boite, @JsonKey(name: 'boite_libelle')  String boiteLibelle,  String carburant, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(fromJson: versIntNullable)  int? caution, @JsonKey(name: 'km_inclus_par_jour', fromJson: versInt)  int kmInclusParJour, @JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable)  int? prixKmSupplementaire, @JsonKey(name: 'carburant_inclus')  bool carburantInclus, @JsonKey(name: 'duree_min_jours', fromJson: versInt)  int dureeMinJours, @JsonKey(name: 'zone_circulation')  String zoneCirculation, @JsonKey(name: 'zone_circulation_libelle')  String zoneCirculationLibelle,  List<String> equipements,  String disponibilite, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_vehicules')  List<VehiculeResume> autresVehicules, @JsonKey(name: 'periodes_indisponibles')  List<PeriodeIndisponible> periodesIndisponibles)  $default,) {final _that = this;
switch (_that) {
case _Vehicule():
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.couleur,_that.nbPlaces,_that.boite,_that.boiteLibelle,_that.carburant,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.caution,_that.kmInclusParJour,_that.prixKmSupplementaire,_that.carburantInclus,_that.dureeMinJours,_that.zoneCirculation,_that.zoneCirculationLibelle,_that.equipements,_that.disponibilite,_that.localisationTexte,_that.latitude,_that.longitude,_that.loueur,_that.autresVehicules,_that.periodesIndisponibles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titre,  String description,  List<String> galerie,  List<Panorama> panoramas,  String categorie, @JsonKey(name: 'categorie_libelle')  String categorieLibelle,  String marque,  String modele, @JsonKey(fromJson: versIntNullable)  int? annee,  String couleur, @JsonKey(name: 'nb_places', fromJson: versInt)  int nbPlaces,  String boite, @JsonKey(name: 'boite_libelle')  String boiteLibelle,  String carburant, @JsonKey(name: 'carburant_libelle')  String carburantLibelle,  bool climatisation, @JsonKey(name: 'prix_jour', fromJson: versInt)  int prixJour, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)  int? prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible')  bool chauffeurDisponible, @JsonKey(name: 'chauffeur_obligatoire')  bool chauffeurObligatoire, @JsonKey(fromJson: versIntNullable)  int? caution, @JsonKey(name: 'km_inclus_par_jour', fromJson: versInt)  int kmInclusParJour, @JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable)  int? prixKmSupplementaire, @JsonKey(name: 'carburant_inclus')  bool carburantInclus, @JsonKey(name: 'duree_min_jours', fromJson: versInt)  int dureeMinJours, @JsonKey(name: 'zone_circulation')  String zoneCirculation, @JsonKey(name: 'zone_circulation_libelle')  String zoneCirculationLibelle,  List<String> equipements,  String disponibilite, @JsonKey(name: 'localisation_texte')  String localisationTexte, @JsonKey(fromJson: versDoubleNullable)  double? latitude, @JsonKey(fromJson: versDoubleNullable)  double? longitude,  Loueur? loueur, @JsonKey(name: 'autres_vehicules')  List<VehiculeResume> autresVehicules, @JsonKey(name: 'periodes_indisponibles')  List<PeriodeIndisponible> periodesIndisponibles)?  $default,) {final _that = this;
switch (_that) {
case _Vehicule() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.galerie,_that.panoramas,_that.categorie,_that.categorieLibelle,_that.marque,_that.modele,_that.annee,_that.couleur,_that.nbPlaces,_that.boite,_that.boiteLibelle,_that.carburant,_that.carburantLibelle,_that.climatisation,_that.prixJour,_that.prixJourAvecChauffeur,_that.chauffeurDisponible,_that.chauffeurObligatoire,_that.caution,_that.kmInclusParJour,_that.prixKmSupplementaire,_that.carburantInclus,_that.dureeMinJours,_that.zoneCirculation,_that.zoneCirculationLibelle,_that.equipements,_that.disponibilite,_that.localisationTexte,_that.latitude,_that.longitude,_that.loueur,_that.autresVehicules,_that.periodesIndisponibles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vehicule extends Vehicule {
  const _Vehicule({required this.id, this.titre = '', this.description = '', final  List<String> galerie = const <String>[], final  List<Panorama> panoramas = const <Panorama>[], this.categorie = '', @JsonKey(name: 'categorie_libelle') this.categorieLibelle = '', this.marque = '', this.modele = '', @JsonKey(fromJson: versIntNullable) this.annee, this.couleur = '', @JsonKey(name: 'nb_places', fromJson: versInt) this.nbPlaces = 0, this.boite = '', @JsonKey(name: 'boite_libelle') this.boiteLibelle = '', this.carburant = '', @JsonKey(name: 'carburant_libelle') this.carburantLibelle = '', this.climatisation = false, @JsonKey(name: 'prix_jour', fromJson: versInt) this.prixJour = 0, @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) this.prixJourAvecChauffeur, @JsonKey(name: 'chauffeur_disponible') this.chauffeurDisponible = false, @JsonKey(name: 'chauffeur_obligatoire') this.chauffeurObligatoire = false, @JsonKey(fromJson: versIntNullable) this.caution, @JsonKey(name: 'km_inclus_par_jour', fromJson: versInt) this.kmInclusParJour = 0, @JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable) this.prixKmSupplementaire, @JsonKey(name: 'carburant_inclus') this.carburantInclus = false, @JsonKey(name: 'duree_min_jours', fromJson: versInt) this.dureeMinJours = 1, @JsonKey(name: 'zone_circulation') this.zoneCirculation = '', @JsonKey(name: 'zone_circulation_libelle') this.zoneCirculationLibelle = '', final  List<String> equipements = const <String>[], this.disponibilite = '', @JsonKey(name: 'localisation_texte') this.localisationTexte = '', @JsonKey(fromJson: versDoubleNullable) this.latitude, @JsonKey(fromJson: versDoubleNullable) this.longitude, this.loueur, @JsonKey(name: 'autres_vehicules') final  List<VehiculeResume> autresVehicules = const <VehiculeResume>[], @JsonKey(name: 'periodes_indisponibles') final  List<PeriodeIndisponible> periodesIndisponibles = const <PeriodeIndisponible>[]}): _galerie = galerie,_panoramas = panoramas,_equipements = equipements,_autresVehicules = autresVehicules,_periodesIndisponibles = periodesIndisponibles,super._();
  factory _Vehicule.fromJson(Map<String, dynamic> json) => _$VehiculeFromJson(json);

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

@override@JsonKey() final  String categorie;
@override@JsonKey(name: 'categorie_libelle') final  String categorieLibelle;
@override@JsonKey() final  String marque;
@override@JsonKey() final  String modele;
@override@JsonKey(fromJson: versIntNullable) final  int? annee;
@override@JsonKey() final  String couleur;
@override@JsonKey(name: 'nb_places', fromJson: versInt) final  int nbPlaces;
@override@JsonKey() final  String boite;
@override@JsonKey(name: 'boite_libelle') final  String boiteLibelle;
@override@JsonKey() final  String carburant;
@override@JsonKey(name: 'carburant_libelle') final  String carburantLibelle;
@override@JsonKey() final  bool climatisation;
@override@JsonKey(name: 'prix_jour', fromJson: versInt) final  int prixJour;
@override@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) final  int? prixJourAvecChauffeur;
@override@JsonKey(name: 'chauffeur_disponible') final  bool chauffeurDisponible;
@override@JsonKey(name: 'chauffeur_obligatoire') final  bool chauffeurObligatoire;
@override@JsonKey(fromJson: versIntNullable) final  int? caution;
/// 0 = kilométrage illimité.
@override@JsonKey(name: 'km_inclus_par_jour', fromJson: versInt) final  int kmInclusParJour;
@override@JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable) final  int? prixKmSupplementaire;
@override@JsonKey(name: 'carburant_inclus') final  bool carburantInclus;
@override@JsonKey(name: 'duree_min_jours', fromJson: versInt) final  int dureeMinJours;
@override@JsonKey(name: 'zone_circulation') final  String zoneCirculation;
@override@JsonKey(name: 'zone_circulation_libelle') final  String zoneCirculationLibelle;
 final  List<String> _equipements;
@override@JsonKey() List<String> get equipements {
  if (_equipements is EqualUnmodifiableListView) return _equipements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipements);
}

@override@JsonKey() final  String disponibilite;
@override@JsonKey(name: 'localisation_texte') final  String localisationTexte;
@override@JsonKey(fromJson: versDoubleNullable) final  double? latitude;
@override@JsonKey(fromJson: versDoubleNullable) final  double? longitude;
@override final  Loueur? loueur;
 final  List<VehiculeResume> _autresVehicules;
@override@JsonKey(name: 'autres_vehicules') List<VehiculeResume> get autresVehicules {
  if (_autresVehicules is EqualUnmodifiableListView) return _autresVehicules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autresVehicules);
}

 final  List<PeriodeIndisponible> _periodesIndisponibles;
@override@JsonKey(name: 'periodes_indisponibles') List<PeriodeIndisponible> get periodesIndisponibles {
  if (_periodesIndisponibles is EqualUnmodifiableListView) return _periodesIndisponibles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periodesIndisponibles);
}


/// Create a copy of Vehicule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehiculeCopyWith<_Vehicule> get copyWith => __$VehiculeCopyWithImpl<_Vehicule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehiculeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vehicule&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._galerie, _galerie)&&const DeepCollectionEquality().equals(other._panoramas, _panoramas)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieLibelle, categorieLibelle) || other.categorieLibelle == categorieLibelle)&&(identical(other.marque, marque) || other.marque == marque)&&(identical(other.modele, modele) || other.modele == modele)&&(identical(other.annee, annee) || other.annee == annee)&&(identical(other.couleur, couleur) || other.couleur == couleur)&&(identical(other.nbPlaces, nbPlaces) || other.nbPlaces == nbPlaces)&&(identical(other.boite, boite) || other.boite == boite)&&(identical(other.boiteLibelle, boiteLibelle) || other.boiteLibelle == boiteLibelle)&&(identical(other.carburant, carburant) || other.carburant == carburant)&&(identical(other.carburantLibelle, carburantLibelle) || other.carburantLibelle == carburantLibelle)&&(identical(other.climatisation, climatisation) || other.climatisation == climatisation)&&(identical(other.prixJour, prixJour) || other.prixJour == prixJour)&&(identical(other.prixJourAvecChauffeur, prixJourAvecChauffeur) || other.prixJourAvecChauffeur == prixJourAvecChauffeur)&&(identical(other.chauffeurDisponible, chauffeurDisponible) || other.chauffeurDisponible == chauffeurDisponible)&&(identical(other.chauffeurObligatoire, chauffeurObligatoire) || other.chauffeurObligatoire == chauffeurObligatoire)&&(identical(other.caution, caution) || other.caution == caution)&&(identical(other.kmInclusParJour, kmInclusParJour) || other.kmInclusParJour == kmInclusParJour)&&(identical(other.prixKmSupplementaire, prixKmSupplementaire) || other.prixKmSupplementaire == prixKmSupplementaire)&&(identical(other.carburantInclus, carburantInclus) || other.carburantInclus == carburantInclus)&&(identical(other.dureeMinJours, dureeMinJours) || other.dureeMinJours == dureeMinJours)&&(identical(other.zoneCirculation, zoneCirculation) || other.zoneCirculation == zoneCirculation)&&(identical(other.zoneCirculationLibelle, zoneCirculationLibelle) || other.zoneCirculationLibelle == zoneCirculationLibelle)&&const DeepCollectionEquality().equals(other._equipements, _equipements)&&(identical(other.disponibilite, disponibilite) || other.disponibilite == disponibilite)&&(identical(other.localisationTexte, localisationTexte) || other.localisationTexte == localisationTexte)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.loueur, loueur) || other.loueur == loueur)&&const DeepCollectionEquality().equals(other._autresVehicules, _autresVehicules)&&const DeepCollectionEquality().equals(other._periodesIndisponibles, _periodesIndisponibles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,titre,description,const DeepCollectionEquality().hash(_galerie),const DeepCollectionEquality().hash(_panoramas),categorie,categorieLibelle,marque,modele,annee,couleur,nbPlaces,boite,boiteLibelle,carburant,carburantLibelle,climatisation,prixJour,prixJourAvecChauffeur,chauffeurDisponible,chauffeurObligatoire,caution,kmInclusParJour,prixKmSupplementaire,carburantInclus,dureeMinJours,zoneCirculation,zoneCirculationLibelle,const DeepCollectionEquality().hash(_equipements),disponibilite,localisationTexte,latitude,longitude,loueur,const DeepCollectionEquality().hash(_autresVehicules),const DeepCollectionEquality().hash(_periodesIndisponibles)]);

@override
String toString() {
  return 'Vehicule(id: $id, titre: $titre, description: $description, galerie: $galerie, panoramas: $panoramas, categorie: $categorie, categorieLibelle: $categorieLibelle, marque: $marque, modele: $modele, annee: $annee, couleur: $couleur, nbPlaces: $nbPlaces, boite: $boite, boiteLibelle: $boiteLibelle, carburant: $carburant, carburantLibelle: $carburantLibelle, climatisation: $climatisation, prixJour: $prixJour, prixJourAvecChauffeur: $prixJourAvecChauffeur, chauffeurDisponible: $chauffeurDisponible, chauffeurObligatoire: $chauffeurObligatoire, caution: $caution, kmInclusParJour: $kmInclusParJour, prixKmSupplementaire: $prixKmSupplementaire, carburantInclus: $carburantInclus, dureeMinJours: $dureeMinJours, zoneCirculation: $zoneCirculation, zoneCirculationLibelle: $zoneCirculationLibelle, equipements: $equipements, disponibilite: $disponibilite, localisationTexte: $localisationTexte, latitude: $latitude, longitude: $longitude, loueur: $loueur, autresVehicules: $autresVehicules, periodesIndisponibles: $periodesIndisponibles)';
}


}

/// @nodoc
abstract mixin class _$VehiculeCopyWith<$Res> implements $VehiculeCopyWith<$Res> {
  factory _$VehiculeCopyWith(_Vehicule value, $Res Function(_Vehicule) _then) = __$VehiculeCopyWithImpl;
@override @useResult
$Res call({
 int id, String titre, String description, List<String> galerie, List<Panorama> panoramas, String categorie,@JsonKey(name: 'categorie_libelle') String categorieLibelle, String marque, String modele,@JsonKey(fromJson: versIntNullable) int? annee, String couleur,@JsonKey(name: 'nb_places', fromJson: versInt) int nbPlaces, String boite,@JsonKey(name: 'boite_libelle') String boiteLibelle, String carburant,@JsonKey(name: 'carburant_libelle') String carburantLibelle, bool climatisation,@JsonKey(name: 'prix_jour', fromJson: versInt) int prixJour,@JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable) int? prixJourAvecChauffeur,@JsonKey(name: 'chauffeur_disponible') bool chauffeurDisponible,@JsonKey(name: 'chauffeur_obligatoire') bool chauffeurObligatoire,@JsonKey(fromJson: versIntNullable) int? caution,@JsonKey(name: 'km_inclus_par_jour', fromJson: versInt) int kmInclusParJour,@JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable) int? prixKmSupplementaire,@JsonKey(name: 'carburant_inclus') bool carburantInclus,@JsonKey(name: 'duree_min_jours', fromJson: versInt) int dureeMinJours,@JsonKey(name: 'zone_circulation') String zoneCirculation,@JsonKey(name: 'zone_circulation_libelle') String zoneCirculationLibelle, List<String> equipements, String disponibilite,@JsonKey(name: 'localisation_texte') String localisationTexte,@JsonKey(fromJson: versDoubleNullable) double? latitude,@JsonKey(fromJson: versDoubleNullable) double? longitude, Loueur? loueur,@JsonKey(name: 'autres_vehicules') List<VehiculeResume> autresVehicules,@JsonKey(name: 'periodes_indisponibles') List<PeriodeIndisponible> periodesIndisponibles
});


@override $LoueurCopyWith<$Res>? get loueur;

}
/// @nodoc
class __$VehiculeCopyWithImpl<$Res>
    implements _$VehiculeCopyWith<$Res> {
  __$VehiculeCopyWithImpl(this._self, this._then);

  final _Vehicule _self;
  final $Res Function(_Vehicule) _then;

/// Create a copy of Vehicule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? galerie = null,Object? panoramas = null,Object? categorie = null,Object? categorieLibelle = null,Object? marque = null,Object? modele = null,Object? annee = freezed,Object? couleur = null,Object? nbPlaces = null,Object? boite = null,Object? boiteLibelle = null,Object? carburant = null,Object? carburantLibelle = null,Object? climatisation = null,Object? prixJour = null,Object? prixJourAvecChauffeur = freezed,Object? chauffeurDisponible = null,Object? chauffeurObligatoire = null,Object? caution = freezed,Object? kmInclusParJour = null,Object? prixKmSupplementaire = freezed,Object? carburantInclus = null,Object? dureeMinJours = null,Object? zoneCirculation = null,Object? zoneCirculationLibelle = null,Object? equipements = null,Object? disponibilite = null,Object? localisationTexte = null,Object? latitude = freezed,Object? longitude = freezed,Object? loueur = freezed,Object? autresVehicules = null,Object? periodesIndisponibles = null,}) {
  return _then(_Vehicule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,galerie: null == galerie ? _self._galerie : galerie // ignore: cast_nullable_to_non_nullable
as List<String>,panoramas: null == panoramas ? _self._panoramas : panoramas // ignore: cast_nullable_to_non_nullable
as List<Panorama>,categorie: null == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as String,categorieLibelle: null == categorieLibelle ? _self.categorieLibelle : categorieLibelle // ignore: cast_nullable_to_non_nullable
as String,marque: null == marque ? _self.marque : marque // ignore: cast_nullable_to_non_nullable
as String,modele: null == modele ? _self.modele : modele // ignore: cast_nullable_to_non_nullable
as String,annee: freezed == annee ? _self.annee : annee // ignore: cast_nullable_to_non_nullable
as int?,couleur: null == couleur ? _self.couleur : couleur // ignore: cast_nullable_to_non_nullable
as String,nbPlaces: null == nbPlaces ? _self.nbPlaces : nbPlaces // ignore: cast_nullable_to_non_nullable
as int,boite: null == boite ? _self.boite : boite // ignore: cast_nullable_to_non_nullable
as String,boiteLibelle: null == boiteLibelle ? _self.boiteLibelle : boiteLibelle // ignore: cast_nullable_to_non_nullable
as String,carburant: null == carburant ? _self.carburant : carburant // ignore: cast_nullable_to_non_nullable
as String,carburantLibelle: null == carburantLibelle ? _self.carburantLibelle : carburantLibelle // ignore: cast_nullable_to_non_nullable
as String,climatisation: null == climatisation ? _self.climatisation : climatisation // ignore: cast_nullable_to_non_nullable
as bool,prixJour: null == prixJour ? _self.prixJour : prixJour // ignore: cast_nullable_to_non_nullable
as int,prixJourAvecChauffeur: freezed == prixJourAvecChauffeur ? _self.prixJourAvecChauffeur : prixJourAvecChauffeur // ignore: cast_nullable_to_non_nullable
as int?,chauffeurDisponible: null == chauffeurDisponible ? _self.chauffeurDisponible : chauffeurDisponible // ignore: cast_nullable_to_non_nullable
as bool,chauffeurObligatoire: null == chauffeurObligatoire ? _self.chauffeurObligatoire : chauffeurObligatoire // ignore: cast_nullable_to_non_nullable
as bool,caution: freezed == caution ? _self.caution : caution // ignore: cast_nullable_to_non_nullable
as int?,kmInclusParJour: null == kmInclusParJour ? _self.kmInclusParJour : kmInclusParJour // ignore: cast_nullable_to_non_nullable
as int,prixKmSupplementaire: freezed == prixKmSupplementaire ? _self.prixKmSupplementaire : prixKmSupplementaire // ignore: cast_nullable_to_non_nullable
as int?,carburantInclus: null == carburantInclus ? _self.carburantInclus : carburantInclus // ignore: cast_nullable_to_non_nullable
as bool,dureeMinJours: null == dureeMinJours ? _self.dureeMinJours : dureeMinJours // ignore: cast_nullable_to_non_nullable
as int,zoneCirculation: null == zoneCirculation ? _self.zoneCirculation : zoneCirculation // ignore: cast_nullable_to_non_nullable
as String,zoneCirculationLibelle: null == zoneCirculationLibelle ? _self.zoneCirculationLibelle : zoneCirculationLibelle // ignore: cast_nullable_to_non_nullable
as String,equipements: null == equipements ? _self._equipements : equipements // ignore: cast_nullable_to_non_nullable
as List<String>,disponibilite: null == disponibilite ? _self.disponibilite : disponibilite // ignore: cast_nullable_to_non_nullable
as String,localisationTexte: null == localisationTexte ? _self.localisationTexte : localisationTexte // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,loueur: freezed == loueur ? _self.loueur : loueur // ignore: cast_nullable_to_non_nullable
as Loueur?,autresVehicules: null == autresVehicules ? _self._autresVehicules : autresVehicules // ignore: cast_nullable_to_non_nullable
as List<VehiculeResume>,periodesIndisponibles: null == periodesIndisponibles ? _self._periodesIndisponibles : periodesIndisponibles // ignore: cast_nullable_to_non_nullable
as List<PeriodeIndisponible>,
  ));
}

/// Create a copy of Vehicule
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

// dart format on
