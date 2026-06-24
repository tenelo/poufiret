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

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, Utilisateur?> {
  /// État d'authentification de l'app.
  /// - data(null)        → déconnecté
  /// - data(Utilisateur) → connecté
  /// - loading           → vérification/connexion en cours
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

String _$authNotifierHash() => r'e7d4555c631ac61980c99b8514d64ab613bbc243';

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours

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
