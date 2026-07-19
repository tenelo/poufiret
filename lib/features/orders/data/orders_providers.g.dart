// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ordersRepository)
final ordersRepositoryProvider = OrdersRepositoryProvider._();

final class OrdersRepositoryProvider
    extends
        $FunctionalProvider<
          OrdersRepository,
          OrdersRepository,
          OrdersRepository
        >
    with $Provider<OrdersRepository> {
  OrdersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrdersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrdersRepository create(Ref ref) {
    return ordersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrdersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrdersRepository>(value),
    );
  }
}

String _$ordersRepositoryHash() => r'3cc80d1c36a02f3e5c34a2e9cf026ceac2039d8d';

/// Mes paniers (un par partenaire). Rechargé après chaque mutation.

@ProviderFor(paniers)
final paniersProvider = PaniersProvider._();

/// Mes paniers (un par partenaire). Rechargé après chaque mutation.

final class PaniersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Panier>>,
          List<Panier>,
          FutureOr<List<Panier>>
        >
    with $FutureModifier<List<Panier>>, $FutureProvider<List<Panier>> {
  /// Mes paniers (un par partenaire). Rechargé après chaque mutation.
  PaniersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paniersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paniersHash();

  @$internal
  @override
  $FutureProviderElement<List<Panier>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Panier>> create(Ref ref) {
    return paniers(ref);
  }
}

String _$paniersHash() => r'74fc4c7640afa98f8b937f8cd416006f7b735cef';

/// Mes commandes (option filtre statut).

@ProviderFor(commandes)
final commandesProvider = CommandesFamily._();

/// Mes commandes (option filtre statut).

final class CommandesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Commande>>,
          List<Commande>,
          FutureOr<List<Commande>>
        >
    with $FutureModifier<List<Commande>>, $FutureProvider<List<Commande>> {
  /// Mes commandes (option filtre statut).
  CommandesProvider._({
    required CommandesFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'commandesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commandesHash();

  @override
  String toString() {
    return r'commandesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Commande>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Commande>> create(Ref ref) {
    final argument = this.argument as String?;
    return commandes(ref, statut: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommandesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commandesHash() => r'4bf066ddadfed7747bbe8880f2f68b3beab2e124';

/// Mes commandes (option filtre statut).

final class CommandesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Commande>>, String?> {
  CommandesFamily._()
    : super(
        retry: null,
        name: r'commandesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mes commandes (option filtre statut).

  CommandesProvider call({String? statut}) =>
      CommandesProvider._(argument: statut, from: this);

  @override
  String toString() => r'commandesProvider';
}

/// Détail d'une commande par id.

@ProviderFor(commandeDetail)
final commandeDetailProvider = CommandeDetailFamily._();

/// Détail d'une commande par id.

final class CommandeDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Commande>, Commande, FutureOr<Commande>>
    with $FutureModifier<Commande>, $FutureProvider<Commande> {
  /// Détail d'une commande par id.
  CommandeDetailProvider._({
    required CommandeDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'commandeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commandeDetailHash();

  @override
  String toString() {
    return r'commandeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Commande> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Commande> create(Ref ref) {
    final argument = this.argument as int;
    return commandeDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommandeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commandeDetailHash() => r'93a011733fecf0dc27b40d273df5bc8eaa00837b';

/// Détail d'une commande par id.

final class CommandeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Commande>, int> {
  CommandeDetailFamily._()
    : super(
        retry: null,
        name: r'commandeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Détail d'une commande par id.

  CommandeDetailProvider call({required int id}) =>
      CommandeDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'commandeDetailProvider';
}
