import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../domain/demande_intervention.dart';
import 'prestations_repository.dart';

part 'prestations_providers.g.dart';

@riverpod
PrestationsRepository prestationsRepository(Ref ref) {
  return PrestationsRepository(dio: ref.watch(dioProvider));
}

/// Mes demandes d'intervention (client). Invalider après création/annulation.
@riverpod
Future<List<DemandeIntervention>> mesDemandesIntervention(Ref ref) {
  return ref.watch(prestationsRepositoryProvider).mesDemandes();
}

/// Demandes reçues (artisan). Invalider après transition.
@riverpod
Future<List<DemandeIntervention>> demandesInterventionRecues(Ref ref) {
  return ref.watch(prestationsRepositoryProvider).demandesRecues();
}

/// Détail d'une demande.
@riverpod
Future<DemandeIntervention> demandeInterventionDetail(Ref ref, {required int id}) {
  return ref.watch(prestationsRepositoryProvider).detail(id);
}
