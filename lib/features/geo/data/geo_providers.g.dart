// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geoRepository)
final geoRepositoryProvider = GeoRepositoryProvider._();

final class GeoRepositoryProvider
    extends $FunctionalProvider<GeoRepository, GeoRepository, GeoRepository>
    with $Provider<GeoRepository> {
  GeoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geoRepositoryHash();

  @$internal
  @override
  $ProviderElement<GeoRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeoRepository create(Ref ref) {
    return geoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeoRepository>(value),
    );
  }
}

String _$geoRepositoryHash() => r'e1fa90b359457fc316208a21f32519d2472ab849';

/// Departements disponibles. keepAlive : la liste est stable, on evite
/// de la recharger a chaque ouverture d'un formulaire.

@ProviderFor(departements)
final departementsProvider = DepartementsProvider._();

/// Departements disponibles. keepAlive : la liste est stable, on evite
/// de la recharger a chaque ouverture d'un formulaire.

final class DepartementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Departement>>,
          List<Departement>,
          FutureOr<List<Departement>>
        >
    with
        $FutureModifier<List<Departement>>,
        $FutureProvider<List<Departement>> {
  /// Departements disponibles. keepAlive : la liste est stable, on evite
  /// de la recharger a chaque ouverture d'un formulaire.
  DepartementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'departementsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$departementsHash();

  @$internal
  @override
  $FutureProviderElement<List<Departement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Departement>> create(Ref ref) {
    return departements(ref);
  }
}

String _$departementsHash() => r'26e62bc04cef9a29b805db65d8862c7f474b97e9';

/// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
/// depend du departement choisi.

@ProviderFor(quartiers)
final quartiersProvider = QuartiersFamily._();

/// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
/// depend du departement choisi.

final class QuartiersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Quartier>>,
          List<Quartier>,
          FutureOr<List<Quartier>>
        >
    with $FutureModifier<List<Quartier>>, $FutureProvider<List<Quartier>> {
  /// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
  /// depend du departement choisi.
  QuartiersProvider._({
    required QuartiersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'quartiersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quartiersHash();

  @override
  String toString() {
    return r'quartiersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Quartier>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Quartier>> create(Ref ref) {
    final argument = this.argument as int;
    return quartiers(ref, departementId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuartiersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quartiersHash() => r'487aa8412b12f6b79e637fb0ddf76e5c2bba0417';

/// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
/// depend du departement choisi.

final class QuartiersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Quartier>>, int> {
  QuartiersFamily._()
    : super(
        retry: null,
        name: r'quartiersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Quartiers d'un departement (autocompletion livraison). Non keepAlive :
  /// depend du departement choisi.

  QuartiersProvider call({required int departementId}) =>
      QuartiersProvider._(argument: departementId, from: this);

  @override
  String toString() => r'quartiersProvider';
}
