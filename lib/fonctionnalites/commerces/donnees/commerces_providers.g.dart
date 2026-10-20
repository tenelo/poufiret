// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commerces_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commercesRepository)
final commercesRepositoryProvider = CommercesRepositoryProvider._();

final class CommercesRepositoryProvider
    extends
        $FunctionalProvider<
          CommercesRepository,
          CommercesRepository,
          CommercesRepository
        >
    with $Provider<CommercesRepository> {
  CommercesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commercesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commercesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommercesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommercesRepository create(Ref ref) {
    return commercesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommercesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommercesRepository>(value),
    );
  }
}

String _$commercesRepositoryHash() =>
    r'31536fa6a09ed1dde75541eeebd55505ba02ad14';

/// Meta des gabarits (choix des filtres) : quasi statique.

@ProviderFor(metaGabarits)
final metaGabaritsProvider = MetaGabaritsProvider._();

/// Meta des gabarits (choix des filtres) : quasi statique.

final class MetaGabaritsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MetaGabarits>,
          MetaGabarits,
          Stream<MetaGabarits>
        >
    with $FutureModifier<MetaGabarits>, $StreamProvider<MetaGabarits> {
  /// Meta des gabarits (choix des filtres) : quasi statique.
  MetaGabaritsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'metaGabaritsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$metaGabaritsHash();

  @$internal
  @override
  $StreamProviderElement<MetaGabarits> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<MetaGabarits> create(Ref ref) {
    return metaGabarits(ref);
  }
}

String _$metaGabaritsHash() => r'3e7e14c170131b12b42ee1e69de94527357e252b';

/// Fiche d'un produit (avec ses autres produits), cache d'abord.

@ProviderFor(produitDetail)
final produitDetailProvider = ProduitDetailFamily._();

/// Fiche d'un produit (avec ses autres produits), cache d'abord.

final class ProduitDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProduitDetail>,
          ProduitDetail,
          Stream<ProduitDetail>
        >
    with $FutureModifier<ProduitDetail>, $StreamProvider<ProduitDetail> {
  /// Fiche d'un produit (avec ses autres produits), cache d'abord.
  ProduitDetailProvider._({
    required ProduitDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'produitDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$produitDetailHash();

  @override
  String toString() {
    return r'produitDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ProduitDetail> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ProduitDetail> create(Ref ref) {
    final argument = this.argument as int;
    return produitDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProduitDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$produitDetailHash() => r'e2c5741b597e3675e9afe37e2aae3a847277cec6';

/// Fiche d'un produit (avec ses autres produits), cache d'abord.

final class ProduitDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ProduitDetail>, int> {
  ProduitDetailFamily._()
    : super(
        retry: null,
        name: r'produitDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche d'un produit (avec ses autres produits), cache d'abord.

  ProduitDetailProvider call({required int id}) =>
      ProduitDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'produitDetailProvider';
}

/// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
/// page à la construction, la suivante à chaque [chargerSuite] (défilement
/// infini). Toujours lue sur le réseau : stock et prix bougent.

@ProviderFor(ProduitsPagines)
final produitsPaginesProvider = ProduitsPaginesFamily._();

/// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
/// page à la construction, la suivante à chaque [chargerSuite] (défilement
/// infini). Toujours lue sur le réseau : stock et prix bougent.
final class ProduitsPaginesProvider
    extends $NotifierProvider<ProduitsPagines, EtatPagination> {
  /// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
  /// page à la construction, la suivante à chaque [chargerSuite] (défilement
  /// infini). Toujours lue sur le réseau : stock et prix bougent.
  ProduitsPaginesProvider._({
    required ProduitsPaginesFamily super.from,
    required RequeteProduits super.argument,
  }) : super(
         retry: null,
         name: r'produitsPaginesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$produitsPaginesHash();

  @override
  String toString() {
    return r'produitsPaginesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProduitsPagines create() => ProduitsPagines();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EtatPagination value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EtatPagination>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProduitsPaginesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$produitsPaginesHash() => r'526d9b75904315129f5413597408a585337b9485';

/// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
/// page à la construction, la suivante à chaque [chargerSuite] (défilement
/// infini). Toujours lue sur le réseau : stock et prix bougent.

final class ProduitsPaginesFamily extends $Family
    with
        $ClassFamilyOverride<
          ProduitsPagines,
          EtatPagination,
          EtatPagination,
          EtatPagination,
          RequeteProduits
        > {
  ProduitsPaginesFamily._()
    : super(
        retry: null,
        name: r'produitsPaginesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
  /// page à la construction, la suivante à chaque [chargerSuite] (défilement
  /// infini). Toujours lue sur le réseau : stock et prix bougent.

  ProduitsPaginesProvider call(RequeteProduits requete) =>
      ProduitsPaginesProvider._(argument: requete, from: this);

  @override
  String toString() => r'produitsPaginesProvider';
}

/// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
/// page à la construction, la suivante à chaque [chargerSuite] (défilement
/// infini). Toujours lue sur le réseau : stock et prix bougent.

abstract class _$ProduitsPagines extends $Notifier<EtatPagination> {
  late final _$args = ref.$arg as RequeteProduits;
  RequeteProduits get requete => _$args;

  EtatPagination build(RequeteProduits requete);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EtatPagination, EtatPagination>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EtatPagination, EtatPagination>,
              EtatPagination,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
