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
import 'package:poufiret/fonctionnalites/locations/metier_domaine/location_models.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/vehicule_models.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_loueur.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_mes_demandes.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_vehicule.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/carte_logement.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/carte_vehicule.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/feuille_reservation_vehicule.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/visite_immersive.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/format_montant.dart';

final _repo = LocationsRepository(Dio());

/// Meta réelle (logements, production 2026-10-07) complétée des listes
/// véhicules du contrat.
final _meta = _repo.metaDepuis({
  ...jsonDecode(File('test/fixtures/locations/meta.json').readAsStringSync())
      as Map<String, dynamic>,
  'categories_vehicule': [
    {'valeur': 'berline', 'libelle': 'Berline'},
    {'valeur': 'suv', 'libelle': 'SUV / 4x4'},
  ],
  'boites': [
    {'valeur': 'manuelle', 'libelle': 'Manuelle'},
    {'valeur': 'automatique', 'libelle': 'Automatique'},
  ],
  'carburants': [
    {'valeur': 'essence', 'libelle': 'Essence'},
    {'valeur': 'diesel', 'libelle': 'Diesel'},
  ],
  'equipements_vehicule': [
    {'valeur': 'gps', 'libelle': 'GPS'},
    {'valeur': 'bluetooth', 'libelle': 'Bluetooth'},
  ],
});

// Aucun véhicule n'est encore publié en production : les réponses
// ci-dessous suivent le contrat, avec des décimaux en chaîne et des null.

const _jsonPageLoueur = '''
{
  "loueur": {"id": 80, "nom": "Ferké Auto", "logo": null, "couverture": null,
             "telephone_pro": "0700000080", "whatsapp": ""},
  "resultats": [
    {"id": 1, "titre": "Corolla grise", "photo": null,
     "categorie": "berline", "categorie_libelle": "Berline",
     "marque": "Toyota", "modele": "Corolla", "annee": 2019, "nb_places": 5,
     "boite": "automatique", "boite_libelle": "Automatique",
     "carburant": "diesel", "carburant_libelle": "Diesel",
     "climatisation": true, "prix_jour": "25000.00",
     "prix_jour_avec_chauffeur": "35000.00", "chauffeur_disponible": true,
     "chauffeur_obligatoire": false, "localisation_texte": "Ferké - Gare",
     "disponibilite": "disponible"},
    {"id": 2, "titre": "Minibus 15 places", "photo": null,
     "categorie": "minibus", "categorie_libelle": "Minibus",
     "marque": "", "modele": "", "annee": null, "nb_places": 15,
     "boite": "manuelle", "boite_libelle": "Manuelle",
     "carburant": "diesel", "carburant_libelle": "Diesel",
     "climatisation": false, "prix_jour": 40000,
     "prix_jour_avec_chauffeur": 50000, "chauffeur_disponible": false,
     "chauffeur_obligatoire": true, "localisation_texte": "",
     "disponibilite": "disponible"}
  ]
}
''';

const _jsonVehicule = '''
{
  "id": 1, "titre": "Corolla grise", "description": "Entretien à jour.",
  "galerie": [],
  "panoramas": [
    {"id": 22, "image": "https://exemple.test/arriere.jpg",
     "titre": "Banquette arrière", "type_vue": "photo_360", "ordre": 2,
     "est_active": true},
    {"id": 21, "image": "https://exemple.test/avant.jpg", "titre": "Tableau de bord",
     "type_vue": "photo_360", "ordre": 1, "est_active": true}
  ],
  "categorie": "berline", "categorie_libelle": "Berline",
  "marque": "Toyota", "modele": "Corolla", "annee": 2019, "couleur": "Gris",
  "nb_places": 5, "boite": "automatique", "boite_libelle": "Automatique",
  "carburant": "diesel", "carburant_libelle": "Diesel", "climatisation": true,
  "prix_jour": "25000.00", "prix_jour_avec_chauffeur": "35000.00",
  "chauffeur_disponible": true, "chauffeur_obligatoire": false,
  "caution": "100000.00", "km_inclus_par_jour": 0,
  "prix_km_supplementaire": null, "carburant_inclus": false,
  "duree_min_jours": 2, "zone_circulation": "ville",
  "zone_circulation_libelle": "Ville de Ferké uniquement",
  "equipements": ["gps", "bluetooth", "siege_bebe"],
  "localisation_texte": "Ferké - Gare",
  "latitude": "9.5928", "longitude": "-5.1942",
  "loueur": {"id": 80, "nom": "Ferké Auto", "telephone_pro": "0700000080"},
  "autres_vehicules": [
    {"id": 2, "titre": "Minibus 15 places", "photo": null,
     "categorie_libelle": "Minibus", "marque": "", "modele": "", "annee": null,
     "nb_places": 15, "boite_libelle": "Manuelle",
     "carburant_libelle": "Diesel", "climatisation": false,
     "prix_jour": 40000, "prix_jour_avec_chauffeur": 50000,
     "chauffeur_disponible": false, "chauffeur_obligatoire": true,
     "localisation_texte": "", "disponibilite": "disponible"}
  ],
  "periodes_indisponibles": [
    {"date_debut": "2026-10-15", "date_fin": "2026-10-17"},
    {"date_debut": "2026-10-25", "date_fin": "2026-10-25"}
  ]
}
''';

final _page = _repo.pageVehiculesDepuis(jsonDecode(_jsonPageLoueur));
final _vehicule = _repo.vehiculeDepuis(jsonDecode(_jsonVehicule));

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

DateTime _j(int jour, [int mois = 10]) => DateTime(2026, mois, jour);

class _Session extends AuthNotifier {
  _Session(this.utilisateur);
  final Utilisateur? utilisateur;

  @override
  Future<Utilisateur?> build() async => utilisateur;
}

/// Serveur factice des réservations.
class _FauxLocations extends LocationsRepository {
  _FauxLocations() : super(Dio());

  final envois = <Map<String, Object?>>[];

  /// Corps d'un refus 400, renvoyé tel quel par le serveur.
  Map<String, dynamic>? refus;
  List<DemandeReservation> demandes = const [];

  @override
  Future<void> reserverVehicule({
    required int vehiculeId,
    required DateTime du,
    required DateTime au,
    required bool avecChauffeur,
    required String telephone,
    String lieuPriseEnCharge = '',
    String message = '',
  }) async {
    if (refus != null) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: ApiException.fromResponse(400, refus),
      );
    }
    envois.add({
      'objet_id': vehiculeId,
      'date_debut': formatDateIso(du),
      'date_fin': formatDateIso(au),
      'avec_chauffeur': avecChauffeur,
      'lieu_prise_en_charge': lieuPriseEnCharge,
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
  double largeur = 420,
}) async {
  tester.view.physicalSize = Size(largeur, 2600);
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
  // Une image ou une vue 360° en cours de chargement tourne sans fin : la
  // fiche est avancée de quelques images au lieu d'attendre l'immobilité.
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
    test('meta : listes véhicules, et meta logement réelle sans elles', () {
      expect(_meta.categoriesVehicule.map((c) => c.libelle), [
        'Berline',
        'SUV / 4x4',
      ]);
      expect(_meta.boites.last.valeur, 'automatique');
      expect(_meta.carburants.first.libelle, 'Essence');
      expect(_meta.libelleEquipementVehicule('gps'), 'GPS');
      expect(_meta.libelleEquipementVehicule('siege_bebe'), 'siege_bebe');
      // La meta réelle d'avant les véhicules reste lisible.
      final ancienne = _repo.metaDepuis(
        jsonDecode(
          File('test/fixtures/locations/meta.json').readAsStringSync(),
        ),
      );
      expect(ancienne.categoriesVehicule, isEmpty);
      expect(ancienne.libelleEquipement('cuisine'), 'Cuisine équipée');
    });

    test('page loueur : nom, ligne, prix en chaîne, chauffeur', () {
      expect(_page.loueur.nom, 'Ferké Auto');
      final corolla = _page.resultats.first;
      expect(corolla.nomComplet, 'Toyota Corolla 2019');
      expect(corolla.caracteristiques, '5 places · Automatique · Diesel');
      expect(corolla.prixJour, 25000);
      expect(corolla.prixJourAvecChauffeur, 35000);
      expect(corolla.prixAffiche, 25000);
      expect(
        formatPrixJour(corolla.prixAffiche),
        '${formatMontant(25000)}/jour',
      );
      expect(corolla.avecChauffeur, isTrue);
      // Sans marque ni modèle : le titre ; chauffeur imposé : son tarif.
      final minibus = _page.resultats[1];
      expect(minibus.nomComplet, 'Minibus 15 places');
      expect(minibus.annee, isNull);
      expect(minibus.prixAffiche, 50000);
      expect(minibus.avecChauffeur, isTrue);
    });

    test('fiche véhicule', () {
      final v = _vehicule;
      expect(v.nomComplet, 'Toyota Corolla 2019');
      expect(v.couleur, 'Gris');
      expect(v.caution, 100000);
      expect(v.kmIllimite, isTrue);
      expect(v.prixKmSupplementaire, isNull);
      expect(v.carburantInclus, isFalse);
      expect(v.dureeMin, 2);
      expect(v.zone, 'Ville de Ferké uniquement');
      expect(v.copyWith(zoneCirculationLibelle: '').zone, 'ville');
      expect(v.equipements, ['gps', 'bluetooth', 'siege_bebe']);
      expect(v.latitude, 9.5928);
      expect(v.aPosition, isTrue);
      expect(v.loueur?.nom, 'Ferké Auto');
      expect(v.autresVehicules.single.nomComplet, 'Minibus 15 places');
      expect(v.panoramasActifs.map((p) => p.titre), [
        'Tableau de bord',
        'Banquette arrière',
      ]);
      expect(v.periodesIndisponibles.first.debut, _j(15));
      expect(v.periodesIndisponibles.first.fin, _j(17));
      // Durée minimale absente ou nulle : un jour.
      expect(Vehicule.fromJson(const {'id': 3}).dureeMin, 1);
      expect(
        Vehicule.fromJson(const {'id': 3, 'duree_min_jours': 0}).dureeMin,
        1,
      );
    });

    test('demande de réservation : période, chauffeur, montant', () {
      final d = DemandeReservation.fromJson({
        'id': 9,
        'numero': 'RES-0009',
        'nature': 'reservation',
        'nature_libelle': 'Réservation',
        'objet_type': 'vehicule',
        'objet_nom': 'Toyota Corolla 2019',
        'partenaire_nom': 'Ferké Auto',
        'date_souhaitee': null,
        'date_debut': '2026-10-20',
        'date_fin': '2026-10-22',
        'avec_chauffeur': true,
        'lieu_prise_en_charge': 'Gare routière',
        'montant_estime': '105000.00',
        'statut': 'nouvelle',
        'statut_libelle': 'Nouvelle',
      });
      expect(d.estReservation, isTrue);
      expect(d.objetType, 'vehicule');
      expect(d.periodeLisible, 'Du 20/10/2026 au 22/10/2026');
      expect(d.copyWith(dateFin: '2026-10-20').periodeLisible, 'Le 20/10/2026');
      expect(d.avecChauffeur, isTrue);
      expect(d.lieuPriseEnCharge, 'Gare routière');
      expect(d.montantEstime, 105000);
      // Une visite reste une visite.
      final visite = DemandeReservation.fromJson(const {
        'id': 5,
        'nature': 'visite',
        'date_souhaitee': '2026-10-20',
      });
      expect(visite.estReservation, isFalse);
      expect(visite.montantEstime, isNull);
    });

    test('filtre : disponibles par défaut, critères en paramètres', () {
      expect(const FiltreVehicules().parametres, {'disponible': 1});
      expect(const FiltreVehicules().nombre, 0);
      const filtre = FiltreVehicules(
        categorie: 'berline',
        prixMax: 30000,
        placesMin: 5,
        boite: 'automatique',
        avecChauffeur: true,
      );
      expect(filtre.parametres, {
        'disponible': 1,
        'categorie': 'berline',
        'prix_max': 30000,
        'places_min': 5,
        'boite': 'automatique',
        'avec_chauffeur': 1,
      });
      expect(filtre.nombre, 5);
      expect(
        filtre,
        const FiltreVehicules(
          categorie: 'berline',
          prixMax: 30000,
          placesMin: 5,
          boite: 'automatique',
          avecChauffeur: true,
        ),
      );
    });
  });

  group('montant estimé', () {
    test('jours comptés bornes incluses', () {
      expect(nombreJours(_j(10), _j(12)), 3);
      expect(nombreJours(_j(10), _j(10)), 1);
      expect(nombreJours(DateTime(2026, 10, 10, 18), _j(11)), 2);
      // Passage à l'heure d'hiver ou fin de mois : pas de jour perdu.
      expect(nombreJours(_j(24), _j(2, 11)), 10);
      expect(nombreJours(DateTime(2026, 12, 30), DateTime(2027, 1, 2)), 4);
    });

    test('3 jours × 25 000 F = 75 000 F, puis avec chauffeur', () {
      final sans = EstimationLocation.pour(
        _vehicule,
        du: _j(10),
        au: _j(12),
        avecChauffeur: false,
      );
      expect(sans.total, 75000);
      expect(
        sans.libelle,
        '3 jours × ${formatMontant(25000)} = ${formatMontant(75000)}',
      );
      final avec = EstimationLocation.pour(
        _vehicule,
        du: _j(10),
        au: _j(12),
        avecChauffeur: true,
      );
      expect(avec.total, 105000);
      expect(
        EstimationLocation.pour(
          _vehicule,
          du: _j(10),
          au: _j(10),
          avecChauffeur: false,
        ).libelle,
        '1 jour × ${formatMontant(25000)} = ${formatMontant(25000)}',
      );
    });

    test('sans tarif « avec chauffeur » publié : tarif de base', () {
      final v = _vehicule.copyWith(prixJourAvecChauffeur: null);
      expect(v.prixJourPour(avecChauffeur: true), 25000);
    });
  });

  group('dates indisponibles', () {
    final v = _vehicule;

    test('jours réservés, bornes incluses', () {
      expect(v.jourIndisponible(_j(14)), isFalse);
      expect(v.jourIndisponible(_j(15)), isTrue);
      expect(v.jourIndisponible(_j(17)), isTrue);
      expect(v.jourIndisponible(DateTime(2026, 10, 17, 23, 59)), isTrue);
      expect(v.jourIndisponible(_j(18)), isFalse);
      expect(v.jourIndisponible(_j(25)), isTrue);
    });

    test('une plage qui enjambe une période réservée est refusée', () {
      expect(v.plageLibre(_j(10), _j(14)), isTrue);
      expect(v.plageLibre(_j(13), _j(19)), isFalse);
      expect(v.plageLibre(_j(18), _j(24)), isTrue);
    });

    test('calendrier : jours grisés et fin bloquée après une période', () {
      expect(v.jourSelectionnable(_j(16), null, null), isFalse);
      expect(v.jourSelectionnable(_j(12), null, null), isTrue);
      // Début le 12 : la fin ne peut dépasser le 14.
      expect(v.jourSelectionnable(_j(14), _j(12), null), isTrue);
      expect(v.jourSelectionnable(_j(19), _j(12), null), isFalse);
      // Plage terminée : un nouveau début est libre.
      expect(v.jourSelectionnable(_j(19), _j(12), _j(14)), isTrue);
    });

    test('durée minimale et chevauchement', () {
      expect(v.erreurPlage(_j(10), _j(11)), isNull);
      expect(v.erreurPlage(_j(10), _j(10)), contains('Durée minimale'));
      expect(v.erreurPlage(_j(14), _j(16)), contains('déjà réservé'));
      expect(v.erreurPlage(_j(12), _j(10)), isNotNull);
    });
  });

  group('aiguillage loueur_voiture', () {
    test('type de location selon les types de la catégorie', () {
      expect(typeLocation(['loueur_maison']), TypeLocation.logement);
      expect(typeLocation(['loueur_voiture']), TypeLocation.vehicule);
      expect(typeLocation(['restaurateur']), isNull);
    });

    const loueur = PartenaireCategorie(id: 80, nomCommerce: 'Ferké Auto');
    const sansPage = PartenaireCategorie(id: 81, nomCommerce: 'Garage Y');

    final overrides = <Override>[
      departementsProvider.overrideWith(
        (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
      ),
      visiteCategorieProvider(categorieId: 16).overrideWith((ref) async {}),
      partenairesParCategorieProvider(
        slug: 'location-voitures',
      ).overrideWith((ref) => Stream.value(const [loueur, sansPage])),
      for (final id in [80, 81])
        vueVitrineProvider(partenaireId: id).overrideWith((ref) async {}),
      pageLoueurVehiculesProvider(
        partenaireId: 80,
      ).overrideWith((ref) => Stream.value(_page)),
      pageLoueurVehiculesProvider(partenaireId: 81).overrideWith(
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
        categorieId: 16,
        partenaireId: 81,
      ).overrideWith((ref) => Stream.value(const <ArticleListe>[])),
      videosPartenaireProvider(
        partenaireId: 81,
      ).overrideWith((ref) async => const <VideoArticle>[]),
    ];

    const annuaire = EcranPrestataires(
      categorieId: 16,
      categorieNom: 'Location de voitures',
      categorieSlug: 'location-voitures',
      modeTransaction: 'vitrine_chat',
      typesPartenaire: ['loueur_voiture'],
    );

    testWidgets("l'annuaire de la catégorie ne change pas", (tester) async {
      await _monter(tester, annuaire, overrides: overrides);
      expect(find.byType(FiltreLocalites), findsOneWidget);
      expect(find.text('Par région'), findsOneWidget);
      expect(find.byType(GrillePrestataires), findsOneWidget);
      expect(find.text('Ferké Auto'), findsOneWidget);
      expect(find.byType(CarteVehicule), findsNothing);
    });

    testWidgets('toucher un loueur ouvre sa page véhicules', (tester) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Ferké Auto'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranLoueur), findsOneWidget);
      expect(find.byType(EcranArticles), findsNothing);
      expect(find.byType(CarteVehicule), findsNWidgets(2));
      expect(find.byType(CarteLogement), findsNothing);
    });

    testWidgets('partenaire sans page loueur (404) : sa fiche habituelle', (
      tester,
    ) async {
      await _monter(tester, annuaire, overrides: overrides);
      await tester.tap(find.text('Garage Y'));
      await tester.pumpAndSettle();
      expect(find.byType(EcranArticles), findsOneWidget);
      expect(find.text('Loueur introuvable.'), findsNothing);
    });
  });

  group('page loueur véhicules', () {
    const avecChauffeur = FiltreVehicules(avecChauffeur: true);

    testWidgets('cartes, un seul bouton Filtrer, feuille des critères', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranLoueur(partenaireId: 80, type: TypeLocation.vehicule),
        overrides: [
          vueVitrineProvider(partenaireId: 80).overrideWith((ref) async {}),
          pageLoueurVehiculesProvider(
            partenaireId: 80,
          ).overrideWith((ref) => Stream.value(_page)),
          pageLoueurVehiculesProvider(
            partenaireId: 80,
            filtre: avecChauffeur,
          ).overrideWith(
            (ref) => Stream.value(
              _page.copyWith(resultats: [_page.resultats.first]),
            ),
          ),
        ],
      );
      expect(find.text('Ferké Auto'), findsWidgets);
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsNothing);
      expect(find.text('2 véhicules disponibles'), findsOneWidget);
      expect(find.text('Toyota Corolla 2019'), findsOneWidget);
      expect(find.text('5 places · Automatique · Diesel'), findsOneWidget);
      expect(find.text('${formatMontant(25000)}/jour'), findsOneWidget);
      expect(find.text('${formatMontant(50000)}/jour'), findsOneWidget);
      expect(find.text('Avec chauffeur'), findsNWidgets(2));
      expect(find.byType(FilterChip), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);

      await tester.tap(find.text('Filtrer'));
      await tester.pumpAndSettle();
      expect(find.text('Filtrer les véhicules'), findsOneWidget);
      expect(find.text('Catégorie'), findsOneWidget);
      expect(find.text('Prix maximum'), findsOneWidget);
      expect(find.text('Places (minimum)'), findsOneWidget);
      expect(find.text('Boîte de vitesses'), findsOneWidget);

      await tester.tap(find.widgetWithText(SwitchListTile, 'Avec chauffeur'));
      await tester.tap(find.text('Appliquer'));
      await tester.pumpAndSettle();
      expect(find.text('Filtrer (1)'), findsOneWidget);
      expect(find.text('1 véhicule disponible'), findsOneWidget);
      expect(find.text('Minibus 15 places'), findsNothing);
    });

    testWidgets('toucher une carte ouvre la fiche du véhicule', (tester) async {
      await _monter(
        tester,
        const EcranLoueur(partenaireId: 80, type: TypeLocation.vehicule),
        overrides: [
          vueVitrineProvider(partenaireId: 80).overrideWith((ref) async {}),
          pageLoueurVehiculesProvider(
            partenaireId: 80,
          ).overrideWith((ref) => Stream.value(_page)),
          vehiculeDetailProvider(
            id: 1,
          ).overrideWith((ref) => Stream.value(_vehicule)),
        ],
      );
      await tester.tap(find.text('Toyota Corolla 2019'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(EcranVehicule), findsOneWidget);
    });
  });

  group('fiche véhicule', () {
    List<Override> fiche(Vehicule v) => [
      vehiculeDetailProvider(id: v.id).overrideWith((ref) => Stream.value(v)),
    ];

    testWidgets('caractéristiques, tarifs, zone, équipements, actions', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranVehicule(vehiculeId: 1),
        overrides: fiche(_vehicule),
        stabiliser: false,
      );
      expect(find.text('Toyota Corolla 2019'), findsWidgets);
      expect(find.text('Corolla grise'), findsOneWidget);
      expect(find.text('Berline'), findsOneWidget);
      expect(find.text('Ferké - Gare'), findsOneWidget);
      // Caractéristiques en icônes.
      expect(find.text('5 places'), findsOneWidget);
      expect(find.text('Automatique'), findsOneWidget);
      expect(find.text('Diesel'), findsOneWidget);
      expect(find.text('Climatisé'), findsOneWidget);
      expect(find.text('2019'), findsOneWidget);
      expect(find.text('Gris'), findsOneWidget);
      // Tarifs et conditions.
      expect(find.text('Sans chauffeur'), findsOneWidget);
      expect(find.text('${formatMontant(35000)}/jour'), findsOneWidget);
      expect(find.text(formatMontant(100000)), findsOneWidget);
      expect(find.text('Kilométrage illimité'), findsOneWidget);
      expect(find.text('Km supplémentaire'), findsNothing);
      expect(find.text('Non inclus'), findsOneWidget);
      expect(find.text('2 jours'), findsOneWidget);
      expect(find.text('Ville de Ferké uniquement'), findsOneWidget);
      // Équipements : libellés de la meta, valeur brute à défaut.
      expect(find.text('GPS'), findsOneWidget);
      expect(find.text('Bluetooth'), findsOneWidget);
      expect(find.text('siege_bebe'), findsOneWidget);
      // Vue intérieure 360° : la visionneuse de M1.
      expect(find.text('Vue intérieure 360°'), findsOneWidget);
      expect(find.byType(VisiteImmersive), findsOneWidget);
      expect(find.text('Tableau de bord'), findsOneWidget);
      // Autres véhicules du loueur.
      expect(find.text('Autres véhicules de ce loueur'), findsOneWidget);
      expect(find.text('Minibus 15 places'), findsOneWidget);
      // Actions.
      expect(find.text('Itinéraire'), findsOneWidget);
      expect(find.text('Localisation'), findsOneWidget);
      expect(find.text('Réserver'), findsOneWidget);
    });

    testWidgets('kilométrage limité, chauffeur obligatoire', (tester) async {
      await _monter(
        tester,
        const EcranVehicule(vehiculeId: 1),
        overrides: fiche(
          _vehicule.copyWith(
            kmInclusParJour: 200,
            prixKmSupplementaire: 150,
            carburantInclus: true,
            chauffeurObligatoire: true,
            panoramas: const [],
          ),
        ),
      );
      expect(find.text('200 km/jour inclus'), findsOneWidget);
      expect(find.text('${formatMontant(150)}/km'), findsOneWidget);
      expect(find.text('Inclus'), findsOneWidget);
      expect(find.text('Sans chauffeur'), findsNothing);
      expect(find.text('Avec chauffeur (obligatoire)'), findsOneWidget);
    });

    testWidgets('sans panorama ni coordonnées : sections et boutons masqués', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranVehicule(vehiculeId: 1),
        overrides: fiche(
          _vehicule.copyWith(
            panoramas: const [],
            latitude: null,
            longitude: null,
            autresVehicules: const [],
          ),
        ),
      );
      expect(find.text('Vue intérieure 360°'), findsNothing);
      expect(find.text('Itinéraire'), findsNothing);
      expect(find.text('Localisation'), findsNothing);
      expect(find.text('Autres véhicules de ce loueur'), findsNothing);
      expect(find.text('Réserver'), findsOneWidget);
    });
  });

  group('réservation', () {
    Widget bouton(Vehicule v) => Consumer(
      builder: (context, ref, _) => Scaffold(
        body: TextButton(
          onPressed: () => reserverVehicule(context, ref, vehicule: v),
          child: const Text('Ouvrir'),
        ),
      ),
    );

    /// Feuille ouverte avec des dates déjà choisies, une fois la session
    /// chargée (comme derrière le mur d'inscription).
    Widget feuille(Vehicule v, DateTimeRange? plage) => Consumer(
      builder: (context, ref, _) => Scaffold(
        body: ref.watch(authProvider).value == null
            ? const SizedBox.shrink()
            : FeuilleReservationVehicule(
                key: ValueKey(v),
                vehicule: v,
                plageInitiale: plage,
              ),
      ),
    );

    final troisJours = DateTimeRange(start: _j(10, 11), end: _j(12, 11));

    testWidgets("visiteur : invitation à s'inscrire", (tester) async {
      await _monter(tester, bouton(_vehicule), utilisateur: null);
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.text('Enregistrez-vous pour continuer'), findsOneWidget);
      expect(find.byType(FeuilleReservationVehicule), findsNothing);
    });

    testWidgets('dates requises, durée minimale rappelée', (tester) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        bouton(_vehicule),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
        // Le calendrier plein écran du test (police large) déborde à 420.
        largeur: 800,
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(find.byType(FeuilleReservationVehicule), findsOneWidget);
      expect(find.text('Durée minimale : 2 jours'), findsOneWidget);
      expect(
        find.text('Choisissez vos dates pour voir le montant.'),
        findsOneWidget,
      );
      expect(find.widgetWithText(TextFormField, '0707070707'), findsOneWidget);
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(find.text('Choisissez vos dates.'), findsOneWidget);
      expect(serveur.envois, isEmpty);

      // Le calendrier s'ouvre sur la plage de dates.
      await tester.tap(find.text('Choisir les dates'));
      await tester.pumpAndSettle();
      expect(find.text('Dates de location'), findsOneWidget);
    });

    testWidgets('montant recalculé en direct, envoi et confirmation', (
      tester,
    ) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        feuille(_vehicule, troisJours),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(
        find.text('Du 10/11/2026 au 12/11/2026 · 3 jours'),
        findsOneWidget,
      );
      expect(
        find.text(
          '3 jours × ${formatMontant(25000)} = ${formatMontant(75000)}',
        ),
        findsOneWidget,
      );
      await tester.tap(find.widgetWithText(SwitchListTile, 'Avec chauffeur'));
      await tester.pump();
      expect(
        find.text(
          '3 jours × ${formatMontant(35000)} = ${formatMontant(105000)}',
        ),
        findsOneWidget,
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Lieu de prise en charge'),
        'Gare routière',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Message (optionnel)'),
        'Départ tôt',
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(serveur.envois.single, {
        'objet_id': 1,
        'date_debut': '2026-11-10',
        'date_fin': '2026-11-12',
        'avec_chauffeur': true,
        'lieu_prise_en_charge': 'Gare routière',
        'telephone_contact': '0707070707',
        'message': 'Départ tôt',
      });
    });

    testWidgets('chauffeur : masqué sans chauffeur, forcé si obligatoire', (
      tester,
    ) async {
      await _monter(
        tester,
        feuille(_vehicule.copyWith(chauffeurDisponible: false), troisJours),
      );
      expect(find.byType(SwitchListTile), findsNothing);

      await _monter(
        tester,
        feuille(_vehicule.copyWith(chauffeurObligatoire: true), troisJours),
      );
      final interrupteur = tester.widget<SwitchListTile>(
        find.byType(SwitchListTile),
      );
      expect(interrupteur.value, isTrue);
      expect(interrupteur.onChanged, isNull);
      expect(
        find.text('Chauffeur obligatoire pour ce véhicule'),
        findsOneWidget,
      );
      expect(
        find.text(
          '3 jours × ${formatMontant(35000)} = ${formatMontant(105000)}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('durée trop courte : rien n\'est envoyé', (tester) async {
      final serveur = _FauxLocations();
      await _monter(
        tester,
        feuille(_vehicule, DateTimeRange(start: _j(10, 11), end: _j(10, 11))),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(
        find.text('Durée minimale de location : 2 jours.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(serveur.envois, isEmpty);
    });

    testWidgets('refus 400 du serveur affiché dans la feuille', (tester) async {
      final serveur = _FauxLocations()
        ..refus = {
          'erreur': 'Réservation impossible.',
          'details': {
            'date_debut': ['Le véhicule est déjà réservé sur ces dates.'],
          },
        };
      await _monter(
        tester,
        feuille(_vehicule, troisJours),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      await tester.tap(find.text('Envoyer la réservation'));
      await tester.pumpAndSettle();
      expect(
        find.text('Le véhicule est déjà réservé sur ces dates.'),
        findsOneWidget,
      );
      expect(find.byType(FeuilleReservationVehicule), findsOneWidget);
    });

    test('erreur 400 {erreur, details} : message lisible', () {
      expect(
        ApiException.fromResponse(400, {
          'erreur': 'Le chauffeur est obligatoire pour ce véhicule.',
          'details': <String, dynamic>{},
        }).messageLisible,
        'Le chauffeur est obligatoire pour ce véhicule.',
      );
      expect(
        ApiException.fromResponse(400, {
          'erreur': 'Dates invalides.',
          'details': {
            'date_fin': ['Durée minimale : 2 jours.'],
          },
        }).messageLisible,
        'Durée minimale : 2 jours.',
      );
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
      await LocationsRepository(dio).reserverVehicule(
        vehiculeId: 1,
        du: _j(20),
        au: _j(22),
        avecChauffeur: false,
        lieuPriseEnCharge: 'Gare',
        telephone: '0707070707',
        message: 'Bonjour',
      );
      expect(requetes.single.path, '/api/v1/reservations/');
      expect(requetes.single.method, 'POST');
      expect(requetes.single.data, {
        'objet_id': 1,
        'nature': 'reservation',
        'date_debut': '2026-10-20',
        'date_fin': '2026-10-22',
        'avec_chauffeur': false,
        'lieu_prise_en_charge': 'Gare',
        'message': 'Bonjour',
        'telephone_contact': '0707070707',
      });
    });

    test('lectures : chemins et filtres du contrat', () async {
      final requetes = <RequestOptions>[];
      final dio = Dio(BaseOptions(baseUrl: 'https://exemple.test'))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              requetes.add(options);
              handler.resolve(
                Response(requestOptions: options, statusCode: 200, data: {}),
              );
            },
          ),
        );
      final repo = LocationsRepository(dio);
      await repo.vehiculesBrut(80, const FiltreVehicules(placesMin: 7));
      await repo.vehiculeBrut(1);
      expect(
        requetes.first.path,
        '/api/v1/locations/partenaires/80/vehicules/',
      );
      expect(requetes.first.queryParameters, {
        'disponible': 1,
        'places_min': 7,
      });
      expect(requetes.last.path, '/api/v1/locations/vehicules/1/');
    });
  });

  group('mes demandes', () {
    const visite = DemandeReservation(
      id: 5,
      nature: 'visite',
      objetNom: 'Villa 3 pièces à Bromakoté',
      dateSouhaitee: '2026-10-20',
      statut: 'en_attente',
      statutLibelle: 'En attente',
    );
    const reservation = DemandeReservation(
      id: 9,
      nature: 'reservation',
      objetType: 'vehicule',
      objetNom: 'Toyota Corolla 2019',
      partenaireNom: 'Ferké Auto',
      dateDebut: '2026-10-20',
      dateFin: '2026-10-22',
      avecChauffeur: true,
      lieuPriseEnCharge: 'Gare routière',
      montantEstime: 105000,
      statut: 'nouvelle',
      statutLibelle: 'Nouvelle',
    );

    testWidgets('visites et réservations, avec dates, chauffeur, montant', (
      tester,
    ) async {
      final serveur = _FauxLocations()..demandes = const [reservation, visite];
      await _monter(
        tester,
        const EcranMesDemandes(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Mes demandes'), findsOneWidget);
      expect(find.text('Toyota Corolla 2019'), findsOneWidget);
      expect(find.text('Du 20/10/2026 au 22/10/2026'), findsOneWidget);
      expect(find.text('Avec chauffeur'), findsOneWidget);
      expect(find.text('Prise en charge : Gare routière'), findsOneWidget);
      expect(
        find.text('Montant estimé : ${formatMontant(105000)}'),
        findsOneWidget,
      );
      // La visite garde son affichage.
      expect(find.text('Villa 3 pièces à Bromakoté'), findsOneWidget);
      expect(find.text('Visite souhaitée le 20/10/2026'), findsOneWidget);
      expect(find.text('Annuler la demande'), findsNWidgets(2));
    });

    testWidgets('réservation sans chauffeur ni montant : lignes masquées', (
      tester,
    ) async {
      final serveur = _FauxLocations()
        ..demandes = [
          reservation.copyWith(
            avecChauffeur: false,
            montantEstime: null,
            lieuPriseEnCharge: '',
          ),
        ];
      await _monter(
        tester,
        const EcranMesDemandes(),
        overrides: [locationsRepositoryProvider.overrideWithValue(serveur)],
      );
      expect(find.text('Du 20/10/2026 au 22/10/2026'), findsOneWidget);
      expect(find.text('Avec chauffeur'), findsNothing);
      expect(find.textContaining('Montant estimé'), findsNothing);
      expect(find.textContaining('Visite souhaitée'), findsNothing);
    });
  });
}
