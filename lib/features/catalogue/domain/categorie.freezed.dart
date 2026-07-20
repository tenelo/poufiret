// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categorie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Categorie {

 int get id; String get nom; String get slug; String get description; String get icone;@JsonKey(name: 'image_couverture') String? get imageCouverture; int? get parent;@JsonKey(name: 'mode_transaction') String get modeTransaction; int get ordre;@JsonKey(name: 'types_articles') List<String> get typesArticles;@JsonKey(name: 'est_active') bool get estActive;@JsonKey(name: 'nb_partenaires') int? get nbPartenaires; List<Categorie> get enfants;
/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorieCopyWith<Categorie> get copyWith => _$CategorieCopyWithImpl<Categorie>(this as Categorie, _$identity);

  /// Serializes this Categorie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Categorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.modeTransaction, modeTransaction) || other.modeTransaction == modeTransaction)&&(identical(other.ordre, ordre) || other.ordre == ordre)&&const DeepCollectionEquality().equals(other.typesArticles, typesArticles)&&(identical(other.estActive, estActive) || other.estActive == estActive)&&(identical(other.nbPartenaires, nbPartenaires) || other.nbPartenaires == nbPartenaires)&&const DeepCollectionEquality().equals(other.enfants, enfants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,description,icone,imageCouverture,parent,modeTransaction,ordre,const DeepCollectionEquality().hash(typesArticles),estActive,nbPartenaires,const DeepCollectionEquality().hash(enfants));

@override
String toString() {
  return 'Categorie(id: $id, nom: $nom, slug: $slug, description: $description, icone: $icone, imageCouverture: $imageCouverture, parent: $parent, modeTransaction: $modeTransaction, ordre: $ordre, typesArticles: $typesArticles, estActive: $estActive, nbPartenaires: $nbPartenaires, enfants: $enfants)';
}


}

/// @nodoc
abstract mixin class $CategorieCopyWith<$Res>  {
  factory $CategorieCopyWith(Categorie value, $Res Function(Categorie) _then) = _$CategorieCopyWithImpl;
@useResult
$Res call({
 int id, String nom, String slug, String description, String icone,@JsonKey(name: 'image_couverture') String? imageCouverture, int? parent,@JsonKey(name: 'mode_transaction') String modeTransaction, int ordre,@JsonKey(name: 'types_articles') List<String> typesArticles,@JsonKey(name: 'est_active') bool estActive,@JsonKey(name: 'nb_partenaires') int? nbPartenaires, List<Categorie> enfants
});




}
/// @nodoc
class _$CategorieCopyWithImpl<$Res>
    implements $CategorieCopyWith<$Res> {
  _$CategorieCopyWithImpl(this._self, this._then);

  final Categorie _self;
  final $Res Function(Categorie) _then;

/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? description = null,Object? icone = null,Object? imageCouverture = freezed,Object? parent = freezed,Object? modeTransaction = null,Object? ordre = null,Object? typesArticles = null,Object? estActive = null,Object? nbPartenaires = freezed,Object? enfants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,modeTransaction: null == modeTransaction ? _self.modeTransaction : modeTransaction // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,typesArticles: null == typesArticles ? _self.typesArticles : typesArticles // ignore: cast_nullable_to_non_nullable
as List<String>,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,nbPartenaires: freezed == nbPartenaires ? _self.nbPartenaires : nbPartenaires // ignore: cast_nullable_to_non_nullable
as int?,enfants: null == enfants ? _self.enfants : enfants // ignore: cast_nullable_to_non_nullable
as List<Categorie>,
  ));
}

}


/// Adds pattern-matching-related methods to [Categorie].
extension CategoriePatterns on Categorie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Categorie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Categorie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Categorie value)  $default,){
final _that = this;
switch (_that) {
case _Categorie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Categorie value)?  $default,){
final _that = this;
switch (_that) {
case _Categorie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String description,  String icone, @JsonKey(name: 'image_couverture')  String? imageCouverture,  int? parent, @JsonKey(name: 'mode_transaction')  String modeTransaction,  int ordre, @JsonKey(name: 'types_articles')  List<String> typesArticles, @JsonKey(name: 'est_active')  bool estActive, @JsonKey(name: 'nb_partenaires')  int? nbPartenaires,  List<Categorie> enfants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.icone,_that.imageCouverture,_that.parent,_that.modeTransaction,_that.ordre,_that.typesArticles,_that.estActive,_that.nbPartenaires,_that.enfants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nom,  String slug,  String description,  String icone, @JsonKey(name: 'image_couverture')  String? imageCouverture,  int? parent, @JsonKey(name: 'mode_transaction')  String modeTransaction,  int ordre, @JsonKey(name: 'types_articles')  List<String> typesArticles, @JsonKey(name: 'est_active')  bool estActive, @JsonKey(name: 'nb_partenaires')  int? nbPartenaires,  List<Categorie> enfants)  $default,) {final _that = this;
switch (_that) {
case _Categorie():
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.icone,_that.imageCouverture,_that.parent,_that.modeTransaction,_that.ordre,_that.typesArticles,_that.estActive,_that.nbPartenaires,_that.enfants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nom,  String slug,  String description,  String icone, @JsonKey(name: 'image_couverture')  String? imageCouverture,  int? parent, @JsonKey(name: 'mode_transaction')  String modeTransaction,  int ordre, @JsonKey(name: 'types_articles')  List<String> typesArticles, @JsonKey(name: 'est_active')  bool estActive, @JsonKey(name: 'nb_partenaires')  int? nbPartenaires,  List<Categorie> enfants)?  $default,) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id,_that.nom,_that.slug,_that.description,_that.icone,_that.imageCouverture,_that.parent,_that.modeTransaction,_that.ordre,_that.typesArticles,_that.estActive,_that.nbPartenaires,_that.enfants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Categorie implements Categorie {
  const _Categorie({required this.id, required this.nom, required this.slug, this.description = '', this.icone = '', @JsonKey(name: 'image_couverture') this.imageCouverture, this.parent, @JsonKey(name: 'mode_transaction') this.modeTransaction = '', this.ordre = 0, @JsonKey(name: 'types_articles') final  List<String> typesArticles = const <String>[], @JsonKey(name: 'est_active') this.estActive = true, @JsonKey(name: 'nb_partenaires') this.nbPartenaires, final  List<Categorie> enfants = const <Categorie>[]}): _typesArticles = typesArticles,_enfants = enfants;
  factory _Categorie.fromJson(Map<String, dynamic> json) => _$CategorieFromJson(json);

@override final  int id;
@override final  String nom;
@override final  String slug;
@override@JsonKey() final  String description;
@override@JsonKey() final  String icone;
@override@JsonKey(name: 'image_couverture') final  String? imageCouverture;
@override final  int? parent;
@override@JsonKey(name: 'mode_transaction') final  String modeTransaction;
@override@JsonKey() final  int ordre;
 final  List<String> _typesArticles;
@override@JsonKey(name: 'types_articles') List<String> get typesArticles {
  if (_typesArticles is EqualUnmodifiableListView) return _typesArticles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_typesArticles);
}

@override@JsonKey(name: 'est_active') final  bool estActive;
@override@JsonKey(name: 'nb_partenaires') final  int? nbPartenaires;
 final  List<Categorie> _enfants;
@override@JsonKey() List<Categorie> get enfants {
  if (_enfants is EqualUnmodifiableListView) return _enfants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_enfants);
}


/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorieCopyWith<_Categorie> get copyWith => __$CategorieCopyWithImpl<_Categorie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Categorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icone, icone) || other.icone == icone)&&(identical(other.imageCouverture, imageCouverture) || other.imageCouverture == imageCouverture)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.modeTransaction, modeTransaction) || other.modeTransaction == modeTransaction)&&(identical(other.ordre, ordre) || other.ordre == ordre)&&const DeepCollectionEquality().equals(other._typesArticles, _typesArticles)&&(identical(other.estActive, estActive) || other.estActive == estActive)&&(identical(other.nbPartenaires, nbPartenaires) || other.nbPartenaires == nbPartenaires)&&const DeepCollectionEquality().equals(other._enfants, _enfants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,slug,description,icone,imageCouverture,parent,modeTransaction,ordre,const DeepCollectionEquality().hash(_typesArticles),estActive,nbPartenaires,const DeepCollectionEquality().hash(_enfants));

@override
String toString() {
  return 'Categorie(id: $id, nom: $nom, slug: $slug, description: $description, icone: $icone, imageCouverture: $imageCouverture, parent: $parent, modeTransaction: $modeTransaction, ordre: $ordre, typesArticles: $typesArticles, estActive: $estActive, nbPartenaires: $nbPartenaires, enfants: $enfants)';
}


}

/// @nodoc
abstract mixin class _$CategorieCopyWith<$Res> implements $CategorieCopyWith<$Res> {
  factory _$CategorieCopyWith(_Categorie value, $Res Function(_Categorie) _then) = __$CategorieCopyWithImpl;
@override @useResult
$Res call({
 int id, String nom, String slug, String description, String icone,@JsonKey(name: 'image_couverture') String? imageCouverture, int? parent,@JsonKey(name: 'mode_transaction') String modeTransaction, int ordre,@JsonKey(name: 'types_articles') List<String> typesArticles,@JsonKey(name: 'est_active') bool estActive,@JsonKey(name: 'nb_partenaires') int? nbPartenaires, List<Categorie> enfants
});




}
/// @nodoc
class __$CategorieCopyWithImpl<$Res>
    implements _$CategorieCopyWith<$Res> {
  __$CategorieCopyWithImpl(this._self, this._then);

  final _Categorie _self;
  final $Res Function(_Categorie) _then;

/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? slug = null,Object? description = null,Object? icone = null,Object? imageCouverture = freezed,Object? parent = freezed,Object? modeTransaction = null,Object? ordre = null,Object? typesArticles = null,Object? estActive = null,Object? nbPartenaires = freezed,Object? enfants = null,}) {
  return _then(_Categorie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icone: null == icone ? _self.icone : icone // ignore: cast_nullable_to_non_nullable
as String,imageCouverture: freezed == imageCouverture ? _self.imageCouverture : imageCouverture // ignore: cast_nullable_to_non_nullable
as String?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,modeTransaction: null == modeTransaction ? _self.modeTransaction : modeTransaction // ignore: cast_nullable_to_non_nullable
as String,ordre: null == ordre ? _self.ordre : ordre // ignore: cast_nullable_to_non_nullable
as int,typesArticles: null == typesArticles ? _self._typesArticles : typesArticles // ignore: cast_nullable_to_non_nullable
as List<String>,estActive: null == estActive ? _self.estActive : estActive // ignore: cast_nullable_to_non_nullable
as bool,nbPartenaires: freezed == nbPartenaires ? _self.nbPartenaires : nbPartenaires // ignore: cast_nullable_to_non_nullable
as int?,enfants: null == enfants ? _self._enfants : enfants // ignore: cast_nullable_to_non_nullable
as List<Categorie>,
  ));
}


}

// dart format on
