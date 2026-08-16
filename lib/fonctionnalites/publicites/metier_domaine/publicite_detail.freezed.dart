// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publicite_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImagePublicite {

 String get id; String? get image; int get ordre;
/// Create a copy of ImagePublicite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImagePubliciteCopyWith<ImagePublicite> get copyWith => _$ImagePubliciteCopyWithImpl<ImagePublicite>(this as ImagePublicite, _$identity);

  /// Serializes this ImagePublicite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImagePublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.ordre, ordre) || other.ordre == ordre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,ordre);

@override
String toString() {
  return 'ImagePublicite(id: $id, image: $image, ordre: $ordre)';
}


}

/// @nodoc
abstract mixin class $ImagePubliciteCopyWith<$Res>  {
  factory $ImagePubliciteCopyWith(ImagePublicite value, $Res Function(ImagePublicite) _then) = _$ImagePubliciteCopyWithImpl;
@useResult
$Res call({
 String id, String? image, int ordre
});




}
/// @nodoc
class _$ImagePubliciteCopyWithImpl<$Res>
    implements $ImagePubliciteCopyWith<$Res> {
  _$ImagePubliciteCopyWithImpl(this._self, this._then);

  final ImagePublicite _self;
  final $Res Function(ImagePublicite) _then;

/// Create a copy of ImagePublicite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = freezed,Object? ordre = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ImagePublicite].
extension ImagePublicitePatterns on ImagePublicite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImagePublicite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImagePublicite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImagePublicite value)  $default,){
final _that = this;
switch (_that) {
case _ImagePublicite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImagePublicite value)?  $default,){
final _that = this;
switch (_that) {
case _ImagePublicite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? image,  int ordre)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImagePublicite() when $default != null:
return $default(_that.id,_that.image,_that.ordre);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? image,  int ordre)  $default,) {final _that = this;
switch (_that) {
case _ImagePublicite():
return $default(_that.id,_that.image,_that.ordre);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? image,  int ordre)?  $default,) {final _that = this;
switch (_that) {
case _ImagePublicite() when $default != null:
return $default(_that.id,_that.image,_that.ordre);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImagePublicite implements ImagePublicite {
  const _ImagePublicite({required this.id, this.image, this.ordre = 0});
  factory _ImagePublicite.fromJson(Map<String, dynamic> json) => _$ImagePubliciteFromJson(json);

@override final  String id;
@override final  String? image;
@override@JsonKey() final  int ordre;

/// Create a copy of ImagePublicite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImagePubliciteCopyWith<_ImagePublicite> get copyWith => __$ImagePubliciteCopyWithImpl<_ImagePublicite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImagePubliciteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImagePublicite&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.ordre, ordre) || other.ordre == ordre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,ordre);

@override
String toString() {
  return 'ImagePublicite(id: $id, image: $image, ordre: $ordre)';
}


}

/// @nodoc
abstract mixin class _$ImagePubliciteCopyWith<$Res> implements $ImagePubliciteCopyWith<$Res> {
  factory _$ImagePubliciteCopyWith(_ImagePublicite value, $Res Function(_ImagePublicite) _then) = __$ImagePubliciteCopyWithImpl;
@override @useResult
$Res call({
 String id, String? image, int ordre
});




}
/// @nodoc
class __$ImagePubliciteCopyWithImpl<$Res>
    implements _$ImagePubliciteCopyWith<$Res> {
  __$ImagePubliciteCopyWithImpl(this._self, this._then);

  final _ImagePublicite _self;
  final $Res Function(_ImagePublicite) _then;

/// Create a copy of ImagePublicite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = freezed,Object? ordre = null,}) {
  return _then(_ImagePublicite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PubliciteDetail {

 String get id; String get titre; String get description;@JsonKey(name: 'image_couverture') String? get imageCouverture; String? get video; List<ImagePublicite> get images;@JsonKey(name: 'partenaire_id') int? get partenaireId;@JsonKey(name: 'nom_partenaire') String get nomPartenaire; String get portee;@JsonKey(name: 'portee_effective') String get porteeEffective;
/// Create a copy of PubliciteDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PubliciteDetailCopyWith<PubliciteDetail> get copyWith => _$PubliciteDetailCopyWithImpl<PubliciteDetail>(this as PubliciteDetail, _$identity);

  /// Serializes this PubliciteDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PubliciteDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.video, video) || other.video == video)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.partenaireId, partenaireId) || other.partenaireId == partenaireId)&&(identical(other.nomPartenaire, nomPartenaire) || other.nomPartenaire == nomPartenaire)&&(identical(other.portee, portee) || other.portee == portee)&&(identical(other.porteeEffective, porteeEffective) || other.porteeEffective == porteeEffective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,description,imageCouverture,video,const DeepCollectionEquality().hash(images),partenaireId,nomPartenaire,portee,porteeEffective);

@override
String toString() {
  return 'PubliciteDetail(id: $id, titre: $titre, description: $description, imageCouverture: $imageCouverture, video: $video, images: $images, partenaireId: $partenaireId, nomPartenaire: $nomPartenaire, portee: $portee, porteeEffective: $porteeEffective)';
}


}

/// @nodoc
abstract mixin class $PubliciteDetailCopyWith<$Res>  {
  factory $PubliciteDetailCopyWith(PubliciteDetail value, $Res Function(PubliciteDetail) _then) = _$PubliciteDetailCopyWithImpl;
@useResult
$Res call({
 String id, String titre, String description,@JsonKey(name: 'image_couverture') String? imageCouverture, String? video, List<ImagePublicite> images,@JsonKey(name: 'partenaire_id') int? partenaireId,@JsonKey(name: 'nom_partenaire') String nomPartenaire, String portee,@JsonKey(name: 'portee_effective') String porteeEffective
});




}
/// @nodoc
class _$PubliciteDetailCopyWithImpl<$Res>
    implements $PubliciteDetailCopyWith<$Res> {
  _$PubliciteDetailCopyWithImpl(this._self, this._then);

  final PubliciteDetail _self;
  final $Res Function(PubliciteDetail) _then;

/// Create a copy of PubliciteDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? imageCouverture = freezed,Object? video = freezed,Object? images = null,Object? partenaireId = freezed,Object? nomPartenaire = null,Object? portee = null,Object? porteeEffective = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ImagePublicite>,partenaireId: freezed == partenaireId ? _self.partenaireId : partenaireId // ignore: cast_nullable_to_non_nullable
as int?,nomPartenaire: null == nomPartenaire ? _self.nomPartenaire : nomPartenaire // ignore: cast_nullable_to_non_nullable
as String,portee: null == portee ? _self.portee : portee // ignore: cast_nullable_to_non_nullable
as String,porteeEffective: null == porteeEffective ? _self.porteeEffective : porteeEffective // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PubliciteDetail].
extension PubliciteDetailPatterns on PubliciteDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PubliciteDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PubliciteDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PubliciteDetail value)  $default,){
final _that = this;
switch (_that) {
case _PubliciteDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PubliciteDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PubliciteDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titre,  String description, @JsonKey(name: 'image_couverture')  String? imageCouverture,  String? video,  List<ImagePublicite> images, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'nom_partenaire')  String nomPartenaire,  String portee, @JsonKey(name: 'portee_effective')  String porteeEffective)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PubliciteDetail() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.imageCouverture,_that.video,_that.images,_that.partenaireId,_that.nomPartenaire,_that.portee,_that.porteeEffective);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titre,  String description, @JsonKey(name: 'image_couverture')  String? imageCouverture,  String? video,  List<ImagePublicite> images, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'nom_partenaire')  String nomPartenaire,  String portee, @JsonKey(name: 'portee_effective')  String porteeEffective)  $default,) {final _that = this;
switch (_that) {
case _PubliciteDetail():
return $default(_that.id,_that.titre,_that.description,_that.imageCouverture,_that.video,_that.images,_that.partenaireId,_that.nomPartenaire,_that.portee,_that.porteeEffective);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titre,  String description, @JsonKey(name: 'image_couverture')  String? imageCouverture,  String? video,  List<ImagePublicite> images, @JsonKey(name: 'partenaire_id')  int? partenaireId, @JsonKey(name: 'nom_partenaire')  String nomPartenaire,  String portee, @JsonKey(name: 'portee_effective')  String porteeEffective)?  $default,) {final _that = this;
switch (_that) {
case _PubliciteDetail() when $default != null:
return $default(_that.id,_that.titre,_that.description,_that.imageCouverture,_that.video,_that.images,_that.partenaireId,_that.nomPartenaire,_that.portee,_that.porteeEffective);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PubliciteDetail extends PubliciteDetail {
  const _PubliciteDetail({required this.id, this.titre = '', this.description = '', @JsonKey(name: 'image_couverture') this.imageCouverture, this.video, final  List<ImagePublicite> images = const <ImagePublicite>[], @JsonKey(name: 'partenaire_id') this.partenaireId, @JsonKey(name: 'nom_partenaire') this.nomPartenaire = '', this.portee = 'departement', @JsonKey(name: 'portee_effective') this.porteeEffective = 'departement'}): _images = images,super._();
  factory _PubliciteDetail.fromJson(Map<String, dynamic> json) => _$PubliciteDetailFromJson(json);

@override final  String id;
@override@JsonKey() final  String titre;
@override@JsonKey() final  String description;
@override@JsonKey(name: 'image_couverture') final  String? imageCouverture;
@override final  String? video;
 final  List<ImagePublicite> _images;
@override@JsonKey() List<ImagePublicite> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey(name: 'partenaire_id') final  int? partenaireId;
@override@JsonKey(name: 'nom_partenaire') final  String nomPartenaire;
@override@JsonKey() final  String portee;
@override@JsonKey(name: 'portee_effective') final  String porteeEffective;

/// Create a copy of PubliciteDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PubliciteDetailCopyWith<_PubliciteDetail> get copyWith => __$PubliciteDetailCopyWithImpl<_PubliciteDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PubliciteDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PubliciteDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.titre, titre) || other.titre == titre)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.video, video) || other.video == video)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.partenaireId, partenaireId) || other.partenaireId == partenaireId)&&(identical(other.nomPartenaire, nomPartenaire) || other.nomPartenaire == nomPartenaire)&&(identical(other.portee, portee) || other.portee == portee)&&(identical(other.porteeEffective, porteeEffective) || other.porteeEffective == porteeEffective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titre,description,imageCouverture,video,const DeepCollectionEquality().hash(_images),partenaireId,nomPartenaire,portee,porteeEffective);

@override
String toString() {
  return 'PubliciteDetail(id: $id, titre: $titre, description: $description, imageCouverture: $imageCouverture, video: $video, images: $images, partenaireId: $partenaireId, nomPartenaire: $nomPartenaire, portee: $portee, porteeEffective: $porteeEffective)';
}


}

/// @nodoc
abstract mixin class _$PubliciteDetailCopyWith<$Res> implements $PubliciteDetailCopyWith<$Res> {
  factory _$PubliciteDetailCopyWith(_PubliciteDetail value, $Res Function(_PubliciteDetail) _then) = __$PubliciteDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String titre, String description,@JsonKey(name: 'image_couverture') String? imageCouverture, String? video, List<ImagePublicite> images,@JsonKey(name: 'partenaire_id') int? partenaireId,@JsonKey(name: 'nom_partenaire') String nomPartenaire, String portee,@JsonKey(name: 'portee_effective') String porteeEffective
});




}
/// @nodoc
class __$PubliciteDetailCopyWithImpl<$Res>
    implements _$PubliciteDetailCopyWith<$Res> {
  __$PubliciteDetailCopyWithImpl(this._self, this._then);

  final _PubliciteDetail _self;
  final $Res Function(_PubliciteDetail) _then;

/// Create a copy of PubliciteDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titre = null,Object? description = null,Object? imageCouverture = freezed,Object? video = freezed,Object? images = null,Object? partenaireId = freezed,Object? nomPartenaire = null,Object? portee = null,Object? porteeEffective = null,}) {
  return _then(_PubliciteDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titre: null == titre ? _self.titre : titre // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImagePublicite>,partenaireId: freezed == partenaireId ? _self.partenaireId : partenaireId // ignore: cast_nullable_to_non_nullable
as int?,nomPartenaire: null == nomPartenaire ? _self.nomPartenaire : nomPartenaire // ignore: cast_nullable_to_non_nullable
as String,portee: null == portee ? _self.portee : portee // ignore: cast_nullable_to_non_nullable
as String,porteeEffective: null == porteeEffective ? _self.porteeEffective : porteeEffective // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
