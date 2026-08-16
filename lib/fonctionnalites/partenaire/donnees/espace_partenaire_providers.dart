import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import '../metier_domaine/ma_categorie.dart';
import '../metier_domaine/stats_vues.dart';
import 'espace_partenaire_repository.dart';

part 'espace_partenaire_providers.g.dart';

@riverpod
EspacePartenaireRepository espacePartenaireRepository(Ref ref) {
  return EspacePartenaireRepository(dio: ref.watch(dioProvider));
}

/// Stats de vues du partenaire. Invalider après CRUD article.
@riverpod
Future<StatsVues> statsVuesPartenaire(Ref ref) {
  return ref.watch(espacePartenaireRepositoryProvider).statsVues();
}

/// Profil du partenaire connecte.
@riverpod
Future<Map<String, dynamic>> monProfilPartenaire(Ref ref) {
  return ref.watch(espacePartenaireRepositoryProvider).monProfil();
}

/// Categories du partenaire connecte.
@riverpod
Future<List<MaCategorie>> mesCategories(Ref ref) {
  return ref.watch(espacePartenaireRepositoryProvider).mesCategories();
}
