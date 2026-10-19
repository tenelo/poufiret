import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_detail.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/resultats_recherche.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_recherche.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/feuille_plat.dart';

/// Chez Capi : « Poulet braisé » (101) à la carte, « Tchep au poulet ou
/// poisson » (400) réservé au menu du jour, « Garba » (999) nulle part.
final _chezCapi = RestaurantsRepository(Dio()).detailDepuis({
  'id': 53,
  'nom': 'Chez Capi',
  'est_ouvert': true,
  'message_statut': '',
  'menus_du_jour': {
    'midi': {
      'id': 7,
      'service': 'midi',
      'heure_debut': '00:00:00',
      'heure_fin': '23:59:00',
      'commandable': true,
      'lignes': [
        {
          'id': 70,
          'plat': 400,
          'plat_nom': 'Tchep au poulet ou poisson',
          'plat_image': null,
          'prix_effectif': '2000.00',
          'stock_restant': 4,
          'est_epuise': false,
        },
      ],
    },
    'soir': null,
    'journee': null,
  },
  'menus_en_vigueur_maintenant': {'midi': 7},
  'carte': [
    {
      'id': 1,
      'nom': 'Grillades',
      'plats': [
        {'id': 101, 'nom': 'Poulet braisé', 'prix': 6000, 'images': []},
      ],
    },
  ],
});

const _plats = {
  101: ('poulet-braise', 'Poulet braisé'),
  400: ('tchep-au-poulet-ou-poisson', 'Tchep au poulet ou poisson'),
  999: ('garba', 'Garba'),
};

class _Connecte extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async =>
      const Utilisateur(id: 7, telephone: '+2250100000007', departement: 1);
}

Future<void> _monter(WidgetTester tester) async {
  tester.view.physicalSize = const Size(420, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Connecte.new),
        rechercheUnifieeProvider(terme: 'plat').overrideWith(
          (ref) async => ResultatsRecherche(
            articles: [
              for (final MapEntry(key: id, value: (slug, nom))
                  in _plats.entries)
                ArticleTrouve(
                  id: id,
                  nom: nom,
                  slug: slug,
                  prix: '2000',
                  partenaireNom: 'Chez Capi',
                ),
            ],
          ),
        ),
        // Fiche jamais vue : elle n'arrive qu'après un délai réseau. C'est
        // le cas qui restait bloqué quand le flux n'était pas écouté.
        for (final MapEntry(key: id, value: (slug, nom)) in _plats.entries)
          articleDetailProvider(slug: slug).overrideWith(
            (ref) => Stream.fromFuture(
              Future.delayed(
                const Duration(milliseconds: 50),
                () => ArticleDetail(
                  id: id,
                  nom: nom,
                  slug: slug,
                  type: 'plat',
                  partenaire: 53,
                  partenaireNom: 'Chez Capi',
                ),
              ),
            ),
          ),
        restaurantDetailProvider(id: 53).overrideWith(
          (ref) => Stream.fromFuture(
            Future.delayed(const Duration(milliseconds: 50), () => _chezCapi),
          ),
        ),
      ],
      child: const MaterialApp(home: EcranRecherche()),
    ),
  );
  await tester.enterText(find.byType(TextField), 'plat');
  await tester.pump(const Duration(milliseconds: 500)); // anti-rebond
  await tester.pumpAndSettle();
}

/// Touche un résultat. pumpAndSettle échouerait si l'indicateur de
/// chargement tournait sans fin.
Future<void> _toucher(WidgetTester tester, String nom) async {
  await tester.tap(find.text(nom));
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pumpAndSettle();
  expect(find.byType(CircularProgressIndicator), findsNothing);
}

void main() {
  group('cible d\'ajout d\'un plat', () {
    test('carte, menu du jour, introuvable', () {
      expect(cibleAjoutPlat(_chezCapi, 101), (platId: 101, ligneId: null));
      expect(cibleAjoutPlat(_chezCapi, 400), (platId: null, ligneId: 70));
      expect(cibleAjoutPlat(_chezCapi, 999), isNull);
    });
  });

  group('recherche : toucher un plat', () {
    testWidgets('plat de la carte : feuille plat', (tester) async {
      await _monter(tester);
      await _toucher(tester, 'Poulet braisé');
      final feuille = tester.widget<FeuillePlat>(find.byType(FeuillePlat));
      expect(feuille.platId, 101);
      expect(feuille.ligneId, isNull);
    });

    testWidgets('plat du menu du jour : feuille de la ligne de menu', (
      tester,
    ) async {
      await _monter(tester);
      await _toucher(tester, 'Tchep au poulet ou poisson');
      final feuille = tester.widget<FeuillePlat>(find.byType(FeuillePlat));
      expect(feuille.ligneId, 70);
      expect(feuille.platId, isNull);
      // Prix du menu.
      expect(
        find.textContaining(RegExp(r'Menu du jour · 2\s000')),
        findsOneWidget,
      );
    });

    testWidgets('plat introuvable : message et accès au restaurant', (
      tester,
    ) async {
      await _monter(tester);
      await _toucher(tester, 'Garba');
      expect(find.byType(FeuillePlat), findsNothing);
      expect(
        find.text(
          'Ce plat est proposé uniquement dans le menu du jour de Chez Capi.',
        ),
        findsOneWidget,
      );
      expect(find.text('Voir le restaurant'), findsOneWidget);
    });
  });
}
