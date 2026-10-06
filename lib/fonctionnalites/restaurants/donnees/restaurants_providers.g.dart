// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurants_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(restaurantsRepository)
final restaurantsRepositoryProvider = RestaurantsRepositoryProvider._();

final class RestaurantsRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantsRepository,
          RestaurantsRepository,
          RestaurantsRepository
        >
    with $Provider<RestaurantsRepository> {
  RestaurantsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantsRepository create(Ref ref) {
    return restaurantsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantsRepository>(value),
    );
  }
}

String _$restaurantsRepositoryHash() =>
    r'd102984ef17e2cb3b1666bdef0cfca010dd835dd';

/// Page d'un restaurant : fiche, menus du jour et carte.

@ProviderFor(restaurantDetail)
final restaurantDetailProvider = RestaurantDetailFamily._();

/// Page d'un restaurant : fiche, menus du jour et carte.

final class RestaurantDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Restaurant>,
          Restaurant,
          Stream<Restaurant>
        >
    with $FutureModifier<Restaurant>, $StreamProvider<Restaurant> {
  /// Page d'un restaurant : fiche, menus du jour et carte.
  RestaurantDetailProvider._({
    required RestaurantDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'restaurantDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$restaurantDetailHash();

  @override
  String toString() {
    return r'restaurantDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Restaurant> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Restaurant> create(Ref ref) {
    final argument = this.argument as int;
    return restaurantDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RestaurantDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$restaurantDetailHash() => r'6a23a89bff4ce63fdac3ca9fca82cbac7bbf3a77';

/// Page d'un restaurant : fiche, menus du jour et carte.

final class RestaurantDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Restaurant>, int> {
  RestaurantDetailFamily._()
    : super(
        retry: null,
        name: r'restaurantDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Page d'un restaurant : fiche, menus du jour et carte.

  RestaurantDetailProvider call({required int id}) =>
      RestaurantDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'restaurantDetailProvider';
}
