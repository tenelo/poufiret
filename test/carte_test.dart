import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/global/carte/carte_poufiret.dart';
import 'package:poufiret/global/carte/modeles_carte.dart';
import 'package:poufiret/global/carte/services_google.dart';

void main() {
  const centre = PointCarte(9.5928, -5.1942);

  Future<void> monter(
    WidgetTester tester, {
    required bool google,
    List<MarqueurCarte> marqueurs = const [],
    ControleurCarte? controleur,
    ValueChanged<PointCarte>? onTap,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [servicesGoogleProvider.overrideWith((ref) async => google)],
        child: MaterialApp(
          home: Scaffold(
            body: CartePoufiret(
              centreInitial: centre,
              marqueurs: marqueurs,
              controleur: controleur,
              onTap: onTap,
              boutonsZoom: true,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('sans services Google : carte OpenStreetMap + attribution',
      (tester) async {
    await monter(tester, google: false);
    await tester.pump();

    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.textContaining('OpenStreetMap contributors'), findsOneWidget);
  });

  testWidgets('OSM : marqueur, bulle au toucher, zoom via le controleur',
      (tester) async {
    final controleur = ControleurCarte();
    await monter(
      tester,
      google: false,
      controleur: controleur,
      marqueurs: const [
        MarqueurCarte(
          id: 'part_1',
          position: centre,
          titre: 'Business Center',
          sousTitre: 'Ferké',
        ),
      ],
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Business Center'), findsNothing);
    await tester.tap(find.byIcon(Icons.location_on));
    await tester.pump();
    expect(find.text('Business Center'), findsOneWidget);
    expect(find.text('Ferké'), findsOneWidget);

    final carte = tester.widget<FlutterMap>(find.byType(FlutterMap));
    final zoomAvant = carte.mapController!.camera.zoom;
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(carte.mapController!.camera.zoom, zoomAvant + 1);

    await controleur.centrerSur(const PointCarte(9.6, -5.2), zoom: 16);
    expect(carte.mapController!.camera.zoom, 16);
    expect(controleur.pret, isTrue);
  });

  testWidgets('OSM : le controleur est délié à la fermeture de la carte',
      (tester) async {
    final controleur = ControleurCarte();
    await monter(tester, google: false, controleur: controleur);
    await tester.pump();
    expect(controleur.pret, isTrue);

    await tester.pumpWidget(const SizedBox());

    expect(controleur.pret, isFalse);
  });

  test('ajuster : un seul point => centre, aucun point => rien', () async {
    final centrages = <(PointCarte, double?)>[];
    final controleur = ControleurCarte()
      ..lier(
        zoomer: (_) async {},
        centrer: (p, z) async => centrages.add((p, z)),
        cadrer: (_, _) async => centrages.add((centre, -1)),
      );

    await controleur.ajuster([]);
    await controleur.ajuster([centre], zoomSiUnPoint: 15);
    await controleur.ajuster([centre, const PointCarte(9.7, -5.1)]);

    expect(centrages, [(centre, 15), (centre, -1)]);
  });
}
