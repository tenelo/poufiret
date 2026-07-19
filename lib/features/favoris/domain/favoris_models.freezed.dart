// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favoris_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleFavori {

 int get id; String get nom; String get slug; String get type;@JsonKey(fromJson: _versInt) int get prix;@JsonKey(name: 'nb_vues') int get nbVues;@JsonKey(name: 'nb_likes') int get nbLikes; int? get partenaire;@JsonKey(name: 'partenaire_nom') String get partenaireNom; int? get categorie;
/// Create a copy of ArticleFavori
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleFavoriCopyWith<ArticleFavori> get copyWith => _$ArticleFavoriCopyWithImpl<ArticleFavori>(this as ArticleFavori, _$identity);

  /// Serializes this ArticleFavori to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,type,prix,nbVues,nbLikes,partenaire,partenaireNom,categorie);

@override
String toString() {
  return 'ArticleFavori(id: $id, nom: $nom, slug: $slug, type: $type, prix: $prix, nbVues: $nbVues, nbLikes: $nbLikes, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie)';
}


}

/// @nodoc
abstract mixin class $ArticleFavoriCopyWith<$Res>  {
  factory $ArticleFavoriCopyWith(ArticleFavori value, $Res Function(ArticleFavori) _then) = _$ArticleFavoriCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String type,@JsonKey(fromJson: _versInt) int prix,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? categorie
});




}
/// @nodoc
class _$ArticleFavoriCopyWithImpl<$Res>
    implements $ArticleFavoriCopyWith<$Res> {
  _$ArticleFavoriCopyWithImpl(this._self, this._then);

  final ArticleFavori _self;
  final $Res Function(ArticleFavori) _then;

/// Create a copy of ArticleFavori
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? type = null,Object? prix = null,Object? nbVues = null,Object? nbLikes = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleFavori].
extension ArticleFavoriPatterns on ArticleFavori {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleFavori value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleFavori() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleFavori value)  $default,){
final _that = this;
switch (_that) {
case _ArticleFavori():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleFavori value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleFavori() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String type, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleFavori() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String type, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie)  $default,) {final _that = this;
switch (_that) {
case _ArticleFavori():
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String type, @JsonKey(fromJson: _versInt)  int prix, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie)?  $default,) {final _that = this;
switch (_that) {
case _ArticleFavori() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleFavori implements ArticleFavori {
  const _ArticleFavori({required this.id, this.nom = '', this.slug = '', this.type = '', @JsonKey(fromJson: _versInt) this.prix = 0, @JsonKey(name: 'nb_vues') this.nbVues = 0, @JsonKey(name: 'nb_likes') this.nbLikes = 0, this.partenaire, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', this.categorie});
  factory _ArticleFavori.fromJson(Map<String, dynamic> json) => _$ArticleFavoriFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String type;
@override@JsonKey(fromJson: _versInt) final  int prix;
@override@JsonKey(name: 'nb_vues') final  int nbVues;
@override@JsonKey(name: 'nb_likes') final  int nbLikes;
@override final  int? partenaire;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override final  int? categorie;

/// Create a copy of ArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleFavoriCopyWith<_ArticleFavori> get copyWith => __$ArticleFavoriCopyWithImpl<_ArticleFavori>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleFavoriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,type,prix,nbVues,nbLikes,partenaire,partenaireNom,categorie);

@override
String toString() {
  return 'ArticleFavori(id: $id, nom: $nom, slug: $slug, type: $type, prix: $prix, nbVues: $nbVues, nbLikes: $nbLikes, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie)';
}


}

/// @nodoc
abstract mixin class _$ArticleFavoriCopyWith<$Res> implements $ArticleFavoriCopyWith<$Res> {
  factory _$ArticleFavoriCopyWith(_ArticleFavori value, $Res Function(_ArticleFavori) _then) = __$ArticleFavoriCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String type,@JsonKey(fromJson: _versInt) int prix,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? categorie
});




}
/// @nodoc
class __$ArticleFavoriCopyWithImpl<$Res>
    implements _$ArticleFavoriCopyWith<$Res> {
  __$ArticleFavoriCopyWithImpl(this._self, this._then);

  final _ArticleFavori _self;
  final $Res Function(_ArticleFavori) _then;

/// Create a copy of ArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? type = null,Object? prix = null,Object? nbVues = null,Object? nbLikes = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,}) {
  return _then(_ArticleFavori(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PartenaireFavori {

 int get id;@JsonKey(name: 'nom_commerce') String get nomCommerce;@JsonKey(name: 'type_partenaire') String get typePartenaire; String get ville; String get quartier; String? get logo;
/// Create a copy of PartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartenaireFavoriCopyWith<PartenaireFavori> get copyWith => _$PartenaireFavoriCopyWithImpl<PartenaireFavori>(this as PartenaireFavori, _$identity);

  /// Serializes this PartenaireFavori to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartenaireFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,typePartenaire,ville,quartier,logo);

@override
String toString() {
  return 'PartenaireFavori(id: $id, nomCommerce: $nomCommerce, typePartenaire: $typePartenaire, ville: $ville, quartier: $quartier, logo: $logo)';
}


}

/// @nodoc
abstract mixin class $PartenaireFavoriCopyWith<$Res>  {
  factory $PartenaireFavoriCopyWith(PartenaireFavori value, $Res Function(PartenaireFavori) _then) = _$PartenaireFavoriCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce,@JsonKey(name: 'type_partenaire') String typePartenaire, String ville, String quartier, String? logo
});




}
/// @nodoc
class _$PartenaireFavoriCopyWithImpl<$Res>
    implements $PartenaireFavoriCopyWith<$Res> {
  _$PartenaireFavoriCopyWithImpl(this._self, this._then);

  final PartenaireFavori _self;
  final $Res Function(PartenaireFavori) _then;

/// Create a copy of PartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nomCommerce = null,Object? typePartenaire = null,Object? ville = null,Object? quartier = null,Object? logo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartenaireFavori].
extension PartenaireFavoriPatterns on PartenaireFavori {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartenaireFavori value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartenaireFavori() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartenaireFavori value)  $default,){
final _that = this;
switch (_that) {
case _PartenaireFavori():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartenaireFavori value)?  $default,){
final _that = this;
switch (_that) {
case _PartenaireFavori() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire,  String ville,  String quartier,  String? logo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartenaireFavori() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.ville,_that.quartier,_that.logo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire,  String ville,  String quartier,  String? logo)  $default,) {final _that = this;
switch (_that) {
case _PartenaireFavori():
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.ville,_that.quartier,_that.logo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce, @JsonKey(name: 'type_partenaire')  String typePartenaire,  String ville,  String quartier,  String? logo)?  $default,) {final _that = this;
switch (_that) {
case _PartenaireFavori() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.typePartenaire,_that.ville,_that.quartier,_that.logo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartenaireFavori implements PartenaireFavori {
  const _PartenaireFavori({required this.id, @JsonKey(name: 'nom_commerce') this.nomCommerce = '', @JsonKey(name: 'type_partenaire') this.typePartenaire = '', this.ville = '', this.quartier = '', this.logo});
  factory _PartenaireFavori.fromJson(Map<String, dynamic> json) => _$PartenaireFavoriFromJson(json);

@override final  int id;
@override@JsonKey(name: 'nom_commerce') final  String nomCommerce;
@override@JsonKey(name: 'type_partenaire') final  String typePartenaire;
@override@JsonKey() final  String ville;
@override@JsonKey() final  String quartier;
@override final  String? logo;

/// Create a copy of PartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartenaireFavoriCopyWith<_PartenaireFavori> get copyWith => __$PartenaireFavoriCopyWithImpl<_PartenaireFavori>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartenaireFavoriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartenaireFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire)&&(identical(other.ville, ville) || other.ville == ville)&&(identical(other.quartier, quartier) || other.quartier == quartier)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,typePartenaire,ville,quartier,logo);

@override
String toString() {
  return 'PartenaireFavori(id: $id, nomCommerce: $nomCommerce, typePartenaire: $typePartenaire, ville: $ville, quartier: $quartier, logo: $logo)';
}


}

/// @nodoc
abstract mixin class _$PartenaireFavoriCopyWith<$Res> implements $PartenaireFavoriCopyWith<$Res> {
  factory _$PartenaireFavoriCopyWith(_PartenaireFavori value, $Res Function(_PartenaireFavori) _then) = __$PartenaireFavoriCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce,@JsonKey(name: 'type_partenaire') String typePartenaire, String ville, String quartier, String? logo
});




}
/// @nodoc
class __$PartenaireFavoriCopyWithImpl<$Res>
    implements _$PartenaireFavoriCopyWith<$Res> {
  __$PartenaireFavoriCopyWithImpl(this._self, this._then);

  final _PartenaireFavori _self;
  final $Res Function(_PartenaireFavori) _then;

/// Create a copy of PartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nomCommerce = null,Object? typePartenaire = null,Object? ville = null,Object? quartier = null,Object? logo = freezed,}) {
  return _then(_PartenaireFavori(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,ville: null == ville ? _self.ville : ville // ignore: cast_nullable_to_non_nullable
as String,quartier: null == quartier ? _self.quartier : quartier // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EntreeArticleFavori {

 int get id; ArticleFavori get article;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntreeArticleFavoriCopyWith<EntreeArticleFavori> get copyWith => _$EntreeArticleFavoriCopyWithImpl<EntreeArticleFavori>(this as EntreeArticleFavori, _$identity);

  /// Serializes this EntreeArticleFavori to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntreeArticleFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,createdAt);

@override
String toString() {
  return 'EntreeArticleFavori(id: $id, article: $article, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EntreeArticleFavoriCopyWith<$Res>  {
  factory $EntreeArticleFavoriCopyWith(EntreeArticleFavori value, $Res Function(EntreeArticleFavori) _then) = _$EntreeArticleFavoriCopyWithImpl;
@useResult
$Res call({
 int id, ArticleFavori article,@JsonKey(name: 'created_at') String? createdAt
});


$ArticleFavoriCopyWith<$Res> get article;

}
/// @nodoc
class _$EntreeArticleFavoriCopyWithImpl<$Res>
    implements $EntreeArticleFavoriCopyWith<$Res> {
  _$EntreeArticleFavoriCopyWithImpl(this._self, this._then);

  final EntreeArticleFavori _self;
  final $Res Function(EntreeArticleFavori) _then;

/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? article = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleFavori,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleFavoriCopyWith<$Res> get article {
  
  return $ArticleFavoriCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntreeArticleFavori].
extension EntreeArticleFavoriPatterns on EntreeArticleFavori {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntreeArticleFavori value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntreeArticleFavori() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntreeArticleFavori value)  $default,){
final _that = this;
switch (_that) {
case _EntreeArticleFavori():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntreeArticleFavori value)?  $default,){
final _that = this;
switch (_that) {
case _EntreeArticleFavori() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  ArticleFavori article, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntreeArticleFavori() when $default != null:
return $default(_that.id,_that.article,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  ArticleFavori article, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _EntreeArticleFavori():
return $default(_that.id,_that.article,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  ArticleFavori article, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EntreeArticleFavori() when $default != null:
return $default(_that.id,_that.article,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntreeArticleFavori implements EntreeArticleFavori {
  const _EntreeArticleFavori({required this.id, required this.article, @JsonKey(name: 'created_at') this.createdAt});
  factory _EntreeArticleFavori.fromJson(Map<String, dynamic> json) => _$EntreeArticleFavoriFromJson(json);

@override final  int id;
@override final  ArticleFavori article;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntreeArticleFavoriCopyWith<_EntreeArticleFavori> get copyWith => __$EntreeArticleFavoriCopyWithImpl<_EntreeArticleFavori>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntreeArticleFavoriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntreeArticleFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,createdAt);

@override
String toString() {
  return 'EntreeArticleFavori(id: $id, article: $article, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EntreeArticleFavoriCopyWith<$Res> implements $EntreeArticleFavoriCopyWith<$Res> {
  factory _$EntreeArticleFavoriCopyWith(_EntreeArticleFavori value, $Res Function(_EntreeArticleFavori) _then) = __$EntreeArticleFavoriCopyWithImpl;
@override @useResult
$Res call({
 int id, ArticleFavori article,@JsonKey(name: 'created_at') String? createdAt
});


@override $ArticleFavoriCopyWith<$Res> get article;

}
/// @nodoc
class __$EntreeArticleFavoriCopyWithImpl<$Res>
    implements _$EntreeArticleFavoriCopyWith<$Res> {
  __$EntreeArticleFavoriCopyWithImpl(this._self, this._then);

  final _EntreeArticleFavori _self;
  final $Res Function(_EntreeArticleFavori) _then;

/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? article = null,Object? createdAt = freezed,}) {
  return _then(_EntreeArticleFavori(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleFavori,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EntreeArticleFavori
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleFavoriCopyWith<$Res> get article {
  
  return $ArticleFavoriCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}


/// @nodoc
mixin _$EntreePartenaireFavori {

 int get id; PartenaireFavori get partenaire;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntreePartenaireFavoriCopyWith<EntreePartenaireFavori> get copyWith => _$EntreePartenaireFavoriCopyWithImpl<EntreePartenaireFavori>(this as EntreePartenaireFavori, _$identity);

  /// Serializes this EntreePartenaireFavori to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntreePartenaireFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partenaire,createdAt);

@override
String toString() {
  return 'EntreePartenaireFavori(id: $id, partenaire: $partenaire, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EntreePartenaireFavoriCopyWith<$Res>  {
  factory $EntreePartenaireFavoriCopyWith(EntreePartenaireFavori value, $Res Function(EntreePartenaireFavori) _then) = _$EntreePartenaireFavoriCopyWithImpl;
@useResult
$Res call({
 int id, PartenaireFavori partenaire,@JsonKey(name: 'created_at') String? createdAt
});


$PartenaireFavoriCopyWith<$Res> get partenaire;

}
/// @nodoc
class _$EntreePartenaireFavoriCopyWithImpl<$Res>
    implements $EntreePartenaireFavoriCopyWith<$Res> {
  _$EntreePartenaireFavoriCopyWithImpl(this._self, this._then);

  final EntreePartenaireFavori _self;
  final $Res Function(EntreePartenaireFavori) _then;

/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? partenaire = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,partenaire: null == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as PartenaireFavori,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartenaireFavoriCopyWith<$Res> get partenaire {
  
  return $PartenaireFavoriCopyWith<$Res>(_self.partenaire, (value) {
    return _then(_self.copyWith(partenaire: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntreePartenaireFavori].
extension EntreePartenaireFavoriPatterns on EntreePartenaireFavori {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntreePartenaireFavori value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntreePartenaireFavori() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntreePartenaireFavori value)  $default,){
final _that = this;
switch (_that) {
case _EntreePartenaireFavori():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntreePartenaireFavori value)?  $default,){
final _that = this;
switch (_that) {
case _EntreePartenaireFavori() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  PartenaireFavori partenaire, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntreePartenaireFavori() when $default != null:
return $default(_that.id,_that.partenaire,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  PartenaireFavori partenaire, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _EntreePartenaireFavori():
return $default(_that.id,_that.partenaire,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  PartenaireFavori partenaire, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EntreePartenaireFavori() when $default != null:
return $default(_that.id,_that.partenaire,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntreePartenaireFavori implements EntreePartenaireFavori {
  const _EntreePartenaireFavori({required this.id, required this.partenaire, @JsonKey(name: 'created_at') this.createdAt});
  factory _EntreePartenaireFavori.fromJson(Map<String, dynamic> json) => _$EntreePartenaireFavoriFromJson(json);

@override final  int id;
@override final  PartenaireFavori partenaire;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntreePartenaireFavoriCopyWith<_EntreePartenaireFavori> get copyWith => __$EntreePartenaireFavoriCopyWithImpl<_EntreePartenaireFavori>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntreePartenaireFavoriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntreePartenaireFavori&&(identical(other.id, id) || other.id == id)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partenaire,createdAt);

@override
String toString() {
  return 'EntreePartenaireFavori(id: $id, partenaire: $partenaire, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EntreePartenaireFavoriCopyWith<$Res> implements $EntreePartenaireFavoriCopyWith<$Res> {
  factory _$EntreePartenaireFavoriCopyWith(_EntreePartenaireFavori value, $Res Function(_EntreePartenaireFavori) _then) = __$EntreePartenaireFavoriCopyWithImpl;
@override @useResult
$Res call({
 int id, PartenaireFavori partenaire,@JsonKey(name: 'created_at') String? createdAt
});


@override $PartenaireFavoriCopyWith<$Res> get partenaire;

}
/// @nodoc
class __$EntreePartenaireFavoriCopyWithImpl<$Res>
    implements _$EntreePartenaireFavoriCopyWith<$Res> {
  __$EntreePartenaireFavoriCopyWithImpl(this._self, this._then);

  final _EntreePartenaireFavori _self;
  final $Res Function(_EntreePartenaireFavori) _then;

/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? partenaire = null,Object? createdAt = freezed,}) {
  return _then(_EntreePartenaireFavori(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,partenaire: null == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as PartenaireFavori,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EntreePartenaireFavori
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartenaireFavoriCopyWith<$Res> get partenaire {
  
  return $PartenaireFavoriCopyWith<$Res>(_self.partenaire, (value) {
    return _then(_self.copyWith(partenaire: value));
  });
}
}


/// @nodoc
mixin _$MesFavoris {

 List<EntreeArticleFavori> get articles; List<EntreePartenaireFavori> get partenaires;
/// Create a copy of MesFavoris
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesFavorisCopyWith<MesFavoris> get copyWith => _$MesFavorisCopyWithImpl<MesFavoris>(this as MesFavoris, _$identity);

  /// Serializes this MesFavoris to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesFavoris&&const DeepCollectionEquality().equals(other.articles, articles)&&const DeepCollectionEquality().equals(other.partenaires, partenaires));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(articles),const DeepCollectionEquality().hash(partenaires));

@override
String toString() {
  return 'MesFavoris(articles: $articles, partenaires: $partenaires)';
}


}

/// @nodoc
abstract mixin class $MesFavorisCopyWith<$Res>  {
  factory $MesFavorisCopyWith(MesFavoris value, $Res Function(MesFavoris) _then) = _$MesFavorisCopyWithImpl;
@useResult
$Res call({
 List<EntreeArticleFavori> articles, List<EntreePartenaireFavori> partenaires
});




}
/// @nodoc
class _$MesFavorisCopyWithImpl<$Res>
    implements $MesFavorisCopyWith<$Res> {
  _$MesFavorisCopyWithImpl(this._self, this._then);

  final MesFavoris _self;
  final $Res Function(MesFavoris) _then;

/// Create a copy of MesFavoris
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? articles = null,Object? partenaires = null,}) {
  return _then(_self.copyWith(
articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<EntreeArticleFavori>,partenaires: null == partenaires ? _self.partenaires : partenaires // ignore: cast_nullable_to_non_nullable
as List<EntreePartenaireFavori>,
  ));
}

}


/// Adds pattern-matching-related methods to [MesFavoris].
extension MesFavorisPatterns on MesFavoris {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesFavoris value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesFavoris() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesFavoris value)  $default,){
final _that = this;
switch (_that) {
case _MesFavoris():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesFavoris value)?  $default,){
final _that = this;
switch (_that) {
case _MesFavoris() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EntreeArticleFavori> articles,  List<EntreePartenaireFavori> partenaires)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesFavoris() when $default != null:
return $default(_that.articles,_that.partenaires);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EntreeArticleFavori> articles,  List<EntreePartenaireFavori> partenaires)  $default,) {final _that = this;
switch (_that) {
case _MesFavoris():
return $default(_that.articles,_that.partenaires);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EntreeArticleFavori> articles,  List<EntreePartenaireFavori> partenaires)?  $default,) {final _that = this;
switch (_that) {
case _MesFavoris() when $default != null:
return $default(_that.articles,_that.partenaires);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MesFavoris implements MesFavoris {
  const _MesFavoris({final  List<EntreeArticleFavori> articles = const <EntreeArticleFavori>[], final  List<EntreePartenaireFavori> partenaires = const <EntreePartenaireFavori>[]}): _articles = articles,_partenaires = partenaires;
  factory _MesFavoris.fromJson(Map<String, dynamic> json) => _$MesFavorisFromJson(json);

 final  List<EntreeArticleFavori> _articles;
@override@JsonKey() List<EntreeArticleFavori> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

 final  List<EntreePartenaireFavori> _partenaires;
@override@JsonKey() List<EntreePartenaireFavori> get partenaires {
  if (_partenaires is EqualUnmodifiableListView) return _partenaires;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partenaires);
}


/// Create a copy of MesFavoris
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesFavorisCopyWith<_MesFavoris> get copyWith => __$MesFavorisCopyWithImpl<_MesFavoris>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MesFavorisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesFavoris&&const DeepCollectionEquality().equals(other._articles, _articles)&&const DeepCollectionEquality().equals(other._partenaires, _partenaires));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),const DeepCollectionEquality().hash(_partenaires));

@override
String toString() {
  return 'MesFavoris(articles: $articles, partenaires: $partenaires)';
}


}

/// @nodoc
abstract mixin class _$MesFavorisCopyWith<$Res> implements $MesFavorisCopyWith<$Res> {
  factory _$MesFavorisCopyWith(_MesFavoris value, $Res Function(_MesFavoris) _then) = __$MesFavorisCopyWithImpl;
@override @useResult
$Res call({
 List<EntreeArticleFavori> articles, List<EntreePartenaireFavori> partenaires
});




}
/// @nodoc
class __$MesFavorisCopyWithImpl<$Res>
    implements _$MesFavorisCopyWith<$Res> {
  __$MesFavorisCopyWithImpl(this._self, this._then);

  final _MesFavoris _self;
  final $Res Function(_MesFavoris) _then;

/// Create a copy of MesFavoris
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? partenaires = null,}) {
  return _then(_MesFavoris(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<EntreeArticleFavori>,partenaires: null == partenaires ? _self._partenaires : partenaires // ignore: cast_nullable_to_non_nullable
as List<EntreePartenaireFavori>,
  ));
}


}

// dart format on
