import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_connexion.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/mur_inscription.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/chat/donnees/chat_providers.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_conversations.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/global/navigation/app_shell.dart';

import 'aide_session.dart';

/// Session que le test peut connecter (comme après l'écran de connexion).
class _SessionModifiable extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => null;

  void connecter() => state = const AsyncData(utilisateurTest);
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  required AuthNotifier Function() session,
  List<Override> overrides = const [],
  bool stabiliser = true,
}) async {
  tester.view.physicalSize = const Size(420, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(session),
        departementsProvider.overrideWith(
          (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
        ),
        ...overrides,
      ],
      child: MaterialApp(home: ecran),
    ),
  );
  await _avancer(tester, stabiliser);
}

/// L'accueil anime sans fin (squelettes, bandeaux) : quelques images
/// suffisent au lieu d'attendre l'immobilité.
Future<void> _avancer(WidgetTester tester, bool stabiliser) async {
  if (stabiliser) {
    await tester.pumpAndSettle();
    return;
  }
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Bouton qui lance une action protégée et compte ses exécutions.
class _Action extends ConsumerWidget {
  const _Action(this.executions);
  final List<int> executions;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: TextButton(
      onPressed: () => murInscription(context, ref, () => executions.add(1)),
      child: const Text('Ajouter au panier'),
    ),
  );
}

PartenaireCategorie _carte(int id, String nom, String? type) =>
    PartenaireCategorie.fromJson({
      'id': id,
      'nom_commerce': nom,
      'type_etablissement': ?type,
    });

void main() {
  group('feuille « Connexion requise »', () {
    testWidgets('non connecté : feuille, « Plus tard » n\'exécute rien', (
      tester,
    ) async {
      final executions = <int>[];
      await _monter(
        tester,
        _Action(executions),
        session: () => SessionTest(null),
      );
      await tester.tap(find.text('Ajouter au panier'));
      await tester.pumpAndSettle();
      expect(find.text('Connexion requise'), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
      await tester.tap(find.text('Plus tard'));
      await tester.pumpAndSettle();
      expect(find.byType(FeuilleConnexionRequise), findsNothing);
      expect(executions, isEmpty);
    });

    testWidgets('connecté : l\'action s\'exécute, sans feuille', (
      tester,
    ) async {
      final executions = <int>[];
      await _monter(tester, _Action(executions), session: SessionTest.new);
      await tester.tap(find.text('Ajouter au panier'));
      await tester.pumpAndSettle();
      expect(find.byType(FeuilleConnexionRequise), findsNothing);
      expect(executions, [1]);
    });

    testWidgets('« Se connecter » puis connexion : l\'action reprend', (
      tester,
    ) async {
      final executions = <int>[];
      await _monter(
        tester,
        _Action(executions),
        session: _SessionModifiable.new,
      );
      await tester.tap(find.text('Ajouter au panier'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Se connecter'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranConnexion), findsOneWidget);
      // Connexion réussie : l'écran de connexion se referme.
      final conteneur = ProviderScope.containerOf(
        tester.element(find.byType(EcranConnexion)),
      );
      (conteneur.read(authProvider.notifier) as _SessionModifiable).connecter();
      tester.state<NavigatorState>(find.byType(Navigator).first).pop();
      await tester.pumpAndSettle();
      expect(find.byType(EcranConnexion), findsNothing);
      expect(executions, [1]);
    });
  });

  group('onglets protégés', () {
    final overrides = [
      conversationsProvider.overrideWith((ref) => Stream.value(const [])),
    ];

    test('Messages, Livraison et Map ; Accueil et Pubs libres', () {
      expect(ongletsProteges, {2, 3, 4});
      expect(ongletsProteges.contains(0), isFalse);
      expect(ongletsProteges.contains(1), isFalse);
    });

    testWidgets('visiteur : Messages demande la connexion', (tester) async {
      await _monter(
        tester,
        const AppShell(),
        session: () => SessionTest(null),
        overrides: overrides,
        stabiliser: false,
      );
      await tester.tap(find.text('Messages'));
      await _avancer(tester, false);
      expect(find.text('Connexion requise'), findsOneWidget);
      await tester.tap(find.text('Plus tard'));
      await _avancer(tester, false);
      expect(find.byType(EcranConversations), findsNothing);
    });

    testWidgets('connecté : Messages s\'ouvre', (tester) async {
      await _monter(
        tester,
        const AppShell(),
        session: SessionTest.new,
        overrides: overrides,
        stabiliser: false,
      );
      await tester.tap(find.text('Messages'));
      await _avancer(tester, false);
      expect(find.byType(FeuilleConnexionRequise), findsNothing);
      expect(find.byType(EcranConversations), findsOneWidget);
    });
  });

  group('filtre Hôtels / Résidences', () {
    final cartes = [
      _carte(1, 'Hôtel Le Kôrô', 'hotel'),
      _carte(2, 'Résidence Soleil', 'residence_meublee'),
      _carte(3, 'Hôtel sans type', null),
    ];

    test('filtre local sur type_etablissement (type inconnu gardé)', () {
      expect(filtrerEtablissements(cartes, null), cartes);
      expect(filtrerEtablissements(cartes, 'hotel').map((c) => c.id), [1, 3]);
      expect(
        filtrerEtablissements(cartes, 'residence_meublee').map((c) => c.id),
        [2, 3],
      );
    });

    testWidgets('pastilles : ?type_etablissement envoyé, combiné au filtre', (
      tester,
    ) async {
      final demandes = <String?>[];
      Override annuaire(String? type) =>
          partenairesParCategorieProvider(
            slug: 'hotels',
            typeEtablissement: type,
          ).overrideWith((ref) {
            demandes.add(type);
            // Serveur qui ignore encore le paramètre : tout est renvoyé.
            return Stream.value(cartes);
          });
      await _monter(
        tester,
        const Scaffold(
          body: ContenuPrestataires(
            categorieId: 9,
            categorieNom: 'Hôtels & Résidences',
            categorieSlug: 'hotels',
            typesPartenaire: ['hotelier'],
          ),
        ),
        session: SessionTest.new,
        overrides: [
          visiteCategorieProvider(categorieId: 9).overrideWith((ref) async {}),
          annuaire(null),
          annuaire('hotel'),
          annuaire('residence_meublee'),
        ],
      );
      expect(find.text('Tous'), findsOneWidget);
      expect(find.text('Hôtels'), findsOneWidget);
      expect(find.text('Résidences'), findsOneWidget);
      expect(find.text('Résidence Soleil'), findsOneWidget);

      await tester.tap(find.text('Hôtels'));
      await tester.pumpAndSettle();
      expect(demandes.last, 'hotel');
      expect(find.text('Hôtel Le Kôrô'), findsOneWidget);
      expect(find.text('Résidence Soleil'), findsNothing);

      await tester.tap(find.text('Résidences'));
      await tester.pumpAndSettle();
      expect(demandes.last, 'residence_meublee');
      expect(find.text('Résidence Soleil'), findsOneWidget);
      expect(find.text('Hôtel Le Kôrô'), findsNothing);
    });

    testWidgets('visiteur : ouvrir une fiche de l\'annuaire est bloqué', (
      tester,
    ) async {
      await _monter(
        tester,
        const Scaffold(
          body: ContenuPrestataires(
            categorieId: 9,
            categorieNom: 'Hôtels & Résidences',
            categorieSlug: 'hotels',
            typesPartenaire: ['hotelier'],
          ),
        ),
        session: () => SessionTest(null),
        overrides: [
          visiteCategorieProvider(categorieId: 9).overrideWith((ref) async {}),
          partenairesParCategorieProvider(
            slug: 'hotels',
          ).overrideWith((ref) => Stream.value(cartes)),
        ],
      );
      await tester.tap(find.text('Résidence Soleil'));
      await tester.pumpAndSettle();
      expect(find.text('Connexion requise'), findsOneWidget);
      await tester.tap(find.text('Plus tard'));
      await tester.pumpAndSettle();
      expect(find.byType(ContenuPrestataires), findsOneWidget);
      expect(find.byType(FeuilleConnexionRequise), findsNothing);
    });

    testWidgets('autre catégorie : pas de pastilles', (tester) async {
      await _monter(
        tester,
        const Scaffold(
          body: ContenuPrestataires(
            categorieId: 10,
            categorieNom: 'Pharmacie',
            categorieSlug: 'pharmacie',
            typesPartenaire: ['pharmacie'],
          ),
        ),
        session: SessionTest.new,
        overrides: [
          visiteCategorieProvider(categorieId: 10).overrideWith((ref) async {}),
          partenairesParCategorieProvider(
            slug: 'pharmacie',
          ).overrideWith((ref) => Stream.value(const [])),
        ],
      );
      expect(find.text('Hôtels'), findsNothing);
    });
  });
}
