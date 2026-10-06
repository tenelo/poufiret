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
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_liste.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/resultats_recherche.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/video_article.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_articles.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_categories.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/filtre_localites.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/pubs_affichees.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurant.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/widgets/barre_onglets.dart';

/// Réponses RÉELLES de production, dans test/fixtures/.
Object? _capture(String chemin) =>
    jsonDecode(File('test/fixtures/$chemin.json').readAsStringSync());

final _catalogue = CatalogueRepository(dio: Dio());
final _categories = _catalogue.categoriesDepuis(
  _capture('catalogue/categories'),
);

/// Annuaire réel de la catégorie Restaurants (9 partenaires). Seules les
/// images distantes sont retirées : un test de widget n'en télécharge pas.
final _annuaire = [
  for (final p in _catalogue.partenairesDepuis(
    _capture('catalogue/annuaire_restaurants'),
  ))
    p.copyWith(logo: '', photoCouverture: ''),
];

/// Fiche réelle de Chez Capi (restaurant 53).
final _chezCapi = RestaurantsRepository(
  Dio(),
).detailDepuis(_capture('restaurants/fiche_53'));

class _Connecte extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async =>
      const Utilisateur(id: 7, telephone: '+2250100000007', departement: 1);
}

List<Override> _overrides({Stream<List<Categorie>> Function()? categories}) => [
  authProvider.overrideWith(_Connecte.new),
  categoriesProvider.overrideWith(
    (ref) => categories?.call() ?? Stream.value(_categories),
  ),
  departementsProvider.overrideWith(
    (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
  ),
  paniersProvider.overrideWith((ref) async => const <Panier>[]),
  carrouselPublicitesProvider.overrideWith(
    (ref) => Stream.value(PubsAffichees.vide),
  ),
  visiteCategorieProvider(categorieId: 1).overrideWith((ref) async {}),
  partenairesParCategorieProvider(
    slug: 'restaurants',
  ).overrideWith((ref) => Stream.value(_annuaire)),
  rechercheUnifieeProvider(terme: 'restau').overrideWith(
    (ref) async => ResultatsRecherche.fromJson(
      _capture('catalogue/recherche_restau') as Map<String, dynamic>,
    ),
  ),
  // Chez Capi (53) a une fiche restaurant ; Business Center (1) est rangé
  // dans la catégorie mais le serveur ne lui en connaît pas (404 réel).
  restaurantDetailProvider(
    id: 53,
  ).overrideWith((ref) => Stream.value(_chezCapi)),
  restaurantDetailProvider(id: 1).overrideWith(
    (ref) => Stream.error(
      DioException(
        requestOptions: RequestOptions(),
        error: ApiException.fromResponse(404, {
          'erreur': true,
          'message': 'Restaurant introuvable.',
        }),
      ),
    ),
  ),
  for (final id in [1, 53])
    vueVitrineProvider(partenaireId: id).overrideWith((ref) async {}),
  articlesProvider(
    categorieId: 1,
    partenaireId: 1,
  ).overrideWith((ref) => Stream.value(const <ArticleListe>[])),
  videosPartenaireProvider(
    partenaireId: 1,
  ).overrideWith((ref) async => const <VideoArticle>[]),
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
      // Animations système coupées : l'invite de recherche ne défile pas
      // sans fin et l'écran se stabilise.
      child: MaterialApp(
        builder: (context, enfant) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: enfant!,
        ),
        home: ecran,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// L'affichage d'origine de la catégorie : filtre de localités puis grille
/// des partenaires de l'annuaire, comme pour toute autre catégorie.
void _attendreAnnuaire() {
  final contenu = find.byType(ContenuPrestataires);
  expect(contenu, findsOneWidget);
  Finder dans(Finder f) => find.descendant(of: contenu, matching: f);

  expect(dans(find.byType(FiltreLocalites)), findsOneWidget);
  expect(dans(find.text('Mon département')), findsOneWidget);
  expect(dans(find.text('Par région')), findsOneWidget);
  expect(dans(find.text('Tout')), findsOneWidget);
  expect(dans(find.byType(GrillePrestataires)), findsOneWidget);
  for (final nom in ['Business Center', 'Chez Capi', 'Chez Sara']) {
    expect(dans(find.text(nom)), findsOneWidget);
  }
  // Rien de propre aux restaurants.
  expect(dans(find.byType(FilterChip)), findsNothing);
  expect(dans(find.byType(TextField)), findsNothing);
  expect(find.text('Livraison'), findsNothing);
  expect(find.text('Ouvert'), findsNothing);
  expect(find.text('Fermé'), findsNothing);
}

void main() {
  test('données réelles : catégorie et annuaire Restaurants', () {
    final c = _categories.feuilles.firstWhere((c) => c.slug == 'restaurants');
    expect(c.typesPartenaire, ['restaurateur']);
    expect(_annuaire, hasLength(9));
    expect(_annuaire.first.nomCommerce, 'Business Center');
  });

  group('affichage de la catégorie Restaurants', () {
    testWidgets('accueil : pub, recherche, onglets, grille — rien d\'autre', (
      tester,
    ) async {
      await _monter(tester, const EcranCategories());
      expect(find.byType(CarrouselPublicites), findsOneWidget);
      expect(find.byType(BarreOnglets), findsOneWidget);
      expect(find.widgetWithText(Card, 'Restaurants'), findsOneWidget);
      expect(find.widgetWithText(Card, 'Pharmacie'), findsOneWidget);
      expect(find.text('Chez Capi'), findsNothing);
      expect(find.text('Tout voir'), findsNothing);
      expect(find.textContaining('Menus du jour'), findsNothing);
    });

    testWidgets('onglet « Restaurants » : annuaire d\'origine', (tester) async {
      await _monter(tester, const EcranCategories());
      await tester.tap(
        find.descendant(
          of: find.byType(BarreOnglets),
          matching: find.text('Restaurants'),
        ),
      );
      await tester.pumpAndSettle();
      _attendreAnnuaire();
    });

    testWidgets('tuile « Restaurants » : annuaire d\'origine', (tester) async {
      await _monter(tester, const EcranCategories());
      await tester.tap(find.widgetWithText(Card, 'Restaurants'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranPrestataires), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Restaurants'), findsOneWidget);
      _attendreAnnuaire();
    });

    testWidgets('résultat de recherche : annuaire d\'origine', (tester) async {
      await _monter(tester, const EcranRecherche());
      await tester.enterText(find.byType(TextField), 'restau');
      await tester.pump(const Duration(milliseconds: 500)); // anti-rebond
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Restaurants'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranPrestataires), findsOneWidget);
      _attendreAnnuaire();
    });
  });

  group('toucher une tuile de l\'annuaire Restaurants', () {
    Future<void> ouvrir(WidgetTester tester, String nom) async {
      await _monter(tester, ecranCategorieRestaurants());
      // Dans l'app, la session est déjà chargée par la racine.
      ProviderScope.containerOf(
        tester.element(find.byType(EcranPrestataires)),
      ).listen(authProvider, (_, _) {});
      await tester.pumpAndSettle();
      await tester.tap(find.text(nom));
      await tester.pumpAndSettle();
    }

    testWidgets('restaurant : sa page (menu du jour, carte)', (tester) async {
      await ouvrir(tester, 'Chez Capi');
      expect(find.byType(EcranRestaurant), findsOneWidget);
      expect(find.byType(EcranArticles), findsNothing);
      expect(find.text('Chez Capi'), findsWidgets);
    });

    testWidgets(
      'partenaire sans fiche restaurant (404) : sa fiche habituelle',
      (tester) async {
        await ouvrir(tester, 'Business Center');
        expect(find.byType(EcranArticles), findsOneWidget);
        expect(find.text('Restaurant introuvable.'), findsNothing);
      },
    );
  });
}

/// L'écran de la catégorie réelle Restaurants, tel que l'ouvre l'accueil.
Widget ecranCategorieRestaurants() {
  final c = _categories.feuilles.firstWhere((c) => c.slug == 'restaurants');
  return EcranPrestataires(
    categorieId: c.id,
    categorieNom: c.nom,
    categorieSlug: c.slug,
    modeTransaction: c.modeTransaction,
    afficheCatalogue: c.afficheCatalogue,
    typesPartenaire: c.typesPartenaire,
  );
}
