// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsRepository)
final analyticsRepositoryProvider = AnalyticsRepositoryProvider._();

final class AnalyticsRepositoryProvider
    extends
        $FunctionalProvider<
          AnalyticsRepository,
          AnalyticsRepository,
          AnalyticsRepository
        >
    with $Provider<AnalyticsRepository> {
  AnalyticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnalyticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyticsRepository create(Ref ref) {
    return analyticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsRepository>(value),
    );
  }
}

String _$analyticsRepositoryHash() =>
    r'9a20b1197514272e6d502e146a66ebe217ebdce4';

/// Pilote le heartbeat de session.
///
/// Cycle : [demarrer] à l'ouverture de l'app (ou après connexion), ping
/// automatique toutes les 60 secondes, [arreter] à la déconnexion ou quand
/// l'app passe en arrière-plan.

@ProviderFor(SessionAnalytics)
final sessionAnalyticsProvider = SessionAnalyticsProvider._();

/// Pilote le heartbeat de session.
///
/// Cycle : [demarrer] à l'ouverture de l'app (ou après connexion), ping
/// automatique toutes les 60 secondes, [arreter] à la déconnexion ou quand
/// l'app passe en arrière-plan.
final class SessionAnalyticsProvider
    extends $NotifierProvider<SessionAnalytics, EtatSession> {
  /// Pilote le heartbeat de session.
  ///
  /// Cycle : [demarrer] à l'ouverture de l'app (ou après connexion), ping
  /// automatique toutes les 60 secondes, [arreter] à la déconnexion ou quand
  /// l'app passe en arrière-plan.
  SessionAnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionAnalyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionAnalyticsHash();

  @$internal
  @override
  SessionAnalytics create() => SessionAnalytics();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EtatSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EtatSession>(value),
    );
  }
}

String _$sessionAnalyticsHash() => r'182063f897a78c246c042a8f9b2f7fdb4594fcce';

/// Pilote le heartbeat de session.
///
/// Cycle : [demarrer] à l'ouverture de l'app (ou après connexion), ping
/// automatique toutes les 60 secondes, [arreter] à la déconnexion ou quand
/// l'app passe en arrière-plan.

abstract class _$SessionAnalytics extends $Notifier<EtatSession> {
  EtatSession build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EtatSession, EtatSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EtatSession, EtatSession>,
              EtatSession,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Enregistre la consultation d'un article.
///
/// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
/// donc chaque consultation compte comme une vue distincte.

@ProviderFor(vueArticle)
final vueArticleProvider = VueArticleFamily._();

/// Enregistre la consultation d'un article.
///
/// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
/// donc chaque consultation compte comme une vue distincte.

final class VueArticleProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Enregistre la consultation d'un article.
  ///
  /// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
  /// donc chaque consultation compte comme une vue distincte.
  VueArticleProvider._({
    required VueArticleFamily super.from,
    required ({String slug, String source}) super.argument,
  }) : super(
         retry: null,
         name: r'vueArticleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vueArticleHash();

  @override
  String toString() {
    return r'vueArticleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as ({String slug, String source});
    return vueArticle(ref, slug: argument.slug, source: argument.source);
  }

  @override
  bool operator ==(Object other) {
    return other is VueArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vueArticleHash() => r'fa10b28bae022c187d06c89052af76421adeaa87';

/// Enregistre la consultation d'un article.
///
/// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
/// donc chaque consultation compte comme une vue distincte.

final class VueArticleFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({String slug, String source})
        > {
  VueArticleFamily._()
    : super(
        retry: null,
        name: r'vueArticleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Enregistre la consultation d'un article.
  ///
  /// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
  /// donc chaque consultation compte comme une vue distincte.

  VueArticleProvider call({required String slug, String source = 'detail'}) =>
      VueArticleProvider._(argument: (slug: slug, source: source), from: this);

  @override
  String toString() => r'vueArticleProvider';
}

/// Enregistre l'entrée dans le catalogue d'une catégorie.
///
/// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
/// à l'accueil puis recliquer la catégorie compte une nouvelle visite.

@ProviderFor(visiteCategorie)
final visiteCategorieProvider = VisiteCategorieFamily._();

/// Enregistre l'entrée dans le catalogue d'une catégorie.
///
/// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
/// à l'accueil puis recliquer la catégorie compte une nouvelle visite.

final class VisiteCategorieProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Enregistre l'entrée dans le catalogue d'une catégorie.
  ///
  /// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
  /// à l'accueil puis recliquer la catégorie compte une nouvelle visite.
  VisiteCategorieProvider._({
    required VisiteCategorieFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'visiteCategorieProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$visiteCategorieHash();

  @override
  String toString() {
    return r'visiteCategorieProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as int;
    return visiteCategorie(ref, categorieId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VisiteCategorieProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$visiteCategorieHash() => r'6657b7137fcb153ca6661ad6cdf27045b3b368e5';

/// Enregistre l'entrée dans le catalogue d'une catégorie.
///
/// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
/// à l'accueil puis recliquer la catégorie compte une nouvelle visite.

final class VisiteCategorieFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, int> {
  VisiteCategorieFamily._()
    : super(
        retry: null,
        name: r'visiteCategorieProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Enregistre l'entrée dans le catalogue d'une catégorie.
  ///
  /// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
  /// à l'accueil puis recliquer la catégorie compte une nouvelle visite.

  VisiteCategorieProvider call({required int categorieId}) =>
      VisiteCategorieProvider._(argument: categorieId, from: this);

  @override
  String toString() => r'visiteCategorieProvider';
}
