import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/proposition_decouverte.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/parcours_decouverte.dart';
import 'package:poufiret/fonctionnalites/publicites/screens/ecran_decouvrir_poufiret.dart';

Map<String, Object?> _ecran(int ordre, {Object? bouton}) => {
  'id': 'e$ordre',
  'ordre': ordre,
  'titre': 'Titre $ordre',
  'texte': 'Texte $ordre',
  'image': null,
  'bouton': bouton,
};

const _bouton = {
  'libelle': 'Voir les pharmacies',
  'categorie': {'id': 7, 'nom': 'Pharmacie', 'slug': 'pharmacie'},
};

ParcoursDecouverte _parcours(List<Map<String, Object?>> ecrans) =>
    ParcoursDecouverte.fromJson({
      'actif': true,
      'version': 3,
      'ecrans': ecrans,
    });

Future<void> _monter(
  WidgetTester tester,
  ParcoursDecouverte parcours, {
  double largeur = 400,
}) async {
  tester.view.physicalSize = Size(largeur, 700);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(home: EcranDecouvrirPoufiret(parcours: parcours)),
  );
}

void main() {
  group('lecture de la réponse', () {
    test('écrans triés par ordre ; bouton lu ou null', () {
      final p = _parcours([
        _ecran(2),
        _ecran(1, bouton: _bouton),
        _ecran(3, bouton: {'libelle': 'Sans catégorie', 'categorie': null}),
      ]);
      expect(p.version, 3);
      expect(p.ecrans.map((e) => e.titre), ['Titre 1', 'Titre 2', 'Titre 3']);
      expect(p.ecrans[0].bouton?.categorie.nom, 'Pharmacie');
      expect(p.ecrans[1].bouton, isNull);
      expect(p.ecrans[2].bouton, isNull);
    });

    test('inactif : jamais affichable', () {
      final p = ParcoursDecouverte.fromJson({
        'actif': false,
        'version': 3,
        'ecrans': [],
      });
      expect(p.affichable, isFalse);
    });
  });

  test('proposé seulement si actif et version différente de la vue', () {
    final p = _parcours([_ecran(1), _ecran(2), _ecran(3)]);
    expect(doitProposerDecouverte(p, null), isTrue);
    expect(doitProposerDecouverte(p, '2'), isTrue);
    expect(doitProposerDecouverte(p, '3'), isFalse);
    expect(doitProposerDecouverte(ParcoursDecouverte.inactif, null), isFalse);
  });

  group('écran', () {
    testWidgets('Passer au début, Terminer au dernier écran', (tester) async {
      await _monter(tester, _parcours([_ecran(1), _ecran(2), _ecran(3)]));
      expect(find.text('Titre 1'), findsOneWidget);
      expect(find.text('Passer'), findsOneWidget);
      expect(find.text('Terminer'), findsNothing);

      for (var i = 0; i < 2; i++) {
        await tester.drag(find.byType(PageView), const Offset(-500, 0));
        await tester.pumpAndSettle();
      }
      expect(find.text('Titre 3'), findsOneWidget);
      expect(find.text('Passer'), findsNothing);
      expect(find.text('Terminer'), findsOneWidget);
    });

    testWidgets('bouton affiché seulement s\'il existe', (tester) async {
      await _monter(tester, _parcours([_ecran(1, bouton: _bouton), _ecran(2)]));
      expect(find.text('Voir les pharmacies'), findsOneWidget);

      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();
      expect(find.text('Voir les pharmacies'), findsNothing);
    });

    testWidgets('320 px et 8 écrans : aucun débordement', (tester) async {
      await _monter(
        tester,
        _parcours([for (var i = 1; i <= 8; i++) _ecran(i, bouton: _bouton)]),
        largeur: 320,
      );
      expect(tester.takeException(), isNull);
      for (var i = 0; i < 7; i++) {
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();
      }
      expect(find.text('Terminer'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
