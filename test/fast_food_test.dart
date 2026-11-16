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
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/commande_plat.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurant.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/feuille_plat.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/rangee_populaires.dart';
import 'package:poufiret/global/ui/format_montant.dart';

import 'aide_session.dart';

/// Fast-food au format du serveur : un combo à tailles (sans défaut) et
/// options, trois articles populaires (rangs 2, 1, 3 dans l'ordre de la
/// carte), un article ordinaire, et un menu du jour qui ne doit pas
/// s'afficher. Sans photo : aucun appel réseau.
const _jsonFastFood = '''
{
  "id": 70, "nom": "Speed Burger", "gabarit": "fast_food",
  "description": "", "logo": null, "couverture": "",
  "est_ouvert": true, "prochaine_ouverture": null, "message_statut": "",
  "menus_du_jour": {
    "midi": {
      "id": 9, "service": "midi", "titre": null,
      "heure_debut": "00:00:00", "heure_fin": "23:59:00",
      "heure_limite_commande": null, "commandable": true,
      "lignes": [
        {"id": 90, "plat": 304, "plat_nom": "Glace", "plat_image": null,
         "prix_menu": "500.00", "prix_effectif": "500.00",
         "stock_initial": null, "stock_restant": null, "est_epuise": false, "ordre": 0}
      ]
    },
    "soir": null, "journee": null
  },
  "menus_en_vigueur_maintenant": {"midi": 9},
  "carte": [
    {"id": 1, "nom": "Menus", "description": null, "icone": null, "ordre": 0,
     "plats": [
       {"id": 301, "nom": "Menu Burger", "description": null,
        "prix": "3000.00", "prix_effectif": "3000.00",
        "temps_preparation_min": 15,
        "est_combo": true, "prix_reference": 3500,
        "populaire": true, "rang_populaire": 2,
        "images": [],
        "variantes": [
          {"id": 31, "nom": "Petit", "prix": null, "prix_supplement": "0.00",
           "est_par_defaut": false, "est_active": true, "image": null},
          {"id": 32, "nom": "Grand", "prix": null, "prix_supplement": "1000.00",
           "est_par_defaut": false, "est_active": true, "image": null}
        ],
        "groupes_options": [
          {"id": 41, "libelle": "Boisson", "min_choix": 1, "max_choix": 1,
           "est_actif": true,
           "options": [
             {"id": 51, "nom": "Coca", "prix_supplement": "0.00", "est_actif": true},
             {"id": 52, "nom": "Fanta", "prix_supplement": "0.00", "est_actif": true}
           ]},
          {"id": 42, "libelle": "Sauces", "min_choix": 0, "max_choix": 2,
           "est_actif": true,
           "options": [
             {"id": 53, "nom": "Ketchup", "prix_supplement": "0.00", "est_actif": true},
             {"id": 54, "nom": "Mayo", "prix_supplement": "0.00", "est_actif": true},
             {"id": 55, "nom": "Piment", "prix_supplement": "0.00", "est_actif": true}
           ]}
        ]},
       {"id": 302, "nom": "Frites", "description": null,
        "prix": "1000.00", "prix_effectif": "1000.00",
        "est_combo": false, "prix_reference": null,
        "populaire": true, "rang_populaire": 1,
        "images": [], "variantes": [], "groupes_options": []}
     ]},
    {"id": 2, "nom": "Desserts", "description": null, "icone": null, "ordre": 1,
     "plats": [
       {"id": 303, "nom": "Nuggets", "description": null,
        "prix": "1500.00", "prix_effectif": "1500.00",
        "populaire": true, "rang_populaire": 3,
        "images": [], "variantes": [], "groupes_options": []},
       {"id": 304, "nom": "Glace", "description": null,
        "prix": "500.00", "prix_effectif": "500.00",
        "populaire": false, "rang_populaire": null,
        "images": [], "variantes": [], "groupes_options": []}
     ]}
  ]
}
''';

final Restaurant _fastFood = RestaurantsRepository(
  Dio(),
).detailDepuis(jsonDecode(_jsonFastFood) as Map<String, dynamic>);

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  double largeur = 400,
}) async {
  tester.view.physicalSize = Size(largeur, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        restaurantDetailProvider(
          id: 70,
        ).overrideWith((ref) => Stream.value(_fastFood)),
        vueVitrineProvider(partenaireId: 70).overrideWith((ref) async {}),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
        authProvider.overrideWith(SessionTest.new),
      ],
      child: MaterialApp(home: ecran),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _texteRiche(String texte) =>
    find.textContaining(texte, findRichText: true);

FilledButton _boutonAjout(WidgetTester tester) => tester.widget(
  find.ancestor(
    of: find.textContaining(RegExp('Ajouter au panier|Choisissez un format')),
    matching: find.byType(FilledButton),
  ),
);

void main() {
  final burger = _fastFood.platParId(301)!;

  group('routage', () {
    test('« fast_food » (valeur et type) : gabarit fast-food', () {
      expect(gabaritDepuis('fast_food'), Gabarit.fastFood);
      expect(
        gabaritPartenaire(typesPartenaire: const ['fast_food']),
        Gabarit.fastFood,
      );
      // Le restaurant classique ne change pas.
      expect(gabaritDepuis('restaurant'), Gabarit.restaurant);
    });

    test('page fast-food : la page restaurant, sans menus du jour', () {
      final page = pageGabarit(Gabarit.fastFood, commerceId: 70);
      expect(page, isA<EcranRestaurant>());
      expect((page as EcranRestaurant).avecMenus, isFalse);
    });
  });

  group('données', () {
    test('combo, prix de référence, popularité lus', () {
      expect(burger.estCombo, isTrue);
      expect(burger.prixReference, 3500);
      expect(burger.populaire, isTrue);
      expect(burger.rangPopulaire, 2);
      final glace = _fastFood.platParId(304)!;
      expect(glace.estCombo, isFalse);
      expect(glace.prixReference, isNull);
      expect(glace.rangPopulaire, isNull);
    });

    test('« Les plus commandés » : rangs 1 à 3, dans l\'ordre du rang', () {
      expect(platsPopulaires(_fastFood).map((p) => p.nom), [
        'Frites',
        'Menu Burger',
        'Nuggets',
      ]);
    });

    test('libellés des groupes : obligatoire / facultatif', () {
      final groupes = burger.groupesActifs;
      expect(libelleContrainte(groupes[0]), 'Obligatoire · 1 au choix');
      expect(libelleContrainte(groupes[1]), "Facultatif · jusqu'à 2");
      expect(
        libelleContrainte(groupes[1].copyWith(minChoix: 1, maxChoix: 2)),
        'Obligatoire · de 1 à 2',
      );
      expect(
        libelleContrainte(groupes[1].copyWith(maxChoix: 1)),
        'Facultatif · 1 au choix',
      );
    });
  });

  group('page fast-food', () {
    testWidgets('plus commandés en haut, badges, prix barré, sans menu', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranRestaurant(restaurantId: 70, avecMenus: false),
      );
      expect(find.text('Menu du jour'), findsNothing);
      expect(find.text('Les plus commandés'), findsOneWidget);
      // Ordre du rang : Frites (1), Menu Burger (2), Nuggets (3).
      final x = [302, 301, 303]
          .map((id) => tester.getTopLeft(find.byKey(ValueKey('populaire-$id'))))
          .map((o) => o.dx)
          .toList();
      expect(x[0] < x[1] && x[1] < x[2], isTrue);
      // La rangée est au-dessus des rubriques.
      expect(
        tester.getTopLeft(find.text('Les plus commandés')).dy,
        lessThan(tester.getTopLeft(find.text('Desserts')).dy),
      );
      // Tuiles de la rubrique « Menus » : badges et prix barré.
      expect(find.text('Formule'), findsOneWidget);
      expect(find.text('🔥 Populaire'), findsNWidgets(2));
      expect(_texteRiche('au lieu de ${formatMontant(3500)}'), findsOneWidget);
    });

    testWidgets('pendant une recherche : la rangée disparaît', (tester) async {
      await _monter(
        tester,
        const EcranRestaurant(restaurantId: 70, avecMenus: false),
      );
      await tester.enterText(find.byType(TextField), 'frites');
      await tester.pumpAndSettle();
      expect(find.text('Les plus commandés'), findsNothing);
    });

    testWidgets('320 px : aucun débordement', (tester) async {
      await _monter(
        tester,
        const EcranRestaurant(restaurantId: 70, avecMenus: false),
        largeur: 320,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('fiche d\'un combo', () {
    testWidgets('Taille, formule, prix barré, choix obligatoires', (
      tester,
    ) async {
      await _monter(
        tester,
        const Scaffold(body: FeuillePlat(restaurantId: 70, platId: 301)),
      );
      expect(find.text('Taille'), findsOneWidget);
      expect(find.text('Formule'), findsOneWidget);
      expect(_texteRiche('au lieu de ${formatMontant(3500)}'), findsOneWidget);
      // Temps de préparation : affichage habituel.
      expect(find.text('Préparation : 15 min'), findsOneWidget);
      expect(find.text('Obligatoire · 1 au choix'), findsWidgets);

      // Ni taille ni boisson : bouton inactif.
      expect(_boutonAjout(tester).onPressed, isNull);
      await tester.tap(find.text('Grand'));
      await tester.pump();
      // Taille choisie, boisson manquante : toujours inactif.
      expect(_boutonAjout(tester).onPressed, isNull);
      await tester.ensureVisible(find.text('Coca'));
      await tester.tap(find.text('Coca'));
      await tester.pump();
      expect(
        find.text('Ajouter au panier · ${formatMontant(4000)}'),
        findsOneWidget,
      );
      expect(_boutonAjout(tester).onPressed, isNotNull);
    });
  });
}
