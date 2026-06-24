import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/commentaire.dart';
import 'social_repository.dart';

part 'social_providers.g.dart';

@riverpod
SocialRepository socialRepository(Ref ref) {
  return SocialRepository(dio: ref.watch(dioProvider));
}

/// Commentaires d'un article (rechargeable via invalidate).
@riverpod
Future<List<Commentaire>> commentairesArticle(
  Ref ref, {
  required int articleId,
}) {
  return ref.watch(socialRepositoryProvider).commentairesArticle(articleId);
}
