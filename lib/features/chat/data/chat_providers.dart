import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../../auth/screens/auth_notifier.dart';
import '../domain/chat_models.dart';
import 'chat_repository.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(dio: ref.watch(dioProvider));
}

/// Mes conversations (client + partenaire).
@riverpod
Future<List<Conversation>> conversations(Ref ref) {
  return ref.watch(chatRepositoryProvider).conversations();
}

/// Historique d'une conversation (chargé une fois à l'ouverture ;
/// les messages temps réel arrivent ensuite via le socket).
@riverpod
Future<List<Message>> historiqueMessages(Ref ref, {required int conversationId}) {
  return ref.watch(chatRepositoryProvider).messages(conversationId);
}

/// Id de l'utilisateur connecté, pour distinguer mes messages.
/// Renvoie null si non connecté (ne devrait pas arriver dans le chat).
@riverpod
int? monUtilisateurId(Ref ref) {
  final auth = ref.watch(authProvider);
  return auth.value?.id;
}
