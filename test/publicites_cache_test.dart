import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_repository.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/publicite_liste.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/bandeau_bas_publicite.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/global/cache/cache_api.dart';
import 'package:poufiret/global/cache/cache_disque.dart';
import 'package:poufiret/global/cache/cache_providers.dart';
import 'package:poufiret/global/cache/contexte_cache.dart';

/// Contexte fixe : pas d'authentification dans ces tests.
class _ContexteFixe extends ContexteCacheNotifier {
  @override
  ContexteCache build() => ContexteCache.anonyme;
}

/// Faux dépôt : le réseau ne répond que quand le test le décide, et les
/// impressions envoyées sont enregistrées.
class _FauxPubsRepo extends PublicitesRepository {
  _FauxPubsRepo() : super(dio: Dio());

  Completer<Object?> reseau = Completer();
  final impressions = <String>[];

  @override
  Future<Object?> carrouselBrut() => reseau.future;

  @override
  Future<Object?> bandeauBasBrut() => reseau.future;

  @override
  Future<void> enregistrerImpression(
    String id, {
    required String typeAffichage,
    bool cliquee = false,
    int? minuteSession,
    String? sessionId,
  }) async {
    impressions.add(id);
  }
}

Map<String, Object?> _pub(String id, {String? fin}) => {
  'id': id,
  'titre': 'Pub $id',
  'image_couverture': null,
  'duree_affichage_secondes': 5,
  'priorite': 1,
  'fin_diffusion': ?fin,
};

Object _carrousel(List<Map<String, Object?>> pubs) => {'publicites': pubs};
Object _bandeau(Map<String, Object?>? pub) => {'publicite': pub};

final _passe = DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
final _futur = DateTime.now().add(const Duration(days: 1)).toIso8601String();

void main() {
  late Directory dossier;
  late CacheDisque disque;
  late _FauxPubsRepo repo;

  setUp(() async {
    dossier = await Directory.systemTemp.createTemp('pubs_test');
    disque = CacheDisque(() async => dossier.path);
    repo = _FauxPubsRepo();
  });

  tearDown(() async {
    try {
      if (await dossier.exists()) await dossier.delete(recursive: true);
    } catch (_) {}
  });

  List<Override> overrides() => [
    publicitesRepositoryProvider.overrideWithValue(repo),
    cacheDisqueProvider.overrideWithValue(disque),
    contexteCacheProvider.overrideWith(_ContexteFixe.new),
  ];

  Future<void> semerCache(String cle, Object json) =>
      CacheApi(disque).ecrireBrut(ContexteCache.anonyme, cle, json);

  Future<void> attendre(WidgetTester tester) async {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 150)),
    );
    await tester.pump();
  }

  // Le widget est monté en « vraie » asynchronie : les lectures de fichiers du
  // cache ne se terminent pas dans la fausse horloge de testWidgets.
  Future<void> monter(WidgetTester tester, Widget enfant) => tester.runAsync(
    () => tester.pumpWidget(
      ProviderScope(
        overrides: overrides(),
        child: MaterialApp(home: Scaffold(body: enfant)),
      ),
    ),
  );

  group('fin_diffusion', () {
    test('diffusionTerminee : date passée, future, absente ou illisible', () {
      expect(PubliciteListe.fromJson(_pub('a', fin: _passe)).diffusionTerminee(), isTrue);
      expect(PubliciteListe.fromJson(_pub('a', fin: _futur)).diffusionTerminee(), isFalse);
      expect(PubliciteListe.fromJson(_pub('a')).diffusionTerminee(), isFalse);
      expect(
        PubliciteListe.fromJson(_pub('a', fin: 'pas une date')).diffusionTerminee(),
        isFalse,
      );
    });

    test('le provider n\'expose que les pubs encore diffusables', () async {
      await semerCache(
        'pubs/carrousel',
        _carrousel([_pub('finie', fin: _passe), _pub('ok', fin: _futur)]),
      );
      final conteneur = ProviderContainer(overrides: overrides());
      addTearDown(conteneur.dispose);
      final vus = <List<String>>[];
      conteneur.listen(carrouselPublicitesProvider, (_, suivant) {
        final d = suivant.value;
        if (d != null) vus.add(d.affichables().map((p) => p.id).toList());
      });

      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(vus.first, ['ok']); // 'finie' n'est jamais affichable
    });
  });

  group('impressions', () {
    testWidgets('carrousel : cache seul => aucune impression ; réseau => 1',
        (tester) async {
      final json = _carrousel([_pub('a', fin: _futur)]);
      await tester.runAsync(() => semerCache('pubs/carrousel', json));
      await monter(tester, const CarrouselPublicites());

      await attendre(tester); // le cache s'affiche
      expect(find.text('Pub a'), findsOneWidget);
      expect(repo.impressions, isEmpty);

      repo.reseau.complete(json); // le serveur confirme
      await attendre(tester);
      expect(find.text('Pub a'), findsOneWidget);
      expect(repo.impressions, ['a']);
    });

    testWidgets('carrousel : pub arrêtée par l\'admin => jamais comptée',
        (tester) async {
      await tester.runAsync(
        () => semerCache('pubs/carrousel', _carrousel([_pub('arretee')])),
      );
      await monter(tester, const CarrouselPublicites());
      await attendre(tester);
      expect(find.text('Pub arretee'), findsOneWidget); // affichée depuis le cache
      expect(repo.impressions, isEmpty);

      repo.reseau.complete(_carrousel(const [])); // le serveur ne la connaît plus
      await attendre(tester);

      expect(find.text('Pub arretee'), findsNothing);
      expect(repo.impressions, isEmpty);
    });

    testWidgets('carrousel : pub en cache dont fin_diffusion est dépassée',
        (tester) async {
      await tester.runAsync(
        () => semerCache('pubs/carrousel', _carrousel([_pub('finie', fin: _passe)])),
      );
      await monter(tester, const CarrouselPublicites());

      await attendre(tester);

      expect(find.text('Pub finie'), findsNothing);
      expect(repo.impressions, isEmpty);
    });

    testWidgets('bandeau : cache seul => aucune impression ; réseau => 1',
        (tester) async {
      final json = _bandeau(_pub('b', fin: _futur));
      await tester.runAsync(() => semerCache('pubs/bandeau', json));
      await monter(tester, const BandeauBasPublicite());

      await attendre(tester);
      expect(find.text('Pub b'), findsOneWidget);
      expect(repo.impressions, isEmpty);

      repo.reseau.complete(json);
      await attendre(tester);
      expect(repo.impressions, ['b']);
    });
  });
}
