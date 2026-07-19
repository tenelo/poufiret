// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prestations_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prestationsRepository)
final prestationsRepositoryProvider = PrestationsRepositoryProvider._();

final class PrestationsRepositoryProvider
    extends
        $FunctionalProvider<
          PrestationsRepository,
          PrestationsRepository,
          PrestationsRepository
        >
    with $Provider<PrestationsRepository> {
  PrestationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prestationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prestationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PrestationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PrestationsRepository create(Ref ref) {
    return prestationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrestationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrestationsRepository>(value),
    );
  }
}

String _$prestationsRepositoryHash() =>
    r'701cdc8f9ceb08dd0cec1a5d8ae9c2f00788c300';

/// Mes demandes d'intervention (client). Invalider après création/annulation.

@ProviderFor(mesDemandesIntervention)
final mesDemandesInterventionProvider = MesDemandesInterventionProvider._();

/// Mes demandes d'intervention (client). Invalider après création/annulation.

final class MesDemandesInterventionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DemandeIntervention>>,
          List<DemandeIntervention>,
          FutureOr<List<DemandeIntervention>>
        >
    with
        $FutureModifier<List<DemandeIntervention>>,
        $FutureProvider<List<DemandeIntervention>> {
  /// Mes demandes d'intervention (client). Invalider après création/annulation.
  MesDemandesInterventionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesDemandesInterventionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesDemandesInterventionHash();

  @$internal
  @override
  $FutureProviderElement<List<DemandeIntervention>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DemandeIntervention>> create(Ref ref) {
    return mesDemandesIntervention(ref);
  }
}

String _$mesDemandesInterventionHash() =>
    r'0df2ee9603ffb34646ddf4f9258cde212a79a08b';

/// Demandes reçues (artisan). Invalider après transition.

@ProviderFor(demandesInterventionRecues)
final demandesInterventionRecuesProvider =
    DemandesInterventionRecuesProvider._();

/// Demandes reçues (artisan). Invalider après transition.

final class DemandesInterventionRecuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DemandeIntervention>>,
          List<DemandeIntervention>,
          FutureOr<List<DemandeIntervention>>
        >
    with
        $FutureModifier<List<DemandeIntervention>>,
        $FutureProvider<List<DemandeIntervention>> {
  /// Demandes reçues (artisan). Invalider après transition.
  DemandesInterventionRecuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demandesInterventionRecuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demandesInterventionRecuesHash();

  @$internal
  @override
  $FutureProviderElement<List<DemandeIntervention>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DemandeIntervention>> create(Ref ref) {
    return demandesInterventionRecues(ref);
  }
}

String _$demandesInterventionRecuesHash() =>
    r'a5da02126cde7a2f17fe0d5484648ed1164ac10b';

/// Détail d'une demande.

@ProviderFor(demandeInterventionDetail)
final demandeInterventionDetailProvider = DemandeInterventionDetailFamily._();

/// Détail d'une demande.

final class DemandeInterventionDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<DemandeIntervention>,
          DemandeIntervention,
          FutureOr<DemandeIntervention>
        >
    with
        $FutureModifier<DemandeIntervention>,
        $FutureProvider<DemandeIntervention> {
  /// Détail d'une demande.
  DemandeInterventionDetailProvider._({
    required DemandeInterventionDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'demandeInterventionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$demandeInterventionDetailHash();

  @override
  String toString() {
    return r'demandeInterventionDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DemandeIntervention> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DemandeIntervention> create(Ref ref) {
    final argument = this.argument as int;
    return demandeInterventionDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DemandeInterventionDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$demandeInterventionDetailHash() =>
    r'0d52fadcd08267a7cfe0a980ecdcd74fb1aa144e';

/// Détail d'une demande.

final class DemandeInterventionDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DemandeIntervention>, int> {
  DemandeInterventionDetailFamily._()
    : super(
        retry: null,
        name: r'demandeInterventionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Détail d'une demande.

  DemandeInterventionDetailProvider call({required int id}) =>
      DemandeInterventionDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'demandeInterventionDetailProvider';
}
