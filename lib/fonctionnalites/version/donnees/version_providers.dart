import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../metier_domaine/info_version.dart';
import 'version_repository.dart';

/// Repository de contrôle de version (Dio nu, sans auth).
final versionRepositoryProvider = Provider<VersionRepository>(
  (ref) => VersionRepository(),
);

/// Vérification de version au démarrage, en arrière-plan.
///
/// Non bloquant : tant que ce Future n'a pas répondu, l'app s'affiche
/// normalement. Seul un statut 'obligatoire' déclenche l'écran bloquant,
/// via CoucheMiseAJour. En cas d'erreur, le repository renvoie « à jour ».
final controleVersionProvider = FutureProvider<InfoVersion>(
  (ref) => ref.watch(versionRepositoryProvider).verifier(),
);
