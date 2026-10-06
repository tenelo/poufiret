import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/global/widgets/texte_defilant.dart';

const _invite = 'Que recherchez-vous ? (ex: pharmacie, restaurant…)';

void main() {
  Future<void> monter(
    WidgetTester tester, {
    required double largeur,
    String texte = _invite,
    bool sansAnimations = false,
    VoidCallback? onTap,
  }) => tester.pumpWidget(
    MaterialApp(
      builder: (context, enfant) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(disableAnimations: sansAnimations),
        child: enfant!,
      ),
      home: Scaffold(
        body: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: largeur,
            child: InkWell(onTap: onTap, child: TexteDefilant(texte)),
          ),
        ),
      ),
    ),
  );

  double position(WidgetTester tester) => tester
      .widget<SingleChildScrollView>(find.byType(SingleChildScrollView))
      .controller!
      .offset;

  testWidgets('texte trop long : défile jusqu\'à la fin, puis recommence', (
    tester,
  ) async {
    await monter(tester, largeur: 150);
    await tester.pump();
    expect(position(tester), 0); // pause au début

    await tester.pump(const Duration(milliseconds: 1500)); // fin de la pause
    await tester.pump(const Duration(seconds: 1));
    final enRoute = position(tester);
    expect(enRoute, greaterThan(0));

    // Jusqu'au bout, puis pause.
    await tester.pump(const Duration(seconds: 30));
    await tester.pump();
    final fin = position(tester);
    expect(fin, greaterThan(enRoute));

    // Fin de la pause : retour au début.
    await tester.pump(const Duration(milliseconds: 1600));
    expect(position(tester), 0);

    // Et le cycle reprend.
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(seconds: 1));
    expect(position(tester), greaterThan(0));
  });

  testWidgets('texte qui tient en entier : fixe', (tester) async {
    await monter(tester, largeur: 700, texte: 'Rechercher');
    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(seconds: 5));
    expect(position(tester), 0);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('animations désactivées : tronqué par « … »', (tester) async {
    await monter(tester, largeur: 150, sansAnimations: true);
    await tester.pumpAndSettle();
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(
      tester.widget<Text>(find.text(_invite)).overflow,
      TextOverflow.ellipsis,
    );
  });

  testWidgets('le toucher traverse le texte qui défile', (tester) async {
    var touchers = 0;
    await monter(tester, largeur: 150, onTap: () => touchers++);
    await tester.pump(const Duration(seconds: 3)); // en plein défilement
    await tester.tap(find.byType(TexteDefilant));
    expect(touchers, 1);
  });
}
