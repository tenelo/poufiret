// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatRepository)
final chatRepositoryProvider = ChatRepositoryProvider._();

final class ChatRepositoryProvider
    extends $FunctionalProvider<ChatRepository, ChatRepository, ChatRepository>
    with $Provider<ChatRepository> {
  ChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatRepository create(Ref ref) {
    return chatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRepository>(value),
    );
  }
}

String _$chatRepositoryHash() => r'a939c3ba593cb4cbad3bb01d9a8a1f4a6e900cdf';

/// Mes conversations (client + partenaire).

@ProviderFor(conversations)
final conversationsProvider = ConversationsProvider._();

/// Mes conversations (client + partenaire).

final class ConversationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Conversation>>,
          List<Conversation>,
          FutureOr<List<Conversation>>
        >
    with
        $FutureModifier<List<Conversation>>,
        $FutureProvider<List<Conversation>> {
  /// Mes conversations (client + partenaire).
  ConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Conversation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Conversation>> create(Ref ref) {
    return conversations(ref);
  }
}

String _$conversationsHash() => r'ad4bea488b82fcb650e1709d6ce24488f71988fb';

/// Historique d'une conversation (chargé une fois à l'ouverture ;
/// les messages temps réel arrivent ensuite via le socket).

@ProviderFor(historiqueMessages)
final historiqueMessagesProvider = HistoriqueMessagesFamily._();

/// Historique d'une conversation (chargé une fois à l'ouverture ;
/// les messages temps réel arrivent ensuite via le socket).

final class HistoriqueMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Message>>,
          List<Message>,
          FutureOr<List<Message>>
        >
    with $FutureModifier<List<Message>>, $FutureProvider<List<Message>> {
  /// Historique d'une conversation (chargé une fois à l'ouverture ;
  /// les messages temps réel arrivent ensuite via le socket).
  HistoriqueMessagesProvider._({
    required HistoriqueMessagesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'historiqueMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$historiqueMessagesHash();

  @override
  String toString() {
    return r'historiqueMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Message>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Message>> create(Ref ref) {
    final argument = this.argument as int;
    return historiqueMessages(ref, conversationId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoriqueMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$historiqueMessagesHash() =>
    r'fa15e175b6440a756a065b674c047d6957af398f';

/// Historique d'une conversation (chargé une fois à l'ouverture ;
/// les messages temps réel arrivent ensuite via le socket).

final class HistoriqueMessagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Message>>, int> {
  HistoriqueMessagesFamily._()
    : super(
        retry: null,
        name: r'historiqueMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Historique d'une conversation (chargé une fois à l'ouverture ;
  /// les messages temps réel arrivent ensuite via le socket).

  HistoriqueMessagesProvider call({required int conversationId}) =>
      HistoriqueMessagesProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'historiqueMessagesProvider';
}

/// Id de l'utilisateur connecté, pour distinguer mes messages.
/// Renvoie null si non connecté (ne devrait pas arriver dans le chat).

@ProviderFor(monUtilisateurId)
final monUtilisateurIdProvider = MonUtilisateurIdProvider._();

/// Id de l'utilisateur connecté, pour distinguer mes messages.
/// Renvoie null si non connecté (ne devrait pas arriver dans le chat).

final class MonUtilisateurIdProvider
    extends $FunctionalProvider<int?, int?, int?>
    with $Provider<int?> {
  /// Id de l'utilisateur connecté, pour distinguer mes messages.
  /// Renvoie null si non connecté (ne devrait pas arriver dans le chat).
  MonUtilisateurIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monUtilisateurIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monUtilisateurIdHash();

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    return monUtilisateurId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$monUtilisateurIdHash() => r'9d1aa08578697d4d01700b4f58bb396db648c8ae';
