import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_changer_pin.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_connexion.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_inscription.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_pin_oublie.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/cadre_auth.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/mur_inscription.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/global/config/config.dart';
import 'package:poufiret/global/ui/theme_poufiret.dart';

class _Deconnecte extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => null;
}

/// Monte [ecran] sur un petit téléphone (rien ne doit déborder).
Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  bool sombre = false,
}) async {
  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  Config.sombre = sombre;
  addTearDown(() => Config.sombre = false);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Deconnecte.new),
        departementsProvider.overrideWith(
          (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
        ),
      ],
      child: MaterialApp(
        theme: sombre ? ThemePoufiret.sombre : ThemePoufiret.clair,
        home: ecran,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final sombre in [false, true]) {
    final mode = sombre ? 'sombre' : 'clair';

    testWidgets('connexion, étape numéro ($mode)', (tester) async {
      await _monter(tester, const EcranConnexion(), sombre: sombre);
      expect(find.byType(MarquePoufiret), findsOneWidget);
      expect(find.text('Bienvenue'), findsOneWidget);
      expect(find.byType(PrefixeTelephone), findsOneWidget);
      expect(find.text('Continuer'), findsOneWidget);
      expect(
        find.textContaining('Créer un compte', findRichText: true),
        findsOneWidget,
      );
      // Premier écran de l'app : pas de bouton retour.
      expect(find.byTooltip('Retour'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('inscription : étape 1 sur 3 ($mode)', (tester) async {
      await _monter(tester, const EcranInscription(), sombre: sombre);
      expect(find.text('Créer un compte'), findsOneWidget);
      expect(find.text('Étape 1 sur 3'), findsOneWidget);
      expect(find.byType(PrefixeTelephone), findsOneWidget);
      // Bloc facultatif replié, puis déplié au toucher.
      expect(find.text('Tranche d\'âge'), findsNothing);
      await tester.ensureVisible(find.text('Pour mieux vous servir'));
      await tester.tap(find.text('Pour mieux vous servir'));
      await tester.pumpAndSettle();
      expect(find.text('Tranche d\'âge'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('PIN oublié : étape numéro ($mode)', (tester) async {
      await _monter(tester, const EcranPinOublie(), sombre: sombre);
      expect(find.text('Code PIN oublié'), findsOneWidget);
      expect(find.text('Étape 1 sur 3'), findsOneWidget);
      expect(find.text('Recevoir le code'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('changement de PIN imposé ($mode)', (tester) async {
      await _monter(
        tester,
        const EcranChangerPin(bloquant: true),
        sombre: sombre,
      );
      expect(find.text('Code PIN actuel'), findsOneWidget);
      expect(find.byType(ClavierNumerique), findsOneWidget);
      expect(find.textContaining('Pour votre sécurité'), findsOneWidget);
      // Imposé : impossible de quitter l'écran.
      expect(find.byTooltip('Retour'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('numéro incomplet : message, on reste sur l\'étape', (
    tester,
  ) async {
    await _monter(tester, const EcranConnexion());
    await tester.enterText(find.byType(TextFormField), '0700');
    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Entre tes 10 chiffres'), findsOneWidget);
    expect(find.text('Bienvenue'), findsOneWidget);
  });

  testWidgets('changement de PIN : étapes 1 → 2 au 4e chiffre', (
    tester,
  ) async {
    await _monter(tester, const EcranChangerPin());
    expect(find.byTooltip('Retour'), findsNothing); // aucun écran derrière
    for (final c in ['1', '2', '3', '4']) {
      await tester.tap(find.text(c));
      await tester.pump();
    }
    await tester.pumpAndSettle();
    expect(find.text('Nouveau code PIN'), findsOneWidget);
    expect(find.text('Étape 2 sur 3'), findsOneWidget);
  });

  testWidgets('code SMS : une case par chiffre', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CasesCode(code: '123', longueur: 6)),
      ),
    );
    expect(find.text('1'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNWidgets(6));
  });

  testWidgets('mur d\'inscription : fenêtre et ses deux actions', (
    tester,
  ) async {
    await _monter(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () =>
                murInscriptionSi(context, connecte: false, action: () {}),
            child: const Text('Ouvrir'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Ouvrir'));
    await tester.pumpAndSettle();
    expect(find.byType(DialogueAuth), findsOneWidget);
    expect(find.text('S\'enregistrer'), findsOneWidget);
    await tester.tap(find.text('Plus tard'));
    await tester.pumpAndSettle();
    expect(find.byType(DialogueAuth), findsNothing);
  });
}
