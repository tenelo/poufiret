// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Service de position (geolocator), partagé.

@ProviderFor(servicePosition)
final servicePositionProvider = ServicePositionProvider._();

/// Service de position (geolocator), partagé.

final class ServicePositionProvider
    extends
        $FunctionalProvider<ServicePosition, ServicePosition, ServicePosition>
    with $Provider<ServicePosition> {
  /// Service de position (geolocator), partagé.
  ServicePositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'servicePositionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$servicePositionHash();

  @$internal
  @override
  $ProviderElement<ServicePosition> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ServicePosition create(Ref ref) {
    return servicePosition(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServicePosition value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServicePosition>(value),
    );
  }
}

String _$servicePositionHash() => r'db2824186a599ddf32c7c28bdb877b52054b86c1';

/// Catégorie sélectionnée dans les filtres de la carte.
/// null = onglet « Tous ».

@ProviderFor(CategorieCarte)
final categorieCarteProvider = CategorieCarteProvider._();

/// Catégorie sélectionnée dans les filtres de la carte.
/// null = onglet « Tous ».
final class CategorieCarteProvider
    extends $NotifierProvider<CategorieCarte, String?> {
  /// Catégorie sélectionnée dans les filtres de la carte.
  /// null = onglet « Tous ».
  CategorieCarteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categorieCarteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categorieCarteHash();

  @$internal
  @override
  CategorieCarte create() => CategorieCarte();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$categorieCarteHash() => r'add90685ae96709deb7c371e44b30e1013a33a8a';

/// Catégorie sélectionnée dans les filtres de la carte.
/// null = onglet « Tous ».

abstract class _$CategorieCarte extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Position actuelle de l'utilisateur (demandée une fois, mémorisée).

@ProviderFor(positionUtilisateur)
final positionUtilisateurProvider = PositionUtilisateurProvider._();

/// Position actuelle de l'utilisateur (demandée une fois, mémorisée).

final class PositionUtilisateurProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResultatPosition>,
          ResultatPosition,
          FutureOr<ResultatPosition>
        >
    with $FutureModifier<ResultatPosition>, $FutureProvider<ResultatPosition> {
  /// Position actuelle de l'utilisateur (demandée une fois, mémorisée).
  PositionUtilisateurProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionUtilisateurProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionUtilisateurHash();

  @$internal
  @override
  $FutureProviderElement<ResultatPosition> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ResultatPosition> create(Ref ref) {
    return positionUtilisateur(ref);
  }
}

String _$positionUtilisateurHash() =>
    r'3aa5781d51cfb67938755ec04caf2b29484bbeed';

/// Partenaires géolocalisés selon le filtre catégorie courant.
/// Rechargé quand la catégorie change (un seul appel réseau à chaque fois).

@ProviderFor(partenairesCarte)
final partenairesCarteProvider = PartenairesCarteProvider._();

/// Partenaires géolocalisés selon le filtre catégorie courant.
/// Rechargé quand la catégorie change (un seul appel réseau à chaque fois).

final class PartenairesCarteProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PartenaireCategorie>>,
          List<PartenaireCategorie>,
          FutureOr<List<PartenaireCategorie>>
        >
    with
        $FutureModifier<List<PartenaireCategorie>>,
        $FutureProvider<List<PartenaireCategorie>> {
  /// Partenaires géolocalisés selon le filtre catégorie courant.
  /// Rechargé quand la catégorie change (un seul appel réseau à chaque fois).
  PartenairesCarteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partenairesCarteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partenairesCarteHash();

  @$internal
  @override
  $FutureProviderElement<List<PartenaireCategorie>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PartenaireCategorie>> create(Ref ref) {
    return partenairesCarte(ref);
  }
}

String _$partenairesCarteHash() => r'f0a8b32129a32aea93b4fed9e395e3d956b0886a';
