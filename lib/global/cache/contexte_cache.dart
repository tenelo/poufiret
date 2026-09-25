import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;

import '../../fonctionnalites/auth/metier_domaine/utilisateur.dart';
import '../../fonctionnalites/auth/screens/auth_notifier.dart';
import 'cache_api.dart';
import 'cache_providers.dart';

/// Contexte courant du cache : utilisateur connecté + département, ou visiteur.
///
/// Suit l'état d'authentification mais IGNORE les phases de chargement
/// transitoires (changement de PIN, revalidation...) : le contexte ne
/// « clignote » pas vers le visiteur, ce qui rechargerait tous les écrans.
final contexteCacheProvider =
    NotifierProvider<ContexteCacheNotifier, ContexteCache>(
      ContexteCacheNotifier.new,
    );

class ContexteCacheNotifier extends Notifier<ContexteCache> {
  static ContexteCache _depuis(Utilisateur? u) =>
      u == null ? ContexteCache.anonyme : ContexteCache.utilisateur(u.id, u.departement);

  @override
  ContexteCache build() {
    ref.listen(authProvider, (_, suivant) {
      if (suivant.isLoading) return;
      final c = _depuis(suivant.value);
      if (c != state) state = c;
    });
    final auth = ref.read(authProvider);
    return auth.isLoading ? ContexteCache.anonyme : _depuis(auth.value);
  }
}

/// Garde un provider en mémoire pendant [duree] (sa durée « fraîche »), puis
/// le laisse se libérer. Remplace l'autoDispose qui refaisait l'appel à
/// chaque navigation.
extension GarderVivant on Ref {
  void garderVivant(Duration duree) {
    if (duree <= Duration.zero) return;
    final lien = keepAlive();
    final minuteur = Timer(duree, lien.close);
    onDispose(minuteur.cancel);
  }
}

/// Flux SWR pour un provider : à appeler dans le corps synchrone du provider
/// (tout accès à `ref` doit avoir lieu AVANT le premier `await` du flux).
Stream<T> fluxCache<T>(
  Ref ref, {
  required String cle,
  required PolitiqueCache politique,
  required Future<Object?> Function() reseau,
  required T Function(Object? json) decoder,
}) {
  final contexte = ref.watch(contexteCacheProvider);
  final api = ref.watch(cacheApiProvider);
  ref.garderVivant(politique.frais);
  return api.flux<T>(
    contexte: contexte,
    cle: cle,
    politique: politique,
    reseau: reseau,
    decoder: decoder,
  );
}

/// Variante qui indique l'origine (cache / réseau) de chaque valeur.
Stream<Source<T>> fluxCacheSource<T>(
  Ref ref, {
  required String cle,
  required PolitiqueCache politique,
  required Future<Object?> Function() reseau,
  required T Function(Object? json) decoder,
  bool revalider = false,
}) {
  final contexte = ref.watch(contexteCacheProvider);
  final api = ref.watch(cacheApiProvider);
  ref.garderVivant(politique.frais);
  return api.fluxSource<T>(
    contexte: contexte,
    cle: cle,
    politique: politique,
    reseau: reseau,
    decoder: decoder,
    revalider: revalider,
  );
}

/// Pull-to-refresh : force le réseau (invalidate) et attend la fin du
/// chargement, pour que l'indicateur ne disparaisse pas avant les données.
Future<void> rafraichir(WidgetRef ref, ProviderOrFamily provider) async {
  ref.invalidate(provider);
  await ref.read(cacheApiProvider).attendreFinChargements();
}
