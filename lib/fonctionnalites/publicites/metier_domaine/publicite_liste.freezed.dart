// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publicite_liste.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PubliciteListe {

 String get id; String get titre;@JsonKey(name: 'image_couverture') String? get imageCouverture;@JsonKey(name: 'partenaire_id') int? get partenaireId;@JsonKey(name: 'duree_affichage_secondes') int get dureeAffichageSecondes; int get priorite;
/// Create a copy of PubliciteListe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PubliciteListeCopyWith<PubliciteListe> get copyWith => _$PubliciteListeCopyWithImpl<PubliciteListe>(this as PubliciteListe, _$identity);

  /// Serializes this PubliciteListe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PubliciteListe&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.partenaireId, partenaireId) || other.partenaireId == partenaireId)&&(identical(other.dureeAffichageSecondes, dureeAffichageSecondes) || other.dureeAffichageSecondes == dureeAffichageSecondes)&&(identical(other.priorite, priorite) || other.priorite == priorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,imageCouverture,partenaireId,dureeAffichageSecondes,priorite);

@override
String toString() {
  return 'PubliciteListe(id: $id, titre: $titre, imageCouverture: $imageCouverture, partenaireId: $partenaireId, dureeAffichageSecondes: $dureeAffichageSecondes, priorite: $priorite)';
}


}

/// @nodoc
abstract mixin class $PubliciteListeCopyWith<$Res>  {
  factory $PubliciteListeCopyWith(PubliciteListe value, $Res Function(PubliciteListe) _then) = _$PubliciteListeCopyWithImpl;
@useResult
$Res call({
 String id, String titre,@JsonKey(name: 'image_couverture') String? imageCouverture,@JsonKey(name: 'partenaire_id') int? partenaireId,@JsonKey(name: 'duree_affichage_secondes') int dureeAffichageSecondes, int priorite
});




}
/// @nodoc
class _$PubliciteListeCopyWithImpl<$Res>
    implements $PubliciteListeCopyWith<$Res> {
  _$PubliciteListeCopyWithImpl(this._self, this._then);

  final PubliciteListe _self;
  final $Res Function(PubliciteListe) _then;

/// Create a copy of PubliciteListe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? imageCouverture = freezed,Object? partenaireId = freezed,Object? dureeAffichageSecondes = null,Object? priorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,partenaireId: freezed == partenaireId ? _self.partenaireId : partenaireId // ignore: cast_nullable_to_non_nullable
as int?,dureeAffichageSecondes: null == dureeAffichageSecondes ? _self.dureeAffichageSecondes : dureeAffichageSecondes // ignore: cast_nullable_to_non_nullable
as int,priorite: null == priorite ? _self.priorite : priorite // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PubliciteListe].
extension PubliciteListePatterns on PubliciteListe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PubliciteListe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PubliciteListe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PubliciteListe value)  $default,){
final _that = this;
switch (_that) {
case _PubliciteListe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PubliciteListe value)?  $default,){
final _that = this;
switch (_that) {
case _PubliciteListe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titre, @JsonKey(name: 'image_couverture')  String? imageCouverture, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes,  int priorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PubliciteListe() when $default != null:
return $default(_that.id,_that.titre,_that.imageCouverture,_that.partenaireId,_that.dureeAffichageSecondes,_that.priorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titre, @JsonKey(name: 'image_couverture')  String? imageCouverture, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes,  int priorite)  $default,) {final _that = this;
switch (_that) {
case _PubliciteListe():
return $default(_that.id,_that.titre,_that.imageCouverture,_that.partenaireId,_that.dureeAffichageSecondes,_that.priorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titre, @JsonKey(name: 'image_couverture')  String? imageCouverture, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'duree_affichage_secondes')  int dureeAffichageSecondes,  int priorite)?  $default,) {final _that = this;
switch (_that) {
case _PubliciteListe() when $default != null:
return $default(_that.id,_that.titre,_that.imageCouverture,_that.partenaireId,_that.dureeAffichageSecondes,_that.priorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PubliciteListe extends PubliciteListe {
  const _PubliciteListe({required this.id, this.titre = '', @JsonKey(name: 'image_couverture') this.imageCouverture, @JsonKey(name: 'partenaire_id') this.partenaireId, @JsonKey(name: 'duree_affichage_secondes') this.dureeAffichageSecondes = 5, this.priorite = 0}): super._();
  factory _PubliciteListe.fromJson(Map<String, dynamic> json) => _$PubliciteListeFromJson(json);

@override final  String id;
@override@JsonKey() final  String titre;
@override@JsonKey(name: 'image_couverture') final  String? imageCouverture;
@override@JsonKey(name: 'partenaire_id') final  int? partenaireId;
@override@JsonKey(name: 'duree_affichage_secondes') final  int dureeAffichageSecondes;
@override@JsonKey() final  int priorite;

/// Create a copy of PubliciteListe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PubliciteListeCopyWith<_PubliciteListe> get copyWith => __$PubliciteListeCopyWithImpl<_PubliciteListe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PubliciteListeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PubliciteListe&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.partenaireId, partenaireId) || other.partenaireId == partenaireId)&&(identical(other.dureeAffichageSecondes, dureeAffichageSecondes) || other.dureeAffichageSecondes == dureeAffichageSecondes)&&(identical(other.priorite, priorite) || other.priorite == priorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,imageCouverture,partenaireId,dureeAffichageSecondes,priorite);

@override
String toString() {
  return 'PubliciteListe(id: $id, titre: $titre, imageCouverture: $imageCouverture, partenaireId: $partenaireId, dureeAffichageSecondes: $dureeAffichageSecondes, priorite: $priorite)';
}


}

/// @nodoc
abstract mixin class _$PubliciteListeCopyWith<$Res> implements $PubliciteListeCopyWith<$Res> {
  factory _$PubliciteListeCopyWith(_PubliciteListe value, $Res Function(_PubliciteListe) _then) = __$PubliciteListeCopyWithImpl;
@override @useResult
$Res call({
 String id, String titre,@JsonKey(name: 'image_couverture') String? imageCouverture,@JsonKey(name: 'partenaire_id') int? partenaireId,@JsonKey(name: 'duree_affichage_secondes') int dureeAffichageSecondes, int priorite
});




}
/// @nodoc
class __$PubliciteListeCopyWithImpl<$Res>
    implements _$PubliciteListeCopyWith<$Res> {
  __$PubliciteListeCopyWithImpl(this._self, this._then);

  final _PubliciteListe _self;
  final $Res Function(_PubliciteListe) _then;

/// Create a copy of PubliciteListe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? imageCouverture = freezed,Object? partenaireId = freezed,Object? dureeAffichageSecondes = null,Object? priorite = null,}) {
  return _then(_PubliciteListe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,partenaireId: freezed == partenaireId ? _self.partenaireId : partenaireId // ignore: cast_nullable_to_non_nullable
as int?,dureeAffichageSecondes: null == dureeAffichageSecondes ? _self.dureeAffichageSecondes : dureeAffichageSecondes // ignore: cast_nullable_to_non_nullable
as int,priorite: null == priorite ? _self.priorite : priorite // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
