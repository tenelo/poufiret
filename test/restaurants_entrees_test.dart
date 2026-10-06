import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_repository.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/resultats_recherche.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_categories.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/pubs_affichees.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurants.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/carte_restaurant.dart';
import 'package:poufiret/global/cache/cache_api.dart';
import 'package:poufiret/global/cache/cache_disque.dart';
import 'package:poufiret/global/cache/cache_providers.dart';
import 'package:poufiret/global/cache/contexte_cache.dart';
import 'package:poufiret/global/widgets/barre_onglets.dart';

/// Réponses RÉELLES de production, dans test/fixtures/.
Object? _capture(String chemin) =>
    jsonDecode(File('test/fixtures/$chemin.json').readAsStringSync());

const _noms = ['Chez Sara', 'Chez Capi', 'Resto Ferke Centre'];
const _generique = 'ANNUAIRE GENERIQUE';

final _categories = CatalogueRepository(
  dio: Dio(),
).categoriesDepuis(_capture('catalogue/categories'));

/// Les 3 restaurants réels de Ferké. Seul le logo distant du troisième est
/// retiré pour l'affichage : un test de widget ne télécharge pas d'image.
final _restaurants = [
  for (final r in RestaurantsRepository(
    Dio(),
  ).listeDepuis(_capture('restaurants/liste_departement_1')))
    r.copyWith(logo: ''),
];

class _Connecte extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => const Utilisateur(
    id: 7,
    telephone: '+2250100000007',
    departement: 1,
    departementNom: 'Ferké',
  );
}

List<Override> _overrides({Stream<List<Categorie>> Function()? categories}) => [
  authProvider.overrideWith(_Connecte.new),
  categoriesProvider.overrideWith(
    (ref) => categories?.call() ?? Stream.value(_categories),
  ),
  restaurantsProvider.overrideWith((ref) => Stream.value(_restaurants)),
  menusDuJourAccueilProvider.overrideWith(
    (ref) => Stream.value(const <MenuDuJourAccueil>[]),
  ),
  paniersProvider.overrideWith((ref) async => const <Panier>[]),
  carrouselPublicitesProvider.overrideWith(
    (ref) => Stream.value(PubsAffichees.vide),
  ),
  visiteCategorieProvider(categorieId: 1).overrideWith((ref) async {}),
  // L'ancien annuaire générique de la catégorie : ne doit jamais s'afficher.
  partenairesParCategorieProvider(slug: 'restaurants').overrideWith(
    (ref) => Stream.value(const [
      PartenaireCategorie(id: 99, nomCommerce: _generique),
    ]),
  ),
  rechercheUnifieeProvider(terme: 'restau').overrideWith(
    (ref) async => ResultatsRecherche.fromJson(
      _capture('catalogue/recherche_restau') as Map<String, dynamic>,
    ),
  ),
];

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override>? overrides,
}) async {
  tester.view.physicalSize = const Size(420, 1800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides ?? _overrides(),
      child: MaterialApp(home: ecran),
    ),
  );
  await tester.pumpAndSettle();
}

/// L'écran « Restaurants » montre les 3 restaurants, pas l'annuaire générique.
void _attendreListeRestaurants() {
  expect(find.byType(ContenuRestaurants), findsOneWidget);
  expect(find.byType(ContenuPrestataires), findsNothing);
  expect(find.text(_generique), findsNothing);
  final contenu = find.byType(ContenuRestaurants);
  expect(
    find.descendant(of: contenu, matching: find.byType(CarteRestaurant)),
    findsNWidgets(3),
  );
  for (final nom in _noms) {
    expect(
      find.descendant(of: contenu, matching: find.text(nom)),
      findsOneWidget,
    );
  }
}

void main() {
  test('réponse réelle : 3 restaurants, aucun écarté au décodage', () {
    final bruts =
        (_capture('restaurants/liste_departement_1') as Map)['resultats']
            as List;
    expect(bruts, hasLength(3));
    // Deux sans logo, tous sans couverture ni menu du jour, listes vides.
    expect(bruts.where((r) => r['logo'] == null), hasLength(2));
    expect(bruts.every((r) => r['couverture'] == null), isTrue);
    expect(bruts.every((r) => r['menu_du_jour'] == null), isTrue);
    expect(bruts.every((r) => (r['services'] as List).isEmpty), isTrue);

    final liste = RestaurantsRepository(
      Dio(),
    ).listeDepuis(_capture('restaurants/liste_departement_1'));
    expect(liste.map((r) => r.nom), _noms);
    expect(liste[0].localiteNom, 'Ferké');
    expect(liste[0].quartierNom, 'Bromakoté');
    expect(liste[1].localiteNom, isNull);
  });

  test('la catégorie réelle « Restaurants » est de type restaurateur', () {
    final c = _categories.feuilles.firstWhere((c) => c.slug == 'restaurants');
    expect(c.typesPartenaire, ['restaurateur']);
    expect(c.aDesPartenaires, isTrue);
  });

  group('entrées vers l\'écran Restaurants', () {
    testWidgets('accueil : la section affiche les 3 restaurants', (
      tester,
    ) async {
      await _monter(tester, const EcranCategories());
      for (final nom in _noms) {
        expect(find.text(nom), findsOneWidget);
      }
    });

    testWidgets('onglet « Restaurants » de la barre de catégories', (
      tester,
    ) async {
      await _monter(tester, const EcranCategories());
      await tester.tap(
        find.descendant(
          of: find.byType(BarreOnglets),
          matching: find.text('Restaurants'),
        ),
      );
      await tester.pumpAndSettle();
      _attendreListeRestaurants();
    });

    testWidgets('tuile « Restaurants » de la grille', (tester) async {
      await _monter(tester, const EcranCategories());
      final tuile = find.widgetWithText(Card, 'Restaurants');
      await tester.ensureVisible(tuile);
      await tester.pumpAndSettle();
      await tester.tap(tuile);
      await tester.pumpAndSettle();
      expect(find.byType(EcranRestaurants), findsOneWidget);
      _attendreListeRestaurants();
    });

    testWidgets('lien « Tout voir » de la section Restaurants', (tester) async {
      await _monter(tester, const EcranCategories());
      await tester.tap(find.text('Tout voir'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranRestaurants), findsOneWidget);
      _attendreListeRestaurants();
    });

    Future<void> chercherEtOuvrir(WidgetTester tester) async {
      await tester.enterText(find.byType(TextField), 'restau');
      await tester.pump(const Duration(milliseconds: 500)); // anti-rebond
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Restaurants'));
      await tester.pumpAndSettle();
    }

    testWidgets('résultat de recherche de type catégorie', (tester) async {
      await _monter(tester, const EcranRecherche());
      await chercherEtOuvrir(tester);
      expect(find.byType(EcranRestaurants), findsOneWidget);
      _attendreListeRestaurants();
    });

    testWidgets('recherche ouverte avant le chargement des catégories', (
      tester,
    ) async {
      final categories = StreamController<List<Categorie>>();
      addTearDown(categories.close);
      await _monter(
        tester,
        const EcranRecherche(),
        overrides: _overrides(categories: () => categories.stream),
      );
      await tester.enterText(find.byType(TextField), 'restau');
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await tester.pump();
      await tester.tap(find.widgetWithText(ListTile, 'Restaurants'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      // Les catégories ne sont pas encore là : jamais l'annuaire générique.
      expect(find.text(_generique), findsNothing);
      expect(find.byType(ContenuPrestataires), findsNothing);

      categories.add(_categories);
      await tester.pumpAndSettle();
      expect(find.byType(EcranRestaurants), findsOneWidget);
      _attendreListeRestaurants();
    });
  });

  group('paramètre departement', () {
    Future<Uri> requete(int departement) async {
      final serveur = _ServeurVide();
      final dio = Dio(BaseOptions(baseUrl: 'https://exemple.test'))
        ..httpClientAdapter = serveur;
      await RestaurantsRepository(dio).listeBrut(departement: departement);
      return serveur.uris.single;
    }

    test('utilisateur de Ferké : ?departement=1', () async {
      final uri = await requete(1);
      expect(uri.path, '/api/v1/restaurants/');
      expect(uri.queryParameters, {'departement': '1'});
    });

    test('visiteur sans département : paramètre omis', () async {
      expect((await requete(0)).queryParameters, isEmpty);
    });
  });

  group('cache de la liste', () {
    late Directory dossier;
    late DateTime maintenant;
    late CacheDisque disque;
    late _FauxRestaurants repo;
    late ProviderContainer conteneur;
    late List<List<String>> vues;

    const contexte = ContexteCache(portee: 'u7', departement: 1);

    setUp(() async {
      dossier = await Directory.systemTemp.createTemp('restos_test');
      maintenant = DateTime(2026, 10, 6, 12);
      disque = CacheDisque(() async => dossier.path, horloge: () => maintenant);
      repo = _FauxRestaurants(_capture('restaurants/liste_departement_1'));
      vues = [];
    });

    tearDown(() async {
      conteneur.dispose();
      try {
        if (await dossier.exists()) await dossier.delete(recursive: true);
      } catch (_) {}
    });

    /// Démarre l'écoute de la liste et attend la fin de la lecture (cache
    /// puis, s'il y a lieu, réseau).
    Future<void> charger() async {
      conteneur = ProviderContainer(
        overrides: [
          cacheDisqueProvider.overrideWithValue(disque),
          cacheApiProvider.overrideWithValue(
            CacheApi(disque, horloge: () => maintenant),
          ),
          contexteCacheProvider.overrideWith(_ContexteFerke.new),
          restaurantsRepositoryProvider.overrideWithValue(repo),
        ],
      );
      conteneur.listen(restaurantsProvider, (_, suivant) {
        final liste = suivant.value;
        if (!suivant.isLoading && liste != null) {
          vues.add([for (final r in liste) r.nom]);
        }
      }, fireImmediately: true);
      await conteneur.read(cacheApiProvider).attendreFinChargements();
    }

    Future<void> semerListeVide({required Duration age}) async {
      final ecritLe = maintenant.subtract(age);
      await CacheDisque(
        () async => dossier.path,
        horloge: () => ecritLe,
      ).ecrire(contexte.portee, contexte.cleComplete('restaurants/liste'), {
        'resultats': <Object?>[],
      });
    }

    test(
      'premier chargement : réseau, avec le département de l\'utilisateur',
      () async {
        await charger();
        expect(repo.departements, [1]);
        expect(vues.last, _noms);
      },
    );

    test(
      'ancienne liste vide (plus de 2 min) : remplacée par le réseau',
      () async {
        await semerListeVide(age: const Duration(minutes: 10));
        await charger();
        expect(repo.departements, [1]);
        expect(vues.first, isEmpty); // affichée le temps du réseau
        expect(vues.last, _noms);
      },
    );

    test(
      'liste vide encore fraîche : tirer pour rafraîchir force le réseau',
      () async {
        await semerListeVide(age: const Duration(seconds: 30));
        await charger();
        expect(repo.departements, isEmpty); // fraîche : pas de réseau
        expect(vues.last, isEmpty);

        // Ce que fait le geste « tirer pour rafraîchir ».
        conteneur.invalidate(restaurantsProvider);
        await conteneur.read(cacheApiProvider).attendreFinChargements();
        expect(repo.departements, [1]);
        expect(vues.last, _noms);
      },
    );
  });
}

/// Serveur factice : note les requêtes et répond une liste vide.
class _ServeurVide implements HttpClientAdapter {
  final uris = <Uri>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    uris.add(options.uri);
    return ResponseBody.fromString(
      '{"resultats": []}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Dépôt factice : répond la liste réelle et note le département demandé.
class _FauxRestaurants extends RestaurantsRepository {
  _FauxRestaurants(this.reponse) : super(Dio());

  final Object? reponse;
  final departements = <int>[];

  @override
  Future<Object?> listeBrut({required int departement}) async {
    departements.add(departement);
    return reponse;
  }
}

/// Utilisateur 7, département 1 (Ferké).
class _ContexteFerke extends ContexteCacheNotifier {
  @override
  ContexteCache build() => const ContexteCache(portee: 'u7', departement: 1);
}
