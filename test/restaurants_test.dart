import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_repository.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/commande_plat.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurant.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/feuille_infos_restaurant.dart';
import 'package:poufiret/fonctionnalites/restaurants/widgets/feuille_plat.dart';
import 'package:poufiret/global/carte/carte_poufiret.dart';
import 'package:poufiret/global/carte/services_google.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/ui/format_montant.dart';
import 'package:dio/dio.dart';

/// Réponses RÉELLES de production, capturées le 2026-10-05 et rangées telles
/// quelles dans test/fixtures/restaurants/. À cette date la carte, les menus
/// sont encore vides.
Object? _capture(String nom) =>
    jsonDecode(File('test/fixtures/restaurants/$nom.json').readAsStringSync());

/// Fiche complète : enveloppe de la fiche réelle (statut et coordonnées à la
/// racine), garnie d'une carte et d'un menu aux formats du contrat — lignes
/// `plat, plat_nom, plat_image, prix_effectif, stock_restant, est_epuise`,
/// décimaux en chaîne.
const _jsonComplet = '''
{
  "id": 53, "nom": "Chez Capi", "description": "", "logo": null,
  "couverture": "https://exemple.test/couverture.jpg",
  "adresse": "", "quartier": "Résidentiel", "ville": "Ferké",
  "telephone_pro": "0777782290", "whatsapp": "0777782290",
  "latitude": 9.5928, "longitude": -5.1942,
  "est_ouvert": true, "prochaine_ouverture": null, "message_statut": "Ferme à 22h",
  "fiche": {
    "telephones": [{"id": 1, "libelle": "Salle", "numero": "0101010101", "ordre": 0}],
    "adresse_reperes": "Face à la gare", "facebook": "", "instagram": "", "tiktok": "",
    "specialites": ["Poulet braisé", "Poisson"],
    "services": ["livraison", "emporter"],
    "delai_preparation_min": 20,
    "horaires": [
      {"jour_semaine": 0, "ouvert": true, "heure_ouverture": "11:00:00",
       "heure_fermeture": "22:00:00", "pause_debut": null, "pause_fin": null, "note": null}
    ]
  },
  "menus_du_jour": {
    "midi": {
      "id": 7, "service": "midi", "titre": null,
      "heure_debut": "11:00:00", "heure_fin": "15:00:00",
      "heure_limite_commande": "14:00:00", "commandable": true,
      "lignes": [
        {"id": 70, "plat": 101, "plat_nom": "Poulet braisé",
         "plat_image": "https://exemple.test/poulet.jpg",
         "prix_menu": "5000.00", "prix_effectif": "5000.00",
         "stock_initial": 10, "stock_restant": 3, "est_epuise": false, "ordre": 0},
        {"id": 71, "plat": 102, "plat_nom": "Riz gras", "plat_image": null,
         "prix_menu": null, "prix_effectif": "1500.00",
         "stock_initial": 5, "stock_restant": 0, "est_epuise": true, "ordre": 1}
      ]
    },
    "soir": null, "journee": null
  },
  "menus_en_vigueur_maintenant": {"midi": 7},
  "carte": [
    {"id": 1, "nom": "Grillades", "description": null, "icone": "🔥", "ordre": 0,
     "plats": [
       {"id": 101, "nom": "Poulet braisé", "description": "Poulet fermier",
        "prix": "6000.00", "prix_promotion": null, "prix_effectif": "6000.00",
        "est_en_promotion": false, "est_disponible": true, "est_epuise": false,
        "temps_preparation_min": 25,
        "images": [{"id": 1, "plat": 101, "image": "https://exemple.test/poulet.jpg",
                    "legende": null, "ordre": 0, "est_principale": true, "est_active": true}],
        "variantes": [
          {"id": 11, "article": 101, "nom": "Entier", "prix_supplement": "0.00",
           "est_par_defaut": true, "ordre": 0, "est_active": true},
          {"id": 12, "article": 101, "nom": "Demi", "prix_supplement": "-2500.00",
           "est_par_defaut": false, "ordre": 1, "est_active": true}
        ],
        "groupes_options": [
          {"id": 21, "article": 101, "libelle": "Accompagnement",
           "min_choix": 1, "max_choix": 1, "ordre": 0, "est_actif": true,
           "options": [
             {"id": 31, "groupe": 21, "nom": "Attiéké", "prix_supplement": "0.00", "ordre": 0, "est_actif": true},
             {"id": 32, "groupe": 21, "nom": "Alloco", "prix_supplement": "1000.00", "ordre": 1, "est_actif": true}
           ]},
          {"id": 22, "article": 101, "libelle": "Sauces",
           "min_choix": 0, "max_choix": 2, "ordre": 1, "est_actif": true,
           "options": [
             {"id": 41, "groupe": 22, "nom": "Piment", "prix_supplement": "0.00", "ordre": 0, "est_actif": true},
             {"id": 42, "groupe": 22, "nom": "Moutarde", "prix_supplement": "200.00", "ordre": 1, "est_actif": true},
             {"id": 43, "groupe": 22, "nom": "Mayonnaise", "prix_supplement": "200.00", "ordre": 2, "est_actif": true}
           ]}
        ]}
     ]},
    {"id": 2, "nom": "Boissons", "description": null, "icone": null, "ordre": 1,
     "plats": [
       {"id": 102, "nom": "Riz gras", "description": null, "prix": 1500,
        "prix_effectif": 1500, "est_disponible": true, "est_epuise": true,
        "images": [], "variantes": [], "groupes_options": []},
       {"id": 103, "nom": "Bissap", "description": null, "prix": 500,
        "prix_effectif": 500, "images": [], "variantes": [], "groupes_options": []}
     ]}
  ]
}
''';

final _repo = RestaurantsRepository(Dio());

Restaurant _complet({Map<String, dynamic> statut = const {}}) =>
    _repo.detailDepuis({...jsonDecode(_jsonComplet) as Map, ...statut});

final _midi = DateTime(2026, 10, 5, 12);

/// Serveur qui refuse tout ajout au panier (restaurant fermé).
class _CommandesRefusees extends OrdersRepository {
  _CommandesRefusees(this.message) : super(dio: Dio());

  final String message;
  int tentatives = 0;

  @override
  Future<Panier> ajouterLigne({
    int? articleId,
    required int quantite,
    int? varianteId,
    int? ligneMenuId,
    List<int>? optionIds,
    List<int>? supplementIds,
    String? noteSpeciale,
  }) async {
    tentatives++;
    throw DioException(
      requestOptions: RequestOptions(),
      error: ApiException.fromResponse(400, {
        'erreur': true,
        'message': message,
      }),
    );
  }
}

void main() {
  final restaurant = _complet();
  final poulet = restaurant.platParId(101)!;
  final entier = poulet.variantes[0];
  final demi = poulet.variantes[1];
  final accompagnement = poulet.groupesOptions[0];
  final sauces = poulet.groupesOptions[1];

  group('format des montants', () {
    test('« 7 000 F » avec espaces insécables', () {
      expect(formatMontant(7000), '7 000 F');
      expect(formatMontant(500), '500 F');
      expect(formatMontant(1250000), '1 250 000 F');
      expect(formatSupplement(1000), '+1 000 F');
    });
  });

  group('parsing', () {
    test('fiche réelle (Chez Capi) : statut à la racine, carte vide', () {
      final r = _repo.detailDepuis(_capture('fiche_53'));
      expect(r.id, 53);
      expect(r.nom, 'Chez Capi');
      expect(r.logo, '');
      expect(r.couverture, '');
      expect(r.quartier, 'Résidencetiel');
      expect(r.ville, 'Ferké');
      expect(r.whatsapp, '0777782290');
      expect(r.latitude, isNull);
      expect(r.fiche.delaiPreparationMin, 20);
      expect(r.fiche.horaires, isEmpty);
      expect(r.menus, isEmpty);
      expect(r.carte, isEmpty);
      // Sans horaires : fermé, et le serveur dit pourquoi.
      expect(r.estOuvert, isFalse);
      expect(r.prochaineOuverture, isNull);
      expect(r.messageStatut, 'Horaires non renseignés');
      expect(r.estFerme, isTrue);
    });

    test('fiche complète : carte, variantes, options, menus', () {
      expect(restaurant.estOuvert, isTrue);
      expect(restaurant.messageStatut, 'Ferme à 22h');
      expect(restaurant.latitude, 9.5928);
      expect(restaurant.longitude, -5.1942);
      expect(restaurant.fiche.services, ['livraison', 'emporter']);
      expect(restaurant.fiche.telephones.single.numero, '0101010101');
      expect(restaurant.fiche.horaires.single.heureOuverture, '11:00:00');

      expect(restaurant.carte.map((s) => s.nom), ['Grillades', 'Boissons']);
      // Décimaux en chaîne → entiers.
      expect(poulet.prix, 6000);
      expect(poulet.prixEffectif, 6000);
      expect(poulet.images, ['https://exemple.test/poulet.jpg']);
      expect(poulet.tempsPreparationMin, 25);
      expect(demi.prixSupplement, -2500);
      expect(entier.estParDefaut, isTrue);
      expect(accompagnement.libelle, 'Accompagnement');
      expect(accompagnement.options[1].prixSupplement, 1000);
      expect(sauces.maxChoix, 2);

      final menu = restaurant.menus.single;
      expect(menu.service, 'midi');
      expect(menu.commandable, isTrue);
      expect(menu.heureDebut, '11:00:00');
      expect(menu.heureFin, '15:00:00');
      expect(menu.heureLimiteCommande, '14:00:00');
      expect(restaurant.servicesEnVigueur, ['midi']);
      final ligne = menu.lignes[0];
      expect(ligne.platId, 101);
      expect(ligne.platNom, 'Poulet braisé');
      expect(ligne.image, 'https://exemple.test/poulet.jpg');
      expect(ligne.prixEffectif, 5000);
      expect(ligne.stockRestant, 3);
      expect(menu.lignes[1].epuisee, isTrue);
      expect(restaurant.platDeLigne(ligne).id, 101);
    });

    test('ligne de menu : stock null = illimité, plat hors carte', () {
      final r = _repo.detailDepuis({
        ...jsonDecode(_jsonComplet) as Map,
        'menus_du_jour': {
          'midi': null,
          'soir': null,
          'journee': {
            'id': 9,
            'titre': 'Plat du jour',
            'service': 'journee',
            'heure_debut': '08:00:00',
            'heure_fin': '22:00:00',
            'heure_limite_commande': null,
            'commandable': true,
            'lignes': [
              {
                'id': 90,
                'plat': 999,
                'plat_nom': 'Foutou',
                'plat_image': null,
                'prix_effectif': '2000.00',
                'stock_restant': null,
                'est_epuise': false,
              },
            ],
          },
        },
      });
      final ligne = r.menus.single.lignes.single;
      expect(r.menus.single.titre, 'Plat du jour');
      expect(ligne.stockRestant, isNull);
      expect(ligne.epuisee, isFalse);
      expect(quantiteMax(ligne), isNull);
      // Plat sans section : absent de la carte publique, mais toujours
      // affichable et commandable depuis le menu.
      expect(r.platParId(999), isNull);
      final plat = r.platDeLigne(ligne);
      expect(plat.nom, 'Foutou');
      expect(prixUnitaire(plat, ligne: ligne), 2000);
    });

    test('ligne de panier : variante et options', () {
      final ligne = LignePanier.fromJson({
        'id': 1,
        'article': null,
        'ligne_menu': 70,
        'article_nom': 'Poulet braisé',
        'variante_nom': 'Demi',
        'options': [
          {'id': 32, 'nom': 'Alloco', 'prix_supplement': '1000.00'},
          {'id': 41, 'nom': 'Piment', 'prix_supplement': '0.00'},
        ],
      });
      expect(ligne.ligneMenu, 70);
      expect(ligne.detailChoix, 'Demi · Alloco (+1 000 F) · Piment');
    });
  });

  group('calcul du prix', () {
    test('variante = prix du plat + supplément (négatif possible)', () {
      expect(prixVariante(poulet, entier), 6000);
      expect(prixVariante(poulet, demi), 3500);
      expect(prixAPartirDe(poulet), 3500);
      expect(aPrixVariable(poulet), isTrue);
      expect(varianteParDefaut(poulet), entier);
    });

    test('variante + options + quantité', () {
      expect(prixUnitaire(poulet, variante: demi, optionIds: {32}), 4500);
      expect(
        prixTotal(poulet, variante: demi, optionIds: {32, 42}, quantite: 2),
        (3500 + 1000 + 200) * 2,
      );
      expect(prixTotal(poulet, variante: entier, quantite: 3), 18000);
    });

    test('menu du jour : prix du menu, sans supplément de variante', () {
      final ligne = restaurant.menus.single.lignes[0];
      expect(prixUnitaire(poulet, ligne: ligne, variante: demi), 5000);
      expect(
        prixTotal(poulet, ligne: ligne, optionIds: {32}, quantite: 2),
        12000,
      );
      expect(quantiteMax(ligne), 3);
    });
  });

  group('validation des groupes', () {
    test('libellés de contrainte', () {
      expect(libelleContrainte(accompagnement), 'Choisissez 1');
      expect(libelleContrainte(sauces), "Jusqu'à 2");
      expect(estChoixUnique(accompagnement), isTrue);
      expect(estChoixUnique(sauces), isFalse);
    });

    test('minimum non atteint, puis sélection valide', () {
      expect(erreurSelection(poulet, {}), contains('Accompagnement'));
      expect(erreurSelection(poulet, {31}), isNull);
      expect(erreurSelection(poulet, {31, 41, 42}), isNull);
    });

    test('maximum dépassé', () {
      expect(erreurGroupe(sauces, {41, 42, 43}), contains('2 choix'));
    });

    test('bascule : radio remplace, cases plafonnées', () {
      // Choix unique : la nouvelle option remplace l'ancienne.
      expect(basculerOption(accompagnement, {31}, 32), {32});
      // Obligatoire : ne se décoche pas.
      expect(basculerOption(accompagnement, {32}, 32), {32});
      // Cases : plafond à 2, le troisième choix est ignoré.
      expect(basculerOption(sauces, {41, 42}, 43), {41, 42});
      expect(basculerOption(sauces, {41, 42}, 42), {41});
    });
  });

  group('désactivation', () {
    final menu = restaurant.menus.single;

    test('plat commandable', () {
      expect(
        motifIndisponible(
          restaurant: restaurant,
          plat: poulet,
          maintenant: _midi,
        ),
        isNull,
      );
    });

    test('restaurant fermé : rien n\'est bloqué côté app', () {
      // Le serveur reste l'arbitre : il refuse la commande, l'app relaie.
      final sansHoraires = _repo.detailDepuis(_capture('fiche_53'));
      expect(sansHoraires.estFerme, isTrue);
      expect(
        motifIndisponible(
          restaurant: sansHoraires,
          plat: poulet,
          maintenant: _midi,
        ),
        isNull,
      );
    });

    test('plat épuisé', () {
      expect(
        motifIndisponible(
          restaurant: restaurant,
          plat: restaurant.platParId(102)!,
          maintenant: _midi,
        ),
        'Ce plat est épuisé',
      );
    });

    test('ligne de menu épuisée', () {
      expect(
        motifIndisponible(
          restaurant: restaurant,
          plat: poulet,
          ligne: menu.lignes[1],
          menu: menu,
          maintenant: _midi,
        ),
        'Ce plat du menu est épuisé',
      );
    });

    test('heure limite dépassée', () {
      expect(heureLimiteDepassee(menu, _midi), isFalse);
      expect(
        motifIndisponible(
          restaurant: restaurant,
          plat: poulet,
          ligne: menu.lignes[0],
          menu: menu,
          maintenant: DateTime(2026, 10, 5, 14, 30),
        ),
        'Commandes closes depuis 14h',
      );
    });
  });

  group('écrans', () {
    Future<void> monter(
      WidgetTester tester,
      Restaurant r,
      Widget Function(BuildContext) ecran,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            restaurantDetailProvider(
              id: r.id,
            ).overrideWith((ref) => Stream.value(r)),
            vueVitrineProvider(partenaireId: r.id).overrideWith((ref) async {}),
            paniersProvider.overrideWith((ref) async => const <Panier>[]),
          ],
          child: MaterialApp(home: Builder(builder: ecran)),
        ),
      );
      await tester.pumpAndSettle();
    }

    // Sans photo : aucun appel réseau pendant le test.
    final sansPhotos = restaurant.copyWith(
      couverture: '',
      carte: [
        for (final s in restaurant.carte)
          s.copyWith(
            plats: [for (final p in s.plats) p.copyWith(images: const [])],
          ),
      ],
    );

    FilledButton boutonAjout(WidgetTester tester) => tester.widget(
      find.ancestor(
        of: find.textContaining(RegExp('Ajouter au panier|Indisponible')),
        matching: find.byType(FilledButton),
      ),
    );

    testWidgets('fiche plat : total en direct, bouton après validation', (
      tester,
    ) async {
      await monter(
        tester,
        sansPhotos,
        (_) => Scaffold(body: FeuillePlat(restaurantId: 53, platId: 101)),
      );
      // Variante par défaut présélectionnée, accompagnement manquant.
      expect(find.text('Entier'), findsOneWidget);
      expect(find.textContaining('6 000 F'), findsWidgets);
      expect(boutonAjout(tester).onPressed, isNull);

      await tester.tap(find.text('Demi'));
      await tester.tap(find.text('Alloco'));
      await tester.pump();
      expect(find.text('Ajouter au panier · 4 500 F'), findsOneWidget);
      expect(boutonAjout(tester).onPressed, isNotNull);

      await tester.tap(find.byTooltip('Plus'));
      await tester.pump();
      expect(find.text('Ajouter au panier · 9 000 F'), findsOneWidget);
    });

    testWidgets('restaurant fermé : ajout possible, refus du serveur notifié', (
      tester,
    ) async {
      final ferme = sansPhotos.copyWith(
        estOuvert: false,
        messageStatut: 'Horaires non renseignés',
      );
      final commandes = _CommandesRefusees('Horaires non renseignés');
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            restaurantDetailProvider(
              id: 53,
            ).overrideWith((ref) => Stream.value(ferme)),
            ordersRepositoryProvider.overrideWithValue(commandes),
            paniersProvider.overrideWith((ref) async => const <Panier>[]),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () =>
                      ouvrirFeuillePlat(context, restaurantId: 53, platId: 103),
                  child: const Text('Ouvrir'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();

      // Aucune mention de fermeture, et le bouton reste actif.
      expect(find.textContaining('Fermé'), findsNothing);
      expect(find.text('Indisponible'), findsNothing);
      expect(boutonAjout(tester).onPressed, isNotNull);

      await tester.tap(find.text('Ajouter au panier · 500\u00A0F'));
      await tester.pumpAndSettle();

      // Le serveur a refusé : feuille refermée, son message en notification.
      expect(commandes.tentatives, 1);
      expect(find.byType(FeuillePlat), findsNothing);
      expect(
        find.descendant(
          of: find.byType(SnackBar),
          matching: find.text('Horaires non renseignés'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('fiche plat désactivée si le plat est épuisé', (tester) async {
      await monter(
        tester,
        sansPhotos,
        (_) => Scaffold(body: FeuillePlat(restaurantId: 53, platId: 102)),
      );
      expect(find.text('Ce plat est épuisé'), findsOneWidget);
      expect(boutonAjout(tester).onPressed, isNull);
    });

    testWidgets('page restaurant : menu du jour, carte, onglets, recherche', (
      tester,
    ) async {
      await monter(
        tester,
        sansPhotos,
        (_) => const EcranRestaurant(restaurantId: 53),
      );
      expect(find.text('Ouvert'), findsNothing);
      expect(find.text('Ferme à 22h'), findsNothing);
      // « Commandable jusqu'à 14h » ou « Commandes closes depuis 14h »,
      // selon l'heure à laquelle le test tourne.
      expect(find.textContaining('14h'), findsOneWidget);
      expect(find.text('Plus que 3'), findsOneWidget);
      expect(find.text('Épuisé'), findsWidgets);

      // Onglet « Boissons » : la carte défile jusqu'à la section.
      await tester.dragUntilVisible(
        find.text('Boissons').first,
        find.byType(CustomScrollView),
        const Offset(0, -200),
      );
      await tester.tap(find.text('Boissons').first);
      await tester.pumpAndSettle();
      expect(find.text('Bissap'), findsOneWidget);
      // L'onglet de la section atteinte est l'onglet actif.
      FontWeight? graisse(String onglet) =>
          tester.widget<Text>(find.text(onglet).first).style?.fontWeight;
      expect(graisse('Boissons'), FontWeight.w700);
      expect(graisse('Grillades'), FontWeight.w600);

      // Suivi du défilement : revenir en haut de la carte réactive le
      // premier onglet.
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 150));
      await tester.pumpAndSettle();
      expect(graisse('Grillades'), FontWeight.w700);
      expect(graisse('Boissons'), FontWeight.w600);
      await tester.tap(find.text('Boissons').first);
      await tester.pumpAndSettle();

      // Recherche dans la carte : seules les sections concernées restent.
      await tester.enterText(find.byType(TextField), 'bissap');
      await tester.pumpAndSettle();
      expect(find.text('Bissap'), findsOneWidget);
      expect(find.text('🔥 Grillades'), findsNothing);

      // Un tap sur un plat ouvre sa fiche.
      await tester.tap(find.text('Bissap'));
      await tester.pumpAndSettle();
      expect(find.text('Ajouter au panier · 500 F'), findsOneWidget);
    });

    testWidgets('page restaurant fermée : ni badge ni bandeau, carte lisible', (
      tester,
    ) async {
      final ferme = sansPhotos.copyWith(
        estOuvert: false,
        messageStatut: 'Horaires non renseignés',
      );
      await monter(
        tester,
        ferme,
        (_) => const EcranRestaurant(restaurantId: 53),
      );
      expect(find.textContaining('Fermé'), findsNothing);
      expect(find.text('Horaires non renseignés'), findsNothing);
      expect(find.text('Poulet braisé'), findsWidgets);
    });

    testWidgets('feuille Infos : carte seulement avec des coordonnées', (
      tester,
    ) async {
      Future<void> ouvrir(Restaurant r) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              servicesGoogleProvider.overrideWith((ref) async => false),
            ],
            child: MaterialApp(
              home: Builder(
                builder: (context) => Scaffold(
                  body: TextButton(
                    onPressed: () => ouvrirFeuilleInfos(context, r),
                    child: const Text('Infos'),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Infos'));
        await tester.pumpAndSettle();
      }

      await ouvrir(sansPhotos);
      await tester.scrollUntilVisible(
        find.byType(CartePoufiret),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.byType(CartePoufiret), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await ouvrir(sansPhotos.copyWith(latitude: null, longitude: null));
      expect(find.text('Horaires'), findsOneWidget);
      expect(find.byType(CartePoufiret), findsNothing);
    });
  });
}
