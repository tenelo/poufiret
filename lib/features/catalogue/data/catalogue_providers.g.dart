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
    required ({int categorieId, int? partenaireId}) super.argument,
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
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ArticleListe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArticleListe>> create(Ref ref) {
    final argument = this.argument as ({int categorieId, int? partenaireId});
    return articles(
      ref,
      categorieId: argument.categorieId,
      partenaireId: argument.partenaireId,
    );
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

String _$articlesHash() => r'fbc3cbf02e7840a9d7cde94568980e30a36d112a';

/// Articles d'une catégorie donnée. Le paramètre categorieId permet
/// à Riverpod de mettre en cache par catégorie.

final class ArticlesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ArticleListe>>,
          ({int categorieId, int? partenaireId})
        > {
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

  ArticlesProvider call({required int categorieId, int? partenaireId}) =>
      ArticlesProvider._(
        argument: (categorieId: categorieId, partenaireId: partenaireId),
        from: this,
      );

  @override
  String toString() => r'articlesProvider';
}

/// Fiche détail d'un article par son slug.

@ProviderFor(articleDetail)
final articleDetailProvider = ArticleDetailFamily._();

/// Fiche détail d'un article par son slug.

final class ArticleDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ArticleDetail>,
          ArticleDetail,
          FutureOr<ArticleDetail>
        >
    with $FutureModifier<ArticleDetail>, $FutureProvider<ArticleDetail> {
  /// Fiche détail d'un article par son slug.
  ArticleDetailProvider._({
    required ArticleDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'articleDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleDetailHash();

  @override
  String toString() {
    return r'articleDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ArticleDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ArticleDetail> create(Ref ref) {
    final argument = this.argument as String;
    return articleDetail(ref, slug: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleDetailHash() => r'ad4c91ec0d608927523f7bffd2cd3335f46e64ca';

/// Fiche détail d'un article par son slug.

final class ArticleDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ArticleDetail>, String> {
  ArticleDetailFamily._()
    : super(
        retry: null,
        name: r'articleDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fiche détail d'un article par son slug.

  ArticleDetailProvider call({required String slug}) =>
      ArticleDetailProvider._(argument: slug, from: this);

  @override
  String toString() => r'articleDetailProvider';
}

/// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.

@ProviderFor(rechercheArticles)
final rechercheArticlesProvider = RechercheArticlesFamily._();

/// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.

final class RechercheArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArticleListe>>,
          List<ArticleListe>,
          FutureOr<List<ArticleListe>>
        >
    with
        $FutureModifier<List<ArticleListe>>,
        $FutureProvider<List<ArticleListe>> {
  /// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.
  RechercheArticlesProvider._({
    required RechercheArticlesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'rechercheArticlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rechercheArticlesHash();

  @override
  String toString() {
    return r'rechercheArticlesProvider'
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
    final argument = this.argument as String;
    return rechercheArticles(ref, terme: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RechercheArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rechercheArticlesHash() => r'9a542fb54927a26780774ffc1f03e314d241216b';

/// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.

final class RechercheArticlesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ArticleListe>>, String> {
  RechercheArticlesFamily._()
    : super(
        retry: null,
        name: r'rechercheArticlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Recherche d'articles par nom. Renvoie une liste vide si le terme est vide.

  RechercheArticlesProvider call({required String terme}) =>
      RechercheArticlesProvider._(argument: terme, from: this);

  @override
  String toString() => r'rechercheArticlesProvider';
}

/// Localites choisies par l'utilisateur pour elargir sa vue.
///
/// Liste d'ids de departements, ou ['all'] pour tout voir. Vide = vue par
/// defaut (son departement + ce que la portee des partenaires autorise).
/// keepAlive : le choix persiste entre les categories consultees.

@ProviderFor(LocalitesChoisies)
final localitesChoisiesProvider = LocalitesChoisiesProvider._();

/// Localites choisies par l'utilisateur pour elargir sa vue.
///
/// Liste d'ids de departements, ou ['all'] pour tout voir. Vide = vue par
/// defaut (son departement + ce que la portee des partenaires autorise).
/// keepAlive : le choix persiste entre les categories consultees.
final class LocalitesChoisiesProvider
    extends $NotifierProvider<LocalitesChoisies, List<String>> {
  /// Localites choisies par l'utilisateur pour elargir sa vue.
  ///
  /// Liste d'ids de departements, ou ['all'] pour tout voir. Vide = vue par
  /// defaut (son departement + ce que la portee des partenaires autorise).
  /// keepAlive : le choix persiste entre les categories consultees.
  LocalitesChoisiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localitesChoisiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localitesChoisiesHash();

  @$internal
  @override
  LocalitesChoisies create() => LocalitesChoisies();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$localitesChoisiesHash() => r'57e7a80f9cabbd6fd4f96d6064fb3d751900c3d7';

/// Localites choisies par l'utilisateur pour elargir sa vue.
///
/// Liste d'ids de departements, ou ['all'] pour tout voir. Vide = vue par
/// defaut (son departement + ce que la portee des partenaires autorise).
/// keepAlive : le choix persiste entre les categories consultees.

abstract class _$LocalitesChoisies extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Annuaire des prestataires d'une catégorie, filtre par les localites
/// choisies (le backend applique aussi la regle de portee).

@ProviderFor(partenairesParCategorie)
final partenairesParCategorieProvider = PartenairesParCategorieFamily._();

/// Annuaire des prestataires d'une catégorie, filtre par les localites
/// choisies (le backend applique aussi la regle de portee).

final class PartenairesParCategorieProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PartenaireCategorie>>,
          List<PartenaireCategorie>,
          FutureOr<List<PartenaireCategorie>>
        >
    with
        $FutureModifier<List<PartenaireCategorie>>,
        $FutureProvider<List<PartenaireCategorie>> {
  /// Annuaire des prestataires d'une catégorie, filtre par les localites
  /// choisies (le backend applique aussi la regle de portee).
  PartenairesParCategorieProvider._({
    required PartenairesParCategorieFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'partenairesParCategorieProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$partenairesParCategorieHash();

  @override
  String toString() {
    return r'partenairesParCategorieProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PartenaireCategorie>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PartenaireCategorie>> create(Ref ref) {
    final argument = this.argument as String;
    return partenairesParCategorie(ref, slug: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PartenairesParCategorieProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$partenairesParCategorieHash() =>
    r'77bad025c404ecc3f0da0ef303f066ba83fadc1a';

/// Annuaire des prestataires d'une catégorie, filtre par les localites
/// choisies (le backend applique aussi la regle de portee).

final class PartenairesParCategorieFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<PartenaireCategorie>>, String> {
  PartenairesParCategorieFamily._()
    : super(
        retry: null,
        name: r'partenairesParCategorieProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Annuaire des prestataires d'une catégorie, filtre par les localites
  /// choisies (le backend applique aussi la regle de portee).

  PartenairesParCategorieProvider call({required String slug}) =>
      PartenairesParCategorieProvider._(argument: slug, from: this);

  @override
  String toString() => r'partenairesParCategorieProvider';
}

/// Recherche unifiee : categories + partenaires + articles.

@ProviderFor(rechercheUnifiee)
final rechercheUnifieeProvider = RechercheUnifieeFamily._();

/// Recherche unifiee : categories + partenaires + articles.

final class RechercheUnifieeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResultatsRecherche>,
          ResultatsRecherche,
          FutureOr<ResultatsRecherche>
        >
    with
        $FutureModifier<ResultatsRecherche>,
        $FutureProvider<ResultatsRecherche> {
  /// Recherche unifiee : categories + partenaires + articles.
  RechercheUnifieeProvider._({
    required RechercheUnifieeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'rechercheUnifieeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rechercheUnifieeHash();

  @override
  String toString() {
    return r'rechercheUnifieeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ResultatsRecherche> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ResultatsRecherche> create(Ref ref) {
    final argument = this.argument as String;
    return rechercheUnifiee(ref, terme: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RechercheUnifieeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rechercheUnifieeHash() => r'd51c307f4bebc7c0d751d050d7fc34975165a5e0';

/// Recherche unifiee : categories + partenaires + articles.

final class RechercheUnifieeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ResultatsRecherche>, String> {
  RechercheUnifieeFamily._()
    : super(
        retry: null,
        name: r'rechercheUnifieeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Recherche unifiee : categories + partenaires + articles.

  RechercheUnifieeProvider call({required String terme}) =>
      RechercheUnifieeProvider._(argument: terme, from: this);

  @override
  String toString() => r'rechercheUnifieeProvider';
}

/// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.

@ProviderFor(videosPartenaire)
final videosPartenaireProvider = VideosPartenaireFamily._();

/// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.

final class VideosPartenaireProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VideoArticle>>,
          List<VideoArticle>,
          FutureOr<List<VideoArticle>>
        >
    with
        $FutureModifier<List<VideoArticle>>,
        $FutureProvider<List<VideoArticle>> {
  /// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.
  VideosPartenaireProvider._({
    required VideosPartenaireFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'videosPartenaireProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$videosPartenaireHash();

  @override
  String toString() {
    return r'videosPartenaireProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<VideoArticle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VideoArticle>> create(Ref ref) {
    final argument = this.argument as int;
    return videosPartenaire(ref, partenaireId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VideosPartenaireProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$videosPartenaireHash() => r'd1a21686db9f1e2675a2d89152a6ddfe36b76061';

/// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.

final class VideosPartenaireFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<VideoArticle>>, int> {
  VideosPartenaireFamily._()
    : super(
        retry: null,
        name: r'videosPartenaireProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Videos d'un partenaire, pour l'onglet Videos de sa vitrine.

  VideosPartenaireProvider call({required int partenaireId}) =>
      VideosPartenaireProvider._(argument: partenaireId, from: this);

  @override
  String toString() => r'videosPartenaireProvider';
}
