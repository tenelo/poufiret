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

/// Articles d'une catégorie donnée. Le paramètre categorieId permet
/// à Riverpod de mettre en cache par catégorie.

@ProviderFor(articles)
final articlesProvider = ArticlesFamily._();

/// Articles d'une catégorie donnée. Le paramètre categorieId permet
/// à Riverpod de mettre en cache par catégorie.

final class ArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArticleListe>>,
          List<ArticleListe>,
          FutureOr<List<ArticleListe>>
        >
    with
        $FutureModifier<List<ArticleListe>>,
        $FutureProvider<List<ArticleListe>> {
  /// Articles d'une catégorie donnée. Le paramètre categorieId permet
  /// à Riverpod de mettre en cache par catégorie.
  ArticlesProvider._({
    required ArticlesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articlesHash();

  @override
  String toString() {
    return r'articlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ArticleListe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArticleListe>> create(Ref ref) {
    final argument = this.argument as int;
    return articles(ref, categorieId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articlesHash() => r'268b60da18576f01fd144d384659576e7cceec1c';

/// Articles d'une catégorie donnée. Le paramètre categorieId permet
/// à Riverpod de mettre en cache par catégorie.

final class ArticlesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ArticleListe>>, int> {
  ArticlesFamily._()
    : super(
        retry: null,
        name: r'articlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Articles d'une catégorie donnée. Le paramètre categorieId permet
  /// à Riverpod de mettre en cache par catégorie.

  ArticlesProvider call({required int categorieId}) =>
      ArticlesProvider._(argument: categorieId, from: this);

  @override
  String toString() => r'articlesProvider';
}
