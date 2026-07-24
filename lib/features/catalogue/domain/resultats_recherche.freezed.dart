// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resultats_recherche.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategorieTrouvee {

 int get id; String get nom; String get slug; String get icone;@JsonKey(name: 'mode_transaction') String get modeTransaction;@JsonKey(name: 'affiche_catalogue') bool get afficheCatalogue;
/// Create a copy of CategorieTrouvee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorieTrouveeCopyWith<CategorieTrouvee> get copyWith => _$CategorieTrouveeCopyWithImpl<CategorieTrouvee>(this as CategorieTrouvee, _$identity);

  /// Serializes this CategorieTrouvee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorieTrouvee&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.modeTransaction, modeTransaction) || other.modeTransaction == modeTransaction)&&(identical(other.afficheCatalogue, afficheCatalogue) || other.afficheCatalogue == afficheCatalogue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,icone,modeTransaction,afficheCatalogue);

@override
String toString() {
  return 'CategorieTrouvee(id: $id, nom: $nom, slug: $slug, icone: $icone, modeTransaction: $modeTransaction, afficheCatalogue: $afficheCatalogue)';
}


}

/// @nodoc
abstract mixin class $CategorieTrouveeCopyWith<$Res>  {
  factory $CategorieTrouveeCopyWith(CategorieTrouvee value, $Res Function(CategorieTrouvee) _then) = _$CategorieTrouveeCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String icone,@JsonKey(name: 'mode_transaction') String modeTransaction,@JsonKey(name: 'affiche_catalogue') bool afficheCatalogue
});




}
/// @nodoc
class _$CategorieTrouveeCopyWithImpl<$Res>
    implements $CategorieTrouveeCopyWith<$Res> {
  _$CategorieTrouveeCopyWithImpl(this._self, this._then);

  final CategorieTrouvee _self;
  final $Res Function(CategorieTrouvee) _then;

/// Create a copy of CategorieTrouvee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? icone = null,Object? modeTransaction = null,Object? afficheCatalogue = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,modeTransaction: null == modeTransaction ? _self.modeTransaction : modeTransaction // ignore: cast_nullable_to_non_nullable
as String,afficheCatalogue: null == afficheCatalogue ? _self.afficheCatalogue : afficheCatalogue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategorieTrouvee].
extension CategorieTrouveePatterns on CategorieTrouvee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorieTrouvee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorieTrouvee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorieTrouvee value)  $default,){
final _that = this;
switch (_that) {
case _CategorieTrouvee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorieTrouvee value)?  $default,){
final _that = this;
switch (_that) {
case _CategorieTrouvee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String icone, @JsonKey(name: 'mode_transaction')  String modeTransaction, @JsonKey(name: 'affiche_catalogue')  bool afficheCatalogue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorieTrouvee() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.icone,_that.modeTransaction,_that.afficheCatalogue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String icone, @JsonKey(name: 'mode_transaction')  String modeTransaction, @JsonKey(name: 'affiche_catalogue')  bool afficheCatalogue)  $default,) {final _that = this;
switch (_that) {
case _CategorieTrouvee():
return $default(_that.id,_that.nom,_that.slug,_that.icone,_that.modeTransaction,_that.afficheCatalogue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String icone, @JsonKey(name: 'mode_transaction')  String modeTransaction, @JsonKey(name: 'affiche_catalogue')  bool afficheCatalogue)?  $default,) {final _that = this;
switch (_that) {
case _CategorieTrouvee() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.icone,_that.modeTransaction,_that.afficheCatalogue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategorieTrouvee implements CategorieTrouvee {
  const _CategorieTrouvee({required this.id, this.nom = '', this.slug = '', this.icone = '', @JsonKey(name: 'mode_transaction') this.modeTransaction = '', @JsonKey(name: 'affiche_catalogue') this.afficheCatalogue = true});
  factory _CategorieTrouvee.fromJson(Map<String, dynamic> json) => _$CategorieTrouveeFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String icone;
@override@JsonKey(name: 'mode_transaction') final  String modeTransaction;
@override@JsonKey(name: 'affiche_catalogue') final  bool afficheCatalogue;

/// Create a copy of CategorieTrouvee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorieTrouveeCopyWith<_CategorieTrouvee> get copyWith => __$CategorieTrouveeCopyWithImpl<_CategorieTrouvee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorieTrouveeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorieTrouvee&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.modeTransaction, modeTransaction) || other.modeTransaction == modeTransaction)&&(identical(other.afficheCatalogue, afficheCatalogue) || other.afficheCatalogue == afficheCatalogue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,icone,modeTransaction,afficheCatalogue);

@override
String toString() {
  return 'CategorieTrouvee(id: $id, nom: $nom, slug: $slug, icone: $icone, modeTransaction: $modeTransaction, afficheCatalogue: $afficheCatalogue)';
}


}

/// @nodoc
abstract mixin class _$CategorieTrouveeCopyWith<$Res> implements $CategorieTrouveeCopyWith<$Res> {
  factory _$CategorieTrouveeCopyWith(_CategorieTrouvee value, $Res Function(_CategorieTrouvee) _then) = __$CategorieTrouveeCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String icone,@JsonKey(name: 'mode_transaction') String modeTransaction,@JsonKey(name: 'affiche_catalogue') bool afficheCatalogue
});




}
/// @nodoc
class __$CategorieTrouveeCopyWithImpl<$Res>
    implements _$CategorieTrouveeCopyWith<$Res> {
  __$CategorieTrouveeCopyWithImpl(this._self, this._then);

  final _CategorieTrouvee _self;
  final $Res Function(_CategorieTrouvee) _then;

/// Create a copy of CategorieTrouvee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? icone = null,Object? modeTransaction = null,Object? afficheCatalogue = null,}) {
  return _then(_CategorieTrouvee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,modeTransaction: null == modeTransaction ? _self.modeTransaction : modeTransaction // ignore: cast_nullable_to_non_nullable
as String,afficheCatalogue: null == afficheCatalogue ? _self.afficheCatalogue : afficheCatalogue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PartenaireTrouve {

 int get id;@JsonKey(name: 'nom_commerce') String get nomCommerce; String get description; String get logo;@JsonKey(name: 'photo_couverture') String get photoCouverture;@JsonKey(name: 'type_partenaire') String get typePartenaire;
/// Create a copy of PartenaireTrouve
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartenaireTrouveCopyWith<PartenaireTrouve> get copyWith => _$PartenaireTrouveCopyWithImpl<PartenaireTrouve>(this as PartenaireTrouve, _$identity);

  /// Serializes this PartenaireTrouve to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartenaireTrouve&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,description,logo,photoCouverture,typePartenaire);

@override
String toString() {
  return 'PartenaireTrouve(id: $id, nomCommerce: $nomCommerce, description: $description, logo: $logo, photoCouverture: $photoCouverture, typePartenaire: $typePartenaire)';
}


}

/// @nodoc
abstract mixin class $PartenaireTrouveCopyWith<$Res>  {
  factory $PartenaireTrouveCopyWith(PartenaireTrouve value, $Res Function(PartenaireTrouve) _then) = _$PartenaireTrouveCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce, String description, String logo,@JsonKey(name: 'photo_couverture') String photoCouverture,@JsonKey(name: 'type_partenaire') String typePartenaire
});




}
/// @nodoc
class _$PartenaireTrouveCopyWithImpl<$Res>
    implements $PartenaireTrouveCopyWith<$Res> {
  _$PartenaireTrouveCopyWithImpl(this._self, this._then);

  final PartenaireTrouve _self;
  final $Res Function(PartenaireTrouve) _then;

/// Create a copy of PartenaireTrouve
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nomCommerce = null,Object? description = null,Object? logo = null,Object? photoCouverture = null,Object? typePartenaire = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,photoCouverture: null == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PartenaireTrouve].
extension PartenaireTrouvePatterns on PartenaireTrouve {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartenaireTrouve value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartenaireTrouve() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartenaireTrouve value)  $default,){
final _that = this;
switch (_that) {
case _PartenaireTrouve():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartenaireTrouve value)?  $default,){
final _that = this;
switch (_that) {
case _PartenaireTrouve() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture, @JsonKey(name: 'type_partenaire')  String typePartenaire)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartenaireTrouve() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture,_that.typePartenaire);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture, @JsonKey(name: 'type_partenaire')  String typePartenaire)  $default,) {final _that = this;
switch (_that) {
case _PartenaireTrouve():
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture,_that.typePartenaire);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'nom_commerce')  String nomCommerce,  String description,  String logo, @JsonKey(name: 'photo_couverture')  String photoCouverture, @JsonKey(name: 'type_partenaire')  String typePartenaire)?  $default,) {final _that = this;
switch (_that) {
case _PartenaireTrouve() when $default != null:
return $default(_that.id,_that.nomCommerce,_that.description,_that.logo,_that.photoCouverture,_that.typePartenaire);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartenaireTrouve implements PartenaireTrouve {
  const _PartenaireTrouve({required this.id, @JsonKey(name: 'nom_commerce') this.nomCommerce = '', this.description = '', this.logo = '', @JsonKey(name: 'photo_couverture') this.photoCouverture = '', @JsonKey(name: 'type_partenaire') this.typePartenaire = ''});
  factory _PartenaireTrouve.fromJson(Map<String, dynamic> json) => _$PartenaireTrouveFromJson(json);

@override final  int id;
@override@JsonKey(name: 'nom_commerce') final  String nomCommerce;
@override@JsonKey() final  String description;
@override@JsonKey() final  String logo;
@override@JsonKey(name: 'photo_couverture') final  String photoCouverture;
@override@JsonKey(name: 'type_partenaire') final  String typePartenaire;

/// Create a copy of PartenaireTrouve
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartenaireTrouveCopyWith<_PartenaireTrouve> get copyWith => __$PartenaireTrouveCopyWithImpl<_PartenaireTrouve>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartenaireTrouveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartenaireTrouve&&(identical(other.id, id) || other.id == id)&&(identical(other.nomCommerce, nomCommerce) || other.nomCommerce == nomCommerce)&&(identical(other.description, description) || other.description == description)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.photoCouverture, photoCouverture) || other.photoCouverture == photoCouverture)&&(identical(other.typePartenaire, typePartenaire) || other.typePartenaire == typePartenaire));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nomCommerce,description,logo,photoCouverture,typePartenaire);

@override
String toString() {
  return 'PartenaireTrouve(id: $id, nomCommerce: $nomCommerce, description: $description, logo: $logo, photoCouverture: $photoCouverture, typePartenaire: $typePartenaire)';
}


}

/// @nodoc
abstract mixin class _$PartenaireTrouveCopyWith<$Res> implements $PartenaireTrouveCopyWith<$Res> {
  factory _$PartenaireTrouveCopyWith(_PartenaireTrouve value, $Res Function(_PartenaireTrouve) _then) = __$PartenaireTrouveCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'nom_commerce') String nomCommerce, String description, String logo,@JsonKey(name: 'photo_couverture') String photoCouverture,@JsonKey(name: 'type_partenaire') String typePartenaire
});




}
/// @nodoc
class __$PartenaireTrouveCopyWithImpl<$Res>
    implements _$PartenaireTrouveCopyWith<$Res> {
  __$PartenaireTrouveCopyWithImpl(this._self, this._then);

  final _PartenaireTrouve _self;
  final $Res Function(_PartenaireTrouve) _then;

/// Create a copy of PartenaireTrouve
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nomCommerce = null,Object? description = null,Object? logo = null,Object? photoCouverture = null,Object? typePartenaire = null,}) {
  return _then(_PartenaireTrouve(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nomCommerce: null == nomCommerce ? _self.nomCommerce : nomCommerce // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,photoCouverture: null == photoCouverture ? _self.photoCouverture : photoCouverture // ignore: cast_nullable_to_non_nullable
as String,typePartenaire: null == typePartenaire ? _self.typePartenaire : typePartenaire // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ArticleTrouve {

 int get id; String get nom; String get slug; String get prix;@JsonKey(name: 'partenaire_nom') String get partenaireNom;@JsonKey(name: 'image_principale') String get imagePrincipale;
/// Create a copy of ArticleTrouve
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleTrouveCopyWith<ArticleTrouve> get copyWith => _$ArticleTrouveCopyWithImpl<ArticleTrouve>(this as ArticleTrouve, _$identity);

  /// Serializes this ArticleTrouve to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleTrouve&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.imagePrincipale, imagePrincipale) || other.imagePrincipale == imagePrincipale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,prix,partenaireNom,imagePrincipale);

@override
String toString() {
  return 'ArticleTrouve(id: $id, nom: $nom, slug: $slug, prix: $prix, partenaireNom: $partenaireNom, imagePrincipale: $imagePrincipale)';
}


}

/// @nodoc
abstract mixin class $ArticleTrouveCopyWith<$Res>  {
  factory $ArticleTrouveCopyWith(ArticleTrouve value, $Res Function(ArticleTrouve) _then) = _$ArticleTrouveCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String prix,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'image_principale') String imagePrincipale
});




}
/// @nodoc
class _$ArticleTrouveCopyWithImpl<$Res>
    implements $ArticleTrouveCopyWith<$Res> {
  _$ArticleTrouveCopyWithImpl(this._self, this._then);

  final ArticleTrouve _self;
  final $Res Function(ArticleTrouve) _then;

/// Create a copy of ArticleTrouve
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? prix = null,Object? partenaireNom = null,Object? imagePrincipale = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,imagePrincipale: null == imagePrincipale ? _self.imagePrincipale : imagePrincipale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleTrouve].
extension ArticleTrouvePatterns on ArticleTrouve {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleTrouve value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleTrouve() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleTrouve value)  $default,){
final _that = this;
switch (_that) {
case _ArticleTrouve():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleTrouve value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleTrouve() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String prix, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'image_principale')  String imagePrincipale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleTrouve() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.prix,_that.partenaireNom,_that.imagePrincipale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String prix, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'image_principale')  String imagePrincipale)  $default,) {final _that = this;
switch (_that) {
case _ArticleTrouve():
return $default(_that.id,_that.nom,_that.slug,_that.prix,_that.partenaireNom,_that.imagePrincipale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String prix, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'image_principale')  String imagePrincipale)?  $default,) {final _that = this;
switch (_that) {
case _ArticleTrouve() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.prix,_that.partenaireNom,_that.imagePrincipale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleTrouve implements ArticleTrouve {
  const _ArticleTrouve({required this.id, this.nom = '', this.slug = '', this.prix = '0', @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', @JsonKey(name: 'image_principale') this.imagePrincipale = ''});
  factory _ArticleTrouve.fromJson(Map<String, dynamic> json) => _$ArticleTrouveFromJson(json);

@override final  int id;
@override@JsonKey() final  String nom;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String prix;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override@JsonKey(name: 'image_principale') final  String imagePrincipale;

/// Create a copy of ArticleTrouve
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleTrouveCopyWith<_ArticleTrouve> get copyWith => __$ArticleTrouveCopyWithImpl<_ArticleTrouve>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleTrouveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleTrouve&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.prix, prix) || other.prix == prix)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.imagePrincipale, imagePrincipale) || other.imagePrincipale == imagePrincipale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,prix,partenaireNom,imagePrincipale);

@override
String toString() {
  return 'ArticleTrouve(id: $id, nom: $nom, slug: $slug, prix: $prix, partenaireNom: $partenaireNom, imagePrincipale: $imagePrincipale)';
}


}

/// @nodoc
abstract mixin class _$ArticleTrouveCopyWith<$Res> implements $ArticleTrouveCopyWith<$Res> {
  factory _$ArticleTrouveCopyWith(_ArticleTrouve value, $Res Function(_ArticleTrouve) _then) = __$ArticleTrouveCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String prix,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'image_principale') String imagePrincipale
});




}
/// @nodoc
class __$ArticleTrouveCopyWithImpl<$Res>
    implements _$ArticleTrouveCopyWith<$Res> {
  __$ArticleTrouveCopyWithImpl(this._self, this._then);

  final _ArticleTrouve _self;
  final $Res Function(_ArticleTrouve) _then;

/// Create a copy of ArticleTrouve
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? prix = null,Object? partenaireNom = null,Object? imagePrincipale = null,}) {
  return _then(_ArticleTrouve(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as String,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,imagePrincipale: null == imagePrincipale ? _self.imagePrincipale : imagePrincipale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ResultatsRecherche {

 List<CategorieTrouvee> get categories; List<PartenaireTrouve> get partenaires; List<ArticleTrouve> get articles;
/// Create a copy of ResultatsRecherche
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultatsRechercheCopyWith<ResultatsRecherche> get copyWith => _$ResultatsRechercheCopyWithImpl<ResultatsRecherche>(this as ResultatsRecherche, _$identity);

  /// Serializes this ResultatsRecherche to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultatsRecherche&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.partenaires, partenaires)&&const DeepCollectionEquality().equals(other.articles, articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(partenaires),const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'ResultatsRecherche(categories: $categories, partenaires: $partenaires, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $ResultatsRechercheCopyWith<$Res>  {
  factory $ResultatsRechercheCopyWith(ResultatsRecherche value, $Res Function(ResultatsRecherche) _then) = _$ResultatsRechercheCopyWithImpl;
@useResult
$Res call({
 List<CategorieTrouvee> categories, List<PartenaireTrouve> partenaires, List<ArticleTrouve> articles
});




}
/// @nodoc
class _$ResultatsRechercheCopyWithImpl<$Res>
    implements $ResultatsRechercheCopyWith<$Res> {
  _$ResultatsRechercheCopyWithImpl(this._self, this._then);

  final ResultatsRecherche _self;
  final $Res Function(ResultatsRecherche) _then;

/// Create a copy of ResultatsRecherche
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? partenaires = null,Object? articles = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategorieTrouvee>,partenaires: null == partenaires ? _self.partenaires : partenaires // ignore: cast_nullable_to_non_nullable
as List<PartenaireTrouve>,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleTrouve>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResultatsRecherche].
extension ResultatsRecherchePatterns on ResultatsRecherche {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultatsRecherche value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultatsRecherche() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultatsRecherche value)  $default,){
final _that = this;
switch (_that) {
case _ResultatsRecherche():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultatsRecherche value)?  $default,){
final _that = this;
switch (_that) {
case _ResultatsRecherche() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CategorieTrouvee> categories,  List<PartenaireTrouve> partenaires,  List<ArticleTrouve> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultatsRecherche() when $default != null:
return $default(_that.categories,_that.partenaires,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CategorieTrouvee> categories,  List<PartenaireTrouve> partenaires,  List<ArticleTrouve> articles)  $default,) {final _that = this;
switch (_that) {
case _ResultatsRecherche():
return $default(_that.categories,_that.partenaires,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CategorieTrouvee> categories,  List<PartenaireTrouve> partenaires,  List<ArticleTrouve> articles)?  $default,) {final _that = this;
switch (_that) {
case _ResultatsRecherche() when $default != null:
return $default(_that.categories,_that.partenaires,_that.articles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResultatsRecherche extends ResultatsRecherche {
  const _ResultatsRecherche({final  List<CategorieTrouvee> categories = const <CategorieTrouvee>[], final  List<PartenaireTrouve> partenaires = const <PartenaireTrouve>[], final  List<ArticleTrouve> articles = const <ArticleTrouve>[]}): _categories = categories,_partenaires = partenaires,_articles = articles,super._();
  factory _ResultatsRecherche.fromJson(Map<String, dynamic> json) => _$ResultatsRechercheFromJson(json);

 final  List<CategorieTrouvee> _categories;
@override@JsonKey() List<CategorieTrouvee> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<PartenaireTrouve> _partenaires;
@override@JsonKey() List<PartenaireTrouve> get partenaires {
  if (_partenaires is EqualUnmodifiableListView) return _partenaires;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partenaires);
}

 final  List<ArticleTrouve> _articles;
@override@JsonKey() List<ArticleTrouve> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of ResultatsRecherche
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultatsRechercheCopyWith<_ResultatsRecherche> get copyWith => __$ResultatsRechercheCopyWithImpl<_ResultatsRecherche>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResultatsRechercheToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultatsRecherche&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._partenaires, _partenaires)&&const DeepCollectionEquality().equals(other._articles, _articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_partenaires),const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'ResultatsRecherche(categories: $categories, partenaires: $partenaires, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$ResultatsRechercheCopyWith<$Res> implements $ResultatsRechercheCopyWith<$Res> {
  factory _$ResultatsRechercheCopyWith(_ResultatsRecherche value, $Res Function(_ResultatsRecherche) _then) = __$ResultatsRechercheCopyWithImpl;
@override @useResult
$Res call({
 List<CategorieTrouvee> categories, List<PartenaireTrouve> partenaires, List<ArticleTrouve> articles
});




}
/// @nodoc
class __$ResultatsRechercheCopyWithImpl<$Res>
    implements _$ResultatsRechercheCopyWith<$Res> {
  __$ResultatsRechercheCopyWithImpl(this._self, this._then);

  final _ResultatsRecherche _self;
  final $Res Function(_ResultatsRecherche) _then;

/// Create a copy of ResultatsRecherche
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? partenaires = null,Object? articles = null,}) {
  return _then(_ResultatsRecherche(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategorieTrouvee>,partenaires: null == partenaires ? _self._partenaires : partenaires // ignore: cast_nullable_to_non_nullable
as List<PartenaireTrouve>,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleTrouve>,
  ));
}


}

// dart format on
