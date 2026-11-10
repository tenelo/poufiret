import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/location_models.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/elements_fiche.dart';
import 'package:poufiret/fonctionnalites/partenaire/widgets/interrupteur_whatsapp.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/whatsapp_externe.dart';
import 'package:poufiret/global/widgets/bouton_whatsapp.dart';

Future<void> _monter(WidgetTester tester, Widget enfant) =>
    tester.pumpWidget(MaterialApp(home: Scaffold(body: enfant)));

void main() {
  group('règle d\'affichage', () {
    test('champ lu sur la carte partenaire : null, vide ou numéro', () {
      PartenaireCategorie carte(Map<String, dynamic> extra) =>
          PartenaireCategorie.fromJson({'id': 1, ...extra});
      expect(carte({}).whatsappExterne, isNull);
      expect(carte({'whatsapp_externe': null}).whatsappExterne, isNull);
      expect(carte({'whatsapp_externe': '  '}).whatsappExterne, isNull);
      expect(
        carte({'whatsapp_externe': '2250707070707'}).whatsappExterne,
        '2250707070707',
      );
      // Partenaire imbriqué ou préfixé (fiche article).
      expect(
        lireWhatsappExterne({
          'partenaire': {'whatsapp_externe': '2250101010101'},
        }, 'whatsapp_externe'),
        '2250101010101',
      );
      expect(
        lireWhatsappExterne({
          'partenaire_whatsapp_externe': '2250202020202',
        }, 'whatsapp_externe'),
        '2250202020202',
      );
      expect(
        Loueur.fromJson({
          'id': 3,
          'whatsapp': '0707070707',
          'whatsapp_externe': null,
        }).whatsappExterne,
        isNull,
      );
    });

    test('bouton vert seulement avec un numéro', () {
      expect(afficherWhatsappExterne(null), isFalse);
      expect(afficherWhatsappExterne(''), isFalse);
      expect(afficherWhatsappExterne('2250707070707'), isTrue);
    });

    testWidgets('icône verte absente sans numéro, présente avec', (
      tester,
    ) async {
      await _monter(tester, const IconeWhatsappExterne(numero: null));
      expect(find.byTooltip('WhatsApp'), findsNothing);
      await _monter(
        tester,
        const IconeWhatsappExterne(numero: '2250707070707'),
      );
      expect(find.byTooltip('WhatsApp'), findsOneWidget);
    });

    testWidgets('loueur : bouton WhatsApp masqué si le partenaire refuse', (
      tester,
    ) async {
      await _monter(
        tester,
        const BoutonsContact(telephone: '0707070707', whatsapp: null),
      );
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsNothing);
      await _monter(
        tester,
        const BoutonsContact(
          telephone: '0707070707',
          whatsapp: '2250707070707',
        ),
      );
      expect(find.text('WhatsApp'), findsOneWidget);
    });
  });

  group('page loueur : ligne de contact', () {
    Future<void> monterLigne(WidgetTester tester, String? whatsapp) async {
      // Petit écran : rien ne doit déborder.
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: LigneContactLoueur(
                  telephone: '0707070707',
                  whatsapp: whatsapp,
                  partenaireId: 3,
                  nom: 'Ferké Auto Location',
                ),
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('Appeler + Discuter, sans WhatsApp si non fourni', (
      tester,
    ) async {
      await monterLigne(tester, null);
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.byTooltip('Discuter'), findsOneWidget);
      expect(find.byTooltip('WhatsApp'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('WhatsApp ajouté sur la même ligne si fourni', (tester) async {
      await monterLigne(tester, '2250707070707');
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.byTooltip('Discuter'), findsOneWidget);
      expect(find.byTooltip('WhatsApp'), findsOneWidget);
      final appeler = tester.getRect(find.byType(OutlinedButton).at(0));
      final discuter = tester.getRect(find.byType(OutlinedButton).at(1));
      final whatsapp = tester.getRect(find.byType(OutlinedButton).at(2));
      // Même ligne, même hauteur ; carrés ; Appeler prend le reste.
      expect(discuter.top, appeler.top);
      expect(whatsapp.top, appeler.top);
      expect(discuter.height, appeler.height);
      expect(discuter.width, discuter.height);
      expect(whatsapp.width, whatsapp.height);
      expect(appeler.width, greaterThan(discuter.width));
      expect(tester.takeException(), isNull);
    });
  });

  group('lien wa.me', () {
    test('numéro en chiffres, message prérempli encodé', () {
      expect(
        lienWhatsappExterne('2250707070707').toString(),
        'https://wa.me/2250707070707?text=Bonjour%2C%20je%20vous%20contacte'
        '%20via%20Poufiret.',
      );
      expect(
        lienWhatsappExterne(
          '+225 07 07 07 07 07',
          texte: 'Ça marche ?',
        ).toString(),
        'https://wa.me/2250707070707?text=%C3%87a%20marche%20%3F',
      );
      // Le texte se relit tel quel.
      expect(
        lienWhatsappExterne('2250707070707').queryParameters['text'],
        messageWhatsapp,
      );
    });
  });

  group('interrupteur du profil', () {
    testWidgets('sans numéro : grisé, avec explication', (tester) async {
      var appels = 0;
      await _monter(
        tester,
        InterrupteurWhatsappExterne(
          actif: false,
          numero: '',
          enregistrer: (_) async => appels++,
        ),
      );
      final tuile = tester.widget<SwitchListTile>(find.byType(SwitchListTile));
      expect(tuile.onChanged, isNull);
      expect(find.textContaining('Enregistrez d\'abord'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(appels, 0);
    });

    testWidgets('avec numéro : enregistré ; refus du serveur affiché', (
      tester,
    ) async {
      final envois = <bool>[];
      var refuser = false;
      await _monter(
        tester,
        InterrupteurWhatsappExterne(
          actif: false,
          numero: '0707070707',
          enregistrer: (actif) async {
            envois.add(actif);
            if (refuser) {
              throw DioException(
                requestOptions: RequestOptions(),
                error: ApiException.fromResponse(400, {
                  'erreur': true,
                  'message': 'Renseignez un numéro WhatsApp.',
                }),
              );
            }
          },
        ),
      );
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(envois, [true]);
      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);

      refuser = true;
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(envois, [true, false]);
      expect(find.text('Renseignez un numéro WhatsApp.'), findsOneWidget);
      // Refus : l'interrupteur revient à sa position.
      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    });
  });
}
