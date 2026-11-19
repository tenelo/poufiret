import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_providers.dart';
import 'package:poufiret/fonctionnalites/publicites/donnees/publicites_repository.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/publicite_detail.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/publicite_liste.dart';
import 'package:poufiret/fonctionnalites/publicites/metier_domaine/pubs_affichees.dart';
import 'package:poufiret/fonctionnalites/publicites/screens/ecran_publicite_detail.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/bandeau_bas_publicite.dart';
import 'package:poufiret/fonctionnalites/publicites/widgets/couche_publicites.dart';

/// Impressions et clics envoyés au serveur.
class _FauxPubs extends PublicitesRepository {
  _FauxPubs() : super(dio: Dio());

  final traces = <(String id, String type, bool clic)>[];

  @override
  Future<void> enregistrerImpression(
    String id, {
    required String typeAffichage,
    bool cliquee = false,
    int? minuteSession,
    String? sessionId,
  }) async => traces.add((id, typeAffichage, cliquee));
}

/// Sous-titre propre au bandeau (absent de la page de la pub).
final _bandeau = find.text('Publicité — appuyez pour voir');

void main() {
  late _FauxPubs repo;

  setUp(() {
    repo = _FauxPubs();
    EtatCouchePub.ecranSensible.value = null;
  });

  Future<void> monter(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          publicitesRepositoryProvider.overrideWithValue(repo),
          bandeauBasPubliciteProvider.overrideWith(
            (ref) => Stream.value(
              const PubsAffichees([
                PubliciteListe(id: 'a', titre: 'Pub A'),
                PubliciteListe(id: 'b', titre: 'Pub B'),
              ], confirmeReseau: true),
            ),
          ),
          for (final (id, titre) in [('a', 'Pub A'), ('b', 'Pub B')])
            publiciteDetailProvider(id: id).overrideWith(
              (ref) async => PubliciteDetail(id: id, titre: titre),
            ),
        ],
        child: MaterialApp(
          navigatorObservers: [observateurNavigation],
          home: const CouchePublicites(
            enfant: Scaffold(body: Center(child: Text('Accueil'))),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('toucher : bandeau fermé aussitôt, page de la pub ouverte', (
    tester,
  ) async {
    await monter(tester);
    expect(_bandeau, findsOneWidget);
    expect(find.text('Pub A'), findsOneWidget);

    await tester.tap(find.text('Pub A'));
    // Dès la frame suivante, avant la fin de la transition.
    await tester.pump();
    expect(_bandeau, findsNothing);
    await tester.pump(const Duration(milliseconds: 150));
    expect(_bandeau, findsNothing);
    await tester.pumpAndSettle();

    // Page de la pub, sans le bandeau par-dessus.
    expect(find.byType(EcranPubliciteDetail), findsOneWidget);
    expect(_bandeau, findsNothing);
    // Le clic est compté une fois (par la page de la pub, comme avant).
    expect(repo.traces.where((t) => t.$3), [
      ('a', TypeAffichage.bandeauBas, true),
    ]);

    // Retour : le bandeau reste fermé.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Accueil'), findsOneWidget);
    expect(_bandeau, findsNothing);

    // La pub ouverte n'est plus proposée au bandeau pendant la session.
    final conteneur = ProviderScope.containerOf(
      tester.element(find.text('Accueil')),
    );
    expect(conteneur.read(pubsOuvertesDepuisBandeauProvider), {'a'});
  });

  testWidgets('plus tard, le bandeau revient avec une autre pub', (
    tester,
  ) async {
    await monter(tester);
    await tester.tap(find.text('Pub A'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(_bandeau, findsNothing);

    // Réapparition selon les règles habituelles (ici : après un écran sans
    // bandeau, qui le recrée) : la pub B, jamais la A.
    EtatCouchePub.ecranSensible.value = 'panier';
    await tester.pump();
    EtatCouchePub.ecranSensible.value = null;
    await tester.pumpAndSettle();
    expect(_bandeau, findsOneWidget);
    expect(find.text('Pub B'), findsOneWidget);
    expect(find.text('Pub A'), findsNothing);
    // Toujours un seul clic compté.
    expect(repo.traces.where((t) => t.$3).length, 1);
  });

  testWidgets('la croix garde son comportement : bandeau masqué', (
    tester,
  ) async {
    await monter(tester);
    await tester.tap(find.byTooltip('Masquer'));
    await tester.pumpAndSettle();
    expect(_bandeau, findsNothing);
    expect(find.byType(EcranPubliciteDetail), findsNothing);
    final conteneur = ProviderScope.containerOf(
      tester.element(find.text('Accueil')),
    );
    // Fermer n'est pas ouvrir : la pub reste proposable plus tard.
    expect(conteneur.read(pubsOuvertesDepuisBandeauProvider), isEmpty);
  });
}
