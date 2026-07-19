// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoris_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favorisRepository)
final favorisRepositoryProvider = FavorisRepositoryProvider._();

final class FavorisRepositoryProvider
    extends
        $FunctionalProvider<
          FavorisRepository,
          FavorisRepository,
          FavorisRepository
        >
    with $Provider<FavorisRepository> {
  FavorisRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favorisRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favorisRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavorisRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavorisRepository create(Ref ref) {
    return favorisRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavorisRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavorisRepository>(value),
    );
  }
}

String _$favorisRepositoryHash() => r'a305cc2402576e15d75751343796c057e8a998ec';

/// Mes favoris (articles + partenaires).

@ProviderFor(mesFavoris)
final mesFavorisProvider = MesFavorisProvider._();

/// Mes favoris (articles + partenaires).

final class MesFavorisProvider
    extends
        $FunctionalProvider<
          AsyncValue<MesFavoris>,
          MesFavoris,
          FutureOr<MesFavoris>
        >
    with $FutureModifier<MesFavoris>, $FutureProvider<MesFavoris> {
  /// Mes favoris (articles + partenaires).
  MesFavorisProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesFavorisProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesFavorisHash();

  @$internal
  @override
  $FutureProviderElement<MesFavoris> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<MesFavoris> create(Ref ref) {
    return mesFavoris(ref);
  }
}

String _$mesFavorisHash() => r'9ec8ad4053f531081081d214a6e9d7f975fff41c';
