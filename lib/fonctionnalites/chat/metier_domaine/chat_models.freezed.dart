// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {

 int get id; int get conversation; int? get expediteur;@JsonKey(name: 'expediteur_nom') String get expediteurNom; String get contenu;@JsonKey(name: 'created_at') String? get createdAt; String get statut;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&(identical(other.expediteur, expediteur) || other.expediteur == expediteur)&&(identical(other.expediteurNom, expediteurNom) || other.expediteurNom == expediteurNom)&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.statut, statut) || other.statut == statut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversation,expediteur,expediteurNom,contenu,createdAt,statut);

@override
String toString() {
  return 'Message(id: $id, conversation: $conversation, expediteur: $expediteur, expediteurNom: $expediteurNom, contenu: $contenu, createdAt: $createdAt, statut: $statut)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 int id, int conversation, int? expediteur,@JsonKey(name: 'expediteur_nom') String expediteurNom, String contenu,@JsonKey(name: 'created_at') String? createdAt, String statut
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversation = null,Object? expediteur = freezed,Object? expediteurNom = null,Object? contenu = null,Object? createdAt = freezed,Object? statut = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversation: null == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as int,expediteur: freezed == expediteur ? _self.expediteur : expediteur // ignore: cast_nullable_to_non_nullable
as int?,expediteurNom: null == expediteurNom ? _self.expediteurNom : expediteurNom // ignore: cast_nullable_to_non_nullable
as String,contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversation,  int? expediteur, @JsonKey(name: 'expediteur_nom')  String expediteurNom,  String contenu, @JsonKey(name: 'created_at')  String? createdAt,  String statut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.conversation,_that.expediteur,_that.expediteurNom,_that.contenu,_that.createdAt,_that.statut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversation,  int? expediteur, @JsonKey(name: 'expediteur_nom')  String expediteurNom,  String contenu, @JsonKey(name: 'created_at')  String? createdAt,  String statut)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.conversation,_that.expediteur,_that.expediteurNom,_that.contenu,_that.createdAt,_that.statut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversation,  int? expediteur, @JsonKey(name: 'expediteur_nom')  String expediteurNom,  String contenu, @JsonKey(name: 'created_at')  String? createdAt,  String statut)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.conversation,_that.expediteur,_that.expediteurNom,_that.contenu,_that.createdAt,_that.statut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message extends Message {
  const _Message({required this.id, required this.conversation, this.expediteur, @JsonKey(name: 'expediteur_nom') this.expediteurNom = '', this.contenu = '', @JsonKey(name: 'created_at') this.createdAt, this.statut = 'envoye'}): super._();
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override final  int id;
@override final  int conversation;
@override final  int? expediteur;
@override@JsonKey(name: 'expediteur_nom') final  String expediteurNom;
@override@JsonKey() final  String contenu;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey() final  String statut;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&(identical(other.expediteur, expediteur) || other.expediteur == expediteur)&&(identical(other.expediteurNom, expediteurNom) || other.expediteurNom == expediteurNom)&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.statut, statut) || other.statut == statut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversation,expediteur,expediteurNom,contenu,createdAt,statut);

@override
String toString() {
  return 'Message(id: $id, conversation: $conversation, expediteur: $expediteur, expediteurNom: $expediteurNom, contenu: $contenu, createdAt: $createdAt, statut: $statut)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversation, int? expediteur,@JsonKey(name: 'expediteur_nom') String expediteurNom, String contenu,@JsonKey(name: 'created_at') String? createdAt, String statut
});




}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversation = null,Object? expediteur = freezed,Object? expediteurNom = null,Object? contenu = null,Object? createdAt = freezed,Object? statut = null,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversation: null == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as int,expediteur: freezed == expediteur ? _self.expediteur : expediteur // ignore: cast_nullable_to_non_nullable
as int?,expediteurNom: null == expediteurNom ? _self.expediteurNom : expediteurNom // ignore: cast_nullable_to_non_nullable
as String,contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,statut: null == statut ? _self.statut : statut // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DernierMessage {

 String get contenu;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of DernierMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DernierMessageCopyWith<DernierMessage> get copyWith => _$DernierMessageCopyWithImpl<DernierMessage>(this as DernierMessage, _$identity);

  /// Serializes this DernierMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DernierMessage&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contenu,createdAt);

@override
String toString() {
  return 'DernierMessage(contenu: $contenu, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DernierMessageCopyWith<$Res>  {
  factory $DernierMessageCopyWith(DernierMessage value, $Res Function(DernierMessage) _then) = _$DernierMessageCopyWithImpl;
@useResult
$Res call({
 String contenu,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$DernierMessageCopyWithImpl<$Res>
    implements $DernierMessageCopyWith<$Res> {
  _$DernierMessageCopyWithImpl(this._self, this._then);

  final DernierMessage _self;
  final $Res Function(DernierMessage) _then;

/// Create a copy of DernierMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contenu = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DernierMessage].
extension DernierMessagePatterns on DernierMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DernierMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DernierMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DernierMessage value)  $default,){
final _that = this;
switch (_that) {
case _DernierMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DernierMessage value)?  $default,){
final _that = this;
switch (_that) {
case _DernierMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contenu, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DernierMessage() when $default != null:
return $default(_that.contenu,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contenu, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DernierMessage():
return $default(_that.contenu,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contenu, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DernierMessage() when $default != null:
return $default(_that.contenu,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DernierMessage implements DernierMessage {
  const _DernierMessage({this.contenu = '', @JsonKey(name: 'created_at') this.createdAt});
  factory _DernierMessage.fromJson(Map<String, dynamic> json) => _$DernierMessageFromJson(json);

@override@JsonKey() final  String contenu;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of DernierMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DernierMessageCopyWith<_DernierMessage> get copyWith => __$DernierMessageCopyWithImpl<_DernierMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DernierMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DernierMessage&&(identical(other.contenu, contenu) || other.contenu == contenu)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contenu,createdAt);

@override
String toString() {
  return 'DernierMessage(contenu: $contenu, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DernierMessageCopyWith<$Res> implements $DernierMessageCopyWith<$Res> {
  factory _$DernierMessageCopyWith(_DernierMessage value, $Res Function(_DernierMessage) _then) = __$DernierMessageCopyWithImpl;
@override @useResult
$Res call({
 String contenu,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$DernierMessageCopyWithImpl<$Res>
    implements _$DernierMessageCopyWith<$Res> {
  __$DernierMessageCopyWithImpl(this._self, this._then);

  final _DernierMessage _self;
  final $Res Function(_DernierMessage) _then;

/// Create a copy of DernierMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contenu = null,Object? createdAt = freezed,}) {
  return _then(_DernierMessage(
contenu: null == contenu ? _self.contenu : contenu // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Conversation {

 int get id; int? get client;@JsonKey(name: 'client_nom') String get clientNom; int? get partenaire;@JsonKey(name: 'partenaire_nom') String get partenaireNom; int? get article;@JsonKey(name: 'derniere_activite') String? get derniereActivite;@JsonKey(name: 'est_archivee') bool get estArchivee;@JsonKey(name: 'dernier_message') DernierMessage? get dernierMessage;@JsonKey(name: 'created_at') String? get createdAt; bool get nouvelle;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.article, article) || other.article == article)&&(identical(other.derniereActivite, derniereActivite) || other.derniereActivite == derniereActivite)&&(identical(other.estArchivee, estArchivee) || other.estArchivee == estArchivee)&&(identical(other.dernierMessage, dernierMessage) || other.dernierMessage == dernierMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.nouvelle, nouvelle) || other.nouvelle == nouvelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,client,clientNom,partenaire,partenaireNom,article,derniereActivite,estArchivee,dernierMessage,createdAt,nouvelle);

@override
String toString() {
  return 'Conversation(id: $id, client: $client, clientNom: $clientNom, partenaire: $partenaire, partenaireNom: $partenaireNom, article: $article, derniereActivite: $derniereActivite, estArchivee: $estArchivee, dernierMessage: $dernierMessage, createdAt: $createdAt, nouvelle: $nouvelle)';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 int id, int? client,@JsonKey(name: 'client_nom') String clientNom, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? article,@JsonKey(name: 'derniere_activite') String? derniereActivite,@JsonKey(name: 'est_archivee') bool estArchivee,@JsonKey(name: 'dernier_message') DernierMessage? dernierMessage,@JsonKey(name: 'created_at') String? createdAt, bool nouvelle
});


$DernierMessageCopyWith<$Res>? get dernierMessage;

}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? client = freezed,Object? clientNom = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? article = freezed,Object? derniereActivite = freezed,Object? estArchivee = null,Object? dernierMessage = freezed,Object? createdAt = freezed,Object? nouvelle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as int?,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,derniereActivite: freezed == derniereActivite ? _self.derniereActivite : derniereActivite // ignore: cast_nullable_to_non_nullable
as String?,estArchivee: null == estArchivee ? _self.estArchivee : estArchivee // ignore: cast_nullable_to_non_nullable
as bool,dernierMessage: freezed == dernierMessage ? _self.dernierMessage : dernierMessage // ignore: cast_nullable_to_non_nullable
as DernierMessage?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,nouvelle: null == nouvelle ? _self.nouvelle : nouvelle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DernierMessageCopyWith<$Res>? get dernierMessage {
    if (_self.dernierMessage == null) {
    return null;
  }

  return $DernierMessageCopyWith<$Res>(_self.dernierMessage!, (value) {
    return _then(_self.copyWith(dernierMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? client, @JsonKey(name: 'client_nom')  String clientNom,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? article, @JsonKey(name: 'derniere_activite')  String? derniereActivite, @JsonKey(name: 'est_archivee')  bool estArchivee, @JsonKey(name: 'dernier_message')  DernierMessage? dernierMessage, @JsonKey(name: 'created_at')  String? createdAt,  bool nouvelle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.client,_that.clientNom,_that.partenaire,_that.partenaireNom,_that.article,_that.derniereActivite,_that.estArchivee,_that.dernierMessage,_that.createdAt,_that.nouvelle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? client, @JsonKey(name: 'client_nom')  String clientNom,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? article, @JsonKey(name: 'derniere_activite')  String? derniereActivite, @JsonKey(name: 'est_archivee')  bool estArchivee, @JsonKey(name: 'dernier_message')  DernierMessage? dernierMessage, @JsonKey(name: 'created_at')  String? createdAt,  bool nouvelle)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.client,_that.clientNom,_that.partenaire,_that.partenaireNom,_that.article,_that.derniereActivite,_that.estArchivee,_that.dernierMessage,_that.createdAt,_that.nouvelle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? client, @JsonKey(name: 'client_nom')  String clientNom,  int? partenaire, @JsonKey(name: 'partenaire_nom')  String partenaireNom,  int? article, @JsonKey(name: 'derniere_activite')  String? derniereActivite, @JsonKey(name: 'est_archivee')  bool estArchivee, @JsonKey(name: 'dernier_message')  DernierMessage? dernierMessage, @JsonKey(name: 'created_at')  String? createdAt,  bool nouvelle)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.client,_that.clientNom,_that.partenaire,_that.partenaireNom,_that.article,_that.derniereActivite,_that.estArchivee,_that.dernierMessage,_that.createdAt,_that.nouvelle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Conversation extends Conversation {
  const _Conversation({required this.id, this.client, @JsonKey(name: 'client_nom') this.clientNom = '', this.partenaire, @JsonKey(name: 'partenaire_nom') this.partenaireNom = '', this.article, @JsonKey(name: 'derniere_activite') this.derniereActivite, @JsonKey(name: 'est_archivee') this.estArchivee = false, @JsonKey(name: 'dernier_message') this.dernierMessage, @JsonKey(name: 'created_at') this.createdAt, this.nouvelle = false}): super._();
  factory _Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

@override final  int id;
@override final  int? client;
@override@JsonKey(name: 'client_nom') final  String clientNom;
@override final  int? partenaire;
@override@JsonKey(name: 'partenaire_nom') final  String partenaireNom;
@override final  int? article;
@override@JsonKey(name: 'derniere_activite') final  String? derniereActivite;
@override@JsonKey(name: 'est_archivee') final  bool estArchivee;
@override@JsonKey(name: 'dernier_message') final  DernierMessage? dernierMessage;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey() final  bool nouvelle;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&(identical(other.clientNom, clientNom) || other.clientNom == clientNom)&&(identical(other.partenaire, partenaire) || other.partenaire == partenaire)&&(identical(other.partenaireNom, partenaireNom) || other.partenaireNom == partenaireNom)&&(identical(other.article, article) || other.article == article)&&(identical(other.derniereActivite, derniereActivite) || other.derniereActivite == derniereActivite)&&(identical(other.estArchivee, estArchivee) || other.estArchivee == estArchivee)&&(identical(other.dernierMessage, dernierMessage) || other.dernierMessage == dernierMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.nouvelle, nouvelle) || other.nouvelle == nouvelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,client,clientNom,partenaire,partenaireNom,article,derniereActivite,estArchivee,dernierMessage,createdAt,nouvelle);

@override
String toString() {
  return 'Conversation(id: $id, client: $client, clientNom: $clientNom, partenaire: $partenaire, partenaireNom: $partenaireNom, article: $article, derniereActivite: $derniereActivite, estArchivee: $estArchivee, dernierMessage: $dernierMessage, createdAt: $createdAt, nouvelle: $nouvelle)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 int id, int? client,@JsonKey(name: 'client_nom') String clientNom, int? partenaire,@JsonKey(name: 'partenaire_nom') String partenaireNom, int? article,@JsonKey(name: 'derniere_activite') String? derniereActivite,@JsonKey(name: 'est_archivee') bool estArchivee,@JsonKey(name: 'dernier_message') DernierMessage? dernierMessage,@JsonKey(name: 'created_at') String? createdAt, bool nouvelle
});


@override $DernierMessageCopyWith<$Res>? get dernierMessage;

}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? client = freezed,Object? clientNom = null,Object? partenaire = freezed,Object? partenaireNom = null,Object? article = freezed,Object? derniereActivite = freezed,Object? estArchivee = null,Object? dernierMessage = freezed,Object? createdAt = freezed,Object? nouvelle = null,}) {
  return _then(_Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as int?,clientNom: null == clientNom ? _self.clientNom : clientNom // ignore: cast_nullable_to_non_nullable
as String,partenaire: freezed == partenaire ? _self.partenaire : partenaire // ignore: cast_nullable_to_non_nullable
as int?,partenaireNom: null == partenaireNom ? _self.partenaireNom : partenaireNom // ignore: cast_nullable_to_non_nullable
as String,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as int?,derniereActivite: freezed == derniereActivite ? _self.derniereActivite : derniereActivite // ignore: cast_nullable_to_non_nullable
as String?,estArchivee: null == estArchivee ? _self.estArchivee : estArchivee // ignore: cast_nullable_to_non_nullable
as bool,dernierMessage: freezed == dernierMessage ? _self.dernierMessage : dernierMessage // ignore: cast_nullable_to_non_nullable
as DernierMessage?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,nouvelle: null == nouvelle ? _self.nouvelle : nouvelle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DernierMessageCopyWith<$Res>? get dernierMessage {
    if (_self.dernierMessage == null) {
    return null;
  }

  return $DernierMessageCopyWith<$Res>(_self.dernierMessage!, (value) {
    return _then(_self.copyWith(dernierMessage: value));
  });
}
}

// dart format on
