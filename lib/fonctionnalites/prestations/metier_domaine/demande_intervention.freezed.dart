// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demande_intervention.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoDemande {

 int get id; String get image; String get legende; int get ordre;
/// Create a copy of PhotoDemande
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoDemandeCopyWith<PhotoDemande> get copyWith => _$PhotoDemandeCopyWithImpl<PhotoDemande>(this as PhotoDemande, _$identity);

  /// Serializes this PhotoDemande to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoDemande&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.legende, legende) || other.legende == legende)&&(identical(other.ordre, ordre) || other.ordre == ordre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,legende,ordre);

@override
String toString() {
  return 'PhotoDemande(id: $id, image: $image, legende: $legende, ordre: $ordre)';
}


}

/// @nodoc
abstract mixin class $PhotoDemandeCopyWith<$Res>  {
  factory $PhotoDemandeCopyWith(PhotoDemande value, $Res Function(PhotoDemande) _then) = _$PhotoDemandeCopyWithImpl;
@useResult
$Res call({
 int id, String image, String legende, int ordre
});




}
/// @nodoc
class _$PhotoDemandeCopyWithImpl<$Res>
    implements $PhotoDemandeCopyWith<$Res> {
  _$PhotoDemandeCopyWithImpl(this._self, this._then);

  final PhotoDemande _self;
  final $Res Function(PhotoDemande) _then;

/// Create a copy of PhotoDemande
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = null,Object? legende = null,Object? ordre = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,legende: null == legende ? _self.legende : legende // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoDemande].
extension PhotoDemandePatterns on PhotoDemande {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoDemande value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoDemande() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoDemande value)  $default,){
final _that = this;
switch (_that) {
case _PhotoDemande():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoDemande value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoDemande() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String image,  String legende,  int ordre)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoDemande() when $default != null:
return $default(_that.id,_that.image,_that.legende,_that.ordre);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String image,  String legende,  int ordre)  $default,) {final _that = this;
switch (_that) {
case _PhotoDemande():
return $default(_that.id,_that.image,_that.legende,_that.ordre);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String image,  String legende,  int ordre)?  $default,) {final _that = this;
switch (_that) {
case _PhotoDemande() when $default != null:
return $default(_that.id,_that.image,_that.legende,_that.ordre);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoDemande implements PhotoDemande {
  const _PhotoDemande({required this.id, this.image = '', this.legende = '', this.ordre = 0});
  factory _PhotoDemande.fromJson(Map<String, dynamic> json) => _$PhotoDemandeFromJson(json);

@override final  int id;
@override@JsonKey() final  String image;
@override@JsonKey() final  String legende;
@override@JsonKey() final  int ordre;

/// Create a copy of PhotoDemande
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoDemandeCopyWith<_PhotoDemande> get copyWith => __$PhotoDemandeCopyWithImpl<_PhotoDemande>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoDemandeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoDemande&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.legende, legende) || other.legende == legende)&&(identical(other.ordre, ordre) || other.ordre == ordre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,legende,ordre);

@override
String toString() {
  return 'PhotoDemande(id: $id, image: $image, legende: $legende, ordre: $ordre)';
}


}

/// @nodoc
abstract mixin class _$PhotoDemandeCopyWith<$Res> implements $PhotoDemandeCopyWith<$Res> {
  factory _$PhotoDemandeCopyWith(_PhotoDemande value, $Res Function(_PhotoDemande) _then) = __$PhotoDemandeCopyWithImpl;
@override @useResult
$Res call({
 int id, String image, String legende, int ordre
});




}
/// @nodoc
class __$PhotoDemandeCopyWithImpl<$Res>
    implements _$PhotoDemandeCopyWith<$Res> {
  __$PhotoDemandeCopyWithImpl(this._self, this._then);

  final _PhotoDemande _self;
  final $Res Function(_PhotoDemande) _then;

/// Create a copy of PhotoDemande
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = null,Object? legende = null,Object? ordre = null,}) {
  return _then(_PhotoDemande(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,legende: null == legende ? _self.legende : legende // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DemandeIntervention {

 int get id; String get numero; int? get user;@JsonKey(name: 'client_nom') String get clientNom;@JsonKey(name: 'client_telephone') String get clientTelephone; int? get artisan;@JsonKey(name: 'artisan_nom') String get artisanNom;@JsonKey(name: 'artisan_telephone') String get artisanTelephone;@JsonKey(name: 'type_intervention') String get typeIntervention;@JsonKey(name: 'type_libre') String get typeLibre; String get description; String get urgence; int? get adresse;@JsonKey(name: 'adresse_snapshot') String get adresseSnapshot;@JsonKey(name: 'description_acces') String get descriptionAcces;@JsonKey(fromJson: _versDoubleNullable) double? get latitude;@JsonKey(fromJson: _versDoubleNullable) double? get longitude;@JsonKey(name: 'disponibilite_preferee') String get disponibilitePreferee; String get statut;@JsonKey(name: 'date_proposee') String? get dateProposee;@JsonKey(name: 'prix_propose', fromJson: _versIntNullable) int? get prixPropose;@JsonKey(name: 'raison_refus') String get raisonRefus; int? get conversation; List<PhotoDemande> get photos;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of DemandeIntervention
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemandeInterventionCopyWith<DemandeIntervention> get copyWith => _$DemandeInterventionCopyWithImpl<DemandeIntervention>(this as DemandeIntervention, _$identity);

  /// Serializes this DemandeIntervention to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemandeIntervention&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.user, user) || other.user == user)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.clientTelephone, clientTelephone) || other.clientTelephone == clientTelephone)&&(identical(other.artisan, artisan) || other.artisan == artisan)&&(identical(other.artisanNom, artisanNom) || other.artisanNom == artisanNom)&&(identical(other.artisanTelephone, artisanTelephone) || other.artisanTelephone == artisanTelephone)&&(identical(other.typeIntervention, typeIntervention) || other.typeIntervention == typeIntervention)&&(identical(other.typeLibre, typeLibre) || other.typeLibre == typeLibre)&&(identical(other.description, description) || other.description == description)&&(identical(other.urgence, urgence) || other.urgence == urgence)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.adresseSnapshot, adresseSnapshot) || other.adresseSnapshot == adresseSnapshot)&&(identical(other.descriptionAcces, descriptionAcces) || other.descriptionAcces == descriptionAcces)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.disponibilitePreferee, disponibilitePreferee) || other.disponibilitePreferee == disponibilitePreferee)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.dateProposee, dateProposee) || other.dateProposee == dateProposee)&&(identical(other.prixPropose, prixPropose) || other.prixPropose == prixPropose)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,numero,user,clientNom,clientTelephone,artisan,artisanNom,artisanTelephone,typeIntervention,typeLibre,description,urgence,adresse,adresseSnapshot,descriptionAcces,latitude,longitude,disponibilitePreferee,statut,dateProposee,prixPropose,raisonRefus,conversation,const DeepCollectionEquality().hash(photos),createdAt]);

@override
String toString() {
  return 'DemandeIntervention(id: $id, numero: $numero, user: $user, clientNom: $clientNom, clientTelephone: $clientTelephone, artisan: $artisan, artisanNom: $artisanNom, artisanTelephone: $artisanTelephone, typeIntervention: $typeIntervention, typeLibre: $typeLibre, description: $description, urgence: $urgence, adresse: $adresse, adresseSnapshot: $adresseSnapshot, descriptionAcces: $descriptionAcces, latitude: $latitude, longitude: $longitude, disponibilitePreferee: $disponibilitePreferee, statut: $statut, dateProposee: $dateProposee, prixPropose: $prixPropose, raisonRefus: $raisonRefus, conversation: $conversation, photos: $photos, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DemandeInterventionCopyWith<$Res>  {
  factory $DemandeInterventionCopyWith(DemandeIntervention value, $Res Function(DemandeIntervention) _then) = _$DemandeInterventionCopyWithImpl;
@useResult
$Res call({
 int id, String numero, int? user,@JsonKey(name: 'client_nom') String clientNom,@JsonKey(name: 'client_telephone') String clientTelephone, int? artisan,@JsonKey(name: 'artisan_nom') String artisanNom,@JsonKey(name: 'artisan_telephone') String artisanTelephone,@JsonKey(name: 'type_intervention') String typeIntervention,@JsonKey(name: 'type_libre') String typeLibre, String description, String urgence, int? adresse,@JsonKey(name: 'adresse_snapshot') String adresseSnapshot,@JsonKey(name: 'description_acces') String descriptionAcces,@JsonKey(fromJson: _versDoubleNullable) double? latitude,@JsonKey(fromJson: _versDoubleNullable) double? longitude,@JsonKey(name: 'disponibilite_preferee') String disponibilitePreferee, String statut,@JsonKey(name: 'date_proposee') String? dateProposee,@JsonKey(name: 'prix_propose', fromJson: _versIntNullable) int? prixPropose,@JsonKey(name: 'raison_refus') String raisonRefus, int? conversation, List<PhotoDemande> photos,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$DemandeInterventionCopyWithImpl<$Res>
    implements $DemandeInterventionCopyWith<$Res> {
  _$DemandeInterventionCopyWithImpl(this._self, this._then);

  final DemandeIntervention _self;
  final $Res Function(DemandeIntervention) _then;

/// Create a copy of DemandeIntervention
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? numero = null,Object? user = freezed,Object? clientNom = null,Object? clientTelephone = null,Object? artisan = freezed,Object? artisanNom = null,Object? artisanTelephone = null,Object? typeIntervention = null,Object? typeLibre = null,Object? description = null,Object? urgence = null,Object? adresse = freezed,Object? adresseSnapshot = null,Object? descriptionAcces = null,Object? latitude = freezed,Object? longitude = freezed,Object? disponibilitePreferee = null,Object? statut = null,Object? dateProposee = freezed,Object? prixPropose = freezed,Object? raisonRefus = null,Object? conversation = freezed,Object? photos = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as int?,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,clientTelephone: null == clientTelephone ? _self.clientTelephone : clientTelephone // ignore: cast_nullable_to_non_nullable
as String,artisan: freezed == artisan ? _self.artisan : artisan // ignore: cast_nullable_to_non_nullable
as int?,artisanNom: null == artisanNom ? _self.artisanNom : artisanNom // ignore: cast_nullable_to_non_nullable
as String,artisanTelephone: null == artisanTelephone ? _self.artisanTelephone : artisanTelephone // ignore: cast_nullable_to_non_nullable
as String,typeIntervention: null == typeIntervention ? _self.typeIntervention : typeIntervention // ignore: cast_nullable_to_non_nullable
as String,typeLibre: null == typeLibre ? _self.typeLibre : typeLibre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,urgence: null == urgence ? _self.urgence : urgence // ignore: cast_nullable_to_non_nullable
as String,adresse: freezed == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as int?,adresseSnapshot: null == adresseSnapshot ? _self.adresseSnapshot : adresseSnapshot // ignore: cast_nullable_to_non_nullable
as String,descriptionAcces: null == descriptionAcces ? _self.descriptionAcces : descriptionAcces // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,disponibilitePreferee: null == disponibilitePreferee ? _self.disponibilitePreferee : disponibilitePreferee // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,dateProposee: freezed == dateProposee ? _self.dateProposee : dateProposee // ignore: cast_nullable_to_non_nullable
as String?,prixPropose: freezed == prixPropose ? _self.prixPropose : prixPropose // ignore: cast_nullable_to_non_nullable
as int?,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as int?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoDemande>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DemandeIntervention].
extension DemandeInterventionPatterns on DemandeIntervention {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DemandeIntervention value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DemandeIntervention() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DemandeIntervention value)  $default,){
final _that = this;
switch (_that) {
case _DemandeIntervention():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DemandeIntervention value)?  $default,){
final _that = this;
switch (_that) {
case _DemandeIntervention() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String numero,  int? user, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'client_telephone')  String clientTelephone,  int? artisan, @JsonKey(name: 'artisan_nom')  String artisanNom, @JsonKey(name: 'artisan_telephone')  String artisanTelephone, @JsonKey(name: 'type_intervention')  String typeIntervention, @JsonKey(name: 'type_libre')  String typeLibre,  String description,  String urgence,  int? adresse, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(fromJson: _versDoubleNullable)  double? latitude, @JsonKey(fromJson: _versDoubleNullable)  double? longitude, @JsonKey(name: 'disponibilite_preferee')  String disponibilitePreferee,  String statut, @JsonKey(name: 'date_proposee')  String? dateProposee, @JsonKey(name: 'prix_propose', fromJson: _versIntNullable)  int? prixPropose, @JsonKey(name: 'raison_refus')  String raisonRefus,  int? conversation,  List<PhotoDemande> photos, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DemandeIntervention() when $default != null:
return $default(_that.id,_that.numero,_that.user,_that.clientNom,_that.clientTelephone,_that.artisan,_that.artisanNom,_that.artisanTelephone,_that.typeIntervention,_that.typeLibre,_that.description,_that.urgence,_that.adresse,_that.adresseSnapshot,_that.descriptionAcces,_that.latitude,_that.longitude,_that.disponibilitePreferee,_that.statut,_that.dateProposee,_that.prixPropose,_that.raisonRefus,_that.conversation,_that.photos,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String numero,  int? user, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'client_telephone')  String clientTelephone,  int? artisan, @JsonKey(name: 'artisan_nom')  String artisanNom, @JsonKey(name: 'artisan_telephone')  String artisanTelephone, @JsonKey(name: 'type_intervention')  String typeIntervention, @JsonKey(name: 'type_libre')  String typeLibre,  String description,  String urgence,  int? adresse, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(fromJson: _versDoubleNullable)  double? latitude, @JsonKey(fromJson: _versDoubleNullable)  double? longitude, @JsonKey(name: 'disponibilite_preferee')  String disponibilitePreferee,  String statut, @JsonKey(name: 'date_proposee')  String? dateProposee, @JsonKey(name: 'prix_propose', fromJson: _versIntNullable)  int? prixPropose, @JsonKey(name: 'raison_refus')  String raisonRefus,  int? conversation,  List<PhotoDemande> photos, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _DemandeIntervention():
return $default(_that.id,_that.numero,_that.user,_that.clientNom,_that.clientTelephone,_that.artisan,_that.artisanNom,_that.artisanTelephone,_that.typeIntervention,_that.typeLibre,_that.description,_that.urgence,_that.adresse,_that.adresseSnapshot,_that.descriptionAcces,_that.latitude,_that.longitude,_that.disponibilitePreferee,_that.statut,_that.dateProposee,_that.prixPropose,_that.raisonRefus,_that.conversation,_that.photos,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String numero,  int? user, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'client_telephone')  String clientTelephone,  int? artisan, @JsonKey(name: 'artisan_nom')  String artisanNom, @JsonKey(name: 'artisan_telephone')  String artisanTelephone, @JsonKey(name: 'type_intervention')  String typeIntervention, @JsonKey(name: 'type_libre')  String typeLibre,  String description,  String urgence,  int? adresse, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot, @JsonKey(name: 'description_acces')  String descriptionAcces, @JsonKey(fromJson: _versDoubleNullable)  double? latitude, @JsonKey(fromJson: _versDoubleNullable)  double? longitude, @JsonKey(name: 'disponibilite_preferee')  String disponibilitePreferee,  String statut, @JsonKey(name: 'date_proposee')  String? dateProposee, @JsonKey(name: 'prix_propose', fromJson: _versIntNullable)  int? prixPropose, @JsonKey(name: 'raison_refus')  String raisonRefus,  int? conversation,  List<PhotoDemande> photos, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DemandeIntervention() when $default != null:
return $default(_that.id,_that.numero,_that.user,_that.clientNom,_that.clientTelephone,_that.artisan,_that.artisanNom,_that.artisanTelephone,_that.typeIntervention,_that.typeLibre,_that.description,_that.urgence,_that.adresse,_that.adresseSnapshot,_that.descriptionAcces,_that.latitude,_that.longitude,_that.disponibilitePreferee,_that.statut,_that.dateProposee,_that.prixPropose,_that.raisonRefus,_that.conversation,_that.photos,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DemandeIntervention extends DemandeIntervention {
  const _DemandeIntervention({required this.id, this.numero = '', this.user, @JsonKey(name: 'client_nom') this.clientNom = '', @JsonKey(name: 'client_telephone') this.clientTelephone = '', this.artisan, @JsonKey(name: 'artisan_nom') this.artisanNom = '', @JsonKey(name: 'artisan_telephone') this.artisanTelephone = '', @JsonKey(name: 'type_intervention') this.typeIntervention = 'reparation', @JsonKey(name: 'type_libre') this.typeLibre = '', this.description = '', this.urgence = 'flexible', this.adresse, @JsonKey(name: 'adresse_snapshot') this.adresseSnapshot = '', @JsonKey(name: 'description_acces') this.descriptionAcces = '', @JsonKey(fromJson: _versDoubleNullable) this.latitude, @JsonKey(fromJson: _versDoubleNullable) this.longitude, @JsonKey(name: 'disponibilite_preferee') this.disponibilitePreferee = 'indifferent', this.statut = 'en_attente', @JsonKey(name: 'date_proposee') this.dateProposee, @JsonKey(name: 'prix_propose', fromJson: _versIntNullable) this.prixPropose, @JsonKey(name: 'raison_refus') this.raisonRefus = '', this.conversation, final  List<PhotoDemande> photos = const <PhotoDemande>[], @JsonKey(name: 'created_at') this.createdAt = ''}): _photos = photos,super._();
  factory _DemandeIntervention.fromJson(Map<String, dynamic> json) => _$DemandeInterventionFromJson(json);

@override final  int id;
@override@JsonKey() final  String numero;
@override final  int? user;
@override@JsonKey(name: 'client_nom') final  String clientNom;
@override@JsonKey(name: 'client_telephone') final  String clientTelephone;
@override final  int? artisan;
@override@JsonKey(name: 'artisan_nom') final  String artisanNom;
@override@JsonKey(name: 'artisan_telephone') final  String artisanTelephone;
@override@JsonKey(name: 'type_intervention') final  String typeIntervention;
@override@JsonKey(name: 'type_libre') final  String typeLibre;
@override@JsonKey() final  String description;
@override@JsonKey() final  String urgence;
@override final  int? adresse;
@override@JsonKey(name: 'adresse_snapshot') final  String adresseSnapshot;
@override@JsonKey(name: 'description_acces') final  String descriptionAcces;
@override@JsonKey(fromJson: _versDoubleNullable) final  double? latitude;
@override@JsonKey(fromJson: _versDoubleNullable) final  double? longitude;
@override@JsonKey(name: 'disponibilite_preferee') final  String disponibilitePreferee;
@override@JsonKey() final  String statut;
@override@JsonKey(name: 'date_proposee') final  String? dateProposee;
@override@JsonKey(name: 'prix_propose', fromJson: _versIntNullable) final  int? prixPropose;
@override@JsonKey(name: 'raison_refus') final  String raisonRefus;
@override final  int? conversation;
 final  List<PhotoDemande> _photos;
@override@JsonKey() List<PhotoDemande> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of DemandeIntervention
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DemandeInterventionCopyWith<_DemandeIntervention> get copyWith => __$DemandeInterventionCopyWithImpl<_DemandeIntervention>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DemandeInterventionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DemandeIntervention&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.user, user) || other.user == user)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.clientTelephone, clientTelephone) || other.clientTelephone == clientTelephone)&&(identical(other.artisan, artisan) || other.artisan == artisan)&&(identical(other.artisanNom, artisanNom) || other.artisanNom == artisanNom)&&(identical(other.artisanTelephone, artisanTelephone) || other.artisanTelephone == artisanTelephone)&&(identical(other.typeIntervention, typeIntervention) || other.typeIntervention == typeIntervention)&&(identical(other.typeLibre, typeLibre) || other.typeLibre == typeLibre)&&(identical(other.description, description) || other.description == description)&&(identical(other.urgence, urgence) || other.urgence == urgence)&&(identical(other.adresse, adresse) || other.adresse == adresse)&&(identical(other.adresseSnapshot, adresseSnapshot) || other.adresseSnapshot == adresseSnapshot)&&(identical(other.descriptionAcces, descriptionAcces) || other.descriptionAcces == descriptionAcces)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.disponibilitePreferee, disponibilitePreferee) || other.disponibilitePreferee == disponibilitePreferee)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.dateProposee, dateProposee) || other.dateProposee == dateProposee)&&(identical(other.prixPropose, prixPropose) || other.prixPropose == prixPropose)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,numero,user,clientNom,clientTelephone,artisan,artisanNom,artisanTelephone,typeIntervention,typeLibre,description,urgence,adresse,adresseSnapshot,descriptionAcces,latitude,longitude,disponibilitePreferee,statut,dateProposee,prixPropose,raisonRefus,conversation,const DeepCollectionEquality().hash(_photos),createdAt]);

@override
String toString() {
  return 'DemandeIntervention(id: $id, numero: $numero, user: $user, clientNom: $clientNom, clientTelephone: $clientTelephone, artisan: $artisan, artisanNom: $artisanNom, artisanTelephone: $artisanTelephone, typeIntervention: $typeIntervention, typeLibre: $typeLibre, description: $description, urgence: $urgence, adresse: $adresse, adresseSnapshot: $adresseSnapshot, descriptionAcces: $descriptionAcces, latitude: $latitude, longitude: $longitude, disponibilitePreferee: $disponibilitePreferee, statut: $statut, dateProposee: $dateProposee, prixPropose: $prixPropose, raisonRefus: $raisonRefus, conversation: $conversation, photos: $photos, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DemandeInterventionCopyWith<$Res> implements $DemandeInterventionCopyWith<$Res> {
  factory _$DemandeInterventionCopyWith(_DemandeIntervention value, $Res Function(_DemandeIntervention) _then) = __$DemandeInterventionCopyWithImpl;
@override @useResult
$Res call({
 int id, String numero, int? user,@JsonKey(name: 'client_nom') String clientNom,@JsonKey(name: 'client_telephone') String clientTelephone, int? artisan,@JsonKey(name: 'artisan_nom') String artisanNom,@JsonKey(name: 'artisan_telephone') String artisanTelephone,@JsonKey(name: 'type_intervention') String typeIntervention,@JsonKey(name: 'type_libre') String typeLibre, String description, String urgence, int? adresse,@JsonKey(name: 'adresse_snapshot') String adresseSnapshot,@JsonKey(name: 'description_acces') String descriptionAcces,@JsonKey(fromJson: _versDoubleNullable) double? latitude,@JsonKey(fromJson: _versDoubleNullable) double? longitude,@JsonKey(name: 'disponibilite_preferee') String disponibilitePreferee, String statut,@JsonKey(name: 'date_proposee') String? dateProposee,@JsonKey(name: 'prix_propose', fromJson: _versIntNullable) int? prixPropose,@JsonKey(name: 'raison_refus') String raisonRefus, int? conversation, List<PhotoDemande> photos,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$DemandeInterventionCopyWithImpl<$Res>
    implements _$DemandeInterventionCopyWith<$Res> {
  __$DemandeInterventionCopyWithImpl(this._self, this._then);

  final _DemandeIntervention _self;
  final $Res Function(_DemandeIntervention) _then;

/// Create a copy of DemandeIntervention
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? numero = null,Object? user = freezed,Object? clientNom = null,Object? clientTelephone = null,Object? artisan = freezed,Object? artisanNom = null,Object? artisanTelephone = null,Object? typeIntervention = null,Object? typeLibre = null,Object? description = null,Object? urgence = null,Object? adresse = freezed,Object? adresseSnapshot = null,Object? descriptionAcces = null,Object? latitude = freezed,Object? longitude = freezed,Object? disponibilitePreferee = null,Object? statut = null,Object? dateProposee = freezed,Object? prixPropose = freezed,Object? raisonRefus = null,Object? conversation = freezed,Object? photos = null,Object? createdAt = null,}) {
  return _then(_DemandeIntervention(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as int?,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,clientTelephone: null == clientTelephone ? _self.clientTelephone : clientTelephone // ignore: cast_nullable_to_non_nullable
as String,artisan: freezed == artisan ? _self.artisan : artisan // ignore: cast_nullable_to_non_nullable
as int?,artisanNom: null == artisanNom ? _self.artisanNom : artisanNom // ignore: cast_nullable_to_non_nullable
as String,artisanTelephone: null == artisanTelephone ? _self.artisanTelephone : artisanTelephone // ignore: cast_nullable_to_non_nullable
as String,typeIntervention: null == typeIntervention ? _self.typeIntervention : typeIntervention // ignore: cast_nullable_to_non_nullable
as String,typeLibre: null == typeLibre ? _self.typeLibre : typeLibre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,urgence: null == urgence ? _self.urgence : urgence // ignore: cast_nullable_to_non_nullable
as String,adresse: freezed == adresse ? _self.adresse : adresse // ignore: cast_nullable_to_non_nullable
as int?,adresseSnapshot: null == adresseSnapshot ? _self.adresseSnapshot : adresseSnapshot // ignore: cast_nullable_to_non_nullable
as String,descriptionAcces: null == descriptionAcces ? _self.descriptionAcces : descriptionAcces // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,disponibilitePreferee: null == disponibilitePreferee ? _self.disponibilitePreferee : disponibilitePreferee // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,dateProposee: freezed == dateProposee ? _self.dateProposee : dateProposee // ignore: cast_nullable_to_non_nullable
as String?,prixPropose: freezed == prixPropose ? _self.prixPropose : prixPropose // ignore: cast_nullable_to_non_nullable
as int?,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as int?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoDemande>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
