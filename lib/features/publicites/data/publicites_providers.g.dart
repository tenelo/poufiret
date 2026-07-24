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

/// Fiche detail d'une publicite.

@ProviderFor(publiciteDetail)
final publiciteDetailProvider = PubliciteDetailFamily._();

/// Fiche detail d'une publicite.

final class PubliciteDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PubliciteDetail>,
          PubliciteDetail,
          FutureOr<PubliciteDetail>
        >
    with $FutureModifier<PubliciteDetail>, $FutureProvider<PubliciteDetail> {
  /// Fiche detail d'une publicite.
  PubliciteDetailProvider._({
    required PubliciteDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publiciteDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publiciteDetailHash();

  @override
  String toString() {
    return r'publiciteDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PubliciteDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PubliciteDetail> create(Ref ref) {
    final argument = this.argument as String;
    return publiciteDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PubliciteDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publiciteDetailHash() => r'4b61bd66b751d85b72e8c09df84b69e85d449c25';

/// Fiche detail d'une publicite.

final class PubliciteDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PubliciteDetail>, String> {
  PubliciteDetailFamily._()
    : super(
        retry: null,
        name: r'publiciteDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche detail d'une publicite.

  PubliciteDetailProvider call({required String id}) =>
      PubliciteDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'publiciteDetailProvider';
}

/// Campagnes du partenaire connecte.

@ProviderFor(mesPublicites)
final mesPublicitesProvider = MesPublicitesProvider._();

/// Campagnes du partenaire connecte.

final class MesPublicitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  /// Campagnes du partenaire connecte.
  MesPublicitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesPublicitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesPublicitesHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return mesPublicites(ref);
  }
}

String _$mesPublicitesHash() => r'0dca638df8308b5d363d60a8cbd11e644d9038dd';

/// Resultats des campagnes du partenaire connecte.

@ProviderFor(mesStatsPublicites)
final mesStatsPublicitesProvider = MesStatsPublicitesProvider._();

/// Resultats des campagnes du partenaire connecte.

final class MesStatsPublicitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StatsPublicite>>,
          List<StatsPublicite>,
          FutureOr<List<StatsPublicite>>
        >
    with
        $FutureModifier<List<StatsPublicite>>,
        $FutureProvider<List<StatsPublicite>> {
  /// Resultats des campagnes du partenaire connecte.
  MesStatsPublicitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesStatsPublicitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesStatsPublicitesHash();

  @$internal
  @override
  $FutureProviderElement<List<StatsPublicite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StatsPublicite>> create(Ref ref) {
    return mesStatsPublicites(ref);
  }
}

String _$mesStatsPublicitesHash() =>
    r'869059ffe66a0bb5034dc21e6219dda0104369c9';
