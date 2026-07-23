// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(publicitesRepository)
final publicitesRepositoryProvider = PublicitesRepositoryProvider._();

final class PublicitesRepositoryProvider
    extends
        $FunctionalProvider<
          PublicitesRepository,
          PublicitesRepository,
          PublicitesRepository
        >
    with $Provider<PublicitesRepository> {
  PublicitesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicitesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicitesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PublicitesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PublicitesRepository create(Ref ref) {
    return publicitesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PublicitesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PublicitesRepository>(value),
    );
  }
}

String _$publicitesRepositoryHash() =>
    r'97ead81326abcdff2be751e29b30d8913f974180';

/// Pubs du carrousel d'accueil.

@ProviderFor(carrouselPublicites)
final carrouselPublicitesProvider = CarrouselPublicitesProvider._();

/// Pubs du carrousel d'accueil.

final class CarrouselPublicitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PubliciteListe>>,
          List<PubliciteListe>,
          FutureOr<List<PubliciteListe>>
        >
    with
        $FutureModifier<List<PubliciteListe>>,
        $FutureProvider<List<PubliciteListe>> {
  /// Pubs du carrousel d'accueil.
  CarrouselPublicitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'carrouselPublicitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$carrouselPublicitesHash();

  @$internal
  @override
  $FutureProviderElement<List<PubliciteListe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PubliciteListe>> create(Ref ref) {
    return carrouselPublicites(ref);
  }
}

String _$carrouselPublicitesHash() =>
    r'80b53f54211362f0ec5205d6ad40f78c079a7440';

/// Pubs de l'onglet Publicites.

@ProviderFor(pagePublicites)
final pagePublicitesProvider = PagePublicitesProvider._();

/// Pubs de l'onglet Publicites.

final class PagePublicitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PubliciteListe>>,
          List<PubliciteListe>,
          FutureOr<List<PubliciteListe>>
        >
    with
        $FutureModifier<List<PubliciteListe>>,
        $FutureProvider<List<PubliciteListe>> {
  /// Pubs de l'onglet Publicites.
  PagePublicitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pagePublicitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pagePublicitesHash();

  @$internal
  @override
  $FutureProviderElement<List<PubliciteListe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PubliciteListe>> create(Ref ref) {
    return pagePublicites(ref);
  }
}

String _$pagePublicitesHash() => r'22de15462f8b31a5fd0b64c60b94e2469446c3fe';

/// Pub du bandeau bas (peut etre nulle).

@ProviderFor(bandeauBasPublicite)
final bandeauBasPubliciteProvider = BandeauBasPubliciteProvider._();

/// Pub du bandeau bas (peut etre nulle).

final class BandeauBasPubliciteProvider
    extends
        $FunctionalProvider<
          AsyncValue<PubliciteListe?>,
          PubliciteListe?,
          FutureOr<PubliciteListe?>
        >
    with $FutureModifier<PubliciteListe?>, $FutureProvider<PubliciteListe?> {
  /// Pub du bandeau bas (peut etre nulle).
  BandeauBasPubliciteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bandeauBasPubliciteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bandeauBasPubliciteHash();

  @$internal
  @override
  $FutureProviderElement<PubliciteListe?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PubliciteListe?> create(Ref ref) {
    return bandeauBasPublicite(ref);
  }
}

String _$bandeauBasPubliciteHash() =>
    r'264fd9788a5824b63d08ef9dac2ff33913bd63ff';

/// Forfaits proposes au partenaire.

@ProviderFor(formulesPublicite)
final formulesPubliciteProvider = FormulesPubliciteProvider._();

/// Forfaits proposes au partenaire.

final class FormulesPubliciteProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FormulePublicite>>,
          List<FormulePublicite>,
          FutureOr<List<FormulePublicite>>
        >
    with
        $FutureModifier<List<FormulePublicite>>,
        $FutureProvider<List<FormulePublicite>> {
  /// Forfaits proposes au partenaire.
  FormulesPubliciteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formulesPubliciteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formulesPubliciteHash();

  @$internal
  @override
  $FutureProviderElement<List<FormulePublicite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FormulePublicite>> create(Ref ref) {
    return formulesPublicite(ref);
  }
}

String _$formulesPubliciteHash() => r'a3d5a4e6804b46581d527dd7b242d74000da525c';
