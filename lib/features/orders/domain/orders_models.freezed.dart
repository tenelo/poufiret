// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupplementSnapshot {

 int? get id; String get nom;@JsonKey(fromJson: _versInt) int get prix;
/// Create a copy of SupplementSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplementSnapshotCopyWith<SupplementSnapshot> get copyWith => _$SupplementSnapshotCopyWithImpl<SupplementSnapshot>(this as SupplementSnapshot, _$identity);

  /// Serializes this SupplementSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupplementSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix);

@override
String toString() {
  return 'SupplementSnapshot(id: $id, nom: $nom, prix: $prix)';
}


}

/// @nodoc
abstract mixin class $SupplementSnapshotCopyWith<$Res>  {
  factory $SupplementSnapshotCopyWith(SupplementSnapshot value, $Res Function(SupplementSnapshot) _then) = _$SupplementSnapshotCopyWithImpl;
@useResult
$Res call({
 int? id, String nom,@JsonKey(fromJson: _versInt) int prix
});




}
/// @nodoc
class _$SupplementSnapshotCopyWithImpl<$Res>
    implements $SupplementSnapshotCopyWith<$Res> {
  _$SupplementSnapshotCopyWithImpl(this._self, this._then);

  final SupplementSnapshot _self;
  final $Res Function(SupplementSnapshot) _then;

/// Create a copy of SupplementSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? nom = null,Object? prix = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SupplementSnapshot].
extension SupplementSnapshotPatterns on SupplementSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupplementSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupplementSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupplementSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _SupplementSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupplementSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _SupplementSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String nom, @JsonKey(fromJson: _versInt)  int prix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupplementSnapshot() when $default != null:
return $default(_that.id,_that.nom,_that.prix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String nom, @JsonKey(fromJson: _versInt)  int prix)  $default,) {final _that = this;
switch (_that) {
case _SupplementSnapshot():
return $default(_that.id,_that.nom,_that.prix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String nom, @JsonKey(fromJson: _versInt)  int prix)?  $default,) {final _that = this;
switch (_that) {
case _SupplementSnapshot() when $default != null:
return $default(_that.id,_that.nom,_that.prix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupplementSnapshot implements SupplementSnapshot {
  const _SupplementSnapshot({this.id, this.nom = '', @JsonKey(fromJson: _versInt) this.prix = 0});
  factory _SupplementSnapshot.fromJson(Map<String, dynamic> json) => _$SupplementSnapshotFromJson(json);

@override final  int? id;
@override@JsonKey() final  String nom;
@override@JsonKey(fromJson: _versInt) final  int prix;

/// Create a copy of SupplementSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplementSnapshotCopyWith<_SupplementSnapshot> get copyWith => __$SupplementSnapshotCopyWithImpl<_SupplementSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupplementSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupplementSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prix, prix) || other.prix == prix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prix);

@override
String toString() {
  return 'SupplementSnapshot(id: $id, nom: $nom, prix: $prix)';
}


}

/// @nodoc
abstract mixin class _$SupplementSnapshotCopyWith<$Res> implements $SupplementSnapshotCopyWith<$Res> {
  factory _$SupplementSnapshotCopyWith(_SupplementSnapshot value, $Res Function(_SupplementSnapshot) _then) = __$SupplementSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int? id, String nom,@JsonKey(fromJson: _versInt) int prix
});




}
/// @nodoc
class __$SupplementSnapshotCopyWithImpl<$Res>
    implements _$SupplementSnapshotCopyWith<$Res> {
  __$SupplementSnapshotCopyWithImpl(this._self, this._then);

  final _SupplementSnapshot _self;
  final $Res Function(_SupplementSnapshot) _then;

/// Create a copy of SupplementSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? nom = null,Object? prix = null,}) {
  return _then(_SupplementSnapshot(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prix: null == prix ? _self.prix : prix // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LignePanier {

 int get id; int get article;@JsonKey(name: 'article_nom') String get articleNom;@JsonKey(name: 'variante_id') int? get varianteId; List<SupplementSnapshot> get supplements; int get quantite;@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int get prixUnitaire;@JsonKey(name: 'prix_ligne', fromJson: _versInt) int get prixLigne;@JsonKey(name: 'note_speciale') String get noteSpeciale;
/// Create a copy of LignePanier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LignePanierCopyWith<LignePanier> get copyWith => _$LignePanierCopyWithImpl<LignePanier>(this as LignePanier, _$identity);

  /// Serializes this LignePanier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LignePanier&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.articleNom, articleNom) || other.articleNom == articleNom)&&(identical(other.varianteId, varianteId) || other.varianteId == varianteId)&&const DeepCollectionEquality().equals(other.supplements, supplements)&&(identical(other.quantite, quantite) || other.quantite == quantite)&&(identical(other.prixUnitaire, prixUnitaire) || other.prixUnitaire == prixUnitaire)&&(identical(other.prixLigne, prixLigne) || other.prixLigne == prixLigne)&&(identical(other.noteSpeciale, noteSpeciale) || other.noteSpeciale == noteSpeciale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,articleNom,varianteId,const DeepCollectionEquality().hash(supplements),quantite,prixUnitaire,prixLigne,noteSpeciale);

@override
String toString() {
  return 'LignePanier(id: $id, article: $article, articleNom: $articleNom, varianteId: $varianteId, supplements: $supplements, quantite: $quantite, prixUnitaire: $prixUnitaire, prixLigne: $prixLigne, noteSpeciale: $noteSpeciale)';
}


}

/// @nodoc
abstract mixin class $LignePanierCopyWith<$Res>  {
  factory $LignePanierCopyWith(LignePanier value, $Res Function(LignePanier) _then) = _$LignePanierCopyWithImpl;
@useResult
$Res call({
 int id, int article,@JsonKey(name: 'article_nom') String articleNom,@JsonKey(name: 'variante_id') int? varianteId, List<SupplementSnapshot> supplements, int quantite,@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int prixUnitaire,@JsonKey(name: 'prix_ligne', fromJson: _versInt) int prixLigne,@JsonKey(name: 'note_speciale') String noteSpeciale
});




}
/// @nodoc
class _$LignePanierCopyWithImpl<$Res>
    implements $LignePanierCopyWith<$Res> {
  _$LignePanierCopyWithImpl(this._self, this._then);

  final LignePanier _self;
  final $Res Function(LignePanier) _then;

/// Create a copy of LignePanier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? article = null,Object? articleNom = null,Object? varianteId = freezed,Object? supplements = null,Object? quantite = null,Object? prixUnitaire = null,Object? prixLigne = null,Object? noteSpeciale = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int,articleNom: null == articleNom ? _self.articleNom : articleNom // ignore: cast_nullable_to_non_nullable
as String,varianteId: freezed == varianteId ? _self.varianteId : varianteId // ignore: cast_nullable_to_non_nullable
as int?,supplements: null == supplements ? _self.supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<SupplementSnapshot>,quantite: null == quantite ? _self.quantite : quantite // ignore: cast_nullable_to_non_nullable
as int,prixUnitaire: null == prixUnitaire ? _self.prixUnitaire : prixUnitaire // ignore: cast_nullable_to_non_nullable
as int,prixLigne: null == prixLigne ? _self.prixLigne : prixLigne // ignore: cast_nullable_to_non_nullable
as int,noteSpeciale: null == noteSpeciale ? _self.noteSpeciale : noteSpeciale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LignePanier].
extension LignePanierPatterns on LignePanier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LignePanier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LignePanier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LignePanier value)  $default,){
final _that = this;
switch (_that) {
case _LignePanier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LignePanier value)?  $default,){
final _that = this;
switch (_that) {
case _LignePanier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'variante_id')  int? varianteId,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LignePanier() when $default != null:
return $default(_that.id,_that.article,_that.articleNom,_that.varianteId,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'variante_id')  int? varianteId,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)  $default,) {final _that = this;
switch (_that) {
case _LignePanier():
return $default(_that.id,_that.article,_that.articleNom,_that.varianteId,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int article, @JsonKey(name: 'article_nom')  String articleNom, @JsonKey(name: 'variante_id')  int? varianteId,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)?  $default,) {final _that = this;
switch (_that) {
case _LignePanier() when $default != null:
return $default(_that.id,_that.article,_that.articleNom,_that.varianteId,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LignePanier implements LignePanier {
  const _LignePanier({required this.id, required this.article, @JsonKey(name: 'article_nom') this.articleNom = '', @JsonKey(name: 'variante_id') this.varianteId, final  List<SupplementSnapshot> supplements = const <SupplementSnapshot>[], this.quantite = 1, @JsonKey(name: 'prix_unitaire', fromJson: _versInt) this.prixUnitaire = 0, @JsonKey(name: 'prix_ligne', fromJson: _versInt) this.prixLigne = 0, @JsonKey(name: 'note_speciale') this.noteSpeciale = ''}): _supplements = supplements;
  factory _LignePanier.fromJson(Map<String, dynamic> json) => _$LignePanierFromJson(json);

@override final  int id;
@override final  int article;
@override@JsonKey(name: 'article_nom') final  String articleNom;
@override@JsonKey(name: 'variante_id') final  int? varianteId;
 final  List<SupplementSnapshot> _supplements;
@override@JsonKey() List<SupplementSnapshot> get supplements {
  if (_supplements is EqualUnmodifiableListView) return _supplements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supplements);
}

@override@JsonKey() final  int quantite;
@override@JsonKey(name: 'prix_unitaire', fromJson: _versInt) final  int prixUnitaire;
@override@JsonKey(name: 'prix_ligne', fromJson: _versInt) final  int prixLigne;
@override@JsonKey(name: 'note_speciale') final  String noteSpeciale;

/// Create a copy of LignePanier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LignePanierCopyWith<_LignePanier> get copyWith => __$LignePanierCopyWithImpl<_LignePanier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LignePanierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LignePanier&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.articleNom, articleNom) || other.articleNom == articleNom)&&(identical(other.varianteId, varianteId) || other.varianteId == varianteId)&&const DeepCollectionEquality().equals(other._supplements, _supplements)&&(identical(other.quantite, quantite) || other.quantite == quantite)&&(identical(other.prixUnitaire, prixUnitaire) || other.prixUnitaire == prixUnitaire)&&(identical(other.prixLigne, prixLigne) || other.prixLigne == prixLigne)&&(identical(other.noteSpeciale, noteSpeciale) || other.noteSpeciale == noteSpeciale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,articleNom,varianteId,const DeepCollectionEquality().hash(_supplements),quantite,prixUnitaire,prixLigne,noteSpeciale);

@override
String toString() {
  return 'LignePanier(id: $id, article: $article, articleNom: $articleNom, varianteId: $varianteId, supplements: $supplements, quantite: $quantite, prixUnitaire: $prixUnitaire, prixLigne: $prixLigne, noteSpeciale: $noteSpeciale)';
}


}

/// @nodoc
abstract mixin class _$LignePanierCopyWith<$Res> implements $LignePanierCopyWith<$Res> {
  factory _$LignePanierCopyWith(_LignePanier value, $Res Function(_LignePanier) _then) = __$LignePanierCopyWithImpl;
@override @useResult
$Res call({
 int id, int article,@JsonKey(name: 'article_nom') String articleNom,@JsonKey(name: 'variante_id') int? varianteId, List<SupplementSnapshot> supplements, int quantite,@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int prixUnitaire,@JsonKey(name: 'prix_ligne', fromJson: _versInt) int prixLigne,@JsonKey(name: 'note_speciale') String noteSpeciale
});




}
/// @nodoc
class __$LignePanierCopyWithImpl<$Res>
    implements _$LignePanierCopyWith<$Res> {
  __$LignePanierCopyWithImpl(this._self, this._then);

  final _LignePanier _self;
  final $Res Function(_LignePanier) _then;

/// Create a copy of LignePanier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? article = null,Object? articleNom = null,Object? varianteId = freezed,Object? supplements = null,Object? quantite = null,Object? prixUnitaire = null,Object? prixLigne = null,Object? noteSpeciale = null,}) {
  return _then(_LignePanier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int,articleNom: null == articleNom ? _self.articleNom : articleNom // ignore: cast_nullable_to_non_nullable
as String,varianteId: freezed == varianteId ? _self.varianteId : varianteId // ignore: cast_nullable_to_non_nullable
as int?,supplements: null == supplements ? _self._supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<SupplementSnapshot>,quantite: null == quantite ? _self.quantite : quantite // ignore: cast_nullable_to_non_nullable
as int,prixUnitaire: null == prixUnitaire ? _self.prixUnitaire : prixUnitaire // ignore: cast_nullable_to_non_nullable
as int,prixLigne: null == prixLigne ? _self.prixLigne : prixLigne // ignore: cast_nullable_to_non_nullable
as int,noteSpeciale: null == noteSpeciale ? _self.noteSpeciale : noteSpeciale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Panier {

 int get id; int? get partenaire;@JsonKey(name: 'partenaire_nom') String get partenaireNom;@JsonKey(name: 'categorie') int? get categorie;@JsonKey(name: 'categorie_nom') String get categorieNom; List<LignePanier> get lignes;@JsonKey(fromJson: _versInt) int get total;
/// Create a copy of Panier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanierCopyWith<Panier> get copyWith => _$PanierCopyWithImpl<Panier>(this as Panier, _$identity);

  /// Serializes this Panier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Panier&&(identical(other.id, id) || other.id == id)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieNom, categorieNom) || other.categorieNom == categorieNom)&&const DeepCollectionEquality().equals(other.lignes, lignes)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partenaire,partenaireNom,categorie,categorieNom,const DeepCollectionEquality().hash(lignes),total);

@override
String toString() {
  return 'Panier(id: $id, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie, categorieNom: $categorieNom, lignes: $lignes, total: $total)';
}


}

/// @nodoc
abstract mixin class $PanierCopyWith<$Res>  {
  factory $PanierCopyWith(Panier value, $Res Function(Panier) _then) = _$PanierCopyWithImpl;
@useResult
$Res call({
 int id, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'categorie') int? categorie,@JsonKey(name: 'categorie_nom') String categorieNom, List<LignePanier> lignes,@JsonKey(fromJson: _versInt) int total
});




}
/// @nodoc
class _$PanierCopyWithImpl<$Res>
    implements $PanierCopyWith<$Res> {
  _$PanierCopyWithImpl(this._self, this._then);

  final Panier _self;
  final $Res Function(Panier) _then;

/// Create a copy of Panier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,Object? categorieNom = null,Object? lignes = null,Object? total = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,categorieNom: null == categorieNom ? _self.categorieNom : categorieNom // ignore: cast_nullable_to_non_nullable
as String,lignes: null == lignes ? _self.lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LignePanier>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Panier].
extension PanierPatterns on Panier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Panier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Panier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Panier value)  $default,){
final _that = this;
switch (_that) {
case _Panier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Panier value)?  $default,){
final _that = this;
switch (_that) {
case _Panier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'categorie')  int? categorie, @JsonKey(name: 'categorie_nom')  String categorieNom,  List<LignePanier> lignes, @JsonKey(fromJson: _versInt)  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Panier() when $default != null:
return $default(_that.id,_that.partenaire,_that.partenaireNom,_that.categorie,_that.categorieNom,_that.lignes,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'categorie')  int? categorie, @JsonKey(name: 'categorie_nom')  String categorieNom,  List<LignePanier> lignes, @JsonKey(fromJson: _versInt)  int total)  $default,) {final _that = this;
switch (_that) {
case _Panier():
return $default(_that.id,_that.partenaire,_that.partenaireNom,_that.categorie,_that.categorieNom,_that.lignes,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'categorie')  int? categorie, @JsonKey(name: 'categorie_nom')  String categorieNom,  List<LignePanier> lignes, @JsonKey(fromJson: _versInt)  int total)?  $default,) {final _that = this;
switch (_that) {
case _Panier() when $default != null:
return $default(_that.id,_that.partenaire,_that.partenaireNom,_that.categorie,_that.categorieNom,_that.lignes,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Panier implements Panier {
  const _Panier({required this.id, this.partenaire, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', @JsonKey(name: 'categorie') this.categorie, @JsonKey(name: 'categorie_nom') this.categorieNom = '', final  List<LignePanier> lignes = const <LignePanier>[], @JsonKey(fromJson: _versInt) this.total = 0}): _lignes = lignes;
  factory _Panier.fromJson(Map<String, dynamic> json) => _$PanierFromJson(json);

@override final  int id;
@override final  int? partenaire;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override@JsonKey(name: 'categorie') final  int? categorie;
@override@JsonKey(name: 'categorie_nom') final  String categorieNom;
 final  List<LignePanier> _lignes;
@override@JsonKey() List<LignePanier> get lignes {
  if (_lignes is EqualUnmodifiableListView) return _lignes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lignes);
}

@override@JsonKey(fromJson: _versInt) final  int total;

/// Create a copy of Panier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanierCopyWith<_Panier> get copyWith => __$PanierCopyWithImpl<_Panier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PanierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Panier&&(identical(other.id, id) || other.id == id)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.categorie, categorie) || other.categorie == categorie)&&(identical(other.categorieNom, categorieNom) || other.categorieNom == categorieNom)&&const DeepCollectionEquality().equals(other._lignes, _lignes)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partenaire,partenaireNom,categorie,categorieNom,const DeepCollectionEquality().hash(_lignes),total);

@override
String toString() {
  return 'Panier(id: $id, partenaire: $partenaire, partenaireNom: $partenaireNom, categorie: $categorie, categorieNom: $categorieNom, lignes: $lignes, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PanierCopyWith<$Res> implements $PanierCopyWith<$Res> {
  factory _$PanierCopyWith(_Panier value, $Res Function(_Panier) _then) = __$PanierCopyWithImpl;
@override @useResult
$Res call({
 int id, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'categorie') int? categorie,@JsonKey(name: 'categorie_nom') String categorieNom, List<LignePanier> lignes,@JsonKey(fromJson: _versInt) int total
});




}
/// @nodoc
class __$PanierCopyWithImpl<$Res>
    implements _$PanierCopyWith<$Res> {
  __$PanierCopyWithImpl(this._self, this._then);

  final _Panier _self;
  final $Res Function(_Panier) _then;

/// Create a copy of Panier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? categorie = freezed,Object? categorieNom = null,Object? lignes = null,Object? total = null,}) {
  return _then(_Panier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,categorie: freezed == categorie ? _self.categorie : categorie // ignore: cast_nullable_to_non_nullable
as int?,categorieNom: null == categorieNom ? _self.categorieNom : categorieNom // ignore: cast_nullable_to_non_nullable
as String,lignes: null == lignes ? _self._lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LignePanier>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LigneCommande {

 int get id; int? get article;@JsonKey(name: 'nom_article') String get nomArticle;@JsonKey(name: 'variante_nom') String get varianteNom; List<SupplementSnapshot> get supplements; int get quantite;@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int get prixUnitaire;@JsonKey(name: 'prix_ligne', fromJson: _versInt) int get prixLigne;@JsonKey(name: 'note_speciale') String get noteSpeciale;
/// Create a copy of LigneCommande
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LigneCommandeCopyWith<LigneCommande> get copyWith => _$LigneCommandeCopyWithImpl<LigneCommande>(this as LigneCommande, _$identity);

  /// Serializes this LigneCommande to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LigneCommande&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.nomArticle, nomArticle) || other.nomArticle == nomArticle)&&(identical(other.varianteNom, varianteNom) || other.varianteNom == varianteNom)&&const DeepCollectionEquality().equals(other.supplements, supplements)&&(identical(other.quantite, quantite) || other.quantite == quantite)&&(identical(other.prixUnitaire, prixUnitaire) || other.prixUnitaire == prixUnitaire)&&(identical(other.prixLigne, prixLigne) || other.prixLigne == prixLigne)&&(identical(other.noteSpeciale, noteSpeciale) || other.noteSpeciale == noteSpeciale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,nomArticle,varianteNom,const DeepCollectionEquality().hash(supplements),quantite,prixUnitaire,prixLigne,noteSpeciale);

@override
String toString() {
  return 'LigneCommande(id: $id, article: $article, nomArticle: $nomArticle, varianteNom: $varianteNom, supplements: $supplements, quantite: $quantite, prixUnitaire: $prixUnitaire, prixLigne: $prixLigne, noteSpeciale: $noteSpeciale)';
}


}

/// @nodoc
abstract mixin class $LigneCommandeCopyWith<$Res>  {
  factory $LigneCommandeCopyWith(LigneCommande value, $Res Function(LigneCommande) _then) = _$LigneCommandeCopyWithImpl;
@useResult
$Res call({
 int id, int? article,@JsonKey(name: 'nom_article') String nomArticle,@JsonKey(name: 'variante_nom') String varianteNom, List<SupplementSnapshot> supplements, int quantite,@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int prixUnitaire,@JsonKey(name: 'prix_ligne', fromJson: _versInt) int prixLigne,@JsonKey(name: 'note_speciale') String noteSpeciale
});




}
/// @nodoc
class _$LigneCommandeCopyWithImpl<$Res>
    implements $LigneCommandeCopyWith<$Res> {
  _$LigneCommandeCopyWithImpl(this._self, this._then);

  final LigneCommande _self;
  final $Res Function(LigneCommande) _then;

/// Create a copy of LigneCommande
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? article = freezed,Object? nomArticle = null,Object? varianteNom = null,Object? supplements = null,Object? quantite = null,Object? prixUnitaire = null,Object? prixLigne = null,Object? noteSpeciale = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,nomArticle: null == nomArticle ? _self.nomArticle : nomArticle // ignore: cast_nullable_to_non_nullable
as String,varianteNom: null == varianteNom ? _self.varianteNom : varianteNom // ignore: cast_nullable_to_non_nullable
as String,supplements: null == supplements ? _self.supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<SupplementSnapshot>,quantite: null == quantite ? _self.quantite : quantite // ignore: cast_nullable_to_non_nullable
as int,prixUnitaire: null == prixUnitaire ? _self.prixUnitaire : prixUnitaire // ignore: cast_nullable_to_non_nullable
as int,prixLigne: null == prixLigne ? _self.prixLigne : prixLigne // ignore: cast_nullable_to_non_nullable
as int,noteSpeciale: null == noteSpeciale ? _self.noteSpeciale : noteSpeciale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LigneCommande].
extension LigneCommandePatterns on LigneCommande {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LigneCommande value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LigneCommande() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LigneCommande value)  $default,){
final _that = this;
switch (_that) {
case _LigneCommande():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LigneCommande value)?  $default,){
final _that = this;
switch (_that) {
case _LigneCommande() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? article, @JsonKey(name: 'nom_article')  String nomArticle, @JsonKey(name: 'variante_nom')  String varianteNom,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LigneCommande() when $default != null:
return $default(_that.id,_that.article,_that.nomArticle,_that.varianteNom,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? article, @JsonKey(name: 'nom_article')  String nomArticle, @JsonKey(name: 'variante_nom')  String varianteNom,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)  $default,) {final _that = this;
switch (_that) {
case _LigneCommande():
return $default(_that.id,_that.article,_that.nomArticle,_that.varianteNom,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? article, @JsonKey(name: 'nom_article')  String nomArticle, @JsonKey(name: 'variante_nom')  String varianteNom,  List<SupplementSnapshot> supplements,  int quantite, @JsonKey(name: 'prix_unitaire', fromJson: _versInt)  int prixUnitaire, @JsonKey(name: 'prix_ligne', fromJson: _versInt)  int prixLigne, @JsonKey(name: 'note_speciale')  String noteSpeciale)?  $default,) {final _that = this;
switch (_that) {
case _LigneCommande() when $default != null:
return $default(_that.id,_that.article,_that.nomArticle,_that.varianteNom,_that.supplements,_that.quantite,_that.prixUnitaire,_that.prixLigne,_that.noteSpeciale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LigneCommande implements LigneCommande {
  const _LigneCommande({required this.id, this.article, @JsonKey(name: 'nom_article') this.nomArticle = '', @JsonKey(name: 'variante_nom') this.varianteNom = '', final  List<SupplementSnapshot> supplements = const <SupplementSnapshot>[], this.quantite = 1, @JsonKey(name: 'prix_unitaire', fromJson: _versInt) this.prixUnitaire = 0, @JsonKey(name: 'prix_ligne', fromJson: _versInt) this.prixLigne = 0, @JsonKey(name: 'note_speciale') this.noteSpeciale = ''}): _supplements = supplements;
  factory _LigneCommande.fromJson(Map<String, dynamic> json) => _$LigneCommandeFromJson(json);

@override final  int id;
@override final  int? article;
@override@JsonKey(name: 'nom_article') final  String nomArticle;
@override@JsonKey(name: 'variante_nom') final  String varianteNom;
 final  List<SupplementSnapshot> _supplements;
@override@JsonKey() List<SupplementSnapshot> get supplements {
  if (_supplements is EqualUnmodifiableListView) return _supplements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supplements);
}

@override@JsonKey() final  int quantite;
@override@JsonKey(name: 'prix_unitaire', fromJson: _versInt) final  int prixUnitaire;
@override@JsonKey(name: 'prix_ligne', fromJson: _versInt) final  int prixLigne;
@override@JsonKey(name: 'note_speciale') final  String noteSpeciale;

/// Create a copy of LigneCommande
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LigneCommandeCopyWith<_LigneCommande> get copyWith => __$LigneCommandeCopyWithImpl<_LigneCommande>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LigneCommandeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LigneCommande&&(identical(other.id, id) || other.id == id)&&(identical(other.article, article) || other.article == article)&&(identical(other.nomArticle, nomArticle) || other.nomArticle == nomArticle)&&(identical(other.varianteNom, varianteNom) || other.varianteNom == varianteNom)&&const DeepCollectionEquality().equals(other._supplements, _supplements)&&(identical(other.quantite, quantite) || other.quantite == quantite)&&(identical(other.prixUnitaire, prixUnitaire) || other.prixUnitaire == prixUnitaire)&&(identical(other.prixLigne, prixLigne) || other.prixLigne == prixLigne)&&(identical(other.noteSpeciale, noteSpeciale) || other.noteSpeciale == noteSpeciale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,article,nomArticle,varianteNom,const DeepCollectionEquality().hash(_supplements),quantite,prixUnitaire,prixLigne,noteSpeciale);

@override
String toString() {
  return 'LigneCommande(id: $id, article: $article, nomArticle: $nomArticle, varianteNom: $varianteNom, supplements: $supplements, quantite: $quantite, prixUnitaire: $prixUnitaire, prixLigne: $prixLigne, noteSpeciale: $noteSpeciale)';
}


}

/// @nodoc
abstract mixin class _$LigneCommandeCopyWith<$Res> implements $LigneCommandeCopyWith<$Res> {
  factory _$LigneCommandeCopyWith(_LigneCommande value, $Res Function(_LigneCommande) _then) = __$LigneCommandeCopyWithImpl;
@override @useResult
$Res call({
 int id, int? article,@JsonKey(name: 'nom_article') String nomArticle,@JsonKey(name: 'variante_nom') String varianteNom, List<SupplementSnapshot> supplements, int quantite,@JsonKey(name: 'prix_unitaire', fromJson: _versInt) int prixUnitaire,@JsonKey(name: 'prix_ligne', fromJson: _versInt) int prixLigne,@JsonKey(name: 'note_speciale') String noteSpeciale
});




}
/// @nodoc
class __$LigneCommandeCopyWithImpl<$Res>
    implements _$LigneCommandeCopyWith<$Res> {
  __$LigneCommandeCopyWithImpl(this._self, this._then);

  final _LigneCommande _self;
  final $Res Function(_LigneCommande) _then;

/// Create a copy of LigneCommande
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? article = freezed,Object? nomArticle = null,Object? varianteNom = null,Object? supplements = null,Object? quantite = null,Object? prixUnitaire = null,Object? prixLigne = null,Object? noteSpeciale = null,}) {
  return _then(_LigneCommande(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,nomArticle: null == nomArticle ? _self.nomArticle : nomArticle // ignore: cast_nullable_to_non_nullable
as String,varianteNom: null == varianteNom ? _self.varianteNom : varianteNom // ignore: cast_nullable_to_non_nullable
as String,supplements: null == supplements ? _self._supplements : supplements // ignore: cast_nullable_to_non_nullable
as List<SupplementSnapshot>,quantite: null == quantite ? _self.quantite : quantite // ignore: cast_nullable_to_non_nullable
as int,prixUnitaire: null == prixUnitaire ? _self.prixUnitaire : prixUnitaire // ignore: cast_nullable_to_non_nullable
as int,prixLigne: null == prixLigne ? _self.prixLigne : prixLigne // ignore: cast_nullable_to_non_nullable
as int,noteSpeciale: null == noteSpeciale ? _self.noteSpeciale : noteSpeciale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Commande {

 int get id; String get numero; int? get partenaire;@JsonKey(name: 'partenaire_nom') String get partenaireNom;@JsonKey(name: 'client_nom') String get clientNom;@JsonKey(name: 'mode_livraison') String get modeLivraison;@JsonKey(name: 'adresse_snapshot') String get adresseSnapshot; String get statut;@JsonKey(name: 'raison_refus') String get raisonRefus;@JsonKey(name: 'sous_total', fromJson: _versInt) int get sousTotal;@JsonKey(name: 'frais_livraison', fromJson: _versInt) int get fraisLivraison;@JsonKey(fromJson: _versInt) int get total;@JsonKey(name: 'mode_paiement') String get modePaiement;@JsonKey(name: 'notes_client') String get notesClient; List<LigneCommande> get lignes;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of Commande
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommandeCopyWith<Commande> get copyWith => _$CommandeCopyWithImpl<Commande>(this as Commande, _$identity);

  /// Serializes this Commande to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Commande&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.modeLivraison, modeLivraison) || other.modeLivraison == modeLivraison)&&(identical(other.adresseSnapshot, adresseSnapshot) || other.adresseSnapshot == adresseSnapshot)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.sousTotal, sousTotal) || other.sousTotal == sousTotal)&&(identical(other.fraisLivraison, fraisLivraison) || other.fraisLivraison == fraisLivraison)&&(identical(other.total, total) || other.total == total)&&(identical(other.modePaiement, modePaiement) || other.modePaiement == modePaiement)&&(identical(other.notesClient, notesClient) || other.notesClient == notesClient)&&const DeepCollectionEquality().equals(other.lignes, lignes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,partenaire,partenaireNom,clientNom,modeLivraison,adresseSnapshot,statut,raisonRefus,sousTotal,fraisLivraison,total,modePaiement,notesClient,const DeepCollectionEquality().hash(lignes),createdAt);

@override
String toString() {
  return 'Commande(id: $id, numero: $numero, partenaire: $partenaire, partenaireNom: $partenaireNom, clientNom: $clientNom, modeLivraison: $modeLivraison, adresseSnapshot: $adresseSnapshot, statut: $statut, raisonRefus: $raisonRefus, sousTotal: $sousTotal, fraisLivraison: $fraisLivraison, total: $total, modePaiement: $modePaiement, notesClient: $notesClient, lignes: $lignes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommandeCopyWith<$Res>  {
  factory $CommandeCopyWith(Commande value, $Res Function(Commande) _then) = _$CommandeCopyWithImpl;
@useResult
$Res call({
 int id, String numero, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'client_nom') String clientNom,@JsonKey(name: 'mode_livraison') String modeLivraison,@JsonKey(name: 'adresse_snapshot') String adresseSnapshot, String statut,@JsonKey(name: 'raison_refus') String raisonRefus,@JsonKey(name: 'sous_total', fromJson: _versInt) int sousTotal,@JsonKey(name: 'frais_livraison', fromJson: _versInt) int fraisLivraison,@JsonKey(fromJson: _versInt) int total,@JsonKey(name: 'mode_paiement') String modePaiement,@JsonKey(name: 'notes_client') String notesClient, List<LigneCommande> lignes,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$CommandeCopyWithImpl<$Res>
    implements $CommandeCopyWith<$Res> {
  _$CommandeCopyWithImpl(this._self, this._then);

  final Commande _self;
  final $Res Function(Commande) _then;

/// Create a copy of Commande
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? numero = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? clientNom = null,Object? modeLivraison = null,Object? adresseSnapshot = null,Object? statut = null,Object? raisonRefus = null,Object? sousTotal = null,Object? fraisLivraison = null,Object? total = null,Object? modePaiement = null,Object? notesClient = null,Object? lignes = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,modeLivraison: null == modeLivraison ? _self.modeLivraison : modeLivraison // ignore: cast_nullable_to_non_nullable
as String,adresseSnapshot: null == adresseSnapshot ? _self.adresseSnapshot : adresseSnapshot // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,sousTotal: null == sousTotal ? _self.sousTotal : sousTotal // ignore: cast_nullable_to_non_nullable
as int,fraisLivraison: null == fraisLivraison ? _self.fraisLivraison : fraisLivraison // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,modePaiement: null == modePaiement ? _self.modePaiement : modePaiement // ignore: cast_nullable_to_non_nullable
as String,notesClient: null == notesClient ? _self.notesClient : notesClient // ignore: cast_nullable_to_non_nullable
as String,lignes: null == lignes ? _self.lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LigneCommande>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Commande].
extension CommandePatterns on Commande {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Commande value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Commande() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Commande value)  $default,){
final _that = this;
switch (_that) {
case _Commande():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Commande value)?  $default,){
final _that = this;
switch (_that) {
case _Commande() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String numero,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'mode_livraison')  String modeLivraison, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot,  String statut, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'sous_total', fromJson: _versInt)  int sousTotal, @JsonKey(name: 'frais_livraison', fromJson: _versInt)  int fraisLivraison, @JsonKey(fromJson: _versInt)  int total, @JsonKey(name: 'mode_paiement')  String modePaiement, @JsonKey(name: 'notes_client')  String notesClient,  List<LigneCommande> lignes, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Commande() when $default != null:
return $default(_that.id,_that.numero,_that.partenaire,_that.partenaireNom,_that.clientNom,_that.modeLivraison,_that.adresseSnapshot,_that.statut,_that.raisonRefus,_that.sousTotal,_that.fraisLivraison,_that.total,_that.modePaiement,_that.notesClient,_that.lignes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String numero,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'mode_livraison')  String modeLivraison, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot,  String statut, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'sous_total', fromJson: _versInt)  int sousTotal, @JsonKey(name: 'frais_livraison', fromJson: _versInt)  int fraisLivraison, @JsonKey(fromJson: _versInt)  int total, @JsonKey(name: 'mode_paiement')  String modePaiement, @JsonKey(name: 'notes_client')  String notesClient,  List<LigneCommande> lignes, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Commande():
return $default(_that.id,_that.numero,_that.partenaire,_that.partenaireNom,_that.clientNom,_that.modeLivraison,_that.adresseSnapshot,_that.statut,_that.raisonRefus,_that.sousTotal,_that.fraisLivraison,_that.total,_that.modePaiement,_that.notesClient,_that.lignes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String numero,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom, @JsonKey(name: 'client_nom')  String clientNom, @JsonKey(name: 'mode_livraison')  String modeLivraison, @JsonKey(name: 'adresse_snapshot')  String adresseSnapshot,  String statut, @JsonKey(name: 'raison_refus')  String raisonRefus, @JsonKey(name: 'sous_total', fromJson: _versInt)  int sousTotal, @JsonKey(name: 'frais_livraison', fromJson: _versInt)  int fraisLivraison, @JsonKey(fromJson: _versInt)  int total, @JsonKey(name: 'mode_paiement')  String modePaiement, @JsonKey(name: 'notes_client')  String notesClient,  List<LigneCommande> lignes, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Commande() when $default != null:
return $default(_that.id,_that.numero,_that.partenaire,_that.partenaireNom,_that.clientNom,_that.modeLivraison,_that.adresseSnapshot,_that.statut,_that.raisonRefus,_that.sousTotal,_that.fraisLivraison,_that.total,_that.modePaiement,_that.notesClient,_that.lignes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Commande extends Commande {
  const _Commande({required this.id, this.numero = '', this.partenaire, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', @JsonKey(name: 'client_nom') this.clientNom = '', @JsonKey(name: 'mode_livraison') this.modeLivraison = 'emporter', @JsonKey(name: 'adresse_snapshot') this.adresseSnapshot = '', this.statut = 'nouvelle', @JsonKey(name: 'raison_refus') this.raisonRefus = '', @JsonKey(name: 'sous_total', fromJson: _versInt) this.sousTotal = 0, @JsonKey(name: 'frais_livraison', fromJson: _versInt) this.fraisLivraison = 0, @JsonKey(fromJson: _versInt) this.total = 0, @JsonKey(name: 'mode_paiement') this.modePaiement = 'cash', @JsonKey(name: 'notes_client') this.notesClient = '', final  List<LigneCommande> lignes = const <LigneCommande>[], @JsonKey(name: 'created_at') this.createdAt}): _lignes = lignes,super._();
  factory _Commande.fromJson(Map<String, dynamic> json) => _$CommandeFromJson(json);

@override final  int id;
@override@JsonKey() final  String numero;
@override final  int? partenaire;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override@JsonKey(name: 'client_nom') final  String clientNom;
@override@JsonKey(name: 'mode_livraison') final  String modeLivraison;
@override@JsonKey(name: 'adresse_snapshot') final  String adresseSnapshot;
@override@JsonKey() final  String statut;
@override@JsonKey(name: 'raison_refus') final  String raisonRefus;
@override@JsonKey(name: 'sous_total', fromJson: _versInt) final  int sousTotal;
@override@JsonKey(name: 'frais_livraison', fromJson: _versInt) final  int fraisLivraison;
@override@JsonKey(fromJson: _versInt) final  int total;
@override@JsonKey(name: 'mode_paiement') final  String modePaiement;
@override@JsonKey(name: 'notes_client') final  String notesClient;
 final  List<LigneCommande> _lignes;
@override@JsonKey() List<LigneCommande> get lignes {
  if (_lignes is EqualUnmodifiableListView) return _lignes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lignes);
}

@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of Commande
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommandeCopyWith<_Commande> get copyWith => __$CommandeCopyWithImpl<_Commande>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommandeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Commande&&(identical(other.id, id) || other.id == id)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.modeLivraison, modeLivraison) || other.modeLivraison == modeLivraison)&&(identical(other.adresseSnapshot, adresseSnapshot) || other.adresseSnapshot == adresseSnapshot)&&(identical(other.statut, statut) || other.statut == statut)&&(identical(other.raisonRefus, raisonRefus) || other.raisonRefus == raisonRefus)&&(identical(other.sousTotal, sousTotal) || other.sousTotal == sousTotal)&&(identical(other.fraisLivraison, fraisLivraison) || other.fraisLivraison == fraisLivraison)&&(identical(other.total, total) || other.total == total)&&(identical(other.modePaiement, modePaiement) || other.modePaiement == modePaiement)&&(identical(other.notesClient, notesClient) || other.notesClient == notesClient)&&const DeepCollectionEquality().equals(other._lignes, _lignes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,numero,partenaire,partenaireNom,clientNom,modeLivraison,adresseSnapshot,statut,raisonRefus,sousTotal,fraisLivraison,total,modePaiement,notesClient,const DeepCollectionEquality().hash(_lignes),createdAt);

@override
String toString() {
  return 'Commande(id: $id, numero: $numero, partenaire: $partenaire, partenaireNom: $partenaireNom, clientNom: $clientNom, modeLivraison: $modeLivraison, adresseSnapshot: $adresseSnapshot, statut: $statut, raisonRefus: $raisonRefus, sousTotal: $sousTotal, fraisLivraison: $fraisLivraison, total: $total, modePaiement: $modePaiement, notesClient: $notesClient, lignes: $lignes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommandeCopyWith<$Res> implements $CommandeCopyWith<$Res> {
  factory _$CommandeCopyWith(_Commande value, $Res Function(_Commande) _then) = __$CommandeCopyWithImpl;
@override @useResult
$Res call({
 int id, String numero, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom,@JsonKey(name: 'client_nom') String clientNom,@JsonKey(name: 'mode_livraison') String modeLivraison,@JsonKey(name: 'adresse_snapshot') String adresseSnapshot, String statut,@JsonKey(name: 'raison_refus') String raisonRefus,@JsonKey(name: 'sous_total', fromJson: _versInt) int sousTotal,@JsonKey(name: 'frais_livraison', fromJson: _versInt) int fraisLivraison,@JsonKey(fromJson: _versInt) int total,@JsonKey(name: 'mode_paiement') String modePaiement,@JsonKey(name: 'notes_client') String notesClient, List<LigneCommande> lignes,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$CommandeCopyWithImpl<$Res>
    implements _$CommandeCopyWith<$Res> {
  __$CommandeCopyWithImpl(this._self, this._then);

  final _Commande _self;
  final $Res Function(_Commande) _then;

/// Create a copy of Commande
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? numero = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? clientNom = null,Object? modeLivraison = null,Object? adresseSnapshot = null,Object? statut = null,Object? raisonRefus = null,Object? sousTotal = null,Object? fraisLivraison = null,Object? total = null,Object? modePaiement = null,Object? notesClient = null,Object? lignes = null,Object? createdAt = freezed,}) {
  return _then(_Commande(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,modeLivraison: null == modeLivraison ? _self.modeLivraison : modeLivraison // ignore: cast_nullable_to_non_nullable
as String,adresseSnapshot: null == adresseSnapshot ? _self.adresseSnapshot : adresseSnapshot // ignore: cast_nullable_to_non_nullable
as String,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,raisonRefus: null == raisonRefus ? _self.raisonRefus : raisonRefus // ignore: cast_nullable_to_non_nullable
as String,sousTotal: null == sousTotal ? _self.sousTotal : sousTotal // ignore: cast_nullable_to_non_nullable
as int,fraisLivraison: null == fraisLivraison ? _self.fraisLivraison : fraisLivraison // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,modePaiement: null == modePaiement ? _self.modePaiement : modePaiement // ignore: cast_nullable_to_non_nullable
as String,notesClient: null == notesClient ? _self.notesClient : notesClient // ignore: cast_nullable_to_non_nullable
as String,lignes: null == lignes ? _self._lignes : lignes // ignore: cast_nullable_to_non_nullable
as List<LigneCommande>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
