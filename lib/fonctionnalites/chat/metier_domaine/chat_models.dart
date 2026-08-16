import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

/// Un message dans une conversation.
/// Reçu soit via REST (historique), soit via WebSocket (temps réel).
@freezed
abstract class Message with _$Message {
  const Message._();

  const factory Message({
    required int id,
    required int conversation,
    int? expediteur,
    @JsonKey(name: 'expediteur_nom') @Default('') String expediteurNom,
    @Default('') String contenu,
    @JsonKey(name: 'created_at') String? createdAt,
  @Default('envoye') String statut,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Vrai si ce message a été envoyé par l'utilisateur d'id [monId].
  bool estDeMoi(int monId) => expediteur == monId;
}

/// Aperçu du dernier message (imbriqué dans Conversation).
@freezed
abstract class DernierMessage with _$DernierMessage {
  const factory DernierMessage({
    @Default('') String contenu,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _DernierMessage;

  factory DernierMessage.fromJson(Map<String, dynamic> json) =>
      _$DernierMessageFromJson(json);
}

/// Une conversation entre un client et un partenaire.
@freezed
abstract class Conversation with _$Conversation {
  const Conversation._();

  const factory Conversation({
    required int id,
    int? client,
    @JsonKey(name: 'client_nom') @Default('') String clientNom,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    int? article,
    @JsonKey(name: 'derniere_activite') String? derniereActivite,
    @JsonKey(name: 'est_archivee') @Default(false) bool estArchivee,
    @JsonKey(name: 'dernier_message') DernierMessage? dernierMessage,
    @JsonKey(name: 'created_at') String? createdAt,
    @Default(false) bool nouvelle,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// Nom à afficher côté client : le partenaire.
  /// (Côté partenaire, on affichera plutôt clientNom — géré dans l'UI.)
  String get titre =>
      partenaireNom.isNotEmpty ? partenaireNom : 'Conversation';
}
