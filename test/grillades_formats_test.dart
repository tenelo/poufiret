import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/page_gabarit.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_repository.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/commande_plat.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurant.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/cartes_formats.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/feuille_plat.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/format_montant.dart';

import 'aide_session.dart';

/// Grilleur au format du serveur : un menu du jour (qui ne doit pas
/// s'afficher), un article à deux formats SANS format par défaut, avec
/// prix_a_partir_de fourni par le serveur (volontairement différent du
/// calcul local, pour vérifier qu'il est utilisé), et un article simple.
const _jsonGrilleur = '''
{
  "id": 60, "nom": "Chez Ali Grill", "gabarit": "grillades",
  "description": "", "logo": null, "couverture": "",
  "est_ouvert": true, "prochaine_ouverture": null, "message_statut": "",
  "menus_du_jour": {
    "midi": {
      "id": 8, "service": "midi", "titre": null,
      "heure_debut": "00:00:00", "heure_fin": "23:59:00",
      "heure_limite_commande": null, "commandable": true,
      "lignes": [
        {"id": 80, "plat": 202, "plat_nom": "Brochette", "plat_image": null,
         "prix_menu": "900.00", "prix_effectif": "900.00",
         "stock_initial": null, "stock_restant": null, "est_epuise": false, "ordre": 0}
      ]
    },
    "soir": null, "journee": null
  },
  "menus_en_vigueur_maintenant": {"midi": 8},
  "carte": [
    {"id": 1, "nom": "Braisés", "description": null, "icone": null, "ordre": 0,
     "plats": [
       {"id": 201, "nom": "Poulet braisé", "description": null,
        "prix": "3000.00", "prix_effectif": "3000.00",
        "prix_a_partir_de": "2000.00",
        "images": [], "groupes_options": [],
        "variantes": [
          {"id": 21, "nom": "Demi", "prix": "2500.00", "prix_supplement": "0.00",
           "est_par_defaut": false, "est_active": true, "image": null},
          {"id": 22, "nom": "Entier", "prix": "5000.00", "prix_supplement": "0.00",
           "est_par_defaut": false, "est_active": true, "image": null}
        ]},
       {"id": 202, "nom": "Brochette", "description": null,
        "prix": "1000.00", "prix_effectif": "1000.00",
        "images": [], "variantes": [], "groupes_options": []}
     ]}
  ]
}
''';

final Restaurant _grilleur = RestaurantsRepository(
  Dio(),
).detailDepuis(jsonDecode(_jsonGrilleur) as Map<String, dynamic>);

/// Serveur qui refuse l'ajout avec un message 400.
class _AjoutRefuse extends OrdersRepository {
  _AjoutRefuse(this.message) : super(dio: Dio());

  final String message;

  @override
  Future<Panier> ajouterLigne({
    int? articleId,
    required num quantite,
    int? varianteId,
    int? ligneMenuId,
    List<int>? optionIds,
    List<int>? supplementIds,
    String? noteSpeciale,
  }) async => throw DioException(
    requestOptions: RequestOptions(),
    error: ApiException.fromResponse(400, {'erreur': true, 'message': message}),
  );
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  OrdersRepository? commandes,
  double largeur = 400,
}) async {
  tester.view.physicalSize = Size(largeur, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        restaurantDetailProvider(
          id: 60,
        ).overrideWith((ref) => Stream.value(_grilleur)),
        vueVitrineProvider(partenaireId: 60).overrideWith((ref) async {}),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
        authProvider.overrideWith(SessionTest.new),
        if (commandes != null)
          ordersRepositoryProvider.overrideWithValue(commandes),
      ],
      child: MaterialApp(home: ecran),
    ),
  );
  await tester.pumpAndSettle();
}

FilledButton _boutonAjout(WidgetTester tester) => tester.widget(
  find.ancestor(
    of: find.textContaining(RegExp('Ajouter au panier|Choisissez un format')),
    matching: find.byType(FilledButton),
  ),
);

void main() {
  final poulet = _grilleur.platParId(201)!;

  group('routage', () {
    test('« grillades » et le type « grilleur » : gabarit grillades', () {
      expect(gabaritDepuis('grillades'), Gabarit.grillades);
      expect(gabaritDepuis('grilleur'), Gabarit.grillades);
      expect(
        gabaritPartenaire(typesPartenaire: const ['grilleur']),
        Gabarit.grillades,
      );
    });

    test('page grillades : la page restaurant, sans menus du jour', () {
      final page = pageGabarit(Gabarit.grillades, commerceId: 60);
      expect(page, isA<EcranRestaurant>());
      expect((page as EcranRestaurant).avecMenus, isFalse);
      expect(page.grille, isFalse);
    });
  });

  group('données', () {
    test('format : photo lue ; produit : prix_a_partir_de lu', () {
      final avecPhoto = VariantePlat.fromJson({
        'id': 1,
        'nom': 'Entier',
        'image': 'https://exemple.test/entier.jpg',
      });
      expect(avecPhoto.image, 'https://exemple.test/entier.jpg');
      expect(poulet.variantes.first.image, isNull);
      expect(poulet.prixAPartirDeServeur, 2000);
    });

    test('« à partir de » : valeur du serveur, sinon calcul local', () {
      expect(prixAPartirDe(poulet), 2000);
      expect(prixAPartirDe(poulet.copyWith(prixAPartirDeServeur: null)), 2500);
    });

    test('présélection : seulement le format par défaut disponible', () {
      expect(varianteParDefaut(poulet), isNull);
      final avecDefaut = poulet.copyWith(
        variantes: [
          poulet.variantes[0],
          poulet.variantes[1].copyWith(estParDefaut: true),
        ],
      );
      expect(varianteParDefaut(avecDefaut)?.nom, 'Entier');
      final defautEpuise = poulet.copyWith(
        variantes: [
          poulet.variantes[0],
          poulet.variantes[1].copyWith(estParDefaut: true, estEpuise: true),
        ],
      );
      expect(varianteParDefaut(defautEpuise), isNull);
    });
  });

  group('page grilleur', () {
    testWidgets('carte seule : pas de menu du jour, « à partir de »', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranRestaurant(restaurantId: 60, avecMenus: false),
      );
      expect(find.text('Menu du jour'), findsNothing);
      expect(find.text('Poulet braisé'), findsOneWidget);
      expect(find.text('à partir de ${formatMontant(2000)}'), findsOneWidget);
      expect(find.text(formatMontant(1000)), findsOneWidget);
    });

    testWidgets('même données, page restaurant : le menu du jour reste', (
      tester,
    ) async {
      await _monter(tester, const EcranRestaurant(restaurantId: 60));
      expect(find.text('Menu du jour'), findsOneWidget);
    });
  });

  group('fiche article', () {
    testWidgets('sans format par défaut : bouton inactif jusqu\'au choix', (
      tester,
    ) async {
      await _monter(
        tester,
        const Scaffold(body: FeuillePlat(restaurantId: 60, platId: 201)),
      );
      // Titre propre aux grillades ; formats sans photo : la liste.
      expect(find.text('Format'), findsOneWidget);
      expect(find.byType(CartesFormats), findsNothing);
      expect(find.text('Choisissez un format'), findsOneWidget);
      expect(_boutonAjout(tester).onPressed, isNull);

      await tester.tap(find.text('Demi'));
      await tester.pump();
      expect(
        find.text('Ajouter au panier · ${formatMontant(2500)}'),
        findsOneWidget,
      );
      expect(_boutonAjout(tester).onPressed, isNotNull);
    });

    testWidgets('refus 400 du serveur : son message tel quel', (tester) async {
      await _monter(
        tester,
        const Scaffold(body: FeuillePlat(restaurantId: 60, platId: 201)),
        commandes: _AjoutRefuse('Choisissez un format.'),
      );
      await tester.tap(find.text('Demi'));
      await tester.pump();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text('Choisissez un format.'), findsOneWidget);
    });
  });

  group('cartes de formats', () {
    final formats = [
      const VariantePlat(id: 1, nom: 'Demi'),
      const VariantePlat(id: 2, nom: 'Entier'),
      const VariantePlat(id: 3, nom: 'Familial', estEpuise: true),
    ];

    test('cartes seulement si un format a une photo', () {
      expect(CartesFormats.avecPhotos(formats), isFalse);
      expect(
        CartesFormats.avecPhotos([
          ...formats,
          const VariantePlat(id: 4, nom: 'XL', image: 'https://x.test/a.jpg'),
        ]),
        isTrue,
      );
    });

    testWidgets('un seul choisi, épuisé non sélectionnable, 320 px', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final choix = <int>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: CartesFormats(
                formats: formats,
                selection: 2,
                prixDe: (v) => formatMontant(v.id * 1000),
                onChoisir: choix.add,
              ),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Demi'), findsOneWidget);
      expect(find.text(formatMontant(1000)), findsOneWidget);
      expect(find.text('Épuisé'), findsOneWidget);
      // Le format choisi porte la coche.
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      await tester.tap(find.text('Demi'));
      await tester.tap(find.text('Familial'));
      expect(choix, [1]);
    });
  });
}
