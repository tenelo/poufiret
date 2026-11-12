import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/grid_mode.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/aiguillage_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_categories.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_sous_categories.dart';
import 'package:poufiret/fonctionnalites/catalogue/widgets/tuile_categorie.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/pubs_affichees.dart';
import 'package:poufiret/global/widgets/image_reseau.dart';

// Accueil : le bouton flottant bascule la grille des catégories entre
// « images » (image si la catégorie en a une, sinon son icône) et « icônes »
// (icône partout, aucune image). Choix mémorisé sur l'appareil.

const _url = 'https://exemple.test/media/categories/viande.jpg';

/// Une catégorie avec image, une sans.
const _viande = Categorie(
  id: 66,
  nom: 'Viande de Ferké',
  slug: 'viande-de-ferke',
  icone: '🥩',
  image: _url,
);
const _pharmacie = Categorie(
  id: 67,
  nom: 'Pharmacies',
  slug: 'pharmacies',
  icone: '💊',
);

class _Visiteur extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => null;
}

/// Nombre de lectures des catégories (aucun rechargement à la bascule).
var _lectures = 0;

Future<void> _monterAccueil(
  WidgetTester tester, {
  ModeGrille? initial,
  double largeur = 420,
}) async {
  _lectures = 0;
  tester.view.physicalSize = Size(largeur, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      // Nouvelle portée = nouvelle « session » (relance de l'appli).
      key: UniqueKey(),
      overrides: <Override>[
        authProvider.overrideWith(_Visiteur.new),
        categoriesProvider.overrideWith((ref) {
          _lectures++;
          return Stream.value(const [_viande, _pharmacie]);
        }),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
        carrouselPublicitesProvider.overrideWith(
          (ref) => Stream.value(PubsAffichees.vide),
        ),
        if (initial != null)
          modeGrilleInitialProvider.overrideWithValue(initial),
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

/// La tuile d'une catégorie dans la grille (son nom figure aussi dans les
/// onglets).
Finder _tuile(String nom) =>
    find.ancestor(of: find.text(nom), matching: find.byType(TuileCategorie));

Finder _dans(String nom, Finder f) =>
    find.descendant(of: _tuile(nom), matching: f);

Finder get _bouton => find.byType(FloatingActionButton);

Future<void> _basculer(WidgetTester tester) async {
  await tester.tap(_bouton);
  await tester.pump();
}

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  testWidgets('mode images par défaut : image, sinon icône', (tester) async {
    await _monterAccueil(tester);
    expect(_dans('Viande de Ferké', find.byType(ImageReseau)), findsOneWidget);
    expect(
      tester
          .widget<ImageReseau>(
            _dans('Viande de Ferké', find.byType(ImageReseau)),
          )
          .url,
      _url,
    );
    expect(_dans('Pharmacies', find.byType(ImageReseau)), findsNothing);
    expect(_dans('Pharmacies', find.text('💊')), findsOneWidget);
    // Le bouton annonce le mode vers lequel on bascule : les icônes.
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
    expect(
      find.byTooltip('Afficher les icônes des catégories'),
      findsOneWidget,
    );
  });

  testWidgets('bascule vers icônes puis retour, sans recharger', (
    tester,
  ) async {
    await _monterAccueil(tester);
    final lectures = _lectures;

    await _basculer(tester);
    // Aucune image dans la grille : l'icône partout.
    expect(
      find.descendant(
        of: find.byType(GrilleCategories),
        matching: find.byType(ImageReseau),
      ),
      findsNothing,
    );
    expect(_dans('Viande de Ferké', find.text('🥩')), findsOneWidget);
    expect(_dans('Pharmacies', find.text('💊')), findsOneWidget);
    expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    expect(find.byIcon(Icons.grid_view_rounded), findsNothing);
    expect(
      find.byTooltip('Afficher les images des catégories'),
      findsOneWidget,
    );

    await _basculer(tester);
    expect(_dans('Viande de Ferké', find.byType(ImageReseau)), findsOneWidget);
    expect(_dans('Pharmacies', find.text('💊')), findsOneWidget);
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
    expect(_lectures, lectures);
  });

  testWidgets('choix mémorisé et retrouvé après relance', (tester) async {
    await _monterAccueil(tester);
    await _basculer(tester);
    await tester.pumpAndSettle();
    expect(await ModeGrilleNotifier.lire(), ModeGrille.icones);

    // Relance : main.dart lit le choix avant le premier rendu.
    await _monterAccueil(tester, initial: await ModeGrilleNotifier.lire());
    expect(_dans('Viande de Ferké', find.byType(ImageReseau)), findsNothing);
    expect(_dans('Viande de Ferké', find.text('🥩')), findsOneWidget);
    expect(find.byIcon(Icons.image_outlined), findsOneWidget);

    await _basculer(tester);
    await tester.pumpAndSettle();
    expect(await ModeGrilleNotifier.lire(), ModeGrille.images);
  });

  test('lecture : images au premier lancement ou valeur inconnue', () async {
    expect(await ModeGrilleNotifier.lire(), ModeGrille.images);
    FlutterSecureStorage.setMockInitialValues({'poufiret_mode_grille': '???'});
    expect(await ModeGrilleNotifier.lire(), ModeGrille.images);
    FlutterSecureStorage.setMockInitialValues({
      'poufiret_mode_grille': 'icones',
    });
    expect(await ModeGrilleNotifier.lire(), ModeGrille.icones);
  });

  testWidgets('raccourcis retirés : un seul bouton, ni « + » ni Favoris', (
    tester,
  ) async {
    await _monterAccueil(tester);
    expect(_bouton, findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.text('Favoris'), findsNothing);
    await _basculer(tester);
    expect(_bouton, findsOneWidget);
    expect(find.text('Favoris'), findsNothing);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('320 px : rien ne déborde, dans les deux modes', (tester) async {
    await _monterAccueil(tester, largeur: 320);
    expect(tester.takeException(), isNull);
    await _basculer(tester);
    expect(tester.takeException(), isNull);
    final bouton = tester.getRect(_bouton);
    expect(bouton.right, lessThanOrEqualTo(320));
  });

  testWidgets('écran de sous-catégories inchangé, même en mode icônes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(420, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    const animaux = Categorie(
      id: 30,
      nom: 'Animaux',
      slug: 'animaux',
      affichageEnfants: 'grille',
      enfants: [
        Categorie(id: 31, nom: 'Porc', slug: 'porc', icone: '🐖', image: _url),
        Categorie(id: 32, nom: 'Volaille', slug: 'volaille', icone: '🐔'),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authProvider.overrideWith(_Visiteur.new),
          for (final id in [30, 31, 32])
            visiteCategorieProvider(
              categorieId: id,
            ).overrideWith((ref) async {}),
          modeGrilleInitialProvider.overrideWithValue(ModeGrille.icones),
        ],
        child: MaterialApp(home: ecranCategorie(animaux)),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(EcranGrilleSousCategories), findsOneWidget);
    // L'image de la sous-catégorie reste affichée.
    expect(_dans('Porc', find.byType(ImageReseau)), findsOneWidget);
    expect(_dans('Volaille', find.text('🐔')), findsOneWidget);
  });
}
