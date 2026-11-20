import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_repository.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_commandes.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_commandes_partenaire.dart';

// Parcours raccourci (backend f80f5e6) : chaque commande porte `parcours`,
// `etapes` (frise de CETTE commande) et `transitions_possibles`
// ([{action, libelle, commentaire_obligatoire}]).

Map<String, dynamic> _commande({
  int id = 1,
  String statut = 'acceptee',
  String mode = 'emporter',
  String? parcours,
  List<String>? etapes,
  List<Map<String, dynamic>>? transitions,
}) => {
  'id': id,
  'numero': 'CMD-$id',
  'partenaire_nom': 'Boulangerie du Marché',
  'client_nom': 'Awa',
  'mode_livraison': mode,
  'statut': statut,
  'total': '3000.00',
  'lignes': [
    {
      'id': 1,
      'nom_article': 'Baguette',
      'quantite': 2,
      'prix_ligne': '3000.00',
    },
  ],
  'parcours': ?parcours,
  'etapes': ?etapes,
  'transitions_possibles': ?transitions,
};

Map<String, dynamic> _transition(String action, String libelle) => {
  'action': action,
  'libelle': libelle,
  'commentaire_obligatoire': false,
};

/// Commerce, retrait : nouvelle → acceptee → livree.
final _courtRetrait = Commande.fromJson(
  _commande(
    parcours: 'court',
    etapes: const ['nouvelle', 'acceptee', 'livree'],
    transitions: [
      _transition('livree', 'Marquer livrée'),
      _transition('expiree', 'Marquer expirée'),
      _transition('annulee', 'Annuler'),
    ],
  ),
);

/// Restauration, livraison : nouvelle → acceptee → prete → en_livraison →
/// livree.
final _restauLivraison = Commande.fromJson(
  _commande(
    id: 2,
    statut: 'prete',
    mode: 'livraison',
    parcours: 'restauration',
    etapes: const ['nouvelle', 'acceptee', 'prete', 'en_livraison', 'livree'],
    transitions: [
      _transition('en_livraison', 'Passer en livraison'),
      _transition('livree', 'Marquer livrée'),
      _transition('expiree', 'Marquer expirée'),
    ],
  ),
);

/// Ancienne réponse : ni parcours, ni étapes, ni transitions.
final _ancienne = Commande.fromJson(_commande(id: 3));

class _FausseCommandes extends OrdersRepository {
  _FausseCommandes() : super(dio: Dio());

  final transitions = <(int, String, String?)>[];

  @override
  Future<Commande> transition({
    required int commandeId,
    required String statut,
    String? raisonRefus,
  }) async {
    transitions.add((commandeId, statut, raisonRefus));
    return Commande(id: commandeId, statut: statut);
  }
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override> overrides = const [],
  double largeur = 420,
}) async {
  tester.view.physicalSize = Size(largeur, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(home: ecran),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _detail(WidgetTester tester, Commande c, {double largeur = 420}) =>
    _monter(
      tester,
      EcranCommandeDetail(commandeId: c.id),
      largeur: largeur,
      overrides: [
        commandeDetailProvider(id: c.id).overrideWith((ref) async => c),
      ],
    );

Future<_FausseCommandes> _recues(
  WidgetTester tester,
  List<Commande> commandes,
) async {
  final serveur = _FausseCommandes();
  await _monter(
    tester,
    const EcranCommandesPartenaire(),
    overrides: [
      ordersRepositoryProvider.overrideWithValue(serveur),
      commandesPartenaireProvider().overrideWith((ref) async => commandes),
    ],
  );
  return serveur;
}

Finder _etape(String statut) => find.byKey(ValueKey('etape-$statut'));

void main() {
  group('modèle', () {
    test('parcours, étapes, transitions lus ; frise et rang', () {
      expect(_courtRetrait.parcours, 'court');
      expect(_courtRetrait.frise, ['nouvelle', 'acceptee', 'livree']);
      expect(_courtRetrait.rangEtape, 1);
      expect(_courtRetrait.transitionsPossibles!.first.action, 'livree');
      expect(
        _courtRetrait.transitionsPossibles!.first.libelle,
        'Marquer livrée',
      );
      expect(_restauLivraison.rangEtape, 2);
      // Ancienne réponse : rien, donc l'affichage habituel.
      expect(_ancienne.etapes, isNull);
      expect(_ancienne.transitionsPossibles, isNull);
      expect(_ancienne.frise, isNull);
      // Hors frise : refusée, annulée, expirée.
      for (final s in ['refusee', 'annulee', 'expiree']) {
        expect(_courtRetrait.copyWith(statut: s).frise, isNull);
      }
      // Ancienne commande « en préparation » : sur l'étape « acceptée ».
      expect(_restauLivraison.copyWith(statut: 'en_preparation').rangEtape, 1);
    });

    test('libellé « Acceptée » selon le parcours', () {
      expect(_courtRetrait.statutLibelle, 'Acceptée');
      expect(
        _restauLivraison.copyWith(statut: 'acceptee').statutLibelle,
        'Acceptée · en préparation',
      );
      expect(_ancienne.statutLibelle, 'Acceptée');
      expect(_restauLivraison.statutLibelle, 'Prête');
      expect(
        libelleStatutCommande('livree', parcours: 'restauration'),
        'Livrée',
      );
    });
  });

  group('suivi client : frise depuis « etapes »', () {
    testWidgets('commerce, retrait : 3 étapes', (tester) async {
      await _detail(tester, _courtRetrait);
      expect(find.byKey(const ValueKey('frise-commande')), findsOneWidget);
      for (final s in ['nouvelle', 'acceptee', 'livree']) {
        expect(_etape(s), findsOneWidget);
      }
      expect(_etape('prete'), findsNothing);
      expect(_etape('en_preparation'), findsNothing);
      expect(_etape('en_livraison'), findsNothing);
      expect(find.text('Nouvelle'), findsOneWidget);
      expect(find.text('Livrée'), findsOneWidget);
      expect(find.text('En préparation'), findsNothing);
      // Étapes franchies cochées, étape en cours marquée.
      expect(
        find.descendant(
          of: _etape('nouvelle'),
          matching: find.byIcon(Icons.check_circle),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: _etape('acceptee'),
          matching: find.byIcon(Icons.radio_button_checked),
        ),
        findsOneWidget,
      );
    });

    testWidgets('restauration, livraison : 5 étapes', (tester) async {
      await _detail(tester, _restauLivraison, largeur: 320);
      expect(tester.takeException(), isNull);
      for (final s in [
        'nouvelle',
        'acceptee',
        'prete',
        'en_livraison',
        'livree',
      ]) {
        expect(_etape(s), findsOneWidget);
      }
      expect(find.text('Acceptée · en préparation'), findsOneWidget);
      expect(find.text('En livraison'), findsOneWidget);
      // « Prête » : la pastille de statut et l'étape en cours.
      expect(find.text('Prête'), findsNWidgets(2));
    });

    testWidgets('repli sans « etapes » : affichage actuel, sans frise', (
      tester,
    ) async {
      await _detail(tester, _ancienne);
      expect(find.byKey(const ValueKey('frise-commande')), findsNothing);
      expect(find.text('Acceptée'), findsOneWidget);
    });

    testWidgets('commande refusée : pas de frise, motif affiché', (
      tester,
    ) async {
      final refusee = Commande.fromJson({
        ..._commande(
          id: 4,
          statut: 'refusee',
          parcours: 'court',
          etapes: const ['nouvelle', 'acceptee', 'livree'],
          transitions: const [],
        ),
        'raison_refus': 'Rupture de stock',
      });
      await _detail(tester, refusee);
      expect(find.byKey(const ValueKey('frise-commande')), findsNothing);
      expect(find.text('Refusée'), findsOneWidget);
      expect(find.text('Motif : Rupture de stock'), findsOneWidget);
    });
  });

  group('partenaire : boutons depuis « transitions_possibles »', () {
    testWidgets('commerce acceptée : plus de « Mettre en préparation »', (
      tester,
    ) async {
      final serveur = await _recues(tester, [_courtRetrait]);
      expect(find.text('Marquer livrée'), findsOneWidget);
      expect(find.text('Marquer expirée'), findsOneWidget);
      expect(find.text('Annuler'), findsOneWidget);
      expect(find.text('Mettre en préparation'), findsNothing);
      // Action négative : bouton de contour.
      expect(find.widgetWithText(OutlinedButton, 'Annuler'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, 'Marquer livrée'),
        findsOneWidget,
      );

      await tester.tap(find.text('Marquer livrée'));
      await tester.pumpAndSettle();
      expect(serveur.transitions, [(1, 'livree', null)]);
    });

    testWidgets('nouvelle : Accepter, Refuser avec motif', (tester) async {
      final nouvelle = Commande.fromJson(
        _commande(
          id: 5,
          statut: 'nouvelle',
          parcours: 'restauration',
          etapes: const ['nouvelle', 'acceptee', 'prete', 'livree'],
          transitions: [
            _transition('acceptee', 'Accepter'),
            _transition('refusee', 'Refuser'),
            _transition('annulee', 'Annuler'),
          ],
        ),
      );
      final serveur = await _recues(tester, [nouvelle]);
      expect(find.text('Accepter'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Refuser'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Refuser'));
      await tester.pumpAndSettle();
      expect(find.text('Motif du refus'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Fermé ce soir');
      await tester.tap(find.widgetWithText(FilledButton, 'Refuser'));
      await tester.pumpAndSettle();
      expect(serveur.transitions, [(5, 'refusee', 'Fermé ce soir')]);
    });

    testWidgets('motif exigé par le serveur : demandé avant l\'action', (
      tester,
    ) async {
      final c = Commande.fromJson(
        _commande(
          id: 6,
          parcours: 'court',
          etapes: const ['nouvelle', 'acceptee', 'livree'],
          transitions: [
            {
              'action': 'annulee',
              'libelle': 'Annuler',
              'commentaire_obligatoire': true,
            },
          ],
        ),
      );
      final serveur = await _recues(tester, [c]);
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();
      expect(find.text('Motif'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Client injoignable');
      await tester.tap(find.widgetWithText(FilledButton, 'Annuler'));
      await tester.pumpAndSettle();
      expect(serveur.transitions, [(6, 'annulee', 'Client injoignable')]);
    });

    testWidgets('restauration acceptée : libellé du statut', (tester) async {
      final c = Commande.fromJson(
        _commande(
          id: 7,
          parcours: 'restauration',
          etapes: const ['nouvelle', 'acceptee', 'prete', 'livree'],
          transitions: [
            _transition('prete', 'Marquer prête'),
            _transition('annulee', 'Annuler'),
          ],
        ),
      );
      await _recues(tester, [c]);
      expect(find.text('Acceptée · en préparation'), findsOneWidget);
      expect(find.text('Marquer prête'), findsOneWidget);
    });

    testWidgets('liste vide reçue : aucun bouton', (tester) async {
      await _recues(tester, [
        Commande.fromJson(
          _commande(id: 8, statut: 'livree', transitions: const []),
        ),
      ]);
      expect(find.byType(FilledButton), findsNothing);
      expect(find.byType(OutlinedButton), findsNothing);
    });

    testWidgets('repli sans « transitions_possibles » : boutons actuels', (
      tester,
    ) async {
      await _recues(tester, [_ancienne]);
      expect(find.text('Mettre en préparation'), findsOneWidget);
      expect(find.text('Marquer livrée'), findsNothing);
    });

    testWidgets('livraison prête : le pont livreur reste prioritaire', (
      tester,
    ) async {
      await _recues(tester, [_restauLivraison]);
      expect(find.text('Commander un livreur'), findsOneWidget);
      expect(find.text('Passer en livraison'), findsNothing);
      expect(find.text('Marquer livrée'), findsNothing);
    });
  });
}
