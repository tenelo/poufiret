import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/article_liste.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/video_article.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_articles.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/filtre_localites.dart';
import 'package:poufiret/fonctionnalites/locations/donnees/locations_providers.dart';
import 'package:poufiret/fonctionnalites/locations/donnees/locations_repository.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/location_models.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_logement.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_loueur.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_mes_demandes_visite.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/carte_logement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/feuille_demande_visite.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/visite_immersive.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/notifications/routeur_notifications.dart';

final _repo = LocationsRepository(Dio());

/// Réponse RÉELLE de GET /locations/meta/ (production, 2026-10-07).
final _meta = _repo.metaDepuis(
  jsonDecode(File('test/fixtures/locations/meta.json').readAsStringSync()),
);

// Aucun loueur ni logement n'existe encore en production : les réponses
// ci-dessous suivent le contrat, avec des décimaux en chaîne.

const _jsonPageLoueur = '''
{
  "loueur": {"id": 70, "nom": "Immo Ferké", "logo": null, "couverture": null,
             "telephone_pro": "0700000070", "whatsapp": "0700000070"},
  "resultats": [
    {"id": 1, "titre": "Villa 3 pièces à Bromakoté", "photo": null,
     "type_logement": "villa", "type_logement_libelle": "Villa",
     "localisation_texte": "Ferké - Bromakoté", "loyer": "50000.00",
     "nb_chambres": 3, "nb_salles_de_bain": 2, "meuble": true,
     "disponibilite": "disponible"},
    {"id": 2, "titre": "Studio Gare", "photo": null,
     "type_logement": "studio", "type_logement_libelle": "Studio",
     "localisation_texte": "Ferké - Gare", "loyer": 25000,
     "nb_chambres": 1, "nb_salles_de_bain": 1, "meuble": false,
     "disponibilite": "disponible"}
  ]
}
''';

const _jsonLogement = '''
{
  "id": 1, "titre": "Villa 3 pièces à Bromakoté",
  "description": "Villa calme, proche du marché.",
  "galerie": [],
  "panoramas": [
    {"id": 12, "image": "https://exemple.test/chambre.jpg", "titre": "Chambre 1",
     "type_vue": "photo_360", "ordre": 2, "est_active": true},
    {"id": 11, "image": "https://exemple.test/salon.jpg", "titre": "Salon",
     "type_vue": "panoramique", "ordre": 1, "est_active": true},
    {"id": 13, "image": "https://exemple.test/cave.jpg", "titre": "Cave",
     "type_vue": "photo_360", "ordre": 3, "est_active": false}
  ],
  "type_logement": "villa", "type_logement_libelle": "Villa",
  "nb_chambres": 3, "nb_salons": 1, "nb_salles_de_bain": 2,
  "surface_m2": "120.00", "meuble": true,
  "loyer": "50000.00", "caution_mois": 2, "avance_mois": 3,
  "frais_agence": "25000.00",
  "compteur_eau_individuel": true, "compteur_electricite_individuel": false,
  "equipements": ["climatisation", "forage"],
  "disponibilite": "disponible", "disponible_a_partir_du": "2026-11-01",
  "localite_nom": "Ferké", "quartier_nom": "Bromakoté", "secteur": "Rue Princesse",
  "adresse_reperes": "Derrière la mosquée",
  "latitude": "9.5928", "longitude": "-5.1942",
  "loueur": {"id": 70, "nom": "Immo Ferké", "telephone_pro": "0700000070",
             "whatsapp": "0700000070"},
  "autres_logements": [
    {"id": 2, "titre": "Studio Gare", "photo": null, "type_logement": "studio",
     "type_logement_libelle": "Studio", "localisation_texte": "Ferké - Gare",
     "loyer": 25000, "nb_chambres": 1, "nb_salles_de_bain": 1, "meuble": false,
     "disponibilite": "disponible"}
  ]
}
''';

final _page = _repo.pageLoueurDepuis(jsonDecode(_jsonPageLoueur));
final _logement = _repo.logementDepuis(jsonDecode(_jsonLogement));

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

class _Session extends AuthNotifier {
  _Session(this.utilisateur);
  final Utilisateur? utilisateur;

  @override
  Future<Utilisateur?> build() async => utilisateur;
}

/// Serveur factice des demandes de visite.
class _FauxLocations extends LocationsRepository {
  _FauxLocations() : super(Dio());

  final envois = <Map<String, Object?>>[];
  final annulations = <(int, String)>[];
  String? refus;
  List<DemandeReservation> demandes = const [];

  @override
  Future<void> demanderVisite({
    required int logementId,
    required DateTime date,
    required String telephone,
    String message = '',
  }) async {
    if (refus != null) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: ApiException.fromResponse(400, {
          'erreur': true,
          'message': refus,
        }),
      );
    }
    envois.add({
      'objet_id': logementId,
      'date_souhaitee': formatDateIso(date),
      'telephone_contact': telephone,
      'message': message,
    });
  }

  @override
  Future<List<DemandeReservation>> mesDemandes({String? statut}) async =>
      demandes;

  @override
  Future<void> annulerDemande(int id, {String commentaire = ''}) async {
    annulations.add((id, commentaire));
    demandes = const [];
  }
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override> overrides = const [],
  Utilisateur? utilisateur = _utilisateur,
  GlobalKey<NavigatorState>? navigateur,
  bool stabiliser = true,
}) async {
  tester.view.physicalSize = const Size(420, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => _Session(utilisateur)),
        metaLocationsProvider.overrideWith((ref) => Stream.value(_meta)),
        ...overrides,
      ],
      child: MaterialApp(
        navigatorKey: navigateur,
        home: Consumer(
          builder: (context, ref, _) {
            // Dans l'app, la session est chargée par la racine.
            ref.watch(authProvider);
            return ecran;
          },
        ),
      ),
    ),
  );
  // Une image en cours de chargement tourne sans fin : la fiche logement
  // est avancée de quelques images au lieu d'attendre l'immobilité.
  if (stabiliser) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  group('parsing', () {
    test('meta réelle : types, équipements, disponibilités', () {
      expect(_meta.typesLogement.first.valeur, 'studio');
      expect(_meta.typesLogement.map((t) => t.libelle), contains('Villa'));
      expect(_meta.libelleEquipement('cuisine'), 'Cuisine équipée');
      expect(_meta.libelleEquipement('inconnu'), 'inconnu');
      expect(_meta.disponibilites.map((d) => d.valeur), [
        'disponible',
        'reserve',
        'loue',
      ]);
    });

    test(
      'page loueur : loueur et logements, loyers en chaîne ou en nombre',
      () {
        expect(_page.loueur.nom, 'Immo Ferké');
        expect(_page.loueur.logo, '');
        expect(_page.loueur.whatsapp, '0700000070');
        final villa = _page.resultats.first;
        expect(villa.loyer, 50000);
        expect(formatLoyer(villa.loyer), '50 000 F/mois');
        expect(villa.puces, ['3 chambres', '2 sdb', 'Meublé']);
        expect(_page.resultats[1].loyer, 25000);
        expect(_page.resultats[1].puces, ['1 chambre', '1 sdb']);
      },
    );

    test('fiche logement', () {
      final l = _logement;
      expect(l.loyer, 50000);
      expect(l.surfaceM2, 120);
      expect(l.cautionMois, 2);
      expect(l.avanceMois, 3);
      expect(l.fraisAgence, 25000);
      expect(l.compteurEauIndividuel, isTrue);
      expect(l.compteurElectriciteIndividuel, isFalse);
      expect(l.equipements, ['climatisation', 'forage']);
      expect(l.localisation, 'Ferké - Bromakoté - Rue Princesse');
      expect(l.latitude, 9.5928);
      expect(l.aPosition, isTrue);
      expect(l.estDisponible, isTrue);
      expect(l.loueur?.nom, 'Immo Ferké');
      expect(l.autresLogements.single.titre, 'Studio Gare');
      // Visite immersive : vues actives seulement, dans l'ordre.
      expect(l.panoramasActifs.map((p) => p.titre), ['Salon', 'Chambre 1']);
      expect(l.panoramasActifs.first.est360, isFalse);
      expect(l.panoramasActifs.last.est360, isTrue);
    });

    test('demande : statut, motif de refus, annulation possible ou non', () {
      final refusee = DemandeReservation.fromJson({
        'id': 5,
        'numero': 'RES-0005',
        'nature_libelle': 'Visite',
        'objet_nom': 'Villa 3 pièces à Bromakoté',
        'partenaire_nom': 'Immo Ferké',
        'date_souhaitee': '2026-10-20',
        'statut': 'refusee',
        'statut_libelle': 'Refusée',
        'raison_refus': 'Logement déjà loué',
        'created_at': '2026-10-07T09:00:00Z',
        'historique': [],
      });
      expect(refusee.dateLisible, '20/10/2026');
      expect(refusee.raisonRefus, 'Logement déjà loué');
      expect(refusee.peutAnnuler, isFalse);
      expect(refusee.copyWith(statut: 'en_attente').peutAnnuler, isTrue);
    });

    test('filtre : disponibles par défaut, critères en paramètres', () {
      expect(const FiltreLogements().parametres, {'disponible': 1});
      expect(const FiltreLogements().nombre, 0);
      const filtre = FiltreLogements(
        type: 'villa',
        quartier: ' Gare ',
        loyerMax: 60000,
        chambresMin: 2,
        meuble: true,
      );
      expect(filtre.parametres, {
        'disponible': 1,
        'type': 'villa',
        'quartier': 'Gare',
        'loyer_max': 60000,
        'chambres_min': 2,
        'meuble': 1,
      });
      expect(filtre.nombre, 5);
      expect(
        filtre,
        const FiltreLogements(
          type: 'villa',
          quartier: 'Gare',
          loyerMax: 60000,
          chambresMin: 2,
          meuble: true,
        ),
      );
    });
  });

  group('aiguillage loueur_maison', () {
    const loueur = PartenaireCategorie(id: 70, nomCommerce: 'Immo Ferké');
    const sansPage = PartenaireCategorie(id: 71, nomCommerce: 'Agence X');

    final overrides = <Override>[
      departementsProvider.overrideWith(
        (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
      ),
      visiteCategorieProvider(categorieId: 15).overrideWith((ref) async {}),
      partenairesParCategorieProvider(
        slug: 'location-maisons',
      ).overrideWith((ref) => Stream.value(const [loueur, sansPage])),
      for (final id in [70, 71])
        vueVitrineProvider(partenaireId: id).overrideWith((ref) async {}),
      pageLoueurProvider(
        partenaireId: 70,
      ).overrideWith((ref) => Stream.value(_page)),
      // Le serveur ne connaît pas ce partenaire comme loueur.
      pageLoueurProvider(partenaireId: 71).overrideWith(
        (ref) => Stream.error(
          DioException(
            requestOptions: RequestOptions(),
            error: ApiException.fromResponse(404, {
              'erreur': true,
              'message': 'Loueur introuvable.',
            }),
          ),
        ),
      ),
      articlesProvider(
        categorieId: 15,
        partenaireId: 71,
      ).overrideWith((ref) => Stream.value(const <ArticleListe>[])),
      videosPartenaireProvider(
        partenaireId: 71,
      ).overrideWith((ref) async => const <VideoArticle>[]),
    ];

    const annuaire = EcranPrestataires(
      categorieId: 15,
      categorieNom: 'Location de maisons',
      categorieSlug: 'location-maisons',
      modeTransaction: 'vitrine_chat',
      typesPartenaire: ['loueur_maison'],
    );

    testWidgets("l'annuaire de la catégorie ne change pas", (tester) async {
      await _monter(tester, annuaire, overrides: overrides);
      expect(find.byType(FiltreLocalites), findsOneWidget);
      expect(find.text('Par région'), findsOneWidget);
      expect(find.byType(GrillePrestataires), findsOneWidget);
      expect(find.text('Immo Ferké'), findsOneWidget);
      expect(find.byType(CarteLogement), findsNothing);
    });

    testWidgets('toucher un loueur ouvre sa page', (tester) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Immo Ferké'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranLoueur), findsOneWidget);
      expect(find.byType(EcranArticles), findsNothing);
      expect(find.byType(CarteLogement), findsNWidgets(2));
    });

    testWidgets('partenaire sans page loueur (404) : sa fiche habituelle', (
      tester,
    ) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Agence X'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranArticles), findsOneWidget);
      expect(find.text('Loueur introuvable.'), findsNothing);
    });
  });

  group('page loueur', () {
    const meubles = FiltreLogements(meuble: true);

    testWidgets('en-tête, cartes, bouton Filtrer sans puces de filtre', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranLoueur(partenaireId: 70),
        overrides: [
          vueVitrineProvider(partenaireId: 70).overrideWith((ref) async {}),
          pageLoueurProvider(
            partenaireId: 70,
          ).overrideWith((ref) => Stream.value(_page)),
          pageLoueurProvider(partenaireId: 70, filtre: meubles).overrideWith(
            (ref) => Stream.value(
              _page.copyWith(resultats: [_page.resultats.first]),
            ),
          ),
        ],
      );
      expect(find.text('Immo Ferké'), findsWidgets);
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('2 logements disponibles'), findsOneWidget);
      expect(find.text('Villa 3 pièces à Bromakoté'), findsOneWidget);
      expect(find.text('Ferké - Bromakoté'), findsOneWidget);
      expect(find.text('50 000 F/mois'), findsOneWidget);
      expect(find.text('3 chambres'), findsOneWidget);
      expect(find.text('2 sdb'), findsOneWidget);
      expect(find.text('Meublé'), findsOneWidget);
      expect(find.byType(FilterChip), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);

      // Un seul bouton « Filtrer » : il ouvre la feuille des critères.
      await tester.tap(find.text('Filtrer'));
      await tester.pumpAndSettle();
      expect(find.text('Type de logement'), findsOneWidget);
      expect(find.text('Quartier'), findsOneWidget);
      expect(find.text('Loyer maximum'), findsOneWidget);
      expect(find.text('Chambres (minimum)'), findsOneWidget);

      await tester.tap(find.text('Meublé uniquement'));
      await tester.tap(find.text('Appliquer'));
      await tester.pumpAndSettle();
      expect(find.text('Filtrer (1)'), findsOneWidget);
      expect(find.text('1 logement disponible'), findsOneWidget);
      expect(find.text('Studio Gare'), findsNothing);
    });
  });

  group('fiche logement', () {
    List<Override> fiche(Logement l) => [
      logementDetailProvider(id: l.id).overrideWith((ref) => Stream.value(l)),
    ];

    testWidgets('sections, conditions, équipements, actions', (tester) async {
      await _monter(
        tester,
        const EcranLogement(logementId: 1),
        overrides: fiche(_logement),
        stabiliser: false,
      );
      expect(find.text('Ferké - Bromakoté - Rue Princesse'), findsOneWidget);
      expect(find.text('Villa'), findsOneWidget);
      expect(find.text('50 000 F/mois'), findsNWidgets(2));
      // Caractéristiques.
      expect(find.text('3 chambres'), findsOneWidget);
      expect(find.text('1 salon'), findsOneWidget);
      expect(find.text('2 salles de bain'), findsOneWidget);
      expect(find.text('120 m²'), findsOneWidget);
      expect(find.text('Meublé'), findsOneWidget);
      // Conditions.
      expect(find.text('2 mois'), findsOneWidget);
      expect(find.text('3 mois'), findsOneWidget);
      expect(find.text('25 000 F'), findsOneWidget);
      expect(find.text('01/11/2026'), findsOneWidget);
      // Équipements : libellés de la meta réelle.
      expect(find.text('Climatisation'), findsOneWidget);
      expect(find.text('Forage'), findsOneWidget);
      // Autres logements du loueur.
      expect(find.text('Autres logements de ce loueur'), findsOneWidget);
      expect(find.text('Studio Gare'), findsOneWidget);
      // Actions.
      expect(find.text('Itinéraire'), findsOneWidget);
      expect(find.text('Localisation'), findsOneWidget);
      expect(find.text('Demander une visite'), findsOneWidget);
    });

    testWidgets('visite immersive : vue glissée, puis vue 360° choisie', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranLogement(logementId: 1),
        overrides: fiche(_logement),
        stabiliser: false,
      );
      expect(find.text('Visite immersive'), findsOneWidget);
      expect(find.text('Sélectionner la vue à visionner'), findsOneWidget);
      // Vues actives seulement, avec leur titre.
      expect(find.text('Salon'), findsOneWidget);
      expect(find.text('Chambre 1'), findsOneWidget);
      expect(find.text('Cave'), findsNothing);
      // Première vue : panoramique, à faire glisser.
      expect(find.byType(VuePanoramique), findsOneWidget);
      expect(find.text('Maintenez et déplacez la photo'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.text('Chambre 1'));
      await tester.pump();
      expect(find.byType(VueSpherique), findsOneWidget);
      expect(find.byType(PanoramaViewer), findsOneWidget);
      expect(find.byType(VuePanoramique), findsNothing);
      expect(find.text('Tournez la vue avec le doigt'), findsOneWidget);
    });

    testWidgets('sans panorama ni coordonnées : sections et boutons masqués', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranLogement(logementId: 1),
        overrides: fiche(
          _logement.copyWith(
            panoramas: const [],
            latitude: null,
            longitude: null,
          ),
        ),
      );
      expect(find.text('Visite immersive'), findsNothing);
      expect(find.text('Itinéraire'), findsNothing);
      expect(find.text('Localisation'), findsNothing);
      expect(find.text('Demander une visite'), findsOneWidget);
    });
  });

  group('demande de visite', () {
    Widget bouton() => Consumer(
      builder: (context, ref, _) => Scaffold(
        body: TextButton(
          onPressed: () => demanderVisite(
            context,
            ref,
            logementId: 1,
            titre: 'Villa 3 pièces à Bromakoté',
          ),
          child: const Text('Ouvrir'),
        ),
      ),
    );

    testWidgets("visiteur : invitation à s'inscrire", (tester) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        bouton(),
        utilisateur: null,
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.text('Enregistrez-vous pour continuer'), findsOneWidget);
      expect(find.byType(FeuilleDemandeVisite), findsNothing);
    });

    testWidgets('date requise, téléphone prérempli, envoi et confirmation', (
      tester,
    ) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        bouton(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.byType(FeuilleDemandeVisite), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '0707070707'), findsOneWidget);

      // Sans date : rien n'est envoyé.
      await tester.tap(find.text('Envoyer la demande'));
      await tester.pumpAndSettle();
      expect(find.text('Choisissez une date.'), findsOneWidget);
      expect(serveur.envois, isEmpty);

      // Le sélecteur s'ouvre sur aujourd'hui.
      await tester.tap(find.text('Choisir une date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, '0707070707'),
        '0505050505',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Message (optionnel)'),
        'Plutôt le matin',
      );
      await tester.tap(find.text('Envoyer la demande'));
      await tester.pumpAndSettle();

      expect(serveur.envois.single, {
        'objet_id': 1,
        'date_souhaitee': formatDateIso(DateTime.now()),
        'telephone_contact': '0505050505',
        'message': 'Plutôt le matin',
      });
      expect(find.byType(FeuilleDemandeVisite), findsNothing);
      expect(
        find.text(
          'Votre demande a été envoyée. Nous vous recontactons rapidement.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('refus 400 du serveur affiché dans la feuille', (tester) async {
      final serveur = _FauxLocations()
        ..refus = "Ce logement n'est plus disponible.";
      await _monter(
        tester,
        bouton(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choisir une date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Envoyer la demande'));
      await tester.pumpAndSettle();
      expect(find.text("Ce logement n'est plus disponible."), findsOneWidget);
      expect(find.byType(FeuilleDemandeVisite), findsOneWidget);
    });

    test('corps du POST conforme au contrat', () async {
      final requetes = <RequestOptions>[];
      final dio = Dio(BaseOptions(baseUrl: 'https://exemple.test'))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              requetes.add(options);
              handler.resolve(
                Response(requestOptions: options, statusCode: 201),
              );
            },
          ),
        );
      await LocationsRepository(dio).demanderVisite(
        logementId: 1,
        date: DateTime(2026, 10, 20),
        telephone: '0707070707',
        message: 'Bonjour',
      );
      expect(requetes.single.path, '/api/v1/reservations/');
      expect(requetes.single.method, 'POST');
      expect(requetes.single.data, {
        'objet_id': 1,
        'nature': 'visite',
        'date_souhaitee': '2026-10-20',
        'message': 'Bonjour',
        'telephone_contact': '0707070707',
      });
    });
  });

  group('mes demandes', () {
    const enAttente = DemandeReservation(
      id: 5,
      numero: 'RES-0005',
      objetNom: 'Villa 3 pièces à Bromakoté',
      partenaireNom: 'Immo Ferké',
      dateSouhaitee: '2026-10-20',
      statut: 'en_attente',
      statutLibelle: 'En attente',
    );
    const refusee = DemandeReservation(
      id: 6,
      objetNom: 'Studio Gare',
      dateSouhaitee: '2026-10-22',
      statut: 'refusee',
      statutLibelle: 'Refusée',
      raisonRefus: 'Logement déjà loué',
    );

    testWidgets('liste, motif de refus, annulation', (tester) async {
      final serveur = _FauxLocations()..demandes = const [enAttente, refusee];
      await _monter(
        tester,
        const EcranMesDemandesVisite(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Villa 3 pièces à Bromakoté'), findsOneWidget);
      expect(find.text('Visite souhaitée le 20/10/2026'), findsOneWidget);
      expect(find.text('En attente'), findsOneWidget);
      expect(find.text('Refusée'), findsOneWidget);
      expect(find.text('Motif du refus : Logement déjà loué'), findsOneWidget);
      // Seule la demande non terminée peut être annulée.
      expect(find.text('Annuler la demande'), findsOneWidget);

      await tester.tap(find.text('Annuler la demande'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), "Je n'en ai plus besoin");
      await tester.tap(find.widgetWithText(FilledButton, 'Annuler la demande'));
      await tester.pumpAndSettle();
      expect(serveur.annulations, [(5, "Je n'en ai plus besoin")]);
      expect(find.text('Demande annulée.'), findsOneWidget);
    });

    testWidgets('notification de réservation : ouvre « Mes demandes »', (
      tester,
    ) async {
      final serveur = _FauxLocations()..demandes = const [enAttente];
      await _monter(
        tester,
        const Scaffold(body: Text('Accueil')),
        navigateur: navigatorNotifications,
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      // Données exactes du push de transition envoyé par le backend.
      RouteurNotifications.ouvrirDepuisData({
        'type': 'reservation',
        'demande_id': 5,
        'statut': 'confirmee',
      });
      await tester.pumpAndSettle();
      expect(find.byType(EcranMesDemandesVisite), findsOneWidget);
      expect(find.text('Villa 3 pièces à Bromakoté'), findsOneWidget);
    });

    testWidgets('notification : valeurs en chaînes (FCM), tous les statuts', (
      tester,
    ) async {
      final serveur = _FauxLocations()..demandes = const [enAttente];
      await _monter(
        tester,
        const Scaffold(body: Text('Accueil')),
        navigateur: navigatorNotifications,
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      const statuts = [
        'nouvelle',
        'en_cours',
        'confirmee',
        'refusee',
        'annulee',
        'terminee',
      ];
      for (final statut in statuts) {
        // FCM livre les valeurs de data sous forme de chaînes.
        RouteurNotifications.ouvrirDepuisData(
          RouteurNotifications.normaliser({
            'type': 'reservation',
            'demande_id': '5',
            'statut': statut,
          }),
        );
        await tester.pumpAndSettle();
        expect(find.byType(EcranMesDemandesVisite), findsOneWidget);
        navigatorNotifications.currentState!.pop();
        await tester.pumpAndSettle();
      }
    });

    testWidgets("« reservation_transition » n'existe pas : ignoré", (
      tester,
    ) async {
      await _monter(
        tester,
        const Scaffold(body: Text('Accueil')),
        navigateur: navigatorNotifications,
      );
      RouteurNotifications.ouvrirDepuisData({
        'type': 'reservation_transition',
        'demande_id': 5,
      });
      await tester.pumpAndSettle();
      expect(find.byType(EcranMesDemandesVisite), findsNothing);
      expect(find.text('Accueil'), findsOneWidget);
    });
  });
}
