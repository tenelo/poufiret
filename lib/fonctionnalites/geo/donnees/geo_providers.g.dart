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

/// Departements disponibles. Liste quasi statique : cache disque 7 jours,
/// gardee en memoire pour la session (pas de rechargement a chaque
/// ouverture d'un formulaire).

@ProviderFor(departements)
final departementsProvider = DepartementsProvider._();

/// Departements disponibles. Liste quasi statique : cache disque 7 jours,
/// gardee en memoire pour la session (pas de rechargement a chaque
/// ouverture d'un formulaire).

final class DepartementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Departement>>,
          List<Departement>,
          Stream<List<Departement>>
        >
    with
        $FutureModifier<List<Departement>>,
        $StreamProvider<List<Departement>> {
  /// Departements disponibles. Liste quasi statique : cache disque 7 jours,
  /// gardee en memoire pour la session (pas de rechargement a chaque
  /// ouverture d'un formulaire).
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
  $StreamProviderElement<List<Departement>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Departement>> create(Ref ref) {
    return departements(ref);
  }
}

String _$departementsHash() => r'628e0ce06b77b73b7bf0ff245b56c5a57ffc533c';

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

/// Localites d'un departement (cascade de localisation), en cache disque
/// comme les departements.

@ProviderFor(localites)
final localitesProvider = LocalitesFamily._();

/// Localites d'un departement (cascade de localisation), en cache disque
/// comme les departements.

final class LocalitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Localite>>,
          List<Localite>,
          Stream<List<Localite>>
        >
    with $FutureModifier<List<Localite>>, $StreamProvider<List<Localite>> {
  /// Localites d'un departement (cascade de localisation), en cache disque
  /// comme les departements.
  LocalitesProvider._({
    required LocalitesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'localitesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$localitesHash();

  @override
  String toString() {
    return r'localitesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Localite>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Localite>> create(Ref ref) {
    final argument = this.argument as int;
    return localites(ref, departementId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalitesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$localitesHash() => r'd80750323f263fac757184c3219db483b351cf80';

/// Localites d'un departement (cascade de localisation), en cache disque
/// comme les departements.

final class LocalitesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Localite>>, int> {
  LocalitesFamily._()
    : super(
        retry: null,
        name: r'localitesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Localites d'un departement (cascade de localisation), en cache disque
  /// comme les departements.

  LocalitesProvider call({required int departementId}) =>
      LocalitesProvider._(argument: departementId, from: this);

  @override
  String toString() => r'localitesProvider';
}

/// Quartiers d'une localite (cascade de localisation).

@ProviderFor(quartiersDeLocalite)
final quartiersDeLocaliteProvider = QuartiersDeLocaliteFamily._();

/// Quartiers d'une localite (cascade de localisation).

final class QuartiersDeLocaliteProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Quartier>>,
          List<Quartier>,
          Stream<List<Quartier>>
        >
    with $FutureModifier<List<Quartier>>, $StreamProvider<List<Quartier>> {
  /// Quartiers d'une localite (cascade de localisation).
  QuartiersDeLocaliteProvider._({
    required QuartiersDeLocaliteFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'quartiersDeLocaliteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quartiersDeLocaliteHash();

  @override
  String toString() {
    return r'quartiersDeLocaliteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Quartier>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Quartier>> create(Ref ref) {
    final argument = this.argument as int;
    return quartiersDeLocalite(ref, localiteId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuartiersDeLocaliteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quartiersDeLocaliteHash() =>
    r'50b96f0b82e05bd27f35f0084743a14f135f1eec';

/// Quartiers d'une localite (cascade de localisation).

final class QuartiersDeLocaliteFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Quartier>>, int> {
  QuartiersDeLocaliteFamily._()
    : super(
        retry: null,
        name: r'quartiersDeLocaliteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Quartiers d'une localite (cascade de localisation).

  QuartiersDeLocaliteProvider call({required int localiteId}) =>
      QuartiersDeLocaliteProvider._(argument: localiteId, from: this);

  @override
  String toString() => r'quartiersDeLocaliteProvider';
}
