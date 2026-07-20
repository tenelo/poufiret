// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecran_appareils.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sessions appareils de l'utilisateur.

@ProviderFor(mesAppareils)
final mesAppareilsProvider = MesAppareilsProvider._();

/// Sessions appareils de l'utilisateur.

final class MesAppareilsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  /// Sessions appareils de l'utilisateur.
  MesAppareilsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesAppareilsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesAppareilsHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return mesAppareils(ref);
  }
}

String _$mesAppareilsHash() => r'f4fb503150bba11fa0656551ef3c1be0dac9cc28';
