// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partenaire_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(partenaireRepository)
final partenaireRepositoryProvider = PartenaireRepositoryProvider._();

final class PartenaireRepositoryProvider
    extends
        $FunctionalProvider<
          PartenaireRepository,
          PartenaireRepository,
          PartenaireRepository
        >
    with $Provider<PartenaireRepository> {
  PartenaireRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partenaireRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partenaireRepositoryHash();

  @$internal
  @override
  $ProviderElement<PartenaireRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PartenaireRepository create(Ref ref) {
    return partenaireRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PartenaireRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PartenaireRepository>(value),
    );
  }
}

String _$partenaireRepositoryHash() =>
    r'2333e1b0f22c22373f427778cafe47c0289761c5';

/// Vitrine d'un partenaire par son id. Mis en cache par id.

@ProviderFor(partenaireVitrine)
final partenaireVitrineProvider = PartenaireVitrineFamily._();

/// Vitrine d'un partenaire par son id. Mis en cache par id.

final class PartenaireVitrineProvider
    extends
        $FunctionalProvider<
          AsyncValue<PartenaireVitrine>,
          PartenaireVitrine,
          FutureOr<PartenaireVitrine>
        >
    with
        $FutureModifier<PartenaireVitrine>,
        $FutureProvider<PartenaireVitrine> {
  /// Vitrine d'un partenaire par son id. Mis en cache par id.
  PartenaireVitrineProvider._({
    required PartenaireVitrineFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'partenaireVitrineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$partenaireVitrineHash();

  @override
  String toString() {
    return r'partenaireVitrineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PartenaireVitrine> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PartenaireVitrine> create(Ref ref) {
    final argument = this.argument as int;
    return partenaireVitrine(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PartenaireVitrineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$partenaireVitrineHash() => r'9fa1d7bd356b4dc45b3543ef2ca982c9b73adb45';

/// Vitrine d'un partenaire par son id. Mis en cache par id.

final class PartenaireVitrineFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PartenaireVitrine>, int> {
  PartenaireVitrineFamily._()
    : super(
        retry: null,
        name: r'partenaireVitrineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Vitrine d'un partenaire par son id. Mis en cache par id.

  PartenaireVitrineProvider call({required int id}) =>
      PartenaireVitrineProvider._(argument: id, from: this);

  @override
  String toString() => r'partenaireVitrineProvider';
}
