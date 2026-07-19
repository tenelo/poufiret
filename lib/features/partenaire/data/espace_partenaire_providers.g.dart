// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'espace_partenaire_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(espacePartenaireRepository)
final espacePartenaireRepositoryProvider =
    EspacePartenaireRepositoryProvider._();

final class EspacePartenaireRepositoryProvider
    extends
        $FunctionalProvider<
          EspacePartenaireRepository,
          EspacePartenaireRepository,
          EspacePartenaireRepository
        >
    with $Provider<EspacePartenaireRepository> {
  EspacePartenaireRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'espacePartenaireRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$espacePartenaireRepositoryHash();

  @$internal
  @override
  $ProviderElement<EspacePartenaireRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EspacePartenaireRepository create(Ref ref) {
    return espacePartenaireRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EspacePartenaireRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EspacePartenaireRepository>(value),
    );
  }
}

String _$espacePartenaireRepositoryHash() =>
    r'349ef413fd4634b965c4c7f210aff8d7cfb57727';

/// Stats de vues du partenaire. Invalider après CRUD article.

@ProviderFor(statsVuesPartenaire)
final statsVuesPartenaireProvider = StatsVuesPartenaireProvider._();

/// Stats de vues du partenaire. Invalider après CRUD article.

final class StatsVuesPartenaireProvider
    extends
        $FunctionalProvider<
          AsyncValue<StatsVues>,
          StatsVues,
          FutureOr<StatsVues>
        >
    with $FutureModifier<StatsVues>, $FutureProvider<StatsVues> {
  /// Stats de vues du partenaire. Invalider après CRUD article.
  StatsVuesPartenaireProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsVuesPartenaireProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsVuesPartenaireHash();

  @$internal
  @override
  $FutureProviderElement<StatsVues> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<StatsVues> create(Ref ref) {
    return statsVuesPartenaire(ref);
  }
}

String _$statsVuesPartenaireHash() =>
    r'51d4287973de94fd0181ed830be8e58304aa11e5';
