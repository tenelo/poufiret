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
final authProvider = _AuthNotifierProvider._();

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
final class _AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, Utilisateur?> {
  /// État d'authentification de l'app.
  /// - data(null)        → déconnecté
  /// - data(Utilisateur) → connecté
  /// - loading           → vérification/connexion en cours
  _AuthNotifierProvider._()
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

String _$authNotifierHash() => r'd382a78ba8fadfe502c92d9802e149fcc5ba2e82';

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
