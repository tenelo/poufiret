import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_repository.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/element_carrousel.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/carrousel_publicites.dart';

/// Faux dépôt : note chaque impression avec son endpoint.
class _FauxPubsRepo extends PublicitesRepository {
  _FauxPubsRepo() : super(dio: Dio());

  final partenaires = <String>[];
  final poufiret = <String>[];

  @override
  Future<void> enregistrerImpression(
    String id, {
    required String typeAffichage,
    bool cliquee = false,
    int? minuteSession,
    String? sessionId,
  }) async => partenaires.add(id);

  @override
  Future<void> enregistrerImpressionPoufiret(
    String id, {
    required String typeAffichage,
    bool cliquee = false,
    int? minuteSession,
    String? sessionId,
  }) async => poufiret.add(id);
}

Map<String, Object?> _partenaire(String id) => {
  'type': 'partenaire',
  'id': id,
  'titre': 'Pub $id',
  'image_couverture': null,
  'duree_affichage_secondes': 5,
  'priorite': 1,
};

Map<String, Object?> _poufiret(String id, {bool avecCategorie = true}) => {
  'type': 'poufiret',
  'id': id,
  'titre': 'Poufiret $id',
  'texte': 'Texte $id',
  'image_couverture': null,
  'duree_affichage_secondes': 5,
  'categorie': avecCategorie
      ? {'id': 7, 'nom': 'Pharmacie', 'slug': 'pharmacie'}
      : null,
};

void main() {
  final repo = PublicitesRepository(dio: Dio());

  group('lecture de la réponse', () {
    test('elements présent : partenaires et Poufiret, dans l\'ordre', () {
      final elements = repo.carrouselDepuis({
        'publicites': [_partenaire('a')],
        'elements': [_partenaire('a'), _poufiret('p')],
      });
      expect(elements.map((e) => e.id), ['a', 'p']);
      expect(elements[0], isA<ElementPartenaire>());
      final maison = elements[1] as ElementPoufiret;
      expect(maison.titre, 'Poufiret p');
      expect(maison.categorie.nom, 'Pharmacie');
    });

    test('elements absent : publicites, comme avant', () {
      final elements = repo.carrouselDepuis({
        'publicites': [_partenaire('a'), _partenaire('b')],
      });
      expect(elements.map((e) => e.id), ['a', 'b']);
      expect(elements, everyElement(isA<ElementPartenaire>()));
    });

    test('pub Poufiret sans catégorie et type inconnu : retirés', () {
      final elements = repo.carrouselDepuis({
        'elements': [
          _poufiret('sans', avecCategorie: false),
          {'type': 'autre', 'id': 'x'},
          _poufiret('ok'),
        ],
      });
      expect(elements.map((e) => e.id), ['ok']);
    });
  });

  group('journalisation', () {
    Future<_FauxPubsRepo> monter(
      WidgetTester tester,
      List<ElementCarrousel> elements,
    ) async {
      final faux = _FauxPubsRepo();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicitesRepositoryProvider.overrideWithValue(faux),
            carrouselPublicitesProvider.overrideWith(
              (ref) => Stream.value(
                ElementsCarrousel(elements, confirmeReseau: true),
              ),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: CarrouselPublicites())),
        ),
      );
      await tester.pump();
      return faux;
    }

    testWidgets('pub Poufiret affichée : endpoint Poufiret', (tester) async {
      final faux = await monter(
        tester,
        repo.carrouselDepuis({
          'elements': [_poufiret('p')],
        }),
      );
      expect(find.text('Poufiret p'), findsOneWidget);
      expect(faux.poufiret, ['p']);
      expect(faux.partenaires, isEmpty);
    });

    testWidgets('pub partenaire affichée : endpoint partenaire', (
      tester,
    ) async {
      final faux = await monter(
        tester,
        repo.carrouselDepuis({
          'elements': [_partenaire('a')],
        }),
      );
      expect(find.text('Pub a'), findsOneWidget);
      expect(faux.partenaires, ['a']);
      expect(faux.poufiret, isEmpty);
    });
  });
}
