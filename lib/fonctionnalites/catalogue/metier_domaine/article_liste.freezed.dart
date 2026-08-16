// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_liste.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleListe {

 int get id; String get nom; String get slug; String get type; String get prix;@JsonKey(name: 'prix_promotion') String? get prixPromotion;@JsonKey(name: 'est_en_promotion') bool get estEnPromotion;@JsonKey(name: 'est_disponible') bool get estDisponible;@JsonKey(name: 'nb_vues') int get nbVues;@JsonKey(name: 'nb_likes') int get nbLikes; int? get partenaire;@JsonKey(name: 'partenaire_nom') String get partenaireNom; int? get categorie;@JsonKey(name: 'image_principale') String? get imagePrincipale;
/// Create a copy of ArticleListe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleListeCopyWith<ArticleListe> get copyWith => _$ArticleListeCopyWithImpl<ArticleListe>(this as ArticleListe, _$identity);

  /// Serializes this ArticleListe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleListe&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixPromotion, prixPromotion) || other.prixPromotion == prixPromotion)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.imagePrincipale, imagePrincipale) || other.imagePrincipale == imagePrincipale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,type,prix,prixPromotion,estEnPromotion,estDisponible,nbVues,nbLikes,partenaire,partenaireNom,categorie,imagePrincipale);

@override
String toString() {
  return 'ArticleListe(id: $id, nom: $nom, slug: $slug, type: $type, prix: $prix, prixPromotion: $prixPromotion, estEnPromotion: $estEnPromotion, estDisponible: $estDisponible, nbVues: $nbVues, nbLikes: $nbLikes, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie, imagePrincipale: $imagePrincipale)';
}


}

/// @nodoc
abstract mixin class $ArticleListeCopyWith<$Res>  {
  factory $ArticleListeCopyWith(ArticleListe value, $Res Function(ArticleListe) _then) = _$ArticleListeCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String type, String prix,@JsonKey(name: 'prix_promotion') String? prixPromotion,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? categorie,@JsonKey(name: 'image_principale') String? imagePrincipale
});




}
/// @nodoc
class _$ArticleListeCopyWithImpl<$Res>
    implements $ArticleListeCopyWith<$Res> {
  _$ArticleListeCopyWithImpl(this._self, this._then);

  final ArticleListe _self;
  final $Res Function(ArticleListe) _then;

/// Create a copy of ArticleListe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? type = null,Object? prix = null,Object? prixPromotion = freezed,Object? estEnPromotion = null,Object? estDisponible = null,Object? nbVues = null,Object? nbLikes = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,Object? imagePrincipale = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,prixPromotion: freezed == prixPromotion ? _self.prixPromotion : prixPromotion // ignore: cast_nullable_to_non_nullable
as String?,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,imagePrincipale: freezed == imagePrincipale ? _self.imagePrincipale : imagePrincipale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleListe].
extension ArticleListePatterns on ArticleListe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleListe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleListe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleListe value)  $default,){
final _that = this;
switch (_that) {
case _ArticleListe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleListe value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleListe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie, @JsonKey(name: 'image_principale')  String? imagePrincipale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleListe() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.prixPromotion,_that.estEnPromotion,_that.estDisponible,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie,_that.imagePrincipale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie, @JsonKey(name: 'image_principale')  String? imagePrincipale)  $default,) {final _that = this;
switch (_that) {
case _ArticleListe():
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.prixPromotion,_that.estEnPromotion,_that.estDisponible,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie,_that.imagePrincipale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? categorie, @JsonKey(name: 'image_principale')  String? imagePrincipale)?  $default,) {final _that = this;
switch (_that) {
case _ArticleListe() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.type,_that.prix,_that.prixPromotion,_that.estEnPromotion,_that.estDisponible,_that.nbVues,_that.nbLikes,_that.partenaire,_that.partenaireNom,_that.categorie,_that.imagePrincipale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleListe extends ArticleListe {
  const _ArticleListe({required this.id, required this.nom, required this.slug, this.type = '', this.prix = '0', @JsonKey(name: 'prix_promotion') this.prixPromotion, @JsonKey(name: 'est_en_promotion') this.estEnPromotion = false, @JsonKey(name: 'est_disponible') this.estDisponible = true, @JsonKey(name: 'nb_vues') this.nbVues = 0, @JsonKey(name: 'nb_likes') this.nbLikes = 0, this.partenaire, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', this.categorie, @JsonKey(name: 'image_principale') this.imagePrincipale}): super._();
  factory _ArticleListe.fromJson(Map<String, dynamic> json) => _$ArticleListeFromJson(json);

@override final  int id;
@override final  String nom;
@override final  String slug;
@override@JsonKey() final  String type;
@override@JsonKey() final  String prix;
@override@JsonKey(name: 'prix_promotion') final  String? prixPromotion;
@override@JsonKey(name: 'est_en_promotion') final  bool estEnPromotion;
@override@JsonKey(name: 'est_disponible') final  bool estDisponible;
@override@JsonKey(name: 'nb_vues') final  int nbVues;
@override@JsonKey(name: 'nb_likes') final  int nbLikes;
@override final  int? partenaire;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override final  int? categorie;
@override@JsonKey(name: 'image_principale') final  String? imagePrincipale;

/// Create a copy of ArticleListe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleListeCopyWith<_ArticleListe> get copyWith => __$ArticleListeCopyWithImpl<_ArticleListe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleListeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleListe&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixPromotion, prixPromotion) || other.prixPromotion == prixPromotion)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.imagePrincipale, imagePrincipale) || other.imagePrincipale == imagePrincipale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,type,prix,prixPromotion,estEnPromotion,estDisponible,nbVues,nbLikes,partenaire,partenaireNom,categorie,imagePrincipale);

@override
String toString() {
  return 'ArticleListe(id: $id, nom: $nom, slug: $slug, type: $type, prix: $prix, prixPromotion: $prixPromotion, estEnPromotion: $estEnPromotion, estDisponible: $estDisponible, nbVues: $nbVues, nbLikes: $nbLikes, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie, imagePrincipale: $imagePrincipale)';
}


}

/// @nodoc
abstract mixin class _$ArticleListeCopyWith<$Res> implements $ArticleListeCopyWith<$Res> {
  factory _$ArticleListeCopyWith(_ArticleListe value, $Res Function(_ArticleListe) _then) = __$ArticleListeCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String type, String prix,@JsonKey(name: 'prix_promotion') String? prixPromotion,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? categorie,@JsonKey(name: 'image_principale') String? imagePrincipale
});




}
/// @nodoc
class __$ArticleListeCopyWithImpl<$Res>
    implements _$ArticleListeCopyWith<$Res> {
  __$ArticleListeCopyWithImpl(this._self, this._then);

  final _ArticleListe _self;
  final $Res Function(_ArticleListe) _then;

/// Create a copy of ArticleListe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? type = null,Object? prix = null,Object? prixPromotion = freezed,Object? estEnPromotion = null,Object? estDisponible = null,Object? nbVues = null,Object? nbLikes = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,Object? imagePrincipale = freezed,}) {
  return _then(_ArticleListe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,prixPromotion: freezed == prixPromotion ? _self.prixPromotion : prixPromotion // ignore: cast_nullable_to_non_nullable
as String?,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,imagePrincipale: freezed == imagePrincipale ? _self.imagePrincipale : imagePrincipale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
