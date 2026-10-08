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

/// Page d'un établissement (hôtel, résidence) : lui-même et ses
/// hébergements. Les filtres s'appliquent à la liste reçue.

@ProviderFor(pageEtablissement)
final pageEtablissementProvider = PageEtablissementFamily._();

/// Page d'un établissement (hôtel, résidence) : lui-même et ses
/// hébergements. Les filtres s'appliquent à la liste reçue.

final class PageEtablissementProvider
    extends
        $FunctionalProvider<
          AsyncValue<PageEtablissement>,
          PageEtablissement,
          Stream<PageEtablissement>
        >
    with
        $FutureModifier<PageEtablissement>,
        $StreamProvider<PageEtablissement> {
  /// Page d'un établissement (hôtel, résidence) : lui-même et ses
  /// hébergements. Les filtres s'appliquent à la liste reçue.
  PageEtablissementProvider._({
    required PageEtablissementFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pageEtablissementProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pageEtablissementHash();

  @override
  String toString() {
    return r'pageEtablissementProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<PageEtablissement> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PageEtablissement> create(Ref ref) {
    final argument = this.argument as int;
    return pageEtablissement(ref, partenaireId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PageEtablissementProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pageEtablissementHash() => r'e9f330a7df8d216ce33a4dc8529ab7cc711bc7cb';

/// Page d'un établissement (hôtel, résidence) : lui-même et ses
/// hébergements. Les filtres s'appliquent à la liste reçue.

final class PageEtablissementFamily extends $Family
    with $FunctionalFamilyOverride<Stream<PageEtablissement>, int> {
  PageEtablissementFamily._()
    : super(
        retry: null,
        name: r'pageEtablissementProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Page d'un établissement (hôtel, résidence) : lui-même et ses
  /// hébergements. Les filtres s'appliquent à la liste reçue.

  PageEtablissementProvider call({required int partenaireId}) =>
      PageEtablissementProvider._(argument: partenaireId, from: this);

  @override
  String toString() => r'pageEtablissementProvider';
}

/// Fiche d'un hébergement.

@ProviderFor(hebergementDetail)
final hebergementDetailProvider = HebergementDetailFamily._();

/// Fiche d'un hébergement.

final class HebergementDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Hebergement>,
          Hebergement,
          Stream<Hebergement>
        >
    with $FutureModifier<Hebergement>, $StreamProvider<Hebergement> {
  /// Fiche d'un hébergement.
  HebergementDetailProvider._({
    required HebergementDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'hebergementDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hebergementDetailHash();

  @override
  String toString() {
    return r'hebergementDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Hebergement> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Hebergement> create(Ref ref) {
    final argument = this.argument as int;
    return hebergementDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HebergementDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hebergementDetailHash() => r'ed263466a44196ea48a3c6867a80fe4ae042454a';

/// Fiche d'un hébergement.

final class HebergementDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Hebergement>, int> {
  HebergementDetailFamily._()
    : super(
        retry: null,
        name: r'hebergementDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche d'un hébergement.

  HebergementDetailProvider call({required int id}) =>
      HebergementDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'hebergementDetailProvider';
}

/// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
/// Toujours lu sur le réseau : la disponibilité change vite.

@ProviderFor(disponibiliteHebergement)
final disponibiliteHebergementProvider = DisponibiliteHebergementFamily._();

/// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
/// Toujours lu sur le réseau : la disponibilité change vite.

final class DisponibiliteHebergementProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
  /// Toujours lu sur le réseau : la disponibilité change vite.
  DisponibiliteHebergementProvider._({
    required DisponibiliteHebergementFamily super.from,
    required ({int id, String arrivee, String depart}) super.argument,
  }) : super(
         retry: null,
         name: r'disponibiliteHebergementProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$disponibiliteHebergementHash();

  @override
  String toString() {
    return r'disponibiliteHebergementProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as ({int id, String arrivee, String depart});
    return disponibiliteHebergement(
      ref,
      id: argument.id,
      arrivee: argument.arrivee,
      depart: argument.depart,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DisponibiliteHebergementProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$disponibiliteHebergementHash() =>
    r'63f0de6e6d82d836485a5278a9b2de07f5b25e7c';

/// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
/// Toujours lu sur le réseau : la disponibilité change vite.

final class DisponibiliteHebergementFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<int>,
          ({int id, String arrivee, String depart})
        > {
  DisponibiliteHebergementFamily._()
    : super(
        retry: null,
        name: r'disponibiliteHebergementProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Unités libres d'un hébergement sur un séjour (dates « 2026-10-20 »).
  /// Toujours lu sur le réseau : la disponibilité change vite.

  DisponibiliteHebergementProvider call({
    required int id,
    required String arrivee,
    required String depart,
  }) => DisponibiliteHebergementProvider._(
    argument: (id: id, arrivee: arrivee, depart: depart),
    from: this,
  );

  @override
  String toString() => r'disponibiliteHebergementProvider';
}

/// Mes demandes (visites et réservations). Rechargées après chaque envoi
/// ou annulation.

@ProviderFor(mesDemandesReservation)
final mesDemandesReservationProvider = MesDemandesReservationProvider._();

/// Mes demandes (visites et réservations). Rechargées après chaque envoi
/// ou annulation.

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
  /// Mes demandes (visites et réservations). Rechargées après chaque envoi
  /// ou annulation.
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
