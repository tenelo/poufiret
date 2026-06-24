// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catalogueRepository)
final catalogueRepositoryProvider = CatalogueRepositoryProvider._();

final class CatalogueRepositoryProvider
    extends
        $FunctionalProvider<
          CatalogueRepository,
          CatalogueRepository,
          CatalogueRepository
        >
    with $Provider<CatalogueRepository> {
  CatalogueRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogueRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogueRepositoryHash();

  @$internal
  @override
  $ProviderElement<CatalogueRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CatalogueRepository create(Ref ref) {
    return catalogueRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogueRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogueRepository>(value),
    );
  }
}

String _$catalogueRepositoryHash() =>
    r'8021cb515029653ba2cc98a2bffd63b781c6453c';

/// Charge la liste des catégories. FutureProvider : gère loading/error/data.

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

/// Charge la liste des catégories. FutureProvider : gère loading/error/data.

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Categorie>>,
          List<Categorie>,
          FutureOr<List<Categorie>>
        >
    with $FutureModifier<List<Categorie>>, $FutureProvider<List<Categorie>> {
  /// Charge la liste des catégories. FutureProvider : gère loading/error/data.
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Categorie>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Categorie>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'175c3af0a228629cc1bdcc809622adfaf63315ee';
