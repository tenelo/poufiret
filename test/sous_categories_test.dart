import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/aiguillage_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_sous_categories.dart';
import 'package:poufiret/fonctionnalites/catalogue/widgets/tuile_categorie.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/filtre_localites.dart';
import 'package:poufiret/global/widgets/puces_filtre.dart';

import 'aide_session.dart';

Categorie _cat(
  int id,
  String nom, {
  String? affichage,
  List<Categorie> enfants = const [],
}) => Categorie(
  id: id,
  nom: nom,
  slug: nom.toLowerCase(),
  affichageEnfants: affichage,
  enfants: enfants,
);

PartenaireCategorie _p(int id, String nom) =>
    PartenaireCategorie.fromJson({'id': id, 'nom_commerce': nom});

final _a = _p(1, 'Boutique A');
final _b = _p(2, 'Boutique B');

/// Mode « pastilles » : Mode > Chaussures, Vêtements.
final _mode = _cat(
  20,
  'Mode',
  affichage: 'pastilles',
  enfants: [_cat(21, 'Chaussures'), _cat(22, 'Vêtements')],
);

/// Mode « grille » : Animaux > Porc, Volaille (> Poulet, Pintade : pastilles).
final _animaux = _cat(
  30,
  'Animaux',
  affichage: 'grille',
  enfants: [
    _cat(31, 'Porc'),
    _cat(32, 'Volaille', enfants: [_cat(33, 'Poulet'), _cat(34, 'Pintade')]),
  ],
);

/// Requêtes de l'annuaire : (slug, sous_categorie).
final _demandes = <(String, int?)>[];

Override _annuaire(
  String slug,
  int? sous,
  List<PartenaireCategorie> resultat,
) => partenairesParCategorieProvider(slug: slug, sousCategorie: sous)
    .overrideWith((ref) {
      _demandes.add((slug, sous));
      return Stream.value(resultat);
    });

Future<void> _monter(WidgetTester tester, Widget ecran) async {
  _demandes.clear();
  tester.view.physicalSize = const Size(420, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(SessionTest.new),
        departementsProvider.overrideWith(
          (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
        ),
        for (final id in [10, 20, 21, 22, 30, 31, 32, 33, 34])
          visiteCategorieProvider(categorieId: id).overrideWith((ref) async {}),
        _annuaire('pharmacie', null, [_a]),
        _annuaire('mode', null, [_a, _b]),
        _annuaire('mode', 21, [_a]),
        _annuaire('mode', 22, [_b]),
        _annuaire('animaux', 31, [_a]),
        _annuaire('animaux', 32, [_b]),
        _annuaire('volaille', null, [_a, _b]),
        _annuaire('volaille', 33, [_a]),
      ],
      child: MaterialApp(home: ecran),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _pastille(String nom) => find.widgetWithText(ChoiceChip, nom);

void main() {
  testWidgets('sans enfants : annuaire actuel, inchangé', (tester) async {
    await _monter(tester, ecranCategorie(_cat(10, 'Pharmacie')));
    expect(find.byType(EcranPrestataires), findsOneWidget);
    expect(find.byType(EcranSousCategories), findsNothing);
    expect(find.byType(PucesFiltre<Categorie?>), findsNothing);
    expect(find.text('Boutique A'), findsOneWidget);
    expect(_demandes.last, ('pharmacie', null));
  });

  group('mode pastilles', () {
    testWidgets('Tous agrégé, puis une pastille filtre', (tester) async {
      await _monter(tester, ecranCategorie(_mode));
      expect(find.byType(EcranSousCategories), findsOneWidget);
      expect(_pastille('Tous'), findsOneWidget);
      expect(_pastille('Chaussures'), findsOneWidget);
      expect(_pastille('Vêtements'), findsOneWidget);
      // Localisation au-dessus des pastilles de sous-catégories.
      expect(
        tester.getTopLeft(find.byType(FiltreLocalites)).dy,
        lessThan(tester.getTopLeft(_pastille('Tous')).dy),
      );
      // « Tous » : annuaire agrégé, en grille de 2 colonnes.
      expect(_demandes.last, ('mode', null));
      final a = tester.getTopLeft(find.text('Boutique A'));
      final b = tester.getTopLeft(find.text('Boutique B'));
      expect(a.dy, b.dy);
      expect(b.dx, greaterThan(a.dx));
      expect(tester.takeException(), isNull);

      await tester.tap(_pastille('Chaussures'));
      await tester.pumpAndSettle();
      expect(_demandes.last, ('mode', 21));
      expect(find.text('Boutique A'), findsOneWidget);
      expect(find.text('Boutique B'), findsNothing);
      expect(find.widgetWithText(AppBar, 'Chaussures'), findsOneWidget);

      await tester.tap(_pastille('Tous'));
      await tester.pumpAndSettle();
      expect(_demandes.last, ('mode', null));
      expect(find.text('Boutique B'), findsOneWidget);
    });

    testWidgets('valeur absente ou inconnue : pastilles', (tester) async {
      for (final valeur in [null, 'carrousel']) {
        final c = _mode.copyWith(affichageEnfants: valeur);
        expect(c.enfantsEnGrille, isFalse);
        await _monter(tester, ecranCategorie(c));
        expect(find.byType(EcranSousCategories), findsOneWidget);
        expect(find.byType(EcranGrilleSousCategories), findsNothing);
        expect(_pastille('Tous'), findsOneWidget);
      }
    });
  });

  group('mode grille', () {
    testWidgets('tuiles, puis annuaire avec les pastilles sœurs', (
      tester,
    ) async {
      await _monter(tester, ecranCategorie(_animaux));
      expect(find.byType(EcranGrilleSousCategories), findsOneWidget);
      expect(find.byType(TuileCategorie), findsNWidgets(2));
      expect(_demandes, isEmpty);

      await tester.tap(find.widgetWithText(TuileCategorie, 'Porc'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranSousCategories), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Porc'), findsOneWidget);
      // Les sœurs, sans « Tous ».
      expect(_pastille('Porc'), findsOneWidget);
      expect(_pastille('Volaille'), findsOneWidget);
      expect(_pastille('Tous'), findsNothing);
      expect(_demandes.last, ('animaux', 31));
      expect(find.text('Boutique A'), findsOneWidget);

      await tester.tap(_pastille('Volaille'));
      await tester.pumpAndSettle();
      expect(_demandes.last, ('animaux', 32));
      expect(find.text('Boutique B'), findsOneWidget);
      expect(find.text('Boutique A'), findsNothing);
      expect(find.widgetWithText(AppBar, 'Volaille'), findsOneWidget);
    });

    testWidgets('récursif : une sous-catégorie à enfants suit sa règle', (
      tester,
    ) async {
      await _monter(tester, ecranCategorie(_animaux));
      // Volaille a des enfants (réglage absent : pastilles).
      await tester.tap(find.widgetWithText(TuileCategorie, 'Volaille'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Volaille'), findsOneWidget);
      expect(_pastille('Tous'), findsOneWidget);
      expect(_pastille('Poulet'), findsOneWidget);
      expect(_pastille('Pintade'), findsOneWidget);
      expect(_demandes.last, ('volaille', null));

      await tester.tap(_pastille('Poulet'));
      await tester.pumpAndSettle();
      expect(_demandes.last, ('volaille', 33));
    });
  });

  test('toutes : parentes comprises, récursif', () {
    expect([_animaux].toutes.map((c) => c.id), [30, 31, 32, 33, 34]);
    expect([_animaux].feuilles.map((c) => c.id), [31, 33, 34]);
  });
}
