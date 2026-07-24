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

/// Profil du partenaire connecte.

@ProviderFor(monProfilPartenaire)
final monProfilPartenaireProvider = MonProfilPartenaireProvider._();

/// Profil du partenaire connecte.

final class MonProfilPartenaireProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Profil du partenaire connecte.
  MonProfilPartenaireProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monProfilPartenaireProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monProfilPartenaireHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return monProfilPartenaire(ref);
  }
}

String _$monProfilPartenaireHash() =>
    r'41269f3571aa4f7cdaed1caf1f541e8cae52ff35';

/// Categories du partenaire connecte.

@ProviderFor(mesCategories)
final mesCategoriesProvider = MesCategoriesProvider._();

/// Categories du partenaire connecte.

final class MesCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MaCategorie>>,
          List<MaCategorie>,
          FutureOr<List<MaCategorie>>
        >
    with
        $FutureModifier<List<MaCategorie>>,
        $FutureProvider<List<MaCategorie>> {
  /// Categories du partenaire connecte.
  MesCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<MaCategorie>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MaCategorie>> create(Ref ref) {
    return mesCategories(ref);
  }
}

String _$mesCategoriesHash() => r'2cc232b18bbb172a05d574229adf04b8d10c4160';
