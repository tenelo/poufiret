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

/// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
/// filtrés.

@ProviderFor(pageLoueurVehicules)
final pageLoueurVehiculesProvider = PageLoueurVehiculesFamily._();

/// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
/// filtrés.

final class PageLoueurVehiculesProvider
    extends
        $FunctionalProvider<
          AsyncValue<PageLoueurVehicules>,
          PageLoueurVehicules,
          Stream<PageLoueurVehicules>
        >
    with
        $FutureModifier<PageLoueurVehicules>,
        $StreamProvider<PageLoueurVehicules> {
  /// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
  /// filtrés.
  PageLoueurVehiculesProvider._({
    required PageLoueurVehiculesFamily super.from,
    required ({int partenaireId, FiltreVehicules filtre}) super.argument,
  }) : super(
         retry: null,
         name: r'pageLoueurVehiculesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pageLoueurVehiculesHash();

  @override
  String toString() {
    return r'pageLoueurVehiculesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<PageLoueurVehicules> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PageLoueurVehicules> create(Ref ref) {
    final argument =
        this.argument as ({int partenaireId, FiltreVehicules filtre});
    return pageLoueurVehicules(
      ref,
      partenaireId: argument.partenaireId,
      filtre: argument.filtre,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PageLoueurVehiculesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pageLoueurVehiculesHash() =>
    r'db18363a8e4eaf59697368535816b9b450d14ccf';

/// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
/// filtrés.

final class PageLoueurVehiculesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<PageLoueurVehicules>,
          ({int partenaireId, FiltreVehicules filtre})
        > {
  PageLoueurVehiculesFamily._()
    : super(
        retry: null,
        name: r'pageLoueurVehiculesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Page d'un loueur de véhicules : lui-même et ses véhicules disponibles,
  /// filtrés.

  PageLoueurVehiculesProvider call({
    required int partenaireId,
    FiltreVehicules filtre = const FiltreVehicules(),
  }) => PageLoueurVehiculesProvider._(
    argument: (partenaireId: partenaireId, filtre: filtre),
    from: this,
  );

  @override
  String toString() => r'pageLoueurVehiculesProvider';
}

/// Fiche d'un véhicule (avec ses périodes déjà réservées).

@ProviderFor(vehiculeDetail)
final vehiculeDetailProvider = VehiculeDetailFamily._();

/// Fiche d'un véhicule (avec ses périodes déjà réservées).

final class VehiculeDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Vehicule>, Vehicule, Stream<Vehicule>>
    with $FutureModifier<Vehicule>, $StreamProvider<Vehicule> {
  /// Fiche d'un véhicule (avec ses périodes déjà réservées).
  VehiculeDetailProvider._({
    required VehiculeDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'vehiculeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vehiculeDetailHash();

  @override
  String toString() {
    return r'vehiculeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Vehicule> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Vehicule> create(Ref ref) {
    final argument = this.argument as int;
    return vehiculeDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VehiculeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vehiculeDetailHash() => r'b3073d8e5a232f263c7d958432a0d53c2b0fd8d1';

/// Fiche d'un véhicule (avec ses périodes déjà réservées).

final class VehiculeDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Vehicule>, int> {
  VehiculeDetailFamily._()
    : super(
        retry: null,
        name: r'vehiculeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche d'un véhicule (avec ses périodes déjà réservées).

  VehiculeDetailProvider call({required int id}) =>
      VehiculeDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'vehiculeDetailProvider';
}

/// Mes demandes (visites et réservations). Rechargées après chaque envoi ou annulation.

@ProviderFor(mesDemandesReservation)
final mesDemandesReservationProvider = MesDemandesReservationProvider._();

/// Mes demandes (visites et réservations). Rechargées après chaque envoi ou annulation.

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
  /// Mes demandes (visites et réservations). Rechargées après chaque envoi ou annulation.
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
