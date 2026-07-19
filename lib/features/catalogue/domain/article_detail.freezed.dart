// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Variante {

 int get id; String get nom;@JsonKey(name: 'prix_supplement') String get prixSupplement;@JsonKey(name: 'est_par_defaut') bool get estParDefaut;
/// Create a copy of Variante
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VarianteCopyWith<Variante> get copyWith => _$VarianteCopyWithImpl<Variante>(this as Variante, _$identity);

  /// Serializes this Variante to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Variante&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estParDefaut, estParDefaut) || other.estParDefaut == estParDefaut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estParDefaut);

@override
String toString() {
  return 'Variante(id: $id, nom: $nom, prixSupplement: $prixSupplement, estParDefaut: $estParDefaut)';
}


}

/// @nodoc
abstract mixin class $VarianteCopyWith<$Res>  {
  factory $VarianteCopyWith(Variante value, $Res Function(Variante) _then) = _$VarianteCopyWithImpl;
@useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement') String prixSupplement,@JsonKey(name: 'est_par_defaut') bool estParDefaut
});




}
/// @nodoc
class _$VarianteCopyWithImpl<$Res>
    implements $VarianteCopyWith<$Res> {
  _$VarianteCopyWithImpl(this._self, this._then);

  final Variante _self;
  final $Res Function(Variante) _then;

/// Create a copy of Variante
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estParDefaut = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as String,estParDefaut: null == estParDefaut ? _self.estParDefaut : estParDefaut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Variante].
extension VariantePatterns on Variante {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Variante value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Variante() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Variante value)  $default,){
final _that = this;
switch (_that) {
case _Variante():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Variante value)?  $default,){
final _that = this;
switch (_that) {
case _Variante() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement')  String prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Variante() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom, @JsonKey(name: 'prix_supplement')  String prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut)  $default,) {final _that = this;
switch (_that) {
case _Variante():
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom, @JsonKey(name: 'prix_supplement')  String prixSupplement, @JsonKey(name: 'est_par_defaut')  bool estParDefaut)?  $default,) {final _that = this;
switch (_that) {
case _Variante() when $default != null:
return $default(_that.id,_that.nom,_that.prixSupplement,_that.estParDefaut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Variante extends Variante {
  const _Variante({required this.id, required this.nom, @JsonKey(name: 'prix_supplement') this.prixSupplement = '0', @JsonKey(name: 'est_par_defaut') this.estParDefaut = false}): super._();
  factory _Variante.fromJson(Map<String, dynamic> json) => _$VarianteFromJson(json);

@override final  int id;
@override final  String nom;
@override@JsonKey(name: 'prix_supplement') final  String prixSupplement;
@override@JsonKey(name: 'est_par_defaut') final  bool estParDefaut;

/// Create a copy of Variante
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VarianteCopyWith<_Variante> get copyWith => __$VarianteCopyWithImpl<_Variante>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VarianteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Variante&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prixSupplement, prixSupplement) || other.prixSupplement == prixSupplement)&&(identical(other.estParDefaut, estParDefaut) || other.estParDefaut == estParDefaut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prixSupplement,estParDefaut);

@override
String toString() {
  return 'Variante(id: $id, nom: $nom, prixSupplement: $prixSupplement, estParDefaut: $estParDefaut)';
}


}

/// @nodoc
abstract mixin class _$VarianteCopyWith<$Res> implements $VarianteCopyWith<$Res> {
  factory _$VarianteCopyWith(_Variante value, $Res Function(_Variante) _then) = __$VarianteCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom,@JsonKey(name: 'prix_supplement') String prixSupplement,@JsonKey(name: 'est_par_defaut') bool estParDefaut
});




}
/// @nodoc
class __$VarianteCopyWithImpl<$Res>
    implements _$VarianteCopyWith<$Res> {
  __$VarianteCopyWithImpl(this._self, this._then);

  final _Variante _self;
  final $Res Function(_Variante) _then;

/// Create a copy of Variante
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prixSupplement = null,Object? estParDefaut = null,}) {
  return _then(_Variante(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prixSupplement: null == prixSupplement ? _self.prixSupplement : prixSupplement // ignore: cast_nullable_to_non_nullable
as String,estParDefaut: null == estParDefaut ? _self.estParDefaut : estParDefaut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Supplement {

 int get id; String get nom; String get prix;@JsonKey(name: 'est_optionnel') bool get estOptionnel;
/// Create a copy of Supplement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplementCopyWith<Supplement> get copyWith => _$SupplementCopyWithImpl<Supplement>(this as Supplement, _$identity);

  /// Serializes this Supplement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Supplement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.estOptionnel, estOptionnel) || other.estOptionnel == estOptionnel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix,estOptionnel);

@override
String toString() {
  return 'Supplement(id: $id, nom: $nom, prix: $prix, estOptionnel: $estOptionnel)';
}


}

/// @nodoc
abstract mixin class $SupplementCopyWith<$Res>  {
  factory $SupplementCopyWith(Supplement value, $Res Function(Supplement) _then) = _$SupplementCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String prix,@JsonKey(name: 'est_optionnel') bool estOptionnel
});




}
/// @nodoc
class _$SupplementCopyWithImpl<$Res>
    implements $SupplementCopyWith<$Res> {
  _$SupplementCopyWithImpl(this._self, this._then);

  final Supplement _self;
  final $Res Function(Supplement) _then;

/// Create a copy of Supplement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prix = null,Object? estOptionnel = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,estOptionnel: null == estOptionnel ? _self.estOptionnel : estOptionnel // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Supplement].
extension SupplementPatterns on Supplement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Supplement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Supplement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Supplement value)  $default,){
final _that = this;
switch (_that) {
case _Supplement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Supplement value)?  $default,){
final _that = this;
switch (_that) {
case _Supplement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String prix, @JsonKey(name: 'est_optionnel')  bool estOptionnel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Supplement() when $default != null:
return $default(_that.id,_that.nom,_that.prix,_that.estOptionnel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String prix, @JsonKey(name: 'est_optionnel')  bool estOptionnel)  $default,) {final _that = this;
switch (_that) {
case _Supplement():
return $default(_that.id,_that.nom,_that.prix,_that.estOptionnel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String prix, @JsonKey(name: 'est_optionnel')  bool estOptionnel)?  $default,) {final _that = this;
switch (_that) {
case _Supplement() when $default != null:
return $default(_that.id,_that.nom,_that.prix,_that.estOptionnel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Supplement extends Supplement {
  const _Supplement({required this.id, required this.nom, this.prix = '0', @JsonKey(name: 'est_optionnel') this.estOptionnel = true}): super._();
  factory _Supplement.fromJson(Map<String, dynamic> json) => _$SupplementFromJson(json);

@override final  int id;
@override final  String nom;
@override@JsonKey() final  String prix;
@override@JsonKey(name: 'est_optionnel') final  bool estOptionnel;

/// Create a copy of Supplement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplementCopyWith<_Supplement> get copyWith => __$SupplementCopyWithImpl<_Supplement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupplementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Supplement&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.estOptionnel, estOptionnel) || other.estOptionnel == estOptionnel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix,estOptionnel);

@override
String toString() {
  return 'Supplement(id: $id, nom: $nom, prix: $prix, estOptionnel: $estOptionnel)';
}


}

/// @nodoc
abstract mixin class _$SupplementCopyWith<$Res> implements $SupplementCopyWith<$Res> {
  factory _$SupplementCopyWith(_Supplement value, $Res Function(_Supplement) _then) = __$SupplementCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String prix,@JsonKey(name: 'est_optionnel') bool estOptionnel
});




}
/// @nodoc
class __$SupplementCopyWithImpl<$Res>
    implements _$SupplementCopyWith<$Res> {
  __$SupplementCopyWithImpl(this._self, this._then);

  final _Supplement _self;
  final $Res Function(_Supplement) _then;

/// Create a copy of Supplement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prix = null,Object? estOptionnel = null,}) {
  return _then(_Supplement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,estOptionnel: null == estOptionnel ? _self.estOptionnel : estOptionnel // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ArticleDetail {

 int get id; String get nom; String get slug; String get description; String get type; String get prix;@JsonKey(name: 'prix_promotion') String? get prixPromotion; String get unite;@JsonKey(name: 'est_disponible') bool get estDisponible;@JsonKey(name: 'est_actif') bool get estActif;@JsonKey(name: 'est_en_promotion') bool get estEnPromotion;@JsonKey(name: 'nb_vues') int get nbVues;@JsonKey(name: 'nb_likes') int get nbLikes;@JsonKey(name: 'nb_favoris') int get nbFavoris;@JsonKey(name: 'nb_commentaires') int get nbCommentaires;@JsonKey(name: 'partenaire_nom') String get partenaireNom; int? get partenaire; int? get categorie; List<String> get images; List<Variante> get variantes; List<Supplement> get supplements;@JsonKey(name: 'est_like_par_moi') bool get estLikeParMoi;@JsonKey(name: 'est_favori_par_moi') bool get estFavoriParMoi;
/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDetailCopyWith<ArticleDetail> get copyWith => _$ArticleDetailCopyWithImpl<ArticleDetail>(this as ArticleDetail, _$identity);

  /// Serializes this ArticleDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixPromotion, prixPromotion) || other.prixPromotion == prixPromotion)&&(identical(other.unite, unite) || other.unite == unite)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.nbFavoris, nbFavoris) || other.nbFavoris == nbFavoris)&&(identical(other.nbCommentaires, nbCommentaires) || other.nbCommentaires == nbCommentaires)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.variantes, variantes)&&const DeepCollectionEquality().equals(other.supplements, supplements)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&(identical(other.estFavoriParMoi, estFavoriParMoi) || other.estFavoriParMoi == estFavoriParMoi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,slug,description,type,prix,prixPromotion,unite,estDisponible,estActif,estEnPromotion,nbVues,nbLikes,nbFavoris,nbCommentaires,partenaireNom,partenaire,categorie,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(variantes),const DeepCollectionEquality().hash(supplements),estLikeParMoi,estFavoriParMoi]);

@override
String toString() {
  return 'ArticleDetail(id: $id, nom: $nom, slug: $slug, description: $description, type: $type, prix: $prix, prixPromotion: $prixPromotion, unite: $unite, estDisponible: $estDisponible, estActif: $estActif, estEnPromotion: $estEnPromotion, nbVues: $nbVues, nbLikes: $nbLikes, nbFavoris: $nbFavoris, nbCommentaires: $nbCommentaires, partenaireNom: $partenaireNom, partenaire: $partenaire, categorie: $categorie, images: $images, variantes: $variantes, supplements: $supplements, estLikeParMoi: $estLikeParMoi, estFavoriParMoi: $estFavoriParMoi)';
}


}

/// @nodoc
abstract mixin class $ArticleDetailCopyWith<$Res>  {
  factory $ArticleDetailCopyWith(ArticleDetail value, $Res Function(ArticleDetail) _then) = _$ArticleDetailCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String description, String type, String prix,@JsonKey(name: 'prix_promotion') String? prixPromotion, String unite,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'est_actif') bool estActif,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes,@JsonKey(name: 'nb_favoris') int nbFavoris,@JsonKey(name: 'nb_commentaires') int nbCommentaires,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? partenaire, int? categorie, List<String> images, List<Variante> variantes, List<Supplement> supplements,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi,@JsonKey(name: 'est_favori_par_moi') bool estFavoriParMoi
});




}
/// @nodoc
class _$ArticleDetailCopyWithImpl<$Res>
    implements $ArticleDetailCopyWith<$Res> {
  _$ArticleDetailCopyWithImpl(this._self, this._then);

  final ArticleDetail _self;
  final $Res Function(ArticleDetail) _then;

/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? description = null,Object? type = null,Object? prix = null,Object? prixPromotion = freezed,Object? unite = null,Object? estDisponible = null,Object? estActif = null,Object? estEnPromotion = null,Object? nbVues = null,Object? nbLikes = null,Object? nbFavoris = null,Object? nbCommentaires = null,Object? partenaireNom = null,Object? partenaire = freezed,Object? categorie = freezed,Object? images = null,Object? variantes = null,Object? supplements = null,Object? estLikeParMoi = null,Object? estFavoriParMoi = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,prixPromotion: freezed == prixPromotion ? _self.prixPromotion : prixPromotion // ignore: cast_nullable_to_non_nullable
as String?,unite: null == unite ? _self.unite : unite // ignore: cast_nullable_to_non_nullable
as String,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,nbFavoris: null == nbFavoris ? _self.nbFavoris : nbFavoris // ignore: cast_nullable_to_non_nullable
as int,nbCommentaires: null == nbCommentaires ? _self.nbCommentaires : nbCommentaires // ignore: cast_nullable_to_non_nullable
as int,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variantes: null == variantes ? _self.variantes : variantes // ignore: cast_nullable_to_non_nullable
as List<Variante>,supplements: null == supplements ? _self.supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<Supplement>,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,estFavoriParMoi: null == estFavoriParMoi ? _self.estFavoriParMoi : estFavoriParMoi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleDetail].
extension ArticleDetailPatterns on ArticleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDetail value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String description,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion,  String unite, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_actif')  bool estActif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'nb_favoris')  int nbFavoris, @JsonKey(name: 'nb_commentaires')  int nbCommentaires, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? partenaire,  int? categorie,  List<String> images,  List<Variante> variantes,  List<Supplement> supplements, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.type,_that.prix,_that.prixPromotion,_that.unite,_that.estDisponible,_that.estActif,_that.estEnPromotion,_that.nbVues,_that.nbLikes,_that.nbFavoris,_that.nbCommentaires,_that.partenaireNom,_that.partenaire,_that.categorie,_that.images,_that.variantes,_that.supplements,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String description,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion,  String unite, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_actif')  bool estActif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'nb_favoris')  int nbFavoris, @JsonKey(name: 'nb_commentaires')  int nbCommentaires, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? partenaire,  int? categorie,  List<String> images,  List<Variante> variantes,  List<Supplement> supplements, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)  $default,) {final _that = this;
switch (_that) {
case _ArticleDetail():
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.type,_that.prix,_that.prixPromotion,_that.unite,_that.estDisponible,_that.estActif,_that.estEnPromotion,_that.nbVues,_that.nbLikes,_that.nbFavoris,_that.nbCommentaires,_that.partenaireNom,_that.partenaire,_that.categorie,_that.images,_that.variantes,_that.supplements,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String description,  String type,  String prix, @JsonKey(name: 'prix_promotion')  String? prixPromotion,  String unite, @JsonKey(name: 'est_disponible')  bool estDisponible, @JsonKey(name: 'est_actif')  bool estActif, @JsonKey(name: 'est_en_promotion')  bool estEnPromotion, @JsonKey(name: 'nb_vues')  int nbVues, @JsonKey(name: 'nb_likes')  int nbLikes, @JsonKey(name: 'nb_favoris')  int nbFavoris, @JsonKey(name: 'nb_commentaires')  int nbCommentaires, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? partenaire,  int? categorie,  List<String> images,  List<Variante> variantes,  List<Supplement> supplements, @JsonKey(name: 'est_like_par_moi')  bool estLikeParMoi, @JsonKey(name: 'est_favori_par_moi')  bool estFavoriParMoi)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.type,_that.prix,_that.prixPromotion,_that.unite,_that.estDisponible,_that.estActif,_that.estEnPromotion,_that.nbVues,_that.nbLikes,_that.nbFavoris,_that.nbCommentaires,_that.partenaireNom,_that.partenaire,_that.categorie,_that.images,_that.variantes,_that.supplements,_that.estLikeParMoi,_that.estFavoriParMoi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleDetail extends ArticleDetail {
  const _ArticleDetail({required this.id, required this.nom, required this.slug, this.description = '', this.type = '', this.prix = '0', @JsonKey(name: 'prix_promotion') this.prixPromotion, this.unite = '', @JsonKey(name: 'est_disponible') this.estDisponible = true, @JsonKey(name: 'est_actif') this.estActif = true, @JsonKey(name: 'est_en_promotion') this.estEnPromotion = false, @JsonKey(name: 'nb_vues') this.nbVues = 0, @JsonKey(name: 'nb_likes') this.nbLikes = 0, @JsonKey(name: 'nb_favoris') this.nbFavoris = 0, @JsonKey(name: 'nb_commentaires') this.nbCommentaires = 0, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', this.partenaire, this.categorie, final  List<String> images = const <String>[], final  List<Variante> variantes = const <Variante>[], final  List<Supplement> supplements = const <Supplement>[], @JsonKey(name: 'est_like_par_moi') this.estLikeParMoi = false, @JsonKey(name: 'est_favori_par_moi') this.estFavoriParMoi = false}): _images = images,_variantes = variantes,_supplements = supplements,super._();
  factory _ArticleDetail.fromJson(Map<String, dynamic> json) => _$ArticleDetailFromJson(json);

@override final  int id;
@override final  String nom;
@override final  String slug;
@override@JsonKey() final  String description;
@override@JsonKey() final  String type;
@override@JsonKey() final  String prix;
@override@JsonKey(name: 'prix_promotion') final  String? prixPromotion;
@override@JsonKey() final  String unite;
@override@JsonKey(name: 'est_disponible') final  bool estDisponible;
@override@JsonKey(name: 'est_actif') final  bool estActif;
@override@JsonKey(name: 'est_en_promotion') final  bool estEnPromotion;
@override@JsonKey(name: 'nb_vues') final  int nbVues;
@override@JsonKey(name: 'nb_likes') final  int nbLikes;
@override@JsonKey(name: 'nb_favoris') final  int nbFavoris;
@override@JsonKey(name: 'nb_commentaires') final  int nbCommentaires;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override final  int? partenaire;
@override final  int? categorie;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<Variante> _variantes;
@override@JsonKey() List<Variante> get variantes {
  if (_variantes is EqualUnmodifiableListView) return _variantes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variantes);
}

 final  List<Supplement> _supplements;
@override@JsonKey() List<Supplement> get supplements {
  if (_supplements is EqualUnmodifiableListView) return _supplements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supplements);
}

@override@JsonKey(name: 'est_like_par_moi') final  bool estLikeParMoi;
@override@JsonKey(name: 'est_favori_par_moi') final  bool estFavoriParMoi;

/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDetailCopyWith<_ArticleDetail> get copyWith => __$ArticleDetailCopyWithImpl<_ArticleDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.prixPromotion, prixPromotion) || other.prixPromotion == prixPromotion)&&(identical(other.unite, unite) || other.unite == unite)&&(identical(other.estDisponible, estDisponible) || other.estDisponible == estDisponible)&&(identical(other.estActif, estActif) || other.estActif == estActif)&&(identical(other.estEnPromotion, estEnPromotion) || other.estEnPromotion == estEnPromotion)&&(identical(other.nbVues, nbVues) || other.nbVues == nbVues)&&(identical(other.nbLikes, nbLikes) || other.nbLikes == nbLikes)&&(identical(other.nbFavoris, nbFavoris) || other.nbFavoris == nbFavoris)&&(identical(other.nbCommentaires, nbCommentaires) || other.nbCommentaires == nbCommentaires)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._variantes, _variantes)&&const DeepCollectionEquality().equals(other._supplements, _supplements)&&(identical(other.estLikeParMoi, estLikeParMoi) || other.estLikeParMoi == estLikeParMoi)&&(identical(other.estFavoriParMoi, estFavoriParMoi) || other.estFavoriParMoi == estFavoriParMoi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,nom,slug,description,type,prix,prixPromotion,unite,estDisponible,estActif,estEnPromotion,nbVues,nbLikes,nbFavoris,nbCommentaires,partenaireNom,partenaire,categorie,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_variantes),const DeepCollectionEquality().hash(_supplements),estLikeParMoi,estFavoriParMoi]);

@override
String toString() {
  return 'ArticleDetail(id: $id, nom: $nom, slug: $slug, description: $description, type: $type, prix: $prix, prixPromotion: $prixPromotion, unite: $unite, estDisponible: $estDisponible, estActif: $estActif, estEnPromotion: $estEnPromotion, nbVues: $nbVues, nbLikes: $nbLikes, nbFavoris: $nbFavoris, nbCommentaires: $nbCommentaires, partenaireNom: $partenaireNom, partenaire: $partenaire, categorie: $categorie, images: $images, variantes: $variantes, supplements: $supplements, estLikeParMoi: $estLikeParMoi, estFavoriParMoi: $estFavoriParMoi)';
}


}

/// @nodoc
abstract mixin class _$ArticleDetailCopyWith<$Res> implements $ArticleDetailCopyWith<$Res> {
  factory _$ArticleDetailCopyWith(_ArticleDetail value, $Res Function(_ArticleDetail) _then) = __$ArticleDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String description, String type, String prix,@JsonKey(name: 'prix_promotion') String? prixPromotion, String unite,@JsonKey(name: 'est_disponible') bool estDisponible,@JsonKey(name: 'est_actif') bool estActif,@JsonKey(name: 'est_en_promotion') bool estEnPromotion,@JsonKey(name: 'nb_vues') int nbVues,@JsonKey(name: 'nb_likes') int nbLikes,@JsonKey(name: 'nb_favoris') int nbFavoris,@JsonKey(name: 'nb_commentaires') int nbCommentaires,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? partenaire, int? categorie, List<String> images, List<Variante> variantes, List<Supplement> supplements,@JsonKey(name: 'est_like_par_moi') bool estLikeParMoi,@JsonKey(name: 'est_favori_par_moi') bool estFavoriParMoi
});




}
/// @nodoc
class __$ArticleDetailCopyWithImpl<$Res>
    implements _$ArticleDetailCopyWith<$Res> {
  __$ArticleDetailCopyWithImpl(this._self, this._then);

  final _ArticleDetail _self;
  final $Res Function(_ArticleDetail) _then;

/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? description = null,Object? type = null,Object? prix = null,Object? prixPromotion = freezed,Object? unite = null,Object? estDisponible = null,Object? estActif = null,Object? estEnPromotion = null,Object? nbVues = null,Object? nbLikes = null,Object? nbFavoris = null,Object? nbCommentaires = null,Object? partenaireNom = null,Object? partenaire = freezed,Object? categorie = freezed,Object? images = null,Object? variantes = null,Object? supplements = null,Object? estLikeParMoi = null,Object? estFavoriParMoi = null,}) {
  return _then(_ArticleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,prixPromotion: freezed == prixPromotion ? _self.prixPromotion : prixPromotion // ignore: cast_nullable_to_non_nullable
as String?,unite: null == unite ? _self.unite : unite // ignore: cast_nullable_to_non_nullable
as String,estDisponible: null == estDisponible ? _self.estDisponible : estDisponible // ignore: cast_nullable_to_non_nullable
as bool,estActif: null == estActif ? _self.estActif : estActif // ignore: cast_nullable_to_non_nullable
as bool,estEnPromotion: null == estEnPromotion ? _self.estEnPromotion : estEnPromotion // ignore: cast_nullable_to_non_nullable
as bool,nbVues: null == nbVues ? _self.nbVues : nbVues // ignore: cast_nullable_to_non_nullable
as int,nbLikes: null == nbLikes ? _self.nbLikes : nbLikes // ignore: cast_nullable_to_non_nullable
as int,nbFavoris: null == nbFavoris ? _self.nbFavoris : nbFavoris // ignore: cast_nullable_to_non_nullable
as int,nbCommentaires: null == nbCommentaires ? _self.nbCommentaires : nbCommentaires // ignore: cast_nullable_to_non_nullable
as int,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variantes: null == variantes ? _self._variantes : variantes // ignore: cast_nullable_to_non_nullable
as List<Variante>,supplements: null == supplements ? _self._supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<Supplement>,estLikeParMoi: null == estLikeParMoi ? _self.estLikeParMoi : estLikeParMoi // ignore: cast_nullable_to_non_nullable
as bool,estFavoriParMoi: null == estFavoriParMoi ? _self.estFavoriParMoi : estFavoriParMoi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
