// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: (json['id'] as num).toInt(),
  conversation: (json['conversation'] as num).toInt(),
  expediteur: (json['expediteur'] as num?)?.toInt(),
  expediteurNom: json['expediteur_nom'] as String? ?? '',
  contenu: json['contenu'] as String? ?? '',
  createdAt: json['created_at'] as String?,
  statut: json['statut'] as String? ?? 'envoye',
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'conversation': instance.conversation,
  'expediteur': instance.expediteur,
  'expediteur_nom': instance.expediteurNom,
  'contenu': instance.contenu,
  'created_at': instance.createdAt,
  'statut': instance.statut,
};

_DernierMessage _$DernierMessageFromJson(Map<String, dynamic> json) =>
    _DernierMessage(
      contenu: json['contenu'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$DernierMessageToJson(_DernierMessage instance) =>
    <String, dynamic>{
      'contenu': instance.contenu,
      'created_at': instance.createdAt,
    };

_Conversation _$ConversationFromJson(Map<String, dynamic> json) =>
    _Conversation(
      id: (json['id'] as num).toInt(),
      client: (json['client'] as num?)?.toInt(),
      clientNom: json['client_nom'] as String? ?? '',
      partenaire: (json['partenaire'] as num?)?.toInt(),
      partenaireNom: json['partenaire_nom'] as String? ?? '',
      article: (json['article'] as num?)?.toInt(),
      derniereActivite: json['derniere_activite'] as String?,
      estArchivee: json['est_archivee'] as bool? ?? false,
      dernierMessage: json['dernier_message'] == null
          ? null
          : DernierMessage.fromJson(
              json['dernier_message'] as Map<String, dynamic>,
            ),
      createdAt: json['created_at'] as String?,
      nouvelle: json['nouvelle'] as bool? ?? false,
    );

Map<String, dynamic> _$ConversationToJson(_Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'client_nom': instance.clientNom,
      'partenaire': instance.partenaire,
      'partenaire_nom': instance.partenaireNom,
      'article': instance.article,
      'derniere_activite': instance.derniereActivite,
      'est_archivee': instance.estArchivee,
      'dernier_message': instance.dernierMessage,
      'created_at': instance.createdAt,
      'nouvelle': instance.nouvelle,
    };
