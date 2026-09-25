import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/auth/donnees/auth_providers.dart';
import 'package:poufiret/fonctionnalites/auth/donnees/auth_repository.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/global/cache/cache_api.dart';
import 'package:poufiret/global/cache/cache_disque.dart';
import 'package:poufiret/global/cache/cache_providers.dart';
import 'package:poufiret/global/network/providers.dart';
import 'package:poufiret/global/storage/token_storage.dart';

const _alice = Utilisateur(id: 1, telephone: '+2250100000001', prenom: 'Alice');
const _bob = Utilisateur(id: 2, telephone: '+2250100000002', prenom: 'Bob');

/// Faux dépôt : `moi` est scripté, le reste n'est pas utilisé ici.
class _FauxAuthRepo extends AuthRepository {
  _FauxAuthRepo(TokenStorage tokens) : super(dio: Dio(), tokens: tokens);

  Future<Utilisateur> Function() moiScript = () async => _alice;
  Utilisateur? connexionRetour;
  int appelsMoi = 0;

  @override
  Future<Utilisateur> moi() {
    appelsMoi++;
    return moiScript();
  }

  @override
  Future<Utilisateur> connexion({
    required String telephone,
    required String password,
  }) async => connexionRetour!;

  @override
  Future<void> deconnexion() async {}
}

DioException _erreur(int? code) => DioException(
  requestOptions: RequestOptions(path: '/auth/moi/'),
  type: code == null
      ? DioExceptionType.connectionTimeout
      : DioExceptionType.badResponse,
  response: code == null
      ? null
      : Response(requestOptions: RequestOptions(path: '/auth/moi/'), statusCode: code),
);

void main() {
  late Directory dossier;
  late CacheDisque disque;
  late TokenStorage tokens;
  late _FauxAuthRepo repo;
  late ProviderContainer conteneur;

  /// [moi] est posé AVANT le démarrage du notifier : la revalidation en
  /// arrière-plan part dès la fin du build et ne doit pas voir le script par
  /// défaut.
  Future<void> creer({
    bool avecTokens = true,
    Utilisateur? memorise,
    Future<Utilisateur> Function()? moi,
  }) async {
    FlutterSecureStorage.setMockInitialValues({
      if (avecTokens) 'poufiret_access': 'a',
      if (avecTokens) 'poufiret_refresh': 'r',
    });
    tokens = TokenStorage();
    repo = _FauxAuthRepo(tokens);
    if (moi != null) repo.moiScript = moi;
    if (memorise != null) {
      await disque.ecrire(AuthNotifier.porteeSession, 'moi', memorise.toJson());
    }
    conteneur = ProviderContainer(
      overrides: [
        tokenStorageProvider.overrideWithValue(tokens),
        authRepositoryProvider.overrideWithValue(repo),
        cacheDisqueProvider.overrideWithValue(disque),
      ],
    );
    addTearDown(conteneur.dispose);
    // Comme _Racine dans l'app : quelqu'un écoute, le provider (autoDispose)
    // reste vivant entre deux lectures.
    conteneur.listen(authProvider, (_, _) {});
  }

  Future<void> laisserPasser() =>
      Future<void>.delayed(const Duration(milliseconds: 50));

  /// Attend qu'une condition asynchrone soit vraie (3 s max) : les tests ne
  /// dépendent pas de la charge de la machine.
  Future<void> jusqua(Future<bool> Function() condition) async {
    final limite = DateTime.now().add(const Duration(seconds: 3));
    while (DateTime.now().isBefore(limite)) {
      if (await condition()) return;
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
  }

  setUp(() async {
    dossier = await Directory.systemTemp.createTemp('auth_test');
    disque = CacheDisque(() async => dossier.path);
  });

  tearDown(() async {
    try {
      if (await dossier.exists()) await dossier.delete(recursive: true);
    } catch (_) {} // Windows : un fichier peut encore être verrouillé
  });

  test('timeout sur moi (aucun profil en cache) : PAS de déconnexion', () async {
    await creer();
    repo.moiScript = () async => throw _erreur(null);

    final user = await conteneur.read(authProvider.future);

    expect(user, isNull); // visiteur en attendant
    expect(await tokens.aSession, isTrue); // mais la session est conservée
  });

  test('5xx sur moi (aucun profil en cache) : PAS de déconnexion', () async {
    await creer();
    repo.moiScript = () async => throw _erreur(503);

    await conteneur.read(authProvider.future);

    expect(await tokens.aSession, isTrue);
  });

  test('démarrage optimiste : le profil mémorisé est servi sans attendre moi',
      () async {
    await creer(memorise: _alice);
    final attente = Completer<Utilisateur>();
    repo.moiScript = () => attente.future; // le réseau ne répond pas

    final user = await conteneur.read(authProvider.future);

    expect(user, _alice);
    attente.complete(_alice);
  });

  test('réseau coupé avec profil mémorisé : l\'utilisateur reste connecté',
      () async {
    await creer(memorise: _alice, moi: () async => throw _erreur(null));

    final user = await conteneur.read(authProvider.future);
    await jusqua(() async => repo.appelsMoi >= 1); // revalidation en arrière-plan
    await laisserPasser();

    expect(user, _alice);
    expect(conteneur.read(authProvider).value, _alice);
    expect(await tokens.aSession, isTrue);
    expect(repo.appelsMoi, 1);
  });

  test('moi revalidé en arrière-plan : le profil frais remplace le mémorisé',
      () async {
    final frais = _alice.copyWith(prenom: 'Alice B.');
    await creer(memorise: _alice, moi: () async => frais);

    await conteneur.read(authProvider.future);
    await jusqua(() async => conteneur.read(authProvider).value == frais);

    expect(conteneur.read(authProvider).value, frais);
    // Le profil mémorisé suit (écriture disque en arrière-plan).
    Future<Utilisateur?> memorise() async {
      final memo = await disque.lire(AuthNotifier.porteeSession, 'moi');
      final donnees = memo?.donnees;
      return donnees is Map
          ? Utilisateur.fromJson(Map<String, dynamic>.from(donnees))
          : null;
    }

    await jusqua(() async => await memorise() == frais);
    expect(await memorise(), frais);
  });

  test('refresh refusé (401 sur moi) : UNE seule déconnexion, cache purgé',
      () async {
    // Des données de l'utilisateur en cache disque.
    await CacheApi(disque).ecrireBrut(
      ContexteCache.utilisateur(1, 0),
      'conversations',
      [1, 2],
    );
    await creer(memorise: _alice, moi: () async => throw _erreur(401));

    final transitions = <Utilisateur?>[];
    conteneur.listen(authProvider, (avant, apres) {
      if (!apres.isLoading) transitions.add(apres.value);
    }, fireImmediately: true);

    await conteneur.read(authProvider.future);
    await jusqua(() async => conteneur.read(authProvider).value == null);
    await jusqua(
      () async => await disque.lire(AuthNotifier.porteeSession, 'moi') == null,
    );

    expect(conteneur.read(authProvider).value, isNull);
    expect(await tokens.aSession, isFalse);
    // connecté -> déconnecté, une seule fois (pas de va-et-vient).
    expect(transitions, [_alice, null]);
    expect(await disque.lire('u1', 'd0|conversations'), isNull);
    expect(await disque.lire(AuthNotifier.porteeSession, 'moi'), isNull);
  });

  test('401 au tout premier chargement (sans profil mémorisé) : déconnecté',
      () async {
    await creer();
    repo.moiScript = () async => throw _erreur(401);

    final user = await conteneur.read(authProvider.future);

    expect(user, isNull);
    expect(await tokens.aSession, isFalse);
  });

  test('déconnexion volontaire : données de l\'utilisateur purgées', () async {
    await creer(memorise: _alice);
    await CacheApi(disque).ecrireBrut(
      ContexteCache.utilisateur(1, 0),
      'conversations',
      [1],
    );
    await conteneur.read(authProvider.future);
    await laisserPasser();

    await conteneur.read(authProvider.notifier).deconnexion();
    await jusqua(
      () async =>
          await disque.lire('u1', 'd0|conversations') == null &&
          await disque.lire(AuthNotifier.porteeSession, 'moi') == null,
    );

    expect(await disque.lire('u1', 'd0|conversations'), isNull);
    expect(await disque.lire(AuthNotifier.porteeSession, 'moi'), isNull);
  });

  test('changement de compte pendant une revalidation : l\'ancien profil ne revient pas',
      () async {
    await creer(memorise: _alice);
    final attente = Completer<Utilisateur>();
    repo.moiScript = () => attente.future; // la revalidation d'Alice traîne
    await conteneur.read(authProvider.future);
    await jusqua(() async => repo.appelsMoi >= 1);

    repo.connexionRetour = _bob;
    await conteneur
        .read(authProvider.notifier)
        .connexion(telephone: _bob.telephone, password: '1234');
    attente.complete(_alice); // la réponse d'Alice arrive TROP TARD
    await laisserPasser();
    await laisserPasser();

    expect(conteneur.read(authProvider).value, _bob);
  });

  test('changement de compte : les données de l\'ancien compte sont purgées',
      () async {
    await creer(memorise: _alice);
    await CacheApi(disque).ecrireBrut(
      ContexteCache.utilisateur(1, 0),
      'conversations',
      [1],
    );
    await CacheApi(disque).ecrireBrut(
      ContexteCache.utilisateur(2, 0),
      'conversations',
      [2],
    );
    await conteneur.read(authProvider.future);
    await laisserPasser();

    repo.connexionRetour = _bob;
    await conteneur
        .read(authProvider.notifier)
        .connexion(telephone: _bob.telephone, password: '1234');
    await jusqua(
      () async => await disque.lire('u1', 'd0|conversations') == null,
    );
    await laisserPasser();

    expect(await disque.lire('u1', 'd0|conversations'), isNull);
    expect((await disque.lire('u2', 'd0|conversations'))?.donnees, [2]);
    final memo = await disque.lire(AuthNotifier.porteeSession, 'moi');
    expect((memo!.donnees as Map)['id'], 2);
  });
}
