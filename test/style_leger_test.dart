import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/tuile_elevage.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/tuiles_produits.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/carte_logement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/elements_fiche.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/tuile_plat.dart';
import 'package:poufiret/global/config/config.dart';
import 'package:poufiret/global/ui/theme_poufiret.dart';

/// Charge la vraie police de l'appli (sinon les tests utilisent une police
/// de substitution aux glyphes carrés, bien plus large).
Future<void> _chargerPolice() async {
  final chargeur = FontLoader(police);
  for (final graisse in [
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
    'ExtraBold',
  ]) {
    final octets = File(
      'assets/fonts/PlusJakartaSans-$graisse.ttf',
    ).readAsBytesSync();
    chargeur.addFont(Future.value(ByteData.sublistView(octets)));
  }
  await chargeur.load();
}

final _produit = Plat.fromJson(const {
  'id': 1,
  'nom': 'Poulet bicyclette fermier élevé en plein air',
  'prix': '3500.00',
  'prix_effectif': '3500.00',
  'fiche_specifique': {
    'marque': 'Ferme Koné',
    'etat_vente': 'abattu_entier',
    'unite_prix': 'piece',
    'poids_moyen_kg': '2.5',
    'commande_avance_jours': 3,
    'livraison_possible': true,
    'sur_commande': true,
    'delai_heures': 48,
  },
});

/// Composants denses de l'appli, dans la largeur d'un petit téléphone.
Widget _vitrine() => ListView(
  padding: const EdgeInsets.all(16),
  children: [
    SizedBox(
      height: 900,
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (context, c) => SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio:
                    ((c.crossAxisExtent - 12) / 2) /
                    ((c.crossAxisExtent - 12) / 2 +
                        MediaQuery.textScalerOf(
                          context,
                        ).scale(hauteurTexteElevage)),
                children: [
                  TuileElevage(produit: _produit, onTap: () {}),
                  TuileElevage(produit: _produit, onTap: () {}),
                ],
              ),
            ),
            SliverLayoutBuilder(
              builder: (context, c) => SliverPadding(
                padding: const EdgeInsets.only(top: 12),
                sliver: SliverGrid(
                  gridDelegate: grilleProduits(context, c.crossAxisExtent),
                  delegate: SliverChildListDelegate([
                    TuileGrilleProduit(
                      produit: _produit,
                      surTitre: 'Ferme Koné',
                      mention: "Sur commande · 48 h à l'avance",
                      onTap: () {},
                    ),
                    TuileGrilleProduit(produit: _produit, onTap: () {}),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    LigneProduit(
      produit: _produit,
      lignes: const ['Comprimé · 500 mg', 'Laboratoire Cipla'],
      mention: 'Sur ordonnance',
      action: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.call_outlined, size: 18),
        label: const Text('Appeler la pharmacie'),
      ),
      onTap: () {},
    ),
    TuilePlat(
      nom: 'Garba poisson thon avec attiéké et piment',
      description: 'Attiéké frais, thon frit, oignons, tomates et piment.',
      prix: 'à partir de 1 500 F',
      mention: 'Plus que 3',
      onTap: () {},
    ),
    const SizedBox(height: 12),
    CarteLocation(
      photo: '',
      iconeSansPhoto: Icons.home_outlined,
      titre: 'Villa 4 pièces avec cour et garage à Bromakoté',
      sousTitre: 'Ferké - Bromakoté - Rue Princesse',
      prix: '150 000 F/mois',
      puces: const ['4 chambres', '2 sdb', 'Meublé'],
      onTap: () {},
    ),
    const SizedBox(height: 12),
    const EncadreMontant(
      libelle: '3 nuits × 25 000 F × 2 chambres = 150 000 F',
    ),
    const LigneFiche("Compteur d'électricité individuel", 'Oui'),
    const SizedBox(height: 12),
    Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.directions_outlined, size: 18),
            label: const Text('Itinéraire'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map_outlined, size: 18),
            label: const Text('Localisation'),
          ),
        ),
      ],
    ),
    const SizedBox(height: 12),
    FilledButton(
      onPressed: () {},
      child: const Text('Ajouter au panier · 10 500 F'),
    ),
  ],
);

void main() {
  setUpAll(_chargerPolice);

  group('thème léger', () {
    for (final (nom, theme) in [
      ('clair', ThemePoufiret.clair),
      ('sombre', ThemePoufiret.sombre),
    ]) {
      test('$nom : graisses fines, texte courant aéré', () {
        final t = theme.textTheme;
        final tous = [
          t.headlineLarge, t.headlineMedium, t.headlineSmall, //
          t.titleLarge, t.titleMedium, t.titleSmall,
          t.bodyLarge, t.bodyMedium, t.bodySmall,
          t.labelLarge, t.labelMedium, t.labelSmall,
        ];
        for (final style in tous) {
          expect(style!.fontFamily, police);
          expect(style.fontWeight!.value, lessThanOrEqualTo(600));
        }
        for (final style in [t.bodyLarge, t.bodyMedium, t.bodySmall]) {
          expect(style!.fontWeight, FontWeight.w400);
          expect(style.height, inInclusiveRange(1.35, 1.5));
        }
        for (final style in [t.headlineLarge, t.headlineMedium, t.titleLarge]) {
          expect(style!.fontWeight, FontWeight.w600);
          expect(style.letterSpacing, lessThan(0));
        }
        expect(t.labelSmall!.letterSpacing, greaterThan(0));
        expect(theme.dividerTheme.thickness, lessThanOrEqualTo(1));
        expect(theme.cardTheme.elevation, lessThanOrEqualTo(1));
      });
    }

    test('ombre : même teinte, plus transparente', () {
      final ombre = Config.ombre.first.color;
      expect(ombre.r, closeTo(0x14 / 255, 0.01));
      expect(ombre.g, closeTo(0x3C / 255, 0.01));
      expect(ombre.b, closeTo(0x78 / 255, 0.01));
      expect(ombre.a, lessThan(0.1));
    });
  });

  for (final (nom, theme) in [
    ('clair', ThemePoufiret.clair),
    ('sombre', ThemePoufiret.sombre),
  ]) {
    testWidgets('375 px ($nom) : rien ne déborde', (tester) async {
      tester.view.physicalSize = const Size(375 * 3, 1600 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(body: _vitrine()),
        ),
      );
      await tester.pumpAndSettle();
      // Un débordement (RenderFlex overflowed) lève une erreur ici.
      expect(tester.takeException(), isNull);
      expect(find.text('Appeler la pharmacie'), findsOneWidget);
    });
  }
}
