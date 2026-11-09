import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/service_suivi.dart';
import 'package:poufiret/fonctionnalites/avis/donnees/avis_repository.dart';
import 'package:poufiret/fonctionnalites/avis/metier_domaine/avis.dart';
import 'package:poufiret/fonctionnalites/avis/widgets/widgets_avis.dart';
import 'package:poufiret/fonctionnalites/confidentialite/donnees/consentements_repository.dart';
import 'package:poufiret/fonctionnalites/confidentialite/donnees/demande_consentement.dart';
import 'package:poufiret/fonctionnalites/confidentialite/metier_domaine/consentements.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/network/dio_client.dart';
import 'package:poufiret/global/network/entetes_app.dart';

// ── Service de suivi ────────────────────────────────────────────────────

class _Serveur {
  final lots = <List<Map<String, dynamic>>>[];
  final clics = <(int, String, int)>[];
  bool enPanne = false;

  ServiceSuivi service() => ServiceSuivi(
    minuteur: false,
    envoyerLot: (lot) async {
      if (enPanne) throw DioException(requestOptions: RequestOptions());
      lots.add(lot);
    },
    envoyerClic: (id, type, resultat) async {
      if (enPanne) {
        throw DioException(
          requestOptions: RequestOptions(),
          error: ApiException.fromResponse(409, {'message': 'Déjà cliqué.'}),
        );
      }
      clics.add((id, type, resultat));
    },
  );
}

// ── Avis ────────────────────────────────────────────────────────────────

class _AvisFaux extends AvisRepository {
  _AvisFaux({this.refus}) : super(Dio());

  /// Refus du serveur à renvoyer (null : accepté).
  final ApiException? refus;
  final envois = <(ObjetAvis, String, int, String)>[];

  @override
  Future<Avis> creer({
    required ObjetAvis objet,
    required String objetId,
    required int note,
    String commentaire = '',
  }) async {
    if (refus != null) {
      throw DioException(requestOptions: RequestOptions(), error: refus);
    }
    envois.add((objet, objetId, note, commentaire));
    return Avis(id: 1, note: note, commentaire: commentaire);
  }

  @override
  Future<List<Avis>> mesAvis() async => const [];
}

Future<void> _monterFeuille(WidgetTester tester, _AvisFaux repo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [avisRepositoryProvider.overrideWithValue(repo)],
      child: const MaterialApp(
        home: Scaffold(
          body: FeuilleNotation(objet: ObjetAvis.commande, objetId: '42'),
        ),
      ),
    ),
  );
}

// ── Consentement ────────────────────────────────────────────────────────

class _ConsentementsFaux extends ConsentementsRepository {
  _ConsentementsFaux(this.version) : super(Dio());

  final String? version;
  final enregistres = <(bool, bool)>[];

  @override
  Future<Consentements> lire() async => Consentements(version: version);

  @override
  Future<Consentements> enregistrer({
    required bool statistiques,
    required bool ia,
  }) async {
    enregistres.add((statistiques, ia));
    return Consentements(
      statistiques: statistiques,
      ia: ia,
      version: versionConsentement,
    );
  }
}

Future<GlobalKey<NavigatorState>> _monterAccueil(WidgetTester tester) async {
  final cle = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: cle,
      home: const Scaffold(body: Text('Accueil')),
    ),
  );
  return cle;
}

// ── En-têtes ────────────────────────────────────────────────────────────

class _AdaptateurEspion implements HttpClientAdapter {
  Map<String, dynamic>? entetes;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    entetes = options.headers;
    return ResponseBody.fromString(
      jsonEncode({'ok': true}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('service de suivi', () {
    test('envoi groupé par lots de 50 au plus', () async {
      final serveur = _Serveur();
      final suivi = serveur.service();
      for (var i = 0; i < 120; i++) {
        suivi.evenement(TypeEvenement.appelPartenaire, partenaireId: i);
      }
      await suivi.vider();
      expect(serveur.lots.map((l) => l.length), [50, 50, 20]);
      expect(serveur.lots.first.first, {
        'type': 'appel_partenaire',
        'partenaire_id': 0,
      });
      expect(suivi.enAttente, 0);
    });

    test('échec silencieux : rien ne remonte, le lot repart ensuite', () async {
      final serveur = _Serveur()..enPanne = true;
      final suivi = serveur.service();
      suivi
        ..evenement(TypeEvenement.whatsappPartenaire, partenaireId: 3)
        ..evenement(TypeEvenement.itinerairePartenaire, partenaireId: 3);
      await expectLater(suivi.vider(), completes);
      expect(suivi.enAttente, 2);

      serveur.enPanne = false;
      await suivi.vider();
      expect(serveur.lots.single.map((e) => e['type']), [
        'whatsapp_partenaire',
        'itineraire_partenaire',
      ]);
      expect(suivi.enAttente, 0);
    });

    test('clic de recherche : envoyé, ignoré sans id, 409 avalé', () async {
      final serveur = _Serveur();
      final suivi = serveur.service();
      suivi
        ..clicRecherche(69, 'article', 291)
        ..clicRecherche(null, 'partenaire', 53);
      await Future<void>.delayed(Duration.zero);
      expect(serveur.clics, [(69, 'article', 291)]);

      serveur.enPanne = true; // 409 : déjà cliqué
      suivi.clicRecherche(69, 'article', 291);
      await Future<void>.delayed(Duration.zero);
      expect(serveur.clics, hasLength(1));
    });
  });

  group('feuille de notation', () {
    testWidgets('étoiles + commentaire → avis envoyé', (tester) async {
      final repo = _AvisFaux();
      await _monterFeuille(tester, repo);
      // Sans note, pas d'envoi possible.
      final envoyer = find.widgetWithText(FilledButton, 'Envoyer');
      expect(tester.widget<FilledButton>(envoyer).onPressed, isNull);

      await tester.tap(find.byTooltip('4 sur 5'));
      await tester.enterText(find.byType(TextField), 'Très bon accueil');
      await tester.pump();
      await tester.tap(envoyer);
      await tester.pumpAndSettle();
      expect(repo.envois, [(ObjetAvis.commande, '42', 4, 'Très bon accueil')]);
    });

    testWidgets('refus du serveur : son message est affiché', (tester) async {
      final repo = _AvisFaux(
        refus: ApiException.fromResponse(409, {
          'message': 'Vous avez déjà donné votre avis : modifiez-le plutôt.',
        }),
      );
      await _monterFeuille(tester, repo);
      await tester.tap(find.byTooltip('5 sur 5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Envoyer'));
      await tester.pumpAndSettle();
      expect(
        find.text('Vous avez déjà donné votre avis : modifiez-le plutôt.'),
        findsOneWidget,
      );
    });

    testWidgets('commentaire limité à 1000 caractères', (tester) async {
      await _monterFeuille(tester, _AvisFaux());
      final champ = tester.widget<TextField>(find.byType(TextField));
      expect(champ.maxLength, 1000);
    });
  });

  group('affichage des avis', () {
    testWidgets('« ★ 4,5 (12) », rien sans avis', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ResumeNote(noteMoyenne: 4.5, nbAvis: 12),
                ResumeNote(noteMoyenne: null, nbAvis: 0),
              ],
            ),
          ),
        ),
      );
      expect(find.text('4,5 (12)'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    });

    test('note moyenne en nombre ou en texte ; bouton Noter', () {
      expect(lireNoteMoyenne('4.50'), 4.5);
      expect(lireNoteMoyenne(4), 4.0);
      expect(lireNoteMoyenne(null), isNull);
      expect(const EtatNotation(peutNoter: true).proposerNote, isTrue);
      expect(
        const EtatNotation(peutNoter: true, monAvis: 3).proposerNote,
        isFalse,
      );
      final avis = Avis.fromJson({
        'id': 3,
        'note': 4,
        'modifiable_jusqu_au': '2026-11-12T10:00:00Z',
      });
      expect(avis.modifiable(DateTime.utc(2026, 11, 10)), isTrue);
      expect(avis.modifiable(DateTime.utc(2026, 11, 13)), isFalse);
    });
  });

  group('consentement', () {
    test('règle d\'affichage : version absente ou différente', () {
      expect(doitDemanderConsentement(null), isTrue);
      expect(doitDemanderConsentement('2026-10'), isTrue);
      expect(doitDemanderConsentement(versionConsentement), isFalse);
    });

    testWidgets('fermer sans choisir : non aux deux, version enregistrée', (
      tester,
    ) async {
      final cle = await _monterAccueil(tester);
      final repo = _ConsentementsFaux(null);
      final demande = DemandeConsentement(repo, cle);
      final fin = demande.proposerSiBesoin();
      await tester.pumpAndSettle();
      expect(find.text('Vos données, vos choix'), findsOneWidget);
      // Fermée en touchant hors de la feuille.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      await fin;
      expect(repo.enregistres, [(false, false)]);

      // Une seule fois par session.
      await demande.proposerSiBesoin();
      await tester.pumpAndSettle();
      expect(find.text('Vos données, vos choix'), findsNothing);
    });

    testWidgets('choix enregistrés tels quels', (tester) async {
      final cle = await _monterAccueil(tester);
      final repo = _ConsentementsFaux('2026-01');
      final fin = DemandeConsentement(repo, cle).proposerSiBesoin();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();
      await fin;
      expect(repo.enregistres, [(true, false)]);
    });

    testWidgets('version à jour : rien n\'est demandé', (tester) async {
      final cle = await _monterAccueil(tester);
      final repo = _ConsentementsFaux(versionConsentement);
      await DemandeConsentement(repo, cle).proposerSiBesoin();
      await tester.pumpAndSettle();
      expect(find.text('Vos données, vos choix'), findsNothing);
      expect(repo.enregistres, isEmpty);
    });
  });

  test('en-têtes X-Plateforme et X-Version-App sur chaque requête', () async {
    EntetesApp.definirVersion('9.8.7');
    final espion = _AdaptateurEspion();
    final dio = DioClient.creerNu(adaptateur: espion);
    await dio.get('/api/v1/version/verifier/');
    expect(espion.entetes?['X-Version-App'], '9.8.7');
    expect(
      espion.entetes?['X-Plateforme'],
      isIn(['android', 'ios', 'web', 'autre']),
    );
  });
}
