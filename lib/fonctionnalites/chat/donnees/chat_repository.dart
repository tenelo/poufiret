import 'package:dio/dio.dart';

import '../../../global/config/env.dart';
import '../metier_domaine/chat_models.dart';

class ChatRepository {
  final Dio _dio;

  ChatRepository({required Dio dio}) : _dio = dio;

  /// POST /messaging/contacter/ — ouvre (ou récupère) une conversation
  /// à partir d'un article. Renvoie la conversation avec `nouvelle`.
  Future<Conversation> contacter({int? articleId, int? partenaireId}) async {
    assert(articleId != null || partenaireId != null);
    final r = await _dio.post(
      '${Env.apiPrefix}/messaging/contacter/',
      data: articleId != null
          ? {'article': articleId}
          : {'partenaire': partenaireId},
    );
    return Conversation.fromJson(r.data as Map<String, dynamic>);
  }

  /// GET /messaging/conversations/ — mes conversations (client + partenaire).
  Future<List<Conversation>> conversations() async {
    final r = await _dio.get('${Env.apiPrefix}/messaging/conversations/');
    final data = r.data as List;
    return data
        .cast<Map<String, dynamic>>()
        .map(Conversation.fromJson)
        .toList();
  }

  /// GET /messaging/conversations/<id>/messages/ — historique trié chrono.
  Future<List<Message>> messages(int conversationId) async {
    final r = await _dio.get(
      '${Env.apiPrefix}/messaging/conversations/$conversationId/messages/',
    );
    final data = r.data as List;
    return data.cast<Map<String, dynamic>>().map(Message.fromJson).toList();
  }
}
