import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/commentaire.dart';
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

/// Commentaires d'une vitrine partenaire (racines + réponses imbriquées).
@riverpod
Future<List<Commentaire>> commentairesPartenaire(
  Ref ref, {
  required int partenaireId,
}) {
  return ref
      .watch(socialRepositoryProvider)
      .commentairesPartenaire(partenaireId);
}
