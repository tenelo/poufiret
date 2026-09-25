import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/global/cache/cache_api.dart';
import 'package:poufiret/global/cache/cache_disque.dart';

const _politique = PolitiqueCache(
  frais: Duration(minutes: 10),
  perime: Duration(days: 7),
);

void main() {
  late Directory dossier;
  late DateTime maintenant;
  late CacheDisque disque;

  // « Nouveau lancement » : une nouvelle CacheApi sur le même disque.
  CacheApi nouvelleApi() => CacheApi(disque, horloge: () => maintenant);

  Object? decoder(Object? json) => (json as Map)['v'] as String;

  int appelsReseau = 0;
  Future<Object?> Function() reseau(String valeur) => () async {
    appelsReseau++;
    return {'v': valeur};
  };

  Future<List<Source<Object?>>> lire(
    CacheApi api, {
    ContexteCache contexte = ContexteCache.anonyme,
    String cle = 'categories',
    PolitiqueCache politique = _politique,
    required Future<Object?> Function() res,
    bool revalider = false,
  }) => api
      .fluxSource<Object?>(
        contexte: contexte,
        cle: cle,
        politique: politique,
        reseau: res,
        decoder: decoder,
        revalider: revalider,
      )
      .toList();

  setUp(() async {
    dossier = await Directory.systemTemp.createTemp('cache_test');
    maintenant = DateTime(2026, 9, 25, 10);
    disque = CacheDisque(() async => dossier.path, horloge: () => maintenant);
    appelsReseau = 0;
  });

  tearDown(() async {
    if (await dossier.exists()) await dossier.delete(recursive: true);
  });

  test('miss : réseau puis écriture sur disque', () async {
    final r = await lire(nouvelleApi(), res: reseau('A'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', true)]);
    expect(appelsReseau, 1);
    expect((await disque.lire('anon', 'd0|categories'))?.donnees, {'v': 'A'});
  });

  test('hit frais : cache seul, aucun appel réseau', () async {
    await lire(nouvelleApi(), res: reseau('A'));
    maintenant = maintenant.add(const Duration(minutes: 5));

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', false)]);
    expect(appelsReseau, 1); // seulement le premier
  });

  test('périmé mais affichable : cache tout de suite, puis réseau', () async {
    await lire(nouvelleApi(), res: reseau('A'));
    maintenant = maintenant.add(const Duration(hours: 3)); // > frais, < perime

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [
      ('A', false),
      ('B', true),
    ]);
    expect(appelsReseau, 2);
    expect((await disque.lire('anon', 'd0|categories'))?.donnees, {'v': 'B'});
  });

  test('trop périmé : ignoré, réseau seul', () async {
    await lire(nouvelleApi(), res: reseau('A'));
    maintenant = maintenant.add(const Duration(days: 8)); // > perime

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('B', true)]);
  });

  test('erreur réseau : la donnée affichée est conservée, sans erreur', () async {
    await lire(nouvelleApi(), res: reseau('A'));
    maintenant = maintenant.add(const Duration(hours: 3));

    final r = await lire(
      nouvelleApi(),
      res: () async => throw Exception('timeout'),
    );

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', false)]);
  });

  test('erreur réseau sans cache : l\'erreur remonte', () async {
    expect(
      lire(nouvelleApi(), res: () async => throw Exception('timeout')),
      throwsException,
    );
  });

  test('rechargement demandé (même clé revue) : réseau même si frais', () async {
    final api = nouvelleApi();
    await lire(api, res: reseau('A'));

    // Même processus, même clé : c'est un ref.invalidate / pull-to-refresh.
    final r = await lire(api, res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', false), ('B', true)]);
  });

  test('perimer(prefixe) : une écriture force la revalidation', () async {
    await lire(nouvelleApi(), cle: 'articles/c1/p0', res: reseau('A'));
    final api = nouvelleApi();
    maintenant = maintenant.add(const Duration(minutes: 1));
    api.perimer('articles/');

    final r = await lire(api, cle: 'articles/c1/p0', res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', false), ('B', true)]);
  });

  test('revalider : le réseau confirme même un cache frais', () async {
    await lire(nouvelleApi(), res: reseau('A'));

    final r = await lire(nouvelleApi(), res: reseau('A2'), revalider: true);

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('A', false), ('A2', true)]);
  });

  test('isolation : un autre utilisateur ne voit jamais ces données', () async {
    final u1 = ContexteCache.utilisateur(1, 3);
    final u2 = ContexteCache.utilisateur(2, 3);
    await lire(nouvelleApi(), contexte: u1, res: reseau('DONNEES_U1'));

    final r = await lire(nouvelleApi(), contexte: u2, res: reseau('DONNEES_U2'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('DONNEES_U2', true)]);
  });

  test('isolation : le département fait partie de la clé', () async {
    await lire(
      nouvelleApi(),
      contexte: ContexteCache.utilisateur(1, 3),
      res: reseau('DEP3'),
    );

    final r = await lire(
      nouvelleApi(),
      contexte: ContexteCache.utilisateur(1, 7),
      res: reseau('DEP7'),
    );

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('DEP7', true)]);
  });

  test('isolation : les paramètres (slug, filtres) font partie de la clé', () async {
    await lire(nouvelleApi(), cle: 'partenaires/coiffure?loc=', res: reseau('C'));

    final r = await lire(
      nouvelleApi(),
      cle: 'partenaires/plomberie?loc=',
      res: reseau('P'),
    );

    expect(r.map((s) => s.valeur), ['P']);
  });

  test('purge à la déconnexion : données de l\'utilisateur supprimées seulement',
      () async {
    final u1 = ContexteCache.utilisateur(1, 3);
    final u2 = ContexteCache.utilisateur(2, 3);
    await lire(nouvelleApi(), contexte: u1, res: reseau('U1'));
    await lire(nouvelleApi(), contexte: u2, res: reseau('U2'));

    await nouvelleApi().purgerUtilisateur(1);

    expect(await disque.lire('u1', 'd3|categories'), isNull);
    expect((await disque.lire('u2', 'd3|categories'))?.donnees, {'v': 'U2'});
  });

  test('format de cache incompatible : ignoré (et supprimé), sans planter',
      () async {
    await disque.ecrire('anon', 'd0|categories', {'v': 'A'});
    // Simule un cache écrit par une autre version de l'app.
    final fichier = dossier
        .listSync(recursive: true)
        .whereType<File>()
        .firstWhere((f) => f.path.endsWith('.json'));
    final enveloppe = jsonDecode(fichier.readAsStringSync()) as Map;
    enveloppe['v'] = CacheDisque.versionFormat + 1;
    fichier.writeAsStringSync(jsonEncode(enveloppe));

    expect(await disque.lire('anon', 'd0|categories'), isNull);
    expect(fichier.existsSync(), isFalse);
    final r = await lire(nouvelleApi(), res: reseau('B'));
    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('B', true)]);
  });

  test('fichier corrompu : simple miss', () async {
    await disque.ecrire('anon', 'd0|categories', {'v': 'A'});
    final fichier = dossier
        .listSync(recursive: true)
        .whereType<File>()
        .firstWhere((f) => f.path.endsWith('.json'));
    fichier.writeAsStringSync('{ pas du json');

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('B', true)]);
  });

  test('contenu du cache incompréhensible pour le décodeur : réseau prend le relais',
      () async {
    await disque.ecrire('anon', 'd0|categories', {'autre': 'forme'});

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('B', true)]);
  });

  test('réponse réseau arrivée APRÈS la purge : aucune ré-écriture', () async {
    final api = nouvelleApi();
    final u1 = ContexteCache.utilisateur(1, 3);
    final attente = Completer<Object?>();
    final lecture = lire(api, contexte: u1, res: () => attente.future);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    maintenant = maintenant.add(const Duration(seconds: 1));
    await api.purgerUtilisateur(1); // déconnexion pendant la requête
    attente.complete({'v': 'TARDIF'});
    await lecture;

    expect(await disque.lire('u1', 'd3|categories'), isNull);
  });

  test('horloge revenue en arrière : entrée ignorée', () async {
    await lire(nouvelleApi(), res: reseau('A'));
    maintenant = maintenant.subtract(const Duration(days: 1));

    final r = await lire(nouvelleApi(), res: reseau('B'));

    expect(r.map((s) => (s.valeur, s.depuisReseau)), [('B', true)]);
  });
}
