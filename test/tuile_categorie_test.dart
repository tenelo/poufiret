import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_repository.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_categories.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/pubs_affichees.dart';
import 'package:poufiret/global/widgets/image_reseau.dart';

const _url = 'https://exemple.test/media/categories/viande.jpg';

class _Visiteur extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => null;
}

Categorie _categorie({
  String? image,
  String? couverture,
  String icone = '🥩',
}) => Categorie(
  id: 66,
  nom: 'Viande de Ferké',
  slug: 'viande-de-ferke',
  icone: icone,
  image: image,
  imageCouverture: couverture,
);

Future<void> _monter(WidgetTester tester, List<Categorie> categories) async {
  tester.view.physicalSize = const Size(840, 1800);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Visiteur.new),
        categoriesProvider.overrideWith((ref) => Stream.value(categories)),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
        carrouselPublicitesProvider.overrideWith(
          (ref) => Stream.value(PubsAffichees.vide),
        ),
      ],
      child: MaterialApp(
        builder: (context, enfant) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: enfant!,
        ),
        home: const EcranCategories(),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

Finder get _tuile => find.widgetWithText(Card, 'Viande de Ferké');
Finder _dansTuile(Finder f) => find.descendant(of: _tuile, matching: f);

void main() {
  test("réponse réelle : le champ s'appelle image_couverture", () {
    final json =
        jsonDecode(
              File(
                'test/fixtures/catalogue/categories.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    final brutes = (json['results'] as List).cast<Map<String, dynamic>>();
    // Constat du 2026-10-06 : pas de champ "image" ; l'URL est dans
    // "image_couverture" (null pour les catégories sans image).
    expect(brutes.any((c) => c.containsKey('image')), isFalse);
    expect(brutes.every((c) => c.containsKey('image_couverture')), isTrue);

    final categories = CatalogueRepository(dio: Dio()).categoriesDepuis(json);
    final viande = categories.firstWhere((c) => c.slug == 'viande-de-ferke');
    expect(
      viande.imageTuile,
      startsWith('https://poufiret.tenelo.cloud/media/'),
    );
    final restaurants = categories.firstWhere((c) => c.slug == 'restaurants');
    expect(restaurants.imageTuile, isEmpty);
    expect(restaurants.icone, isNotEmpty);
  });

  test('imageTuile : image, sinon image_couverture, sinon rien', () {
    expect(_categorie(image: _url, couverture: 'autre').imageTuile, _url);
    expect(_categorie(couverture: _url).imageTuile, _url);
    expect(_categorie().imageTuile, isEmpty);
    expect(_categorie(image: '', couverture: '').imageTuile, isEmpty);
  });

  testWidgets("tuile sans image : l'emoji, comme avant", (tester) async {
    await _monter(tester, [_categorie()]);
    expect(_dansTuile(find.text('🥩')), findsOneWidget);
    expect(_dansTuile(find.byType(ImageReseau)), findsNothing);
    expect(_dansTuile(find.text('Viande de Ferké')), findsOneWidget);
  });

  testWidgets('tuile avec image : remplit la zone, nom en dessous', (
    tester,
  ) async {
    await _monter(tester, [_categorie(couverture: _url)]);
    final zone = _dansTuile(find.byType(ImageReseau));
    final image = tester.widget<ImageReseau>(zone);
    expect(image.url, _url);
    expect(image.fit, BoxFit.cover);
    // Décodée à la taille affichée, pas à sa taille d'origine.
    expect(image.largeurAffichee, tester.getSize(zone).width);
    expect(tester.getSize(zone).width, greaterThan(100));
    // Coins arrondis.
    final cadre = tester.widget<ClipRRect>(
      find.ancestor(of: zone, matching: find.byType(ClipRRect)).first,
    );
    expect(cadre.borderRadius, BorderRadius.circular(12));
    // Le nom reste sous l'image.
    final nom = _dansTuile(find.text('Viande de Ferké'));
    expect(
      tester.getTopLeft(nom).dy,
      greaterThan(tester.getBottomLeft(zone).dy),
    );
    // Pendant le chargement : l'emoji en repli.
    expect(_dansTuile(find.text('🥩')), findsOneWidget);
  });

  testWidgets('chargement sans emoji : fond neutre', (tester) async {
    await _monter(tester, [_categorie(couverture: _url, icone: '')]);
    final image = tester.widget<ImageReseau>(
      _dansTuile(find.byType(ImageReseau)),
    );
    expect(image.attente, isA<ColoredBox>());
    expect(_dansTuile(find.text('📦')), findsNothing);
  });

  testWidgets("image en erreur : l'emoji", (tester) async {
    await _monter(tester, [_categorie(couverture: _url)]);
    final image = tester.widget<ImageReseau>(
      _dansTuile(find.byType(ImageReseau)),
    );
    // Ce que la tuile affiche quand le chargement échoue.
    final repli = image.errorBuilder!(
      tester.element(_tuile),
      Exception('404'),
      null,
    );
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: repli)));
    expect(find.text('🥩'), findsOneWidget);
  });
}
