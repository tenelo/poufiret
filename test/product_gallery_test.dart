import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/commerces/donnees/commerces_providers.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/catalogue_commerce.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/ecran_produit.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/galerie_miniatures.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/global/ui/format_montant.dart';
import 'package:poufiret/global/widgets/image_reseau.dart';
import 'package:poufiret/global/widgets/visionneuse_images.dart';

// Page produit des commerces : grande image (photo principale d'abord) et
// rangée de vignettes (4 au plus, ordre du serveur) qui se partagent la
// largeur.

const _cote = 'https://exemple.test/cote.jpg';
const _dos = 'https://exemple.test/dos.jpg';
const _dessus = 'https://exemple.test/dessus.jpg';
const _semelle = 'https://exemple.test/semelle.jpg';
const _boite = 'https://exemple.test/boite.jpg';

/// Une chaussure : `image` = photo principale, `images` = la galerie dans
/// l'ordre du serveur (la principale y figure aussi, sans doublon à
/// l'affichage).
Plat _chaussure(List<String> galerie, {String principale = _cote}) =>
    Plat.fromJson({
      'id': 10,
      'nom': 'Basket Air',
      'prix': '25000.00',
      'prix_effectif': '25000.00',
      'image': principale,
      'images': [
        for (final url in galerie) {'image': url},
      ],
      'fiche_specifique': {'marque': 'Nike'},
    });

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

class _Session extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => _utilisateur;
}

Future<void> _monter(
  WidgetTester tester,
  Plat produit, {
  Gabarit gabarit = Gabarit.mode,
  double largeur = 420,
}) async {
  tester.view.physicalSize = Size(largeur, 1800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authProvider.overrideWith(_Session.new),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
        produitDetailProvider(
          id: produit.id,
        ).overrideWith((ref) => Stream.value(ProduitDetail(produit: produit))),
      ],
      child: MaterialApp(
        home: EcranProduit(produitId: produit.id, gabarit: gabarit),
      ),
    ),
  );
  // Les images en chargement tournent sans fin : quelques images suffisent.
  for (var i = 0; i < 4; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Finder _vignette(int i) => find.byKey(ValueKey('miniature-$i'));

Finder _grande(String url) => find.byKey(ValueKey('grande-$url'));

/// Couleur du cadre d'une vignette (transparente si non sélectionnée).
Color _cadre(WidgetTester tester, int i) {
  final boite = tester.widget<AnimatedContainer>(
    find.descendant(of: _vignette(i), matching: find.byType(AnimatedContainer)),
  );
  return ((boite.decoration! as BoxDecoration).border! as Border).top.color;
}

void main() {
  testWidgets('plusieurs photos : principale en grand, rangée dans l\'ordre', (
    tester,
  ) async {
    await _monter(tester, _chaussure([_cote, _dos, _dessus, _semelle]));
    expect(find.byKey(const ValueKey('rangee-vignettes')), findsOneWidget);
    expect(_grande(_cote), findsOneWidget);
    for (final (i, url) in [_cote, _dos, _dessus, _semelle].indexed) {
      final image = find.descendant(
        of: _vignette(i),
        matching: find.byType(ImageReseau),
      );
      expect(tester.widget<ImageReseau>(image).url, url);
    }
    // Le reste de la page ne bouge pas.
    expect(find.text('Basket Air'), findsWidgets);
    expect(find.text(formatMontant(25000)), findsWidgets);
  });

  testWidgets('principale ailleurs dans la liste : affichée en premier', (
    tester,
  ) async {
    await _monter(
      tester,
      _chaussure([_dos, _dessus, _cote], principale: _cote),
    );
    expect(_grande(_cote), findsOneWidget);
    expect(_vignette(2), findsOneWidget);
    expect(_vignette(3), findsNothing);
  });

  testWidgets('plus de 4 photos : 4 vignettes au plus', (tester) async {
    await _monter(tester, _chaussure([_cote, _dos, _dessus, _semelle, _boite]));
    expect(_vignette(3), findsOneWidget);
    expect(_vignette(4), findsNothing);
  });

  testWidgets('une seule photo : pas de rangée', (tester) async {
    await _monter(tester, _chaussure(const [], principale: _cote));
    expect(_grande(_cote), findsOneWidget);
    expect(find.byKey(const ValueKey('rangee-vignettes')), findsNothing);
    expect(_vignette(0), findsNothing);
  });

  testWidgets('appui sur une vignette : elle passe en grand et est marquée', (
    tester,
  ) async {
    await _monter(tester, _chaussure([_cote, _dos, _dessus, _semelle]));
    expect(_cadre(tester, 0), isNot(Colors.transparent));
    expect(_cadre(tester, 3), Colors.transparent);

    await tester.tap(_vignette(3));
    await tester.pump();
    expect(_grande(_semelle), findsOneWidget);
    expect(_grande(_cote), findsNothing);
    expect(_cadre(tester, 3), isNot(Colors.transparent));
    for (final i in [0, 1, 2]) {
      expect(_cadre(tester, i), Colors.transparent);
    }
    final selection = tester.getSemantics(_vignette(3));
    expect(selection.flagsCollection.isSelected, Tristate.isTrue);

    // La grande image ouvre toujours la visionneuse, sur la photo affichée.
    await tester.tap(find.byKey(const ValueKey('galerie-grande')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    final visionneuse = tester.widget<VisionneuseImages>(
      find.byType(VisionneuseImages),
    );
    expect(visionneuse.indexInitial, 3);
    expect(visionneuse.images[visionneuse.indexInitial], _semelle);
  });

  for (final gabarit in [Gabarit.mode, Gabarit.librairie, Gabarit.pharmacie]) {
    testWidgets(
      '320 px (${gabarit.name}) : vignettes égales, sans débordement',
      (tester) async {
        await _monter(
          tester,
          _chaussure([_cote, _dos, _dessus, _semelle, _boite]),
          gabarit: gabarit,
          largeur: 320,
        );
        expect(tester.takeException(), isNull);
        final tailles = [
          for (var i = 0; i < 4; i++) tester.getSize(_vignette(i)),
        ];
        expect(tailles.toSet(), hasLength(1));
        expect(tailles.first.width, tailles.first.height);
        final rangee = tester.getRect(
          find.byKey(const ValueKey('rangee-vignettes')),
        );
        expect(rangee.right, lessThanOrEqualTo(320));
        expect(tester.getRect(_vignette(3)).right, lessThanOrEqualTo(320));
      },
    );
  }

  testWidgets('deux photos : mêmes cases, rangée alignée à gauche', (
    tester,
  ) async {
    await _monter(tester, _chaussure([_cote, _dos]), largeur: 320);
    expect(tester.takeException(), isNull);
    final quatre = (320 - 2 * 12 - 3 * 8) / GalerieMiniatures.maxVignettes;
    expect(tester.getSize(_vignette(0)).width, closeTo(quatre, 0.01));
    expect(tester.getSize(_vignette(1)).width, closeTo(quatre, 0.01));
  });

  testWidgets(
    'page éleveur inchangée : rangée défilante de toutes les photos',
    (tester) async {
      await _monter(
        tester,
        _chaussure([_cote, _dos, _dessus, _semelle, _boite]),
        gabarit: Gabarit.elevage,
      );
      expect(find.byKey(const ValueKey('rangee-vignettes')), findsNothing);
      expect(
        tester.getSize(_vignette(0)),
        const Size.square(GalerieMiniatures.coteMiniature),
      );
      // Toutes les photos, y compris au-delà de 4 (visibles par défilement).
      await tester.scrollUntilVisible(
        _vignette(4),
        100,
        scrollable: find.descendant(
          of: find.byType(GalerieMiniatures),
          matching: find.byType(Scrollable),
        ),
      );
      expect(_vignette(4), findsOneWidget);
    },
  );
}
