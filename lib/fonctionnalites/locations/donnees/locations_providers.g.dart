// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationsRepository)
final locationsRepositoryProvider = LocationsRepositoryProvider._();

final class LocationsRepositoryProvider
    extends
        $FunctionalProvider<
          LocationsRepository,
          LocationsRepository,
          LocationsRepository
        >
    with $Provider<LocationsRepository> {
  LocationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationsRepository create(Ref ref) {
    return locationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationsRepository>(value),
    );
  }
}

String _$locationsRepositoryHash() =>
    r'cedd0118badee446c229c82189c65b3b607c1d64';

/// Listes de référence (libellés des équipements, types pour le filtre) :
/// quasi statiques, gardées comme la géographie.

@ProviderFor(metaLocations)
final metaLocationsProvider = MetaLocationsProvider._();

/// Listes de référence (libellés des équipements, types pour le filtre) :
/// quasi statiques, gardées comme la géographie.

final class MetaLocationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MetaLocations>,
          MetaLocations,
          Stream<MetaLocations>
        >
    with $FutureModifier<MetaLocations>, $StreamProvider<MetaLocations> {
  /// Listes de référence (libellés des équipements, types pour le filtre) :
  /// quasi statiques, gardées comme la géographie.
  MetaLocationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'metaLocationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$metaLocationsHash();

  @$internal
  @override
  $StreamProviderElement<MetaLocations> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<MetaLocations> create(Ref ref) {
    return metaLocations(ref);
  }
}

String _$metaLocationsHash() => r'01bcef663c3fdbe3b12fb3685031bcf28b8f331a';

/// Page d'un loueur : lui-même et ses logements disponibles, filtrés.

@ProviderFor(pageLoueur)
final pageLoueurProvider = PageLoueurFamily._();

/// Page d'un loueur : lui-même et ses logements disponibles, filtrés.

final class PageLoueurProvider
    extends
        $FunctionalProvider<
          AsyncValue<PageLoueur>,
          PageLoueur,
          Stream<PageLoueur>
        >
    with $FutureModifier<PageLoueur>, $StreamProvider<PageLoueur> {
  /// Page d'un loueur : lui-même et ses logements disponibles, filtrés.
  PageLoueurProvider._({
    required PageLoueurFamily super.from,
    required ({int partenaireId, FiltreLogements filtre}) super.argument,
  }) : super(
         retry: null,
         name: r'pageLoueurProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pageLoueurHash();

  @override
  String toString() {
    return r'pageLoueurProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<PageLoueur> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<PageLoueur> create(Ref ref) {
    final argument =
        this.argument as ({int partenaireId, FiltreLogements filtre});
    return pageLoueur(
      ref,
      partenaireId: argument.partenaireId,
      filtre: argument.filtre,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PageLoueurProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pageLoueurHash() => r'1301b6a83b7c8539a97938387f15ff323137fcdb';

/// Page d'un loueur : lui-même et ses logements disponibles, filtrés.

final class PageLoueurFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<PageLoueur>,
          ({int partenaireId, FiltreLogements filtre})
        > {
  PageLoueurFamily._()
    : super(
        retry: null,
        name: r'pageLoueurProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Page d'un loueur : lui-même et ses logements disponibles, filtrés.

  PageLoueurProvider call({
    required int partenaireId,
    FiltreLogements filtre = const FiltreLogements(),
  }) => PageLoueurProvider._(
    argument: (partenaireId: partenaireId, filtre: filtre),
    from: this,
  );

  @override
  String toString() => r'pageLoueurProvider';
}

/// Fiche d'un logement.

@ProviderFor(logementDetail)
final logementDetailProvider = LogementDetailFamily._();

/// Fiche d'un logement.

final class LogementDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Logement>, Logement, Stream<Logement>>
    with $FutureModifier<Logement>, $StreamProvider<Logement> {
  /// Fiche d'un logement.
  LogementDetailProvider._({
    required LogementDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'logementDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$logementDetailHash();

  @override
  String toString() {
    return r'logementDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Logement> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Logement> create(Ref ref) {
    final argument = this.argument as int;
    return logementDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LogementDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$logementDetailHash() => r'0097f9ec631950b48a826de339d02cfc3a5bfb37';

/// Fiche d'un logement.

final class LogementDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Logement>, int> {
  LogementDetailFamily._()
    : super(
        retry: null,
        name: r'logementDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche d'un logement.

  LogementDetailProvider call({required int id}) =>
      LogementDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'logementDetailProvider';
}

/// Mes demandes de visite. Rechargé après chaque envoi ou annulation.

@ProviderFor(mesDemandesReservation)
final mesDemandesReservationProvider = MesDemandesReservationProvider._();

/// Mes demandes de visite. Rechargé après chaque envoi ou annulation.

final class MesDemandesReservationProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DemandeReservation>>,
          List<DemandeReservation>,
          FutureOr<List<DemandeReservation>>
        >
    with
        $FutureModifier<List<DemandeReservation>>,
        $FutureProvider<List<DemandeReservation>> {
  /// Mes demandes de visite. Rechargé après chaque envoi ou annulation.
  MesDemandesReservationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesDemandesReservationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesDemandesReservationHash();

  @$internal
  @override
  $FutureProviderElement<List<DemandeReservation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DemandeReservation>> create(Ref ref) {
    return mesDemandesReservation(ref);
  }
}

String _$mesDemandesReservationHash() =>
    r'4a71aa2a4538b28c042eb2bbe0ab4c9b938add13';
