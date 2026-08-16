// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formule_publicite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormulePublicite {

 String get id; String get nom; int get prix; int get priorite;@JsonKey(name: 'duree_jours') int get dureeJours;@JsonKey(name: 'passages_par_jour') int get passagesParJour;@JsonKey(name: 'duree_affichage_secondes') int get dureeAffichageSecondes;@JsonKey(name: 'quota_partenaires') int get quotaPartenaires;@JsonKey(name: 'acces_heures_affluence') bool get accesHeuresAffluence;@JsonKey(name: 'types_affichage') List<String> get typesAffichage;@JsonKey(name: 'nb_images_max') int get nbImagesMax;@JsonKey(name: 'video_autorisee') bool get videoAutorisee;@JsonKey(name: 'duree_video_max_secondes') int get dureeVideoMaxSecondes;@JsonKey(name: 'cible_pourcentage_actifs') int? get ciblePourcentageActifs;
/// Create a copy of FormulePublicite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormulePubliciteCopyWith<FormulePublicite> get copyWith => _$FormulePubliciteCopyWithImpl<FormulePublicite>(this as FormulePublicite, _$identity);

  /// Serializes this FormulePublicite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormulePublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.priorite, priorite) || other.priorite == priorite)&&(identical(other.dureeJours, dureeJours) || other.dureeJours == dureeJours)&&(identical(other.passagesParJour, passagesParJour) || other.passagesParJour == passagesParJour)&&(identical(other.dureeAffichageSecondes, dureeAffichageSecondes) || other.dureeAffichageSecondes == dureeAffichageSecondes)&&(identical(other.quotaPartenaires, quotaPartenaires) || other.quotaPartenaires == quotaPartenaires)&&(identical(other.accesHeuresAffluence, accesHeuresAffluence) || other.accesHeuresAffluence == accesHeuresAffluence)&&const DeepCollectionEquality().equals(other.typesAffichage, typesAffichage)&&(identical(other.nbImagesMax, nbImagesMax) || other.nbImagesMax == nbImagesMax)&&(identical(other.videoAutorisee, videoAutorisee) || other.videoAutorisee == videoAutorisee)&&(identical(other.dureeVideoMaxSecondes, dureeVideoMaxSecondes) || other.dureeVideoMaxSecondes == dureeVideoMaxSecondes)&&(identical(other.ciblePourcentageActifs, ciblePourcentageActifs) || other.ciblePourcentageActifs == ciblePourcentageActifs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix,priorite,dureeJours,passagesParJour,dureeAffichageSecondes,quotaPartenaires,accesHeuresAffluence,const DeepCollectionEquality().hash(typesAffichage),nbImagesMax,videoAutorisee,dureeVideoMaxSecondes,ciblePourcentageActifs);

@override
String toString() {
  return 'FormulePublicite(id: $id, nom: $nom, prix: $prix, priorite: $priorite, dureeJours: $dureeJours, passagesParJour: $passagesParJour, dureeAffichageSecondes: $dureeAffichageSecondes, quotaPartenaires: $quotaPartenaires, accesHeuresAffluence: $accesHeuresAffluence, typesAffichage: $typesAffichage, nbImagesMax: $nbImagesMax, videoAutorisee: $videoAutorisee, dureeVideoMaxSecondes: $dureeVideoMaxSecondes, ciblePourcentageActifs: $ciblePourcentageActifs)';
}


}

/// @nodoc
abstract mixin class $FormulePubliciteCopyWith<$Res>  {
  factory $FormulePubliciteCopyWith(FormulePublicite value, $Res Function(FormulePublicite) _then) = _$FormulePubliciteCopyWithImpl;
@useResult
$Res call({
 String id, String nom, int prix, int priorite,@JsonKey(name: 'duree_jours') int dureeJours,@JsonKey(name: 'passages_par_jour') int passagesParJour,@JsonKey(name: 'duree_affichage_secondes') int dureeAffichageSecondes,@JsonKey(name: 'quota_partenaires') int quotaPartenaires,@JsonKey(name: 'acces_heures_affluence') bool accesHeuresAffluence,@JsonKey(name: 'types_affichage') List<String> typesAffichage,@JsonKey(name: 'nb_images_max') int nbImagesMax,@JsonKey(name: 'video_autorisee') bool videoAutorisee,@JsonKey(name: 'duree_video_max_secondes') int dureeVideoMaxSecondes,@JsonKey(name: 'cible_pourcentage_actifs') int? ciblePourcentageActifs
});




}
/// @nodoc
class _$FormulePubliciteCopyWithImpl<$Res>
    implements $FormulePubliciteCopyWith<$Res> {
  _$FormulePubliciteCopyWithImpl(this._self, this._then);

  final FormulePublicite _self;
  final $Res Function(FormulePublicite) _then;

/// Create a copy of FormulePublicite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prix = null,Object? priorite = null,Object? dureeJours = null,Object? passagesParJour = null,Object? dureeAffichageSecondes = null,Object? quotaPartenaires = null,Object? accesHeuresAffluence = null,Object? typesAffichage = null,Object? nbImagesMax = null,Object? videoAutorisee = null,Object? dureeVideoMaxSecondes = null,Object? ciblePourcentageActifs = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,priorite: null == priorite ? _self.priorite : priorite // ignore: cast_nullable_to_non_nullable
as int,dureeJours: null == dureeJours ? _self.dureeJours : dureeJours // ignore: cast_nullable_to_non_nullable
as int,passagesParJour: null == passagesParJour ? _self.passagesParJour : passagesParJour // ignore: cast_nullable_to_non_nullable
as int,dureeAffichageSecondes: null == dureeAffichageSecondes ? _self.dureeAffichageSecondes : dureeAffichageSecondes // ignore: cast_nullable_to_non_nullable
as int,quotaPartenaires: null == quotaPartenaires ? _self.quotaPartenaires : quotaPartenaires // ignore: cast_nullable_to_non_nullable
as int,accesHeuresAffluence: null == accesHeuresAffluence ? _self.accesHeuresAffluence : accesHeuresAffluence // ignore: cast_nullable_to_non_nullable
as bool,typesAffichage: null == typesAffichage ? _self.typesAffichage : typesAffichage // ignore: cast_nullable_to_non_nullable
as List<String>,nbImagesMax: null == nbImagesMax ? _self.nbImagesMax : nbImagesMax // ignore: cast_nullable_to_non_nullable
as int,videoAutorisee: null == videoAutorisee ? _self.videoAutorisee : videoAutorisee // ignore: cast_nullable_to_non_nullable
as bool,dureeVideoMaxSecondes: null == dureeVideoMaxSecondes ? _self.dureeVideoMaxSecondes : dureeVideoMaxSecondes // ignore: cast_nullable_to_non_nullable
as int,ciblePourcentageActifs: freezed == ciblePourcentageActifs ? _self.ciblePourcentageActifs : ciblePourcentageActifs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormulePublicite].
extension FormulePublicitePatterns on FormulePublicite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormulePublicite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormulePublicite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormulePublicite value)  $default,){
final _that = this;
switch (_that) {
case _FormulePublicite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormulePublicite value)?  $default,){
final _that = this;
switch (_that) {
case _FormulePublicite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nom,  int prix,  int priorite, @JsonKey(name: 'duree_jours')  int dureeJours, @JsonKey(name: 'passages_par_jour')  int passagesParJour, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes, @JsonKey(name: 'quota_partenaires')  int quotaPartenaires, @JsonKey(name: 'acces_heures_affluence')  bool accesHeuresAffluence, @JsonKey(name: 'types_affichage')  List<String> typesAffichage, @JsonKey(name: 'nb_images_max')  int nbImagesMax, @JsonKey(name: 'video_autorisee')  bool videoAutorisee, @JsonKey(name: 'duree_video_max_secondes')  int dureeVideoMaxSecondes, @JsonKey(name: 'cible_pourcentage_actifs')  int? ciblePourcentageActifs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormulePublicite() when $default != null:
return $default(_that.id,_that.nom,_that.prix,_that.priorite,_that.dureeJours,_that.passagesParJour,_that.dureeAffichageSecondes,_that.quotaPartenaires,_that.accesHeuresAffluence,_that.typesAffichage,_that.nbImagesMax,_that.videoAutorisee,_that.dureeVideoMaxSecondes,_that.ciblePourcentageActifs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nom,  int prix,  int priorite, @JsonKey(name: 'duree_jours')  int dureeJours, @JsonKey(name: 'passages_par_jour')  int passagesParJour, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes, @JsonKey(name: 'quota_partenaires')  int quotaPartenaires, @JsonKey(name: 'acces_heures_affluence')  bool accesHeuresAffluence, @JsonKey(name: 'types_affichage')  List<String> typesAffichage, @JsonKey(name: 'nb_images_max')  int nbImagesMax, @JsonKey(name: 'video_autorisee')  bool videoAutorisee, @JsonKey(name: 'duree_video_max_secondes')  int dureeVideoMaxSecondes, @JsonKey(name: 'cible_pourcentage_actifs')  int? ciblePourcentageActifs)  $default,) {final _that = this;
switch (_that) {
case _FormulePublicite():
return $default(_that.id,_that.nom,_that.prix,_that.priorite,_that.dureeJours,_that.passagesParJour,_that.dureeAffichageSecondes,_that.quotaPartenaires,_that.accesHeuresAffluence,_that.typesAffichage,_that.nbImagesMax,_that.videoAutorisee,_that.dureeVideoMaxSecondes,_that.ciblePourcentageActifs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nom,  int prix,  int priorite, @JsonKey(name: 'duree_jours')  int dureeJours, @JsonKey(name: 'passages_par_jour')  int passagesParJour, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes, @JsonKey(name: 'quota_partenaires')  int quotaPartenaires, @JsonKey(name: 'acces_heures_affluence')  bool accesHeuresAffluence, @JsonKey(name: 'types_affichage')  List<String> typesAffichage, @JsonKey(name: 'nb_images_max')  int nbImagesMax, @JsonKey(name: 'video_autorisee')  bool videoAutorisee, @JsonKey(name: 'duree_video_max_secondes')  int dureeVideoMaxSecondes, @JsonKey(name: 'cible_pourcentage_actifs')  int? ciblePourcentageActifs)?  $default,) {final _that = this;
switch (_that) {
case _FormulePublicite() when $default != null:
return $default(_that.id,_that.nom,_that.prix,_that.priorite,_that.dureeJours,_that.passagesParJour,_that.dureeAffichageSecondes,_that.quotaPartenaires,_that.accesHeuresAffluence,_that.typesAffichage,_that.nbImagesMax,_that.videoAutorisee,_that.dureeVideoMaxSecondes,_that.ciblePourcentageActifs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormulePublicite extends FormulePublicite {
  const _FormulePublicite({required this.id, this.nom = '', this.prix = 0, this.priorite = 0, @JsonKey(name: 'duree_jours') this.dureeJours = 1, @JsonKey(name: 'passages_par_jour') this.passagesParJour = 1, @JsonKey(name: 'duree_affichage_secondes') this.dureeAffichageSecondes = 5, @JsonKey(name: 'quota_partenaires') this.quotaPartenaires = 50, @JsonKey(name: 'acces_heures_affluence') this.accesHeuresAffluence = false, @JsonKey(name: 'types_affichage') final  List<String> typesAffichage = const <String>[], @JsonKey(name: 'nb_images_max') this.nbImagesMax = 1, @JsonKey(name: 'video_autorisee') this.videoAutorisee = false, @JsonKey(name: 'duree_video_max_secondes') this.dureeVideoMaxSecondes = 30, @JsonKey(name: 'cible_pourcentage_actifs') this.ciblePourcentageActifs}): _typesAffichage = typesAffichage,super._();
  factory _FormulePublicite.fromJson(Map<String, dynamic> json) => _$FormulePubliciteFromJson(json);

@override final  String id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  int prix;
@override@JsonKey() final  int priorite;
@override@JsonKey(name: 'duree_jours') final  int dureeJours;
@override@JsonKey(name: 'passages_par_jour') final  int passagesParJour;
@override@JsonKey(name: 'duree_affichage_secondes') final  int dureeAffichageSecondes;
@override@JsonKey(name: 'quota_partenaires') final  int quotaPartenaires;
@override@JsonKey(name: 'acces_heures_affluence') final  bool accesHeuresAffluence;
 final  List<String> _typesAffichage;
@override@JsonKey(name: 'types_affichage') List<String> get typesAffichage {
  if (_typesAffichage is EqualUnmodifiableListView) return _typesAffichage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_typesAffichage);
}

@override@JsonKey(name: 'nb_images_max') final  int nbImagesMax;
@override@JsonKey(name: 'video_autorisee') final  bool videoAutorisee;
@override@JsonKey(name: 'duree_video_max_secondes') final  int dureeVideoMaxSecondes;
@override@JsonKey(name: 'cible_pourcentage_actifs') final  int? ciblePourcentageActifs;

/// Create a copy of FormulePublicite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormulePubliciteCopyWith<_FormulePublicite> get copyWith => __$FormulePubliciteCopyWithImpl<_FormulePublicite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormulePubliciteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormulePublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.priorite, priorite) || other.priorite == priorite)&&(identical(other.dureeJours, dureeJours) || other.dureeJours == dureeJours)&&(identical(other.passagesParJour, passagesParJour) || other.passagesParJour == passagesParJour)&&(identical(other.dureeAffichageSecondes, dureeAffichageSecondes) || other.dureeAffichageSecondes == dureeAffichageSecondes)&&(identical(other.quotaPartenaires, quotaPartenaires) || other.quotaPartenaires == quotaPartenaires)&&(identical(other.accesHeuresAffluence, accesHeuresAffluence) || other.accesHeuresAffluence == accesHeuresAffluence)&&const DeepCollectionEquality().equals(other._typesAffichage, _typesAffichage)&&(identical(other.nbImagesMax, nbImagesMax) || other.nbImagesMax == nbImagesMax)&&(identical(other.videoAutorisee, videoAutorisee) || other.videoAutorisee == videoAutorisee)&&(identical(other.dureeVideoMaxSecondes, dureeVideoMaxSecondes) || other.dureeVideoMaxSecondes == dureeVideoMaxSecondes)&&(identical(other.ciblePourcentageActifs, ciblePourcentageActifs) || other.ciblePourcentageActifs == ciblePourcentageActifs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix,priorite,dureeJours,passagesParJour,dureeAffichageSecondes,quotaPartenaires,accesHeuresAffluence,const DeepCollectionEquality().hash(_typesAffichage),nbImagesMax,videoAutorisee,dureeVideoMaxSecondes,ciblePourcentageActifs);

@override
String toString() {
  return 'FormulePublicite(id: $id, nom: $nom, prix: $prix, priorite: $priorite, dureeJours: $dureeJours, passagesParJour: $passagesParJour, dureeAffichageSecondes: $dureeAffichageSecondes, quotaPartenaires: $quotaPartenaires, accesHeuresAffluence: $accesHeuresAffluence, typesAffichage: $typesAffichage, nbImagesMax: $nbImagesMax, videoAutorisee: $videoAutorisee, dureeVideoMaxSecondes: $dureeVideoMaxSecondes, ciblePourcentageActifs: $ciblePourcentageActifs)';
}


}

/// @nodoc
abstract mixin class _$FormulePubliciteCopyWith<$Res> implements $FormulePubliciteCopyWith<$Res> {
  factory _$FormulePubliciteCopyWith(_FormulePublicite value, $Res Function(_FormulePublicite) _then) = __$FormulePubliciteCopyWithImpl;
@override @useResult
$Res call({
 String id, String nom, int prix, int priorite,@JsonKey(name: 'duree_jours') int dureeJours,@JsonKey(name: 'passages_par_jour') int passagesParJour,@JsonKey(name: 'duree_affichage_secondes') int dureeAffichageSecondes,@JsonKey(name: 'quota_partenaires') int quotaPartenaires,@JsonKey(name: 'acces_heures_affluence') bool accesHeuresAffluence,@JsonKey(name: 'types_affichage') List<String> typesAffichage,@JsonKey(name: 'nb_images_max') int nbImagesMax,@JsonKey(name: 'video_autorisee') bool videoAutorisee,@JsonKey(name: 'duree_video_max_secondes') int dureeVideoMaxSecondes,@JsonKey(name: 'cible_pourcentage_actifs') int? ciblePourcentageActifs
});




}
/// @nodoc
class __$FormulePubliciteCopyWithImpl<$Res>
    implements _$FormulePubliciteCopyWith<$Res> {
  __$FormulePubliciteCopyWithImpl(this._self, this._then);

  final _FormulePublicite _self;
  final $Res Function(_FormulePublicite) _then;

/// Create a copy of FormulePublicite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prix = null,Object? priorite = null,Object? dureeJours = null,Object? passagesParJour = null,Object? dureeAffichageSecondes = null,Object? quotaPartenaires = null,Object? accesHeuresAffluence = null,Object? typesAffichage = null,Object? nbImagesMax = null,Object? videoAutorisee = null,Object? dureeVideoMaxSecondes = null,Object? ciblePourcentageActifs = freezed,}) {
  return _then(_FormulePublicite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,priorite: null == priorite ? _self.priorite : priorite // ignore: cast_nullable_to_non_nullable
as int,dureeJours: null == dureeJours ? _self.dureeJours : dureeJours // ignore: cast_nullable_to_non_nullable
as int,passagesParJour: null == passagesParJour ? _self.passagesParJour : passagesParJour // ignore: cast_nullable_to_non_nullable
as int,dureeAffichageSecondes: null == dureeAffichageSecondes ? _self.dureeAffichageSecondes : dureeAffichageSecondes // ignore: cast_nullable_to_non_nullable
as int,quotaPartenaires: null == quotaPartenaires ? _self.quotaPartenaires : quotaPartenaires // ignore: cast_nullable_to_non_nullable
as int,accesHeuresAffluence: null == accesHeuresAffluence ? _self.accesHeuresAffluence : accesHeuresAffluence // ignore: cast_nullable_to_non_nullable
as bool,typesAffichage: null == typesAffichage ? _self._typesAffichage : typesAffichage // ignore: cast_nullable_to_non_nullable
as List<String>,nbImagesMax: null == nbImagesMax ? _self.nbImagesMax : nbImagesMax // ignore: cast_nullable_to_non_nullable
as int,videoAutorisee: null == videoAutorisee ? _self.videoAutorisee : videoAutorisee // ignore: cast_nullable_to_non_nullable
as bool,dureeVideoMaxSecondes: null == dureeVideoMaxSecondes ? _self.dureeVideoMaxSecondes : dureeVideoMaxSecondes // ignore: cast_nullable_to_non_nullable
as int,ciblePourcentageActifs: freezed == ciblePourcentageActifs ? _self.ciblePourcentageActifs : ciblePourcentageActifs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
