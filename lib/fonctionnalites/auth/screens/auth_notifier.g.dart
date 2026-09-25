// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
///
/// Session robuste : seul un VRAI échec d'authentification (refresh refusé,
/// 401/403 après renouvellement) déconnecte. Un timeout, une coupure réseau
/// ou un 5xx gardent la session : l'app démarre avec le dernier utilisateur
/// connu (cache disque) et `moi` est revalidé en arrière-plan.

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
///
/// Session robuste : seul un VRAI échec d'authentification (refresh refusé,
/// 401/403 après renouvellement) déconnecte. Un timeout, une coupure réseau
/// ou un 5xx gardent la session : l'app démarre avec le dernier utilisateur
/// connu (cache disque) et `moi` est revalidé en arrière-plan.
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, Utilisateur?> {
  /// État d'authentification de l'app.
  /// - data(null)        → déconnecté
  /// - data(Utilisateur) → connecté
  /// - loading           → vérification/connexion en cours
  ///
  /// Session robuste : seul un VRAI échec d'authentification (refresh refusé,
  /// 401/403 après renouvellement) déconnecte. Un timeout, une coupure réseau
  /// ou un 5xx gardent la session : l'app démarre avec le dernier utilisateur
  /// connu (cache disque) et `moi` est revalidé en arrière-plan.
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'dc4e052c140366899b0fc379810ede72c4991e41';

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
///
/// Session robuste : seul un VRAI échec d'authentification (refresh refusé,
/// 401/403 après renouvellement) déconnecte. Un timeout, une coupure réseau
/// ou un 5xx gardent la session : l'app démarre avec le dernier utilisateur
/// connu (cache disque) et `moi` est revalidé en arrière-plan.

abstract class _$AuthNotifier extends $AsyncNotifier<Utilisateur?> {
  FutureOr<Utilisateur?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Utilisateur?>, Utilisateur?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Utilisateur?>, Utilisateur?>,
              AsyncValue<Utilisateur?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
