// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(socialRepository)
final socialRepositoryProvider = SocialRepositoryProvider._();

final class SocialRepositoryProvider
    extends
        $FunctionalProvider<
          SocialRepository,
          SocialRepository,
          SocialRepository
        >
    with $Provider<SocialRepository> {
  SocialRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialRepositoryHash();

  @$internal
  @override
  $ProviderElement<SocialRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SocialRepository create(Ref ref) {
    return socialRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SocialRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SocialRepository>(value),
    );
  }
}

String _$socialRepositoryHash() => r'50700334ac008fb3cd51dda872b6356f2cac737b';

/// Commentaires d'un article (rechargeable via invalidate).

@ProviderFor(commentairesArticle)
final commentairesArticleProvider = CommentairesArticleFamily._();

/// Commentaires d'un article (rechargeable via invalidate).

final class CommentairesArticleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Commentaire>>,
          List<Commentaire>,
          FutureOr<List<Commentaire>>
        >
    with
        $FutureModifier<List<Commentaire>>,
        $FutureProvider<List<Commentaire>> {
  /// Commentaires d'un article (rechargeable via invalidate).
  CommentairesArticleProvider._({
    required CommentairesArticleFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'commentairesArticleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentairesArticleHash();

  @override
  String toString() {
    return r'commentairesArticleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Commentaire>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Commentaire>> create(Ref ref) {
    final argument = this.argument as int;
    return commentairesArticle(ref, articleId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentairesArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentairesArticleHash() =>
    r'2a3e5d81a5e420e35fc46e0c418909f3b37643cc';

/// Commentaires d'un article (rechargeable via invalidate).

final class CommentairesArticleFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Commentaire>>, int> {
  CommentairesArticleFamily._()
    : super(
        retry: null,
        name: r'commentairesArticleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Commentaires d'un article (rechargeable via invalidate).

  CommentairesArticleProvider call({required int articleId}) =>
      CommentairesArticleProvider._(argument: articleId, from: this);

  @override
  String toString() => r'commentairesArticleProvider';
}
