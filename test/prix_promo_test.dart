import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/catalogue/widgets/prix_promo.dart';
import 'package:poufiret/global/ui/format_montant.dart';

Future<void> _monter(WidgetTester tester, Widget prix) =>
    tester.pumpWidget(MaterialApp(home: Scaffold(body: prix)));

void main() {
  testWidgets('sans promo : prix mis en forme par formatMontant', (
    tester,
  ) async {
    await _monter(
      tester,
      const PrixPromo(prixNormal: 12500, prixEffectif: 12500),
    );
    expect(find.text(formatMontant(12500)), findsOneWidget);
    expect(find.text('12 500 f'), findsOneWidget);
  });

  testWidgets('promo : ancien et nouveau prix, arrondis au franc', (
    tester,
  ) async {
    await _monter(
      tester,
      const PrixPromo(
        prixNormal: 10000,
        prixEffectif: 8499.5,
        pourcentageReduction: 15,
      ),
    );
    expect(find.text(formatMontant(10000)), findsOneWidget);
    expect(find.text(formatMontant(8500)), findsOneWidget);
    expect(find.text('-15%'), findsOneWidget);
  });
}
