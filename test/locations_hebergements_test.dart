import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
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
import 'package:poufiret/fonctionnalites/locations/metier_domaine/hebergement_models.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/location_models.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_hebergement.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_loueur.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_mes_demandes.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/carte_hebergement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/entete_etablissement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/feuille_reservation_hebergement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/visite_immersive.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/format_montant.dart';

final _repo = LocationsRepository(Dio());

/// Meta réelle (production 2026-10-07) : sans listes d'hôtel.
final _meta = _repo.metaDepuis(
  jsonDecode(File('test/fixtures/locations/meta.json').readAsStringSync()),
);

// Aucun établissement n'est encore publié en production : les réponses
// ci-dessous suivent le contrat, avec des décimaux en chaîne, des null, et
// les deux formes plausibles des équipements et du petit-déjeuner.

const _jsonPage = '''
{
  "etablissement": {
    "id": 90, "nom": "Hôtel Le Kôrô", "logo": null, "couverture": null,
    "telephone_pro": "0700000090", "whatsapp": "0700000090",
    "type_etablissement": "hotel", "type_etablissement_libelle": "Hôtel",
    "description": "Au calme, près du centre.",
    "galerie": [],
    "panoramas": [
      {"id": 31, "image": "https://exemple.test/hall.jpg", "titre": "Hall",
       "type_vue": "photo_360", "ordre": 1, "est_active": true}
    ],
    "etoiles": 3, "localisation_texte": "Ferké - Centre",
    "latitude": "9.5928", "longitude": "-5.1942",
    "heure_arrivee": "14:00:00", "heure_depart": "12:00:00",
    "equipements_etablissement": ["piscine", {"valeur": "salle_de_sport", "libelle": "Salle de sport"}, "wifi"],
    "petit_dejeuner": "en_option", "prix_petit_dejeuner": "3000.00",
    "politique_annulation": "flexible",
    "politique_annulation_libelle": "Annulation gratuite jusqu'à 24 h avant l'arrivée",
    "conditions": "Pièce d'identité demandée à l'arrivée."
  },
  "hebergements": [
    {"id": 1, "titre": "Chambre double climatisée", "photo": null,
     "type_hebergement": "chambre", "type_hebergement_libelle": "Chambre",
     "capacite_adultes": 2, "capacite_enfants": 1, "lits": "1 lit double",
     "prix_nuit": "25000.00", "prix_semaine": "150000.00", "prix_mois": null,
     "disponibilite": "disponible"},
    {"id": 2, "titre": "Suite familiale", "photo": null,
     "type_hebergement": "suite", "type_hebergement_libelle": "Suite",
     "capacite_adultes": 4, "capacite_enfants": 2, "lits": 3,
     "prix_nuit": 60000, "prix_semaine": null, "prix_mois": null,
     "disponibilite": "disponible"},
    {"id": 3, "titre": "Studio meublé", "photo": null,
     "type_hebergement": "studio", "type_hebergement_libelle": "Studio",
     "capacite_adultes": 2, "capacite_enfants": 0, "lits": null,
     "prix_nuit": 20000, "disponibilite": "loue"}
  ]
}
''';

const _jsonHebergement = '''
{
  "id": 1, "titre": "Chambre double climatisée",
  "description": "Vue sur le jardin.",
  "galerie": [],
  "panoramas": [
    {"id": 41, "image": "https://exemple.test/chambre.jpg", "titre": "Chambre",
     "type_vue": "photo_360", "ordre": 1, "est_active": true}
  ],
  "type_hebergement": "chambre", "type_hebergement_libelle": "Chambre",
  "capacite_adultes": 2, "capacite_enfants": 1, "lits": "1 lit double",
  "surface_m2": "24.00", "equipements": ["climatisation", "tv", "wifi"],
  "prix_nuit": "25000.00", "prix_semaine": "150000.00", "prix_mois": "500000.00",
  "duree_min_nuits": 2, "nb_unites": 5, "unites_disponibles": null,
  "heure_arrivee": "", "heure_depart": null,
  "disponibilite": "disponible",
  "etablissement": {"id": 90, "nom": "Hôtel Le Kôrô",
                    "heure_arrivee": "14:00", "heure_depart": "12:00"}
}
''';

final _page = _repo.pageEtablissementDepuis(jsonDecode(_jsonPage));
final _hebergement = _repo.hebergementDepuis(jsonDecode(_jsonHebergement));

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

DateTime _j(int jour, [int mois = 11]) => DateTime(2026, mois, jour);

class _Session extends AuthNotifier {
  _Session(this.utilisateur);
  final Utilisateur? utilisateur;

  @override
  Future<Utilisateur?> build() async => utilisateur;
}

/// Serveur factice : disponibilité et réservations.
class _FauxLocations extends LocationsRepository {
  _FauxLocations() : super(Dio());

  final envois = <Map<String, Object?>>[];
  final verifications = <(int, String, String)>[];

  /// Unités libres renvoyées (null : la vérification échoue).
  int? disponibles = 3;
  Map<String, dynamic>? refus;
  List<DemandeReservation> demandes = const [];

  @override
  Future<int> disponibiliteHebergement(
    int id, {
    required DateTime arrivee,
    required DateTime depart,
  }) async {
    verifications.add((id, formatDateIso(arrivee), formatDateIso(depart)));
    if (disponibles == null) throw Exception('réseau');
    return disponibles!;
  }

  @override
  Future<void> reserverHebergement({
    required int hebergementId,
    required DateTime arrivee,
    required DateTime depart,
    required int adultes,
    required int enfants,
    required int unites,
    required String telephone,
    String message = '',
  }) async {
    if (refus != null) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: ApiException.fromResponse(400, refus),
      );
    }
    envois.add({
      'objet_id': hebergementId,
      'date_debut': formatDateIso(arrivee),
      'date_fin': formatDateIso(depart),
      'nb_adultes': adultes,
      'nb_enfants': enfants,
      'nb_unites': unites,
      'telephone_contact': telephone,
      'message': message,
    });
  }

  @override
  Future<List<DemandeReservation>> mesDemandes({String? statut}) async =>
      demandes;
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override> overrides = const [],
  Utilisateur? utilisateur = _utilisateur,
  bool stabiliser = true,
}) async {
  tester.view.physicalSize = const Size(420, 3200);
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
        home: Consumer(
          builder: (context, ref, _) {
            ref.watch(authProvider);
            return ecran;
          },
        ),
      ),
    ),
  );
  // Une vue 360° en cours de chargement tourne sans fin : l'écran est
  // avancé de quelques images au lieu d'attendre l'immobilité.
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
    test('établissement : étoiles, heures, équipements, petit-déjeuner', () {
      final e = _page.etablissement;
      expect(e.nom, 'Hôtel Le Kôrô');
      expect(e.nbEtoiles, 3);
      expect(e.typeEtablissementLibelle, 'Hôtel');
      expect(e.latitude, 9.5928);
      expect(e.aPosition, isTrue);
      expect(formatHeure(e.heureArrivee), '14h00');
      expect(formatHeure(e.heureDepart), '12h00');
      expect(e.equipements, ['piscine', 'salle_de_sport', 'wifi']);
      expect(e.petitDejeunerLisible, 'En option (${formatMontant(3000)})');
      expect(
        e.politiqueAnnulationLisible,
        "Annulation gratuite jusqu'à 24 h avant l'arrivée",
      );
      expect(e.panoramasActifs.single.titre, 'Hall');
      expect(e.loueur.telephonePro, '0700000090');
    });

    test('petit-déjeuner : booléen, code ou libellé', () {
      Etablissement avec(Map<String, dynamic> champs) =>
          Etablissement.fromJson({'nom': 'X', ...champs});
      expect(avec({'petit_dejeuner': true}).petitDejeunerLisible, 'Inclus');
      expect(
        avec({'petit_dejeuner': false}).petitDejeunerLisible,
        'Non proposé',
      );
      expect(avec({}).petitDejeunerLisible, '');
      expect(
        avec({
          'petit_dejeuner': 'inclus',
          'petit_dejeuner_libelle': 'Inclus dans le prix',
        }).petitDejeunerLisible,
        'Inclus dans le prix',
      );
      expect(
        avec({
          'politique_annulation': 'non_remboursable',
        }).politiqueAnnulationLisible,
        'Non remboursable',
      );
    });

    test('hébergements : capacité, lits, prix en chaîne, disponibles', () {
      final chambre = _page.hebergements.first;
      expect(chambre.capacite, '2 adultes · 1 enfant');
      expect(chambre.lits, '1 lit double');
      expect(chambre.prixNuit, 25000);
      expect(chambre.prixSemaine, 150000);
      expect(chambre.prixMois, isNull);
      expect(formatPrixNuit(chambre.prixNuit), '${formatMontant(25000)}/nuit');
      expect(_page.hebergements[1].lits, '3 lits');
      expect(_page.hebergements[2].lits, '');
      expect(_page.hebergements[2].capacite, '2 adultes');
      // Le studio loué n'est pas listé.
      expect(_page.disponibles.map((h) => h.id), [1, 2]);
    });

    test('fiche hébergement : heures de l\'établissement à défaut', () {
      final h = _hebergement;
      expect(h.surfaceM2, 24);
      expect(h.dureeMin, 2);
      expect(h.nbUnites, 5);
      expect(h.unitesDisponibles, isNull);
      expect(h.prixMois, 500000);
      expect(h.arrivee, '14:00');
      expect(h.depart, '12:00');
      expect(h.panoramasActifs.single.titre, 'Chambre');
      // Durée minimale sous un autre nom, ou absente.
      expect(
        Hebergement.fromJson(const {'id': 9, 'duree_min_jours': 3}).dureeMin,
        3,
      );
      expect(Hebergement.fromJson(const {'id': 9}).dureeMin, 1);
      expect(
        Hebergement.fromJson(const {
          'id': 9,
          'unites_disponibles': '4',
        }).unitesDisponibles,
        4,
      );
    });

    test('demande de séjour : arrivée, départ, voyageurs, chambres', () {
      final d = DemandeReservation.fromJson({
        'id': 12,
        'nature': 'reservation',
        'objet_type': 'hebergement',
        'objet_nom': 'Chambre double climatisée',
        'date_debut': '2026-11-10',
        'date_fin': '2026-11-13',
        'nb_adultes': 2,
        'nb_enfants': 1,
        'nb_unites': '1',
        'montant_estime': '75000.00',
        'statut': 'nouvelle',
      });
      expect(d.estSejour, isTrue);
      expect(d.sejourLisible, 'Arrivée le 10/11/2026 · départ le 13/11/2026');
      expect(d.voyageursLisible, '2 adultes · 1 enfant');
      expect(d.nbUnites, 1);
      expect(d.montantEstime, 75000);
      // Une réservation de véhicule n'est pas un séjour.
      final vehicule = DemandeReservation.fromJson(const {
        'id': 9,
        'nature': 'reservation',
        'objet_type': 'vehicule',
      });
      expect(vehicule.estSejour, isFalse);
      expect(vehicule.estReservation, isTrue);
    });

    test('filtre : type, prix max, capacité, appliqués sur place', () {
      final liste = _page.disponibles;
      expect(const FiltreHebergements().appliquer(liste), hasLength(2));
      expect(const FiltreHebergements().nombre, 0);
      expect(
        const FiltreHebergements(type: 'suite').appliquer(liste).single.id,
        2,
      );
      expect(
        const FiltreHebergements(prixMax: 30000).appliquer(liste).single.id,
        1,
      );
      expect(
        const FiltreHebergements(capacite: 4).appliquer(liste).single.id,
        2,
      );
      const tous = FiltreHebergements(type: 'chambre', prixMax: 1, capacite: 1);
      expect(tous.nombre, 3);
      expect(tous.appliquer(liste), isEmpty);
      expect(
        tous,
        const FiltreHebergements(type: 'chambre', prixMax: 1, capacite: 1),
      );
    });

    test('textes lisibles', () {
      expect(lisible('salle_de_sport'), 'Salle de sport');
      expect(formatHeure('9:30'), '09h30');
      expect(formatHeure('Midi'), 'Midi');
      expect(capaciteLisible(1, 0), '1 adulte');
      expect(_meta.libelleEquipementHotel('piscine'), 'Piscine');
    });
  });

  group('montant estimé', () {
    test('nuits entre arrivée et départ', () {
      expect(nombreNuits(_j(10), _j(13)), 3);
      expect(nombreNuits(_j(10), _j(10)), 0);
      expect(nombreNuits(_j(13), _j(10)), 0);
      // Changement d'heure (fin octobre) : pas de nuit perdue.
      expect(nombreNuits(_j(24, 10), _j(2)), 9);
    });

    test('3 nuits × 25 000 F × 1 chambre = 75 000 F', () {
      const une = EstimationSejour(nuits: 3, prixNuit: 25000, unites: 1);
      expect(une.total, 75000);
      expect(
        une.libelle,
        '3 nuits × ${formatMontant(25000)} × 1 chambre = '
        '${formatMontant(75000)}',
      );
      const deux = EstimationSejour(nuits: 1, prixNuit: 25000, unites: 2);
      expect(
        deux.libelle,
        '1 nuit × ${formatMontant(25000)} × 2 chambres = '
        '${formatMontant(50000)}',
      );
    });

    test('séjour : départ après l\'arrivée, durée minimale', () {
      expect(_hebergement.erreurSejour(_j(10), _j(12)), isNull);
      expect(_hebergement.erreurSejour(_j(10), _j(10)), contains('départ'));
      expect(
        _hebergement.erreurSejour(_j(10), _j(11)),
        'Durée minimale de séjour : 2 nuits.',
      );
    });

    test('plafonds : chambres libres, capacité par chambre', () {
      final h = _hebergement;
      expect(h.maxUnites(null), 5);
      expect(h.maxUnites(3), 3);
      expect(h.maxUnites(0), 1);
      expect(h.maxAdultes(1), 2);
      expect(h.maxAdultes(3), 6);
      expect(h.maxEnfants(2), 2);
      expect(h.copyWith(capaciteEnfants: 0).maxEnfants(2), 0);
      expect(const Hebergement(id: 1).maxUnites(null), 10);
    });
  });

  group('disponibilité', () {
    test('libellés', () {
      expect(libelleDisponibilite(3), '3 chambres disponibles');
      expect(libelleDisponibilite(1), '1 chambre disponible');
      expect(libelleDisponibilite(0), 'Complet sur ces dates');
    });

    test('requêtes : chemins et paramètres du contrat', () async {
      final requetes = <RequestOptions>[];
      final dio = Dio(BaseOptions(baseUrl: 'https://exemple.test'))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              requetes.add(options);
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: {'unites_disponibles': '3'},
                ),
              );
            },
          ),
        );
      final repo = LocationsRepository(dio);
      final libres = await repo.disponibiliteHebergement(
        1,
        arrivee: _j(10),
        depart: _j(13),
      );
      expect(libres, 3);
      expect(
        requetes.single.path,
        '/api/v1/locations/hebergements/1/disponibilite/',
      );
      expect(requetes.single.queryParameters, {
        'date_debut': '2026-11-10',
        'date_fin': '2026-11-13',
      });
      await repo.etablissementBrut(90);
      await repo.hebergementBrut(1);
      expect(
        requetes[1].path,
        '/api/v1/locations/partenaires/90/etablissement/',
      );
      expect(requetes[2].path, '/api/v1/locations/hebergements/1/');
    });
  });

  group('aiguillage hotelier', () {
    test('type de location', () {
      expect(typeLocation(['hotelier']), TypeLocation.hebergement);
    });

    const hotel = PartenaireCategorie(id: 90, nomCommerce: 'Hôtel Le Kôrô');
    const sansPage = PartenaireCategorie(id: 91, nomCommerce: 'Auberge Z');

    final overrides = <Override>[
      departementsProvider.overrideWith(
        (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
      ),
      visiteCategorieProvider(categorieId: 17).overrideWith((ref) async {}),
      partenairesParCategorieProvider(
        slug: 'hotels-residences',
      ).overrideWith((ref) => Stream.value(const [hotel, sansPage])),
      for (final id in [90, 91])
        vueVitrineProvider(partenaireId: id).overrideWith((ref) async {}),
      pageEtablissementProvider(
        partenaireId: 90,
      ).overrideWith((ref) => Stream.value(_page)),
      pageEtablissementProvider(partenaireId: 91).overrideWith(
        (ref) => Stream.error(
          DioException(
            requestOptions: RequestOptions(),
            error: ApiException.fromResponse(404, {
              'erreur': true,
              'message': 'Établissement introuvable.',
            }),
          ),
        ),
      ),
      articlesProvider(
        categorieId: 17,
        partenaireId: 91,
      ).overrideWith((ref) => Stream.value(const <ArticleListe>[])),
      videosPartenaireProvider(
        partenaireId: 91,
      ).overrideWith((ref) async => const <VideoArticle>[]),
    ];

    const annuaire = EcranPrestataires(
      categorieId: 17,
      categorieNom: 'Hôtels et résidences',
      categorieSlug: 'hotels-residences',
      modeTransaction: 'vitrine_chat',
      typesPartenaire: ['hotelier'],
    );

    testWidgets("l'annuaire de la catégorie ne change pas", (tester) async {
      await _monter(tester, annuaire, overrides: overrides);
      expect(find.byType(FiltreLocalites), findsOneWidget);
      expect(find.text('Par région'), findsOneWidget);
      expect(find.byType(GrillePrestataires), findsOneWidget);
      expect(find.text('Hôtel Le Kôrô'), findsOneWidget);
      expect(find.byType(CarteHebergement), findsNothing);
    });

    testWidgets('toucher un hôtelier ouvre la page établissement', (
      tester,
    ) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Hôtel Le Kôrô'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(EcranLoueur), findsOneWidget);
      expect(find.byType(EnteteEtablissement), findsOneWidget);
      expect(find.byType(EcranArticles), findsNothing);
      expect(find.byType(CarteHebergement), findsNWidgets(2));
    });

    testWidgets('partenaire sans établissement (404) : sa fiche habituelle', (
      tester,
    ) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Auberge Z'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranArticles), findsOneWidget);
      expect(find.text('Établissement introuvable.'), findsNothing);
    });
  });

  group('page établissement', () {
    final overrides = <Override>[
      vueVitrineProvider(partenaireId: 90).overrideWith((ref) async {}),
      pageEtablissementProvider(
        partenaireId: 90,
      ).overrideWith((ref) => Stream.value(_page)),
    ];

    testWidgets('en-tête, infos pratiques, cartes, Filtrer', (tester) async {
      await _monter(
        tester,
        const EcranLoueur(partenaireId: 90, type: TypeLocation.hebergement),
        overrides: overrides,
        stabiliser: false,
      );
      expect(find.text('Hôtel Le Kôrô'), findsWidgets);
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(3));
      expect(find.text('Hôtel'), findsOneWidget);
      expect(find.text('Ferké - Centre'), findsOneWidget);
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('Itinéraire'), findsOneWidget);
      expect(find.text('Localisation'), findsOneWidget);
      // Vue 360° de l'établissement : la visionneuse de M1.
      expect(find.text('Vue 360°'), findsOneWidget);
      expect(find.byType(VisiteImmersive), findsOneWidget);
      // Équipements : libellés reçus, sinon valeurs rendues lisibles.
      expect(find.text('Piscine'), findsOneWidget);
      expect(find.text('Salle de sport'), findsOneWidget);
      expect(find.text('Wifi'), findsOneWidget);
      // Arrivée, départ, petit-déjeuner, annulation, conditions.
      expect(find.text('à partir de 14h00'), findsOneWidget);
      expect(find.text('avant 12h00'), findsOneWidget);
      expect(find.text('En option (${formatMontant(3000)})'), findsOneWidget);
      expect(
        find.text("Annulation gratuite jusqu'à 24 h avant l'arrivée"),
        findsOneWidget,
      );
      expect(
        find.text("Pièce d'identité demandée à l'arrivée."),
        findsOneWidget,
      );
      // Hébergements disponibles seulement.
      expect(find.text('2 hébergements disponibles'), findsOneWidget);
      expect(find.text('Chambre double climatisée'), findsOneWidget);
      expect(find.text('Chambre'), findsOneWidget);
      expect(find.text('2 adultes · 1 enfant'), findsOneWidget);
      expect(find.text('1 lit double'), findsOneWidget);
      expect(find.text('${formatMontant(25000)}/nuit'), findsOneWidget);
      expect(find.text('Studio meublé'), findsNothing);
      expect(find.byType(FilterChip), findsNothing);

      // Un seul bouton « Filtrer » : type, prix max, capacité.
      await tester.tap(find.text('Filtrer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text("Type d'hébergement"), findsOneWidget);
      expect(find.text('Prix maximum'), findsOneWidget);
      expect(find.text('Capacité'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextField, 'Prix maximum'),
        '30000',
      );
      await tester.tap(find.text('Appliquer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Filtrer (1)'), findsOneWidget);
      expect(find.text('1 hébergement disponible'), findsOneWidget);
      expect(find.text('Suite familiale'), findsNothing);
    });

    testWidgets('sans position, panorama ni contacts : masqués', (
      tester,
    ) async {
      final nu = _page.copyWith(
        etablissement: _page.etablissement.copyWith(
          latitude: null,
          longitude: null,
          panoramas: const [],
          whatsapp: '',
          etoiles: null,
        ),
      );
      await _monter(
        tester,
        const EcranLoueur(partenaireId: 90, type: TypeLocation.hebergement),
        overrides: [
          vueVitrineProvider(partenaireId: 90).overrideWith((ref) async {}),
          pageEtablissementProvider(
            partenaireId: 90,
          ).overrideWith((ref) => Stream.value(nu)),
        ],
      );
      expect(find.text('Itinéraire'), findsNothing);
      expect(find.text('Vue 360°'), findsNothing);
      expect(find.text('WhatsApp'), findsNothing);
      expect(find.byIcon(Icons.star_rounded), findsNothing);
      expect(find.text('Appeler'), findsOneWidget);
    });
  });

  group('fiche hébergement', () {
    testWidgets('capacité, tarifs, durée minimale, heures, Réserver', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranHebergement(hebergementId: 1),
        overrides: [
          hebergementDetailProvider(
            id: 1,
          ).overrideWith((ref) => Stream.value(_hebergement)),
        ],
        stabiliser: false,
      );
      expect(find.text('Chambre double climatisée'), findsWidgets);
      expect(find.text('Hôtel Le Kôrô'), findsOneWidget);
      expect(find.text('Chambre'), findsWidgets);
      expect(find.text('Vue 360°'), findsOneWidget);
      expect(find.text('2 adultes · 1 enfant'), findsOneWidget);
      expect(find.text('1 lit double'), findsOneWidget);
      expect(find.text('24 m²'), findsOneWidget);
      expect(find.text('Climatisation'), findsOneWidget);
      expect(find.text('Tv'), findsOneWidget);
      expect(find.text('${formatMontant(25000)}/nuit'), findsNWidgets(2));
      expect(find.text('${formatMontant(150000)}/semaine'), findsOneWidget);
      expect(find.text('${formatMontant(500000)}/mois'), findsOneWidget);
      expect(find.text('2 nuits'), findsOneWidget);
      expect(find.text('à partir de 14h00'), findsOneWidget);
      expect(find.text('avant 12h00'), findsOneWidget);
      expect(find.text('Réserver'), findsOneWidget);
    });
  });

  group('réservation', () {
    Widget bouton(Hebergement h) => Consumer(
      builder: (context, ref, _) => Scaffold(
        body: TextButton(
          onPressed: () => reserverHebergement(context, ref, hebergement: h),
          child: const Text('Ouvrir'),
        ),
      ),
    );

    /// Feuille ouverte sur un séjour déjà choisi, une fois la session chargée
    /// (comme derrière le mur d'inscription).
    Widget feuille(Hebergement h, DateTimeRange? plage) => Consumer(
      builder: (context, ref, _) => Scaffold(
        body: ref.watch(authProvider).value == null
            ? const SizedBox.shrink()
            : FeuilleReservationHebergement(
                hebergement: h,
                plageInitiale: plage,
              ),
      ),
    );

    final troisNuits = DateTimeRange(start: _j(10), end: _j(13));

    Text compteur(WidgetTester tester, String libelle) =>
        tester.widget<Text>(find.byKey(ValueKey('compteur-$libelle')));

    testWidgets("visiteur : invitation à s'inscrire", (tester) async {
      await _monter(tester, bouton(_hebergement), utilisateur: null);
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.text('Enregistrez-vous pour continuer'), findsOneWidget);
      expect(find.byType(FeuilleReservationHebergement), findsNothing);
    });

    testWidgets('dates requises, durée minimale, pas de vérification', (
      tester,
    ) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        bouton(_hebergement),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.text('Durée minimale : 2 nuits'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '0707070707'), findsOneWidget);
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(find.text('Choisissez vos dates.'), findsOneWidget);
      expect(serveur.envois, isEmpty);
      expect(serveur.verifications, isEmpty);
    });

    testWidgets('disponibilité, compteurs plafonnés, montant, envoi', (
      tester,
    ) async {
      final serveur = _FauxLocations()..disponibles = 2;
      await _monter(
        tester,
        feuille(_hebergement, troisNuits),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(
        find.text('Du 10/11/2026 au 13/11/2026 · 3 nuits'),
        findsOneWidget,
      );
      expect(serveur.verifications, [(1, '2026-11-10', '2026-11-13')]);
      expect(find.text('2 chambres disponibles'), findsOneWidget);
      expect(
        find.text(
          '3 nuits × ${formatMontant(25000)} × 1 chambre = '
          '${formatMontant(75000)}',
        ),
        findsOneWidget,
      );

      // Adultes : 2 par chambre.
      final plusAdultes = find.byTooltip('Adultes : un de plus');
      await tester.tap(plusAdultes);
      await tester.pump();
      await tester.tap(plusAdultes);
      await tester.pump();
      expect(compteur(tester, 'Adultes').data, '2');
      // Chambres : 2 libres au plus.
      final plusChambres = find.byTooltip('Chambres : un de plus');
      await tester.tap(plusChambres);
      await tester.pump();
      await tester.tap(plusChambres);
      await tester.pump();
      expect(compteur(tester, 'Chambres').data, '2');
      expect(
        find.text(
          '3 nuits × ${formatMontant(25000)} × 2 chambres = '
          '${formatMontant(150000)}',
        ),
        findsOneWidget,
      );
      // Avec deux chambres, jusqu'à 4 adultes.
      await tester.tap(plusAdultes);
      await tester.pump();
      expect(compteur(tester, 'Adultes').data, '3');
      await tester.tap(find.byTooltip('Enfants : un de plus'));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Message (optionnel)'),
        'Arrivée tardive',
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(serveur.envois.single, {
        'objet_id': 1,
        'date_debut': '2026-11-10',
        'date_fin': '2026-11-13',
        'nb_adultes': 3,
        'nb_enfants': 1,
        'nb_unites': 2,
        'telephone_contact': '0707070707',
        'message': 'Arrivée tardive',
      });
    });

    testWidgets('complet sur ces dates : envoi impossible', (tester) async {
      final serveur = _FauxLocations()..disponibles = 0;
      await _monter(
        tester,
        feuille(_hebergement, troisNuits),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Complet sur ces dates'), findsOneWidget);
      expect(find.text('Aucune chambre libre sur ces dates.'), findsOneWidget);
      final bouton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Envoyer la réservation'),
      );
      expect(bouton.onPressed, isNull);
    });

    testWidgets('vérification impossible : la demande reste possible', (
      tester,
    ) async {
      final serveur = _FauxLocations()..disponibles = null;
      await _monter(
        tester,
        feuille(_hebergement, troisNuits),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(
        find.text("Disponibilité non vérifiée : l'établissement confirmera."),
        findsOneWidget,
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(serveur.envois, hasLength(1));
    });

    testWidgets('séjour trop court : ni vérification ni envoi', (tester) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        feuille(_hebergement, DateTimeRange(start: _j(10), end: _j(11))),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Durée minimale de séjour : 2 nuits.'), findsOneWidget);
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(serveur.verifications, isEmpty);
      expect(serveur.envois, isEmpty);
    });

    testWidgets('refus 400 du serveur affiché dans la feuille', (tester) async {
      final serveur = _FauxLocations()
        ..refus = {
          'erreur': 'Réservation impossible.',
          'details': {
            'nb_unites': ['Plus assez de chambres libres sur ces dates.'],
          },
        };
      await _monter(
        tester,
        feuille(_hebergement, troisNuits),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(
        find.text('Plus assez de chambres libres sur ces dates.'),
        findsOneWidget,
      );
      expect(find.byType(FeuilleReservationHebergement), findsOneWidget);
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
      await LocationsRepository(dio).reserverHebergement(
        hebergementId: 1,
        arrivee: _j(10),
        depart: _j(13),
        adultes: 2,
        enfants: 1,
        unites: 1,
        telephone: '0707070707',
        message: 'Bonjour',
      );
      expect(requetes.single.path, '/api/v1/reservations/');
      expect(requetes.single.method, 'POST');
      expect(requetes.single.data, {
        'objet_id': 1,
        'nature': 'reservation',
        'date_debut': '2026-11-10',
        'date_fin': '2026-11-13',
        'nb_adultes': 2,
        'nb_enfants': 1,
        'nb_unites': 1,
        'message': 'Bonjour',
        'telephone_contact': '0707070707',
      });
    });
  });

  group('mes demandes', () {
    testWidgets('séjour : arrivée, départ, voyageurs, chambres, montant', (
      tester,
    ) async {
      final serveur = _FauxLocations()
        ..demandes = const [
          DemandeReservation(
            id: 12,
            nature: 'reservation',
            objetType: 'hebergement',
            objetNom: 'Chambre double climatisée',
            partenaireNom: 'Hôtel Le Kôrô',
            dateDebut: '2026-11-10',
            dateFin: '2026-11-13',
            nbAdultes: 2,
            nbEnfants: 1,
            nbUnites: 1,
            montantEstime: 75000,
            statut: 'nouvelle',
            statutLibelle: 'Nouvelle',
          ),
        ];
      await _monter(
        tester,
        const EcranMesDemandes(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Chambre double climatisée'), findsOneWidget);
      expect(
        find.text('Arrivée le 10/11/2026 · départ le 13/11/2026'),
        findsOneWidget,
      );
      expect(find.text('2 adultes · 1 enfant'), findsOneWidget);
      expect(find.text('1 chambre'), findsOneWidget);
      expect(
        find.text('Montant estimé : ${formatMontant(75000)}'),
        findsOneWidget,
      );
      // Pas les lignes propres aux véhicules.
      expect(find.text('Du 10/11/2026 au 13/11/2026'), findsNothing);
      expect(find.text('Avec chauffeur'), findsNothing);
    });
  });
}
