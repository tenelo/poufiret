import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_repository.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/localisation.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/localite.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/quartier.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/cascade_localisation.dart';
import 'package:poufiret/fonctionnalites/partenaire/metier_domaine/partenaire_vitrine.dart';
import 'package:poufiret/global/errors/api_exception.dart';

/// Réponses RÉELLES de production (2026-10-05), dans test/fixtures/.
Object? _capture(String chemin) =>
    jsonDecode(File('test/fixtures/$chemin.json').readAsStringSync());

final _repo = GeoRepository(dio: Dio());

const _departements = [
  Departement(id: 1, nom: 'Ferké'),
  Departement(id: 2, nom: 'Kong'),
];
const _ferke = [
  Localite(id: 1, nom: 'Ferké'),
  Localite(id: 5, nom: 'Togoniéré'),
];
const _quartiersFerke = [
  Quartier(id: 3, nom: 'Bromakoté'),
  Quartier(id: 9, nom: 'Résidentiel'),
];

/// Formulaire minimal qui tient la sélection, comme les écrans.
class _Banc extends StatefulWidget {
  const _Banc({
    required this.initiale,
    this.departementModifiable = true,
    this.ancienneSaisie = '',
    this.erreurs = const {},
  });

  final SelectionLocalisation initiale;
  final bool departementModifiable;
  final String ancienneSaisie;
  final Map<NiveauLocalisation, String> erreurs;

  @override
  State<_Banc> createState() => _BancState();
}

class _BancState extends State<_Banc> {
  final cle = GlobalKey<FormState>();
  late SelectionLocalisation selection = widget.initiale;

  @override
  Widget build(BuildContext context) => Form(
    key: cle,
    child: SingleChildScrollView(
      child: CascadeLocalisation(
        selection: selection,
        departementModifiable: widget.departementModifiable,
        departementNom: 'Ferké',
        ancienneSaisie: widget.ancienneSaisie,
        erreurs: widget.erreurs,
        onChange: (s) => setState(() => selection = s),
      ),
    ),
  );
}

void main() {
  group('parsing', () {
    test('localités et quartiers réels : {"resultats": [{id, nom}]}', () {
      final localites = _repo.localitesDepuis(
        _capture('geo/localites_departement_1'),
      );
      expect(localites.single.id, 1);
      expect(localites.single.nom, 'Ferké');
      expect(
        _repo.localitesDepuis(_capture('geo/localites_departement_2')),
        isEmpty,
      );

      final quartiers = _repo.quartiersDeLocaliteDepuis(
        _capture('geo/quartiers_localite_1'),
      );
      expect(quartiers, hasLength(9));
      expect(quartiers.first.nom, 'Bromakoté');
      expect(quartiers.map((q) => q.id), contains(9));
    });

    test('vitrine réelle rattachée (Chez Sara)', () {
      final v = PartenaireVitrine.fromJson(
        _capture('partenaires/vitrine_54') as Map<String, dynamic>,
      );
      expect(v.localiteId, 1);
      expect(v.localiteNom, 'Ferké');
      expect(v.quartierId, 3);
      expect(v.quartierNom, 'Bromakoté');
      // Localité et département homonymes : le département n'est pas répété.
      expect(v.localisationLisible, 'Bromakoté, Ferké');
    });

    test('vitrine réelle non rattachée (Chez Capi) : anciens textes', () {
      final v = PartenaireVitrine.fromJson(
        _capture('partenaires/vitrine_53') as Map<String, dynamic>,
      );
      expect(v.localiteId, isNull);
      expect(v.quartierNom, isNull);
      expect(v.localisationLisible, 'Résidencetiel, Ferké');
    });
  });

  group('affichage', () {
    test('« Quartier, Localité (Département) »', () {
      expect(
        formatLocalisation(
          quartierNom: 'Centre',
          localiteNom: 'Togoniéré',
          departement: 'Ferké',
        ),
        'Centre, Togoniéré (Ferké)',
      );
      expect(
        formatLocalisation(localiteNom: 'Togoniéré', departement: 'Ferké'),
        'Togoniéré (Ferké)',
      );
    });

    test('repli sur les anciens textes, niveau par niveau', () {
      expect(
        formatLocalisation(
          localiteNom: 'Togoniéré',
          departement: 'Ferké',
          ancienQuartier: 'Marché',
          ancienneVille: 'Ancienne',
        ),
        'Marché, Togoniéré (Ferké)',
      );
      expect(
        formatLocalisation(ancienQuartier: 'Gare', ancienneVille: 'Kong'),
        'Gare, Kong',
      );
      expect(formatLocalisation(departement: 'Ferké'), 'Ferké');
      expect(formatLocalisation(), '');
    });
  });

  group('sélection', () {
    const complete = SelectionLocalisation(
      departement: 1,
      localite: 1,
      quartier: 3,
    );

    test('changer un niveau réinitialise les suivants', () {
      expect(
        complete.avecDepartement(2),
        const SelectionLocalisation(departement: 2),
      );
      expect(
        complete.avecLocalite(5),
        const SelectionLocalisation(departement: 1, localite: 5),
      );
      expect(complete.avecQuartier(null).localite, 1);
      // Rechoisir la même valeur ne perd rien.
      expect(complete.avecDepartement(1), complete);
      expect(complete.avecLocalite(1), complete);
    });

    test('champs envoyés au backend', () {
      expect(complete.versJson(avecDepartement: true), {
        'departement': 1,
        'localite_id': 1,
        'quartier_id': 3,
      });
      // Profil : pas de département, et un quartier retiré part en null.
      expect(complete.avecQuartier(null).versJson(), {
        'localite_id': 1,
        'quartier_id': null,
      });
    });

    test('erreurs 400 rangées par champ', () {
      final erreur = DioException(
        requestOptions: RequestOptions(),
        error: ApiException.fromResponse(400, {
          'localite_id': ["Cette localité n'appartient pas au département."],
          'quartier_id': "Ce quartier n'appartient pas à la localité.",
          'nom_commerce': ['Nom trop court.'],
        }),
      );
      expect(erreursLocalisation(erreur), {
        NiveauLocalisation.localite:
            "Cette localité n'appartient pas au département.",
        NiveauLocalisation.quartier:
            "Ce quartier n'appartient pas à la localité.",
      });
      expect(erreursLocalisation(Exception('réseau')), isEmpty);
    });
  });

  group('cascade', () {
    Future<_BancState> monter(
      WidgetTester tester, {
      SelectionLocalisation initiale = const SelectionLocalisation(),
      bool departementModifiable = true,
      String ancienneSaisie = '',
      Map<NiveauLocalisation, String> erreurs = const {},
      Stream<List<Localite>> Function()? localitesFerke,
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            departementsProvider.overrideWith(
              (ref) => Stream.value(_departements),
            ),
            localitesProvider(departementId: 1).overrideWith(
              (ref) => localitesFerke?.call() ?? Stream.value(_ferke),
            ),
            localitesProvider(
              departementId: 2,
            ).overrideWith((ref) => Stream.value(const <Localite>[])),
            quartiersDeLocaliteProvider(
              localiteId: 1,
            ).overrideWith((ref) => Stream.value(_quartiersFerke)),
            quartiersDeLocaliteProvider(
              localiteId: 5,
            ).overrideWith((ref) => Stream.value(const <Quartier>[])),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: _Banc(
                initiale: initiale,
                departementModifiable: departementModifiable,
                ancienneSaisie: ancienneSaisie,
                erreurs: erreurs,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return tester.state(find.byType(_Banc));
    }

    Future<void> choisir(
      WidgetTester tester,
      String champ,
      String valeur,
    ) async {
      await tester.tap(
        find
            .ancestor(
              of: find.textContaining(champ),
              matching: find.byWidgetPredicate(
                (w) => w is DropdownButtonFormField,
              ),
            )
            .first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(valeur).last);
      await tester.pumpAndSettle();
    }

    testWidgets('choix en cascade, puis réinitialisation', (tester) async {
      final banc = await monter(tester);
      // Tant que le département n'est pas choisi : ni localité ni quartier.
      expect(find.textContaining('Localité'), findsNothing);
      expect(find.textContaining('Quartier'), findsNothing);

      await choisir(tester, 'Département', 'Ferké');
      expect(find.text('Localité *'), findsOneWidget);
      expect(find.textContaining('Quartier'), findsNothing);

      await choisir(tester, 'Localité', 'Ferké');
      await choisir(tester, 'Quartier', 'Bromakoté');
      expect(
        banc.selection,
        const SelectionLocalisation(departement: 1, localite: 1, quartier: 3),
      );

      // Changer de localité vide le quartier.
      await choisir(tester, 'Localité', 'Togoniéré');
      expect(
        banc.selection,
        const SelectionLocalisation(departement: 1, localite: 5),
      );
      expect(find.text('Bromakoté'), findsNothing);
      expect(
        find.text('Aucun quartier enregistré pour cette localité.'),
        findsOneWidget,
      );

      // Changer de département vide la localité et le quartier.
      await choisir(tester, 'Département', 'Kong');
      expect(banc.selection, const SelectionLocalisation(departement: 2));
      expect(find.textContaining('Quartier'), findsNothing);
    });

    testWidgets('liste vide : message, sans bloquer le formulaire', (
      tester,
    ) async {
      final banc = await monter(
        tester,
        initiale: const SelectionLocalisation(departement: 2),
      );
      expect(
        find.text(
          'Aucune localité pour ce département. '
          "Contactez l'administration.",
        ),
        findsOneWidget,
      );
      expect(banc.cle.currentState!.validate(), isTrue);
    });

    testWidgets('localité requise, quartier optionnel', (tester) async {
      final banc = await monter(
        tester,
        initiale: const SelectionLocalisation(departement: 1),
      );
      expect(banc.cle.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Choisissez votre localité.'), findsOneWidget);

      await choisir(tester, 'Localité', 'Ferké');
      expect(find.text('Quartier (optionnel)'), findsOneWidget);
      expect(banc.cle.currentState!.validate(), isTrue);
    });

    testWidgets('préremplissage et département en lecture seule', (
      tester,
    ) async {
      final banc = await monter(
        tester,
        departementModifiable: false,
        initiale: const SelectionLocalisation(
          departement: 1,
          localite: 1,
          quartier: 9,
        ),
      );
      expect(find.text("Géré par l'administration"), findsOneWidget);
      // Département (lecture seule) et localité portent le même nom.
      expect(find.text('Ferké'), findsNWidgets(2));
      expect(find.text('Résidentiel'), findsOneWidget);
      expect(find.textContaining('Ancienne saisie'), findsNothing);

      // Le quartier peut être retiré.
      await choisir(tester, 'Quartier', '— Aucun —');
      expect(banc.selection.quartier, isNull);
      expect(banc.selection.localite, 1);
    });

    testWidgets('ancienne saisie libre rappelée tant que rien n\'est choisi', (
      tester,
    ) async {
      await monter(
        tester,
        departementModifiable: false,
        initiale: const SelectionLocalisation(departement: 1),
        ancienneSaisie: 'Résidencetiel, Ferké',
      );
      expect(
        find.text(
          'Ancienne saisie : Résidencetiel, Ferké — choisissez dans la liste',
        ),
        findsOneWidget,
      );
      await choisir(tester, 'Localité', 'Ferké');
      expect(find.textContaining('Ancienne saisie'), findsNothing);
    });

    testWidgets('rattachement à une localité retirée : non présélectionnée', (
      tester,
    ) async {
      final banc = await monter(
        tester,
        initiale: const SelectionLocalisation(departement: 1, localite: 5),
        localitesFerke: () =>
            Stream.value(const [Localite(id: 1, nom: 'Ferké')]),
      );
      expect(find.text('Togoniéré'), findsNothing);
      expect(banc.cle.currentState!.validate(), isFalse);
    });

    testWidgets('erreur réseau avec « Réessayer »', (tester) async {
      // Riverpod réessaie de lui-même : la panne dure jusqu'au geste.
      var enPanne = true;
      await monter(
        tester,
        initiale: const SelectionLocalisation(departement: 1),
        localitesFerke: () => enPanne
            ? Stream.error(Exception('hors ligne'))
            : Stream.value(_ferke),
      );
      expect(find.text('Localités indisponibles'), findsOneWidget);

      enPanne = false;
      await tester.tap(find.text('Réessayer'));
      await tester.pumpAndSettle();
      expect(find.text('Localités indisponibles'), findsNothing);
      expect(find.text('Localité *'), findsOneWidget);
    });

    testWidgets('erreurs du backend sous les champs', (tester) async {
      await monter(
        tester,
        initiale: const SelectionLocalisation(
          departement: 1,
          localite: 1,
          quartier: 3,
        ),
        erreurs: const {
          NiveauLocalisation.localite: 'Localité hors du département.',
          NiveauLocalisation.quartier: 'Quartier hors de la localité.',
        },
      );
      expect(find.text('Localité hors du département.'), findsOneWidget);
      expect(find.text('Quartier hors de la localité.'), findsOneWidget);
    });
  });

  group('ligne de localisation des cartes de partenaires', () {
    test('complet', () {
      expect(
        ligneLocalisation(
          localite: 'Ferké',
          quartier: 'Bromakoté',
          secteur: 'Rue Princesse',
        ),
        'Ferké - Bromakoté - Rue Princesse',
      );
    });

    test('quartier absent', () {
      expect(
        ligneLocalisation(localite: 'Ferké', secteur: 'Rue Princesse'),
        'Ferké - - Rue Princesse',
      );
    });

    test('secteur absent', () {
      expect(
        ligneLocalisation(localite: 'Ferké', quartier: 'Bromakoté'),
        'Ferké - Bromakoté -',
      );
    });

    test('quartier et secteur absents', () {
      expect(ligneLocalisation(localite: 'Ferké'), 'Ferké - -');
      expect(ligneLocalisation(), '');
    });

    test(
      'texte long : rendu entier par la fonction (tronqué à l\'affichage)',
      () {
        const secteur =
            'Derrière la grande mosquée, deuxième rue à gauche après le marché';
        expect(
          ligneLocalisation(
            localite: 'Ferkessédougou',
            quartier: 'Résidentiel',
            secteur: secteur,
          ),
          'Ferkessédougou - Résidentiel - $secteur',
        );
      },
    );

    test('sources : noms rattachés, sinon anciens textes', () {
      const rattache = PartenaireCategorie(
        id: 54,
        departement: 'Ferké',
        ville: 'Ancienne ville',
        quartier: 'Ancien quartier',
        secteur: 'Rue Princesse',
        localiteNom: 'Ferké',
        quartierNom: 'Bromakoté',
      );
      expect(rattache.ligneLocalisation, 'Ferké - Bromakoté - Rue Princesse');

      const ancien = PartenaireCategorie(
        id: 53,
        ville: 'Kong',
        quartier: 'Marché',
      );
      expect(ancien.ligneLocalisation, 'Kong - Marché -');
    });

    test(
      'annuaire réel : ni localité ni ville, le département en tient lieu',
      () {
        final p = PartenaireCategorie.fromJson(
          (_capture('catalogue/annuaire_restaurants') as List).first
              as Map<String, dynamic>,
        );
        expect(p.nomCommerce, 'Business Center');
        expect(p.ligneLocalisation, 'Ferké - Gare -');
      },
    );

    testWidgets('carte : une seule ligne, tronquée par « … »', (tester) async {
      const ligne =
          'Ferké - Bromakoté - Derrière la grande mosquée, '
          'deuxième rue à gauche après le marché';
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: GrillePrestataires(
                prestataires: const [
                  PartenaireCategorie(
                    id: 54,
                    nomCommerce: 'Chez Sara',
                    localiteNom: 'Ferké',
                    quartierNom: 'Bromakoté',
                    secteur:
                        'Derrière la grande mosquée, '
                        'deuxième rue à gauche après le marché',
                  ),
                ],
                onRefresh: () async {},
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );
      final texte = tester.widget<Text>(find.text(ligne));
      expect(texte.maxLines, 1);
      expect(texte.overflow, TextOverflow.ellipsis);
      expect(tester.takeException(), isNull); // aucun débordement
    });
  });
}
