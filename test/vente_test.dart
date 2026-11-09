import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/locations/donnees/mes_annonces_repository.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/location_models.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/vehicule_models.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/vente_models.dart';
import 'package:poufiret/fonctionnalites/locations/screens/ecran_loueur.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/elements_vente.dart';
import 'package:poufiret/fonctionnalites/locations/widgets/formulaire_vente.dart';

// Champs de vente, tels que le méta les décrit (extrait).
const _vente = {
  'champ': 'mode',
  'valeurs': ['vente', 'location_vente'],
};
const _location = {
  'champ': 'mode',
  'valeurs': ['location', 'location_vente'],
};
final _champs = [
  for (final c in [
    {
      'cle': 'mode',
      'libelle': "Type d'annonce",
      'type': 'choix',
      'obligatoire': true,
      'defaut': 'location',
      'visible_si': null,
    },
    {
      'cle': 'prix',
      'libelle': 'Prix de location (FCFA)',
      'type': 'entier',
      'obligatoire': true,
      'visible_si': _location,
    },
    {
      'cle': 'prix_vente',
      'libelle': 'Prix de vente (FCFA)',
      'type': 'entier',
      'obligatoire': true,
      'visible_si': _vente,
    },
    {
      'cle': 'prix_negociable',
      'libelle': 'Prix négociable',
      'type': 'booleen',
      'obligatoire': false,
      'defaut': true,
      'visible_si': _vente,
    },
    {
      'cle': 'kilometrage',
      'libelle': 'Kilométrage',
      'type': 'entier',
      'obligatoire': false,
      'visible_si': _vente,
    },
  ])
    ChampVente.fromJson(c),
];

class _AnnoncesFaux extends MesAnnoncesRepository {
  _AnnoncesFaux() : super(Dio());

  final envois = <Map<String, Object?>>[];

  @override
  Future<AnnonceGestion> modifier(
    TypeAnnonce type,
    int id,
    Map<String, Object?> donnees,
  ) async {
    envois.add(donnees);
    return AnnonceGestion.fromJson({'id': id, 'nom': 'Corolla', ...donnees});
  }
}

void main() {
  group('modèles', () {
    test('carte véhicule : champs de vente lus (prix en texte décimal)', () {
      final v = VehiculeResume.fromJson({
        'id': 5,
        'marque': 'Toyota',
        'mode': 'location_vente',
        'mode_libelle': 'Location ou vente',
        'prix_vente': '12500000.00',
        'prix_negociable': true,
        'vendu': false,
        'vendu_le': null,
        'etat': 'france_au_revoir',
        'etat_libelle': 'France au revoir (occasion importée)',
        'kilometrage': 85000,
        'dedouane': true,
        'carte_grise': null,
        'visite_technique_valide_jusqu_au': '2027-03-31',
        'assurance_valide_jusqu_au': null,
        'nb_proprietaires': 2,
      });
      expect(v.vente.mode, ModeAnnonce.locationVente);
      expect(v.vente.prixVente, 12500000);
      expect(v.vente.prixVenteLisible, '12 500 000 FCFA');
      expect(v.vente.aVendre, isTrue);
      // Seulement les champs renseignés.
      expect(v.vente.lignesVehicule, [
        ('État', 'France au revoir (occasion importée)'),
        ('Kilométrage', '85 000 km'),
        ('Dédouané', 'Oui'),
        ("Visite technique valide jusqu'au", '31/03/2027'),
        ('Propriétaires précédents', '2'),
      ]);
    });

    test('ancienne réponse sans champs de vente : location, rien à vendre', () {
      final v = VehiculeResume.fromJson({'id': 1, 'prix_jour': 25000});
      expect(v.vente.mode, ModeAnnonce.location);
      expect(v.vente.prixVente, isNull);
      expect(v.vente.vendu, isFalse);
      expect(v.vente.aVendre, isFalse);
      expect(v.vente.lignesVehicule, isEmpty);
    });

    test('maison : document, terrain, lotie ; valeurs null ignorées', () {
      final l = Logement.fromJson({
        'id': 9,
        'titre': 'Villa',
        'mode': 'vente',
        'prix_vente': 45000000,
        'vendu': true,
        'vendu_le': '2026-11-09T10:00:00Z',
        'type_document': 'acd',
        'type_document_libelle': 'ACD (arrêté de concession définitive)',
        'surface_terrain_m2': 600,
        'est_lotie': null,
      });
      expect(l.vente.mode, ModeAnnonce.vente);
      expect(l.vente.vendu, isTrue);
      expect(l.vente.lignesLogement, [
        ('Document', 'ACD (arrêté de concession définitive)'),
        ('Surface du terrain', '600 m²'),
      ]);
    });

    test('demande d\'achat : libellé, sans dates', () {
      final d = DemandeReservation.fromJson({
        'id': 1,
        'nature': 'achat',
        'nature_libelle': 'Achat (information ou visite)',
        'montant_estime': '45000000.00',
      });
      expect(d.estAchat, isTrue);
      expect(d.natureLisible, "Demande d'achat");
      expect(d.estReservation, isFalse);
      expect(d.montantEstime, 45000000);
    });

    test('méta : champs de vente et condition visible_si', () {
      final meta = MetaLocations.fromJson({
        'modes': [
          {'valeur': 'vente', 'libelle': 'Vente'},
        ],
        'champs_vente': {
          'vehicule': [
            {'cle': 'prix_vente', 'type': 'entier', 'visible_si': _vente},
          ],
          'logement': [],
        },
      });
      final champ = meta.champsVente.vehicule.single;
      expect(champ.visible({'mode': 'location'}), isFalse);
      expect(champ.visible({'mode': 'location_vente'}), isTrue);
      expect(meta.modes.single.valeur, 'vente');
    });
  });

  group('règle des boutons', () {
    test('location / vente / location_vente / vendu', () {
      final location = ActionsAnnonce.pour(ModeAnnonce.location, vendu: false);
      expect((location.louer, location.acheter), (true, false));
      final vente = ActionsAnnonce.pour(ModeAnnonce.vente, vendu: false);
      expect((vente.louer, vente.acheter), (false, true));
      final lesDeux = ActionsAnnonce.pour(
        ModeAnnonce.locationVente,
        vendu: false,
      );
      expect((lesDeux.louer, lesDeux.acheter), (true, true));
      final vendu = ActionsAnnonce.pour(ModeAnnonce.locationVente, vendu: true);
      expect((vendu.louer, vendu.acheter, vendu.vendu), (false, false, true));
    });

    Future<void> monter(WidgetTester tester, ActionsAnnonce actions) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionsFicheVente(
                actions: actions,
                louer: FilledButton(
                  onPressed: () {},
                  child: const Text('Réserver'),
                ),
                onInteresse: () {},
              ),
            ),
          ),
        );

    testWidgets('vente seule : « Je suis intéressé », pas de réservation', (
      tester,
    ) async {
      await monter(
        tester,
        ActionsAnnonce.pour(ModeAnnonce.vente, vendu: false),
      );
      expect(find.text('Je suis intéressé'), findsOneWidget);
      expect(find.text('Réserver'), findsNothing);
    });

    testWidgets('location et vente : les deux boutons', (tester) async {
      await monter(
        tester,
        ActionsAnnonce.pour(ModeAnnonce.locationVente, vendu: false),
      );
      expect(find.text('Je suis intéressé'), findsOneWidget);
      expect(find.text('Réserver'), findsOneWidget);
    });

    testWidgets('vendu : bandeau, aucun bouton', (tester) async {
      await monter(tester, ActionsAnnonce.pour(ModeAnnonce.vente, vendu: true));
      expect(find.text('Vendu'), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);
    });

    test('sélecteur Louer | Acheter : seulement avec les deux types', () {
      const loc = InfosVente();
      const vente = InfosVente(mode: ModeAnnonce.vente);
      const lesDeux = InfosVente(mode: ModeAnnonce.locationVente);
      expect(aLesDeuxModes([loc, loc]), isFalse);
      expect(aLesDeuxModes([vente]), isFalse);
      expect(aLesDeuxModes([loc, vente]), isTrue);
      expect(aLesDeuxModes([lesDeux]), isTrue);
      // Le mode part dans la requête, sans compter comme un filtre.
      final f = const FiltreVehicules().avecMode('vente');
      expect(f.parametres['mode'], 'vente');
      expect(f.nombre, 0);
      expect(const FiltreLogements().avecMode(null).parametres, {
        'disponible': 1,
      });
    });
  });

  group('formulaire de vente', () {
    test('règle des prix identique au serveur', () {
      expect(
        erreursPrixAnnonce(
          mode: ModeAnnonce.location,
          prixLocation: null,
          prixVente: 100,
        ).keys,
        ['prix'],
      );
      expect(
        erreursPrixAnnonce(
          mode: ModeAnnonce.vente,
          prixLocation: null,
          prixVente: null,
        ).keys,
        ['prix_vente'],
      );
      expect(
        erreursPrixAnnonce(
          mode: ModeAnnonce.locationVente,
          prixLocation: null,
          prixVente: null,
        ).keys,
        unorderedEquals(['prix', 'prix_vente']),
      );
      expect(
        erreursPrixAnnonce(
          mode: ModeAnnonce.vente,
          prixLocation: null,
          prixVente: 5000000,
        ),
        isEmpty,
      );
    });

    test('seuls les champs visibles sont envoyés', () {
      final donnees = donneesVente({
        'mode': 'location',
        'prix': 25000,
        'prix_vente': 9000000,
        'kilometrage': 1000,
      }, _champs);
      expect(donnees, {'mode': 'location', 'prix': 25000});
    });

    testWidgets('champs de vente selon le type ; prix de vente exigé', (
      tester,
    ) async {
      final repo = _AnnoncesFaux();
      final annonce = AnnonceGestion.fromJson({
        'id': 7,
        'nom': 'Corolla',
        'prix': '25000.00',
        'mode': 'location',
      });
      await tester.pumpWidget(
        ProviderScope(
          overrides: [mesAnnoncesRepositoryProvider.overrideWithValue(repo)],
          child: MaterialApp(
            home: Scaffold(
              body: FormulaireVente(
                type: TypeAnnonce.vehicule,
                annonce: annonce,
                champs: _champs,
              ),
            ),
          ),
        ),
      );
      // Location : pas de champs de vente.
      expect(find.text('Prix de vente (FCFA) *'), findsNothing);
      expect(find.text('Kilométrage'), findsNothing);

      // Passage en « Vente » : champs de vente affichés, prix de location masqué.
      await tester.tap(find.byKey(const ValueKey('champ-mode')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Vente').last);
      await tester.pumpAndSettle();
      expect(find.text('Prix de vente (FCFA) *'), findsOneWidget);
      expect(find.text('Kilométrage'), findsOneWidget);
      expect(find.text('Prix de location (FCFA) *'), findsNothing);

      // Sans prix de vente : refus local, rien d'envoyé.
      await tester.tap(find.text('Enregistrer'));
      await tester.pump();
      expect(
        find.text(
          'Le prix de vente est obligatoire pour une annonce à vendre.',
        ),
        findsOneWidget,
      );
      expect(repo.envois, isEmpty);

      await tester.enterText(
        find.byKey(const ValueKey('champ-prix_vente')),
        '9000000',
      );
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();
      expect(repo.envois.single, {
        'mode': 'vente',
        'prix_vente': 9000000,
        'prix_negociable': true,
        'kilometrage': null,
      });
    });
  });
}
