import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/commerces/donnees/commerces_providers.dart';
import 'package:poufiret/fonctionnalites/commerces/donnees/commerces_repository.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/catalogue_commerce.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/elevage.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/fiche_produit.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/meta_gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/ecran_catalogue.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/ecran_produit.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/tuile_elevage.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/filtre_localites.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_repository.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/global/ui/format_montant.dart';

// Le gabarit « elevage » est développé en parallèle côté serveur : les
// réponses ci-dessous suivent le contrat (décimaux en chaîne, booléens,
// champs parfois à la racine du produit).

/// Espace insécable, comme dans les montants et les quantités affichés.
const _nb = ' ';

final _restaurants = RestaurantsRepository(Dio());

Restaurant _fiche(Map<String, dynamic> json) =>
    _restaurants.detailDepuis(jsonDecode(jsonEncode(json)));

Map<String, dynamic> _produit(
  int id,
  String nom, {
  Object prix = '3500.00',
  Map<String, dynamic> fiche = const {},
  bool commandable = true,
}) => {
  'id': id,
  'nom': nom,
  'prix': prix,
  'prix_effectif': prix,
  'images': [],
  'commandable': commandable,
  'fiche_specifique': fiche,
};

final _poulet = _produit(
  1,
  'Poulet bicyclette',
  fiche: {
    'espece': 'poulet',
    'espece_libelle': 'Poulet',
    'etat_vente': 'vivant',
    'unite_prix': 'piece',
    'poids_moyen_kg': '2.50',
    'age': '4',
    'quantite_disponible': 12,
    'commande_avance_jours': null,
    'livraison_possible': true,
  },
);

final _porc = _produit(
  2,
  'Porc découpé',
  prix: '2500.00',
  fiche: {
    'espece': 'porc',
    'etat_vente': 'decoupe',
    'unite_prix': 'kg',
    'quantite_disponible': '4.5',
    'livraison_possible': false,
  },
);

final _pintade = _produit(
  3,
  'Pintade abattue',
  prix: 4000,
  fiche: {
    'espece': 'pintade',
    'etat_vente': {'valeur': 'abattu_entier', 'libelle': 'Abattu entier'},
    'unite_prix': 'piece',
    'commande_avance_jours': '3',
    'livraison_possible': 'true',
  },
);

final _mouton = _produit(
  4,
  'Mouton de Tabaski',
  prix: 90000,
  fiche: {'espece': 'mouton', 'etat_vente': 'vivant', 'quantite_disponible': 0},
);

final _eleveur = _fiche({
  'id': 90,
  'gabarit': 'elevage',
  'nom': 'Ferme Koné',
  'couverture': 'https://exemple.test/ferme.jpg',
  'telephone_pro': '0700000090',
  'whatsapp': '0700000090',
  'est_ouvert': true,
  'pagination_publique': false,
  'sections': [
    {
      'id': 1,
      'nom': 'Volailles',
      'produits': [_poulet, _pintade],
    },
    {
      'id': 2,
      'nom': 'Porcs et ovins',
      'produits': [_porc, _mouton],
    },
  ],
});

Plat _plat(Map<String, dynamic> json) =>
    _eleveur.carte.expand((s) => s.plats).firstWhere((p) => p.id == json['id']);

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

class _Session extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => _utilisateur;
}

class _FauxPanier extends OrdersRepository {
  _FauxPanier() : super(dio: Dio());

  final ajouts = <(int?, num)>[];

  @override
  Future<Panier> ajouterLigne({
    int? articleId,
    required num quantite,
    int? varianteId,
    int? ligneMenuId,
    List<int>? optionIds,
    List<int>? supplementIds,
    String? noteSpeciale,
  }) async {
    ajouts.add((articleId, quantite));
    return const Panier(id: 1);
  }
}

/// Aucun appel paginé ne doit partir : les produits sont joints à la fiche.
class _PasDePagination extends CommercesRepository {
  _PasDePagination() : super(Dio());

  int appels = 0;

  @override
  Future<PageProduits> produits(RequeteProduits requete, {int page = 1}) async {
    appels++;
    return const PageProduits(count: 0, results: []);
  }
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override> overrides = const [],
  bool stabiliser = true,
}) async {
  tester.view.physicalSize = const Size(420, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Session.new),
        metaGabaritsProvider.overrideWith(
          (ref) => Stream.value(MetaGabarits.vide),
        ),
        paniersProvider.overrideWith((ref) async => const <Panier>[]),
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
  if (stabiliser) {
    await tester.pumpAndSettle();
  } else {
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }
}

List<Override> _page(CommercesRepository serveur) => [
  vueVitrineProvider(partenaireId: 90).overrideWith((ref) async {}),
  restaurantDetailProvider(
    id: 90,
  ).overrideWith((ref) => Stream.value(_eleveur)),
  commercesRepositoryProvider.overrideWithValue(serveur),
];

Override _detail(Plat p) => produitDetailProvider(
  id: p.id,
).overrideWith((ref) => Stream.value(ProduitDetail(produit: p)));

void main() {
  group('parsing de fiche_specifique', () {
    test('poulet vivant à la pièce, en stock, livrable', () {
      final p = _plat(_poulet);
      expect(p.espece, 'Poulet');
      expect(p.etatVente, 'Vivant');
      expect(p.unitePrix, UnitePrix.piece);
      expect(p.poidsMoyenKg, 2.5);
      expect(p.poidsMoyenLisible, 'Poids moyen : 2,5${_nb}kg');
      expect(p.age, '4 mois');
      expect(p.quantiteDisponible, 12);
      expect(p.commandeAvanceJours, isNull);
      expect(p.livraisonPossible, isTrue);
      expect(p.disponibiliteElevage, 'En stock : 12');
      expect(p.stockAZero, isFalse);
      expect(p.toutEpuise, isFalse);
    });

    test('porc découpé au kilo : stock décimal, sans livraison', () {
      final p = _plat(_porc);
      expect(p.etatVente, 'Découpé');
      expect(p.espece, 'porc');
      expect(p.unitePrix, UnitePrix.kg);
      expect(p.prixEffectif, 2500);
      expect(p.quantiteDisponible, 4.5);
      expect(p.disponibiliteElevage, 'En stock : 4,5${_nb}kg');
      expect(p.livraisonPossible, isFalse);
    });

    test('pintade sur commande : objet {valeur, libelle}, délai en texte', () {
      final p = _plat(_pintade);
      expect(p.etatVente, 'Abattu entier');
      expect(p.valeur('etat_vente'), 'abattu_entier');
      expect(p.quantiteDisponible, isNull);
      expect(p.commandeAvanceJours, 3);
      expect(p.disponibiliteElevage, "Sur commande · 3 jours à l'avance");
      expect(p.livraisonPossible, isTrue);
      // Unité absente : à la pièce.
      expect(Plat.fromJson(const {'id': 9}).unitePrix, UnitePrix.piece);
    });

    test('stock à zéro : épuisé', () {
      final p = _plat(_mouton);
      expect(p.stockAZero, isTrue);
      expect(p.toutEpuise, isTrue);
      expect(p.disponibiliteElevage, '');
    });

    test('champs à la racine du produit repris', () {
      final p = Plat.fromJson(const {
        'id': 5,
        'espece': 'lapin',
        'unite_prix': 'kg',
        'etat_vente': 'abattu_entier',
        'poids_moyen_kg': 1.8,
      });
      expect(p.espece, 'lapin');
      expect(p.unitePrix, UnitePrix.kg);
      expect(p.etatVente, 'Abattu entier');
      expect(p.poidsMoyenKg, 1.8);
    });

    test('filtres : espèce, état de vente, livraison', () {
      final champs = MetaGabarits.vide.champsFiltre(Gabarit.elevage);
      expect(champs.map((c) => c.cle), [
        'espece',
        'etat_vente',
        'livraison_possible',
      ]);
      expect(champs[1].choix.map((c) => c.libelle), [
        'Vivant',
        'Abattu entier',
        'Découpé',
      ]);
      const livrables = FiltreCatalogue(
        valeurs: {'livraison_possible': 'true'},
      );
      expect(livrables.garde(_plat(_poulet)), isTrue);
      expect(livrables.garde(_plat(_porc)), isFalse);
      expect(
        const FiltreCatalogue(
          valeurs: {'etat_vente': 'abattu_entier'},
        ).garde(_plat(_pintade)),
        isTrue,
      );
    });
  });

  group('calcul pièce / kg', () {
    test('prix à l\'unité', () {
      expect(
        formatPrixUnite(3500, UnitePrix.piece),
        '${formatMontant(3500)} / pièce',
      );
      expect(
        formatPrixUnite(2500, UnitePrix.kg),
        '${formatMontant(2500)} / kg',
      );
    });

    test('quantité ramenée sur la grille de l\'unité et sous le stock', () {
      // Pièces : entières, au moins 1.
      expect(ajusterQuantite(2.7, UnitePrix.piece), 2);
      expect(ajusterQuantite(0, UnitePrix.piece), 1);
      expect(ajusterQuantite(15, UnitePrix.piece, max: 12), 12);
      // Kg : par 0,5, au moins 0,5.
      expect(ajusterQuantite(1.7, UnitePrix.kg), 1.5);
      expect(ajusterQuantite(0, UnitePrix.kg), 0.5);
      expect(ajusterQuantite(6, UnitePrix.kg, max: 4.5), 4.5);
      expect(ajusterQuantite(2.0, UnitePrix.kg), isA<int>());
    });

    test('total : prix × quantité, arrondi au franc', () {
      expect(totalElevage(3500, 3), 10500);
      expect(totalElevage(2500, 2.5), 6250);
      expect(totalElevage(1999, 0.5), 1000);
      expect(
        libelleTotalElevage(2500, 2.5, UnitePrix.kg),
        '2,5${_nb}kg × ${formatMontant(2500)} = ${formatMontant(6250)}',
      );
      expect(
        libelleTotalElevage(3500, 3, UnitePrix.piece),
        '3 pièces × ${formatMontant(3500)} = ${formatMontant(10500)}',
      );
      expect(formatQuantiteUnite(1, UnitePrix.piece), '1 pièce');
    });

    test('panier : quantité décimale lue, pas de 0,5 au kilo', () {
      final kg = LignePanier.fromJson(const {
        'id': 1,
        'quantite': '2.50',
        'unite_prix': 'kg',
      });
      expect(kg.quantite, 2.5);
      expect(kg.pasQuantite, 0.5);
      expect(kg.quantiteLisible, '2,5${_nb}kg');
      expect(kg.nbArticles, 1);
      final pieces = LignePanier.fromJson(const {'id': 2, 'quantite': 3});
      expect(pieces.quantite, 3);
      expect(pieces.pasQuantite, 1);
      expect(pieces.quantiteLisible, '3');
      expect(pieces.nbArticles, 3);
      expect(
        LignePanier.fromJson(const {'id': 3, 'quantite': '2.00'}).quantite,
        isA<int>(),
      );
    });
  });

  group('aiguillage elevage', () {
    test('gabarit de la carte ou type eleveur', () {
      expect(gabaritPartenaire(gabarit: 'elevage'), Gabarit.elevage);
      expect(gabaritPartenaire(typesPartenaire: ['eleveur']), Gabarit.elevage);
      expect(gabaritPartenaire(typesCategorie: ['eleveur']), Gabarit.elevage);
    });

    const partenaires = [
      PartenaireCategorie(
        id: 90,
        nomCommerce: 'Ferme Koné',
        gabarit: 'elevage',
      ),
      PartenaireCategorie(
        id: 91,
        nomCommerce: 'Porcherie Ouattara',
        typesPartenaire: ['eleveur'],
      ),
    ];

    List<Override> overrides() => [
      departementsProvider.overrideWith(
        (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
      ),
      visiteCategorieProvider(categorieId: 30).overrideWith((ref) async {}),
      partenairesParCategorieProvider(
        slug: 'elevage',
      ).overrideWith((ref) => Stream.value(partenaires)),
      for (final p in partenaires) ...[
        vueVitrineProvider(partenaireId: p.id).overrideWith((ref) async {}),
        restaurantDetailProvider(
          id: p.id,
        ).overrideWith((ref) => Stream.value(_eleveur.copyWith(id: p.id))),
      ],
      commercesRepositoryProvider.overrideWithValue(_PasDePagination()),
    ];

    const annuaire = EcranPrestataires(
      categorieId: 30,
      categorieNom: 'Élevage',
      categorieSlug: 'elevage',
      modeTransaction: 'vitrine_chat',
    );

    testWidgets("l'annuaire ne change pas", (tester) async {
      await _monter(tester, annuaire, overrides: overrides());
      expect(find.byType(FiltreLocalites), findsOneWidget);
      expect(find.byType(GrillePrestataires), findsOneWidget);
      expect(find.text('Ferme Koné'), findsOneWidget);
      expect(find.byType(EcranCatalogue), findsNothing);
      expect(find.byType(TuileElevage), findsNothing);
    });

    for (final nom in ['Ferme Koné', 'Porcherie Ouattara']) {
      testWidgets('toucher « $nom » ouvre la page éleveur', (tester) async {
        await _monter(tester, annuaire, overrides: overrides());
        await tester.tap(find.text(nom));
        await tester.pumpAndSettle();
        expect(
          tester.widget<EcranCatalogue>(find.byType(EcranCatalogue)).gabarit,
          Gabarit.elevage,
        );
        expect(find.byType(TuileElevage), findsNWidgets(2));
      });
    }
  });

  group('page éleveur', () {
    testWidgets('en-tête, onglets, grille : état, prix, poids, stock', (
      tester,
    ) async {
      final serveur = _PasDePagination();
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 90, gabarit: Gabarit.elevage),
        overrides: _page(serveur),
      );
      // En-tête : nom, Appeler, WhatsApp ; pas de recherche, pas de puces de
      // filtre, pas de badge Ouvert / Fermé.
      expect(find.text('Ferme Koné'), findsWidgets);
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.byType(FilterChip), findsNothing);
      expect(find.text('Ouvert'), findsNothing);
      expect(find.text('Fermé'), findsNothing);
      // Premier onglet seulement.
      expect(find.text('Poulet bicyclette'), findsOneWidget);
      expect(find.text('Pintade abattue'), findsOneWidget);
      expect(find.text('Porc découpé'), findsNothing);
      expect(find.text('Vivant'), findsOneWidget);
      expect(find.text('Abattu entier'), findsOneWidget);
      expect(find.text('${formatMontant(3500)} / pièce'), findsOneWidget);
      expect(find.text('Poids moyen : 2,5${_nb}kg'), findsOneWidget);
      expect(find.text('En stock : 12'), findsOneWidget);
      expect(find.text("Sur commande · 3 jours à l'avance"), findsOneWidget);
      expect(find.text('Livraison possible'), findsNWidgets(2));
      expect(serveur.appels, 0);

      await tester.tap(find.text('Porcs et ovins'));
      await tester.pumpAndSettle();
      expect(find.text('Poulet bicyclette'), findsNothing);
      expect(find.text('Découpé'), findsOneWidget);
      expect(find.text('${formatMontant(2500)} / kg'), findsOneWidget);
      expect(find.text('En stock : 4,5${_nb}kg'), findsOneWidget);
      expect(find.text('Épuisé'), findsOneWidget);
    });

    testWidgets('un seul bouton Filtrer : espèce, état, livraison', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 90, gabarit: Gabarit.elevage),
        overrides: _page(_PasDePagination()),
      );
      await tester.tap(find.text('Filtrer'));
      await tester.pumpAndSettle();
      expect(find.text('Espèce'), findsOneWidget);
      expect(find.text('État de vente'), findsOneWidget);
      expect(find.text('Livraison'), findsOneWidget);
      expect(find.text('Prix maximum'), findsNothing);
      await tester.tap(find.byKey(const ValueKey('filtre-etat_vente')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Abattu entier').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Appliquer'));
      await tester.pumpAndSettle();
      expect(find.text('Filtrer (1)'), findsOneWidget);
      expect(find.text('Pintade abattue'), findsOneWidget);
      expect(find.text('Poulet bicyclette'), findsNothing);
    });
  });

  group('fiche produit éleveur', () {
    testWidgets('kg par 0,5 : total en direct, plafond du stock, ajout', (
      tester,
    ) async {
      final panier = _FauxPanier();
      final porc = _plat(_porc);
      await _monter(
        tester,
        const EcranProduit(produitId: 2, gabarit: Gabarit.elevage),
        overrides: [
          _detail(porc),
          ordersRepositoryProvider.overrideWithValue(panier),
        ],
        stabiliser: false,
      );
      for (final texte in [
        'porc',
        'Découpé',
        '${formatMontant(2500)} / kg',
        '4,5${_nb}kg',
        'Non proposée',
        'Poids (kg)',
      ]) {
        expect(find.text(texte), findsWidgets, reason: texte);
      }
      Text texte(String cle) => tester.widget<Text>(find.byKey(ValueKey(cle)));
      expect(texte('quantite-elevage').data, '0,5${_nb}kg');
      expect(
        texte('total-elevage').data,
        '0,5${_nb}kg × ${formatMontant(2500)} = ${formatMontant(1250)}',
      );

      final plus = find.byTooltip('Plus');
      for (var i = 0; i < 2; i++) {
        await tester.tap(plus);
        await tester.pump();
      }
      expect(texte('quantite-elevage').data, '1,5${_nb}kg');
      expect(
        find.text('Ajouter au panier · ${formatMontant(3750)}'),
        findsOneWidget,
      );
      // Jusqu'au stock (4,5 kg), pas au-delà.
      for (var i = 0; i < 10; i++) {
        await tester.tap(plus);
        await tester.pump();
      }
      expect(texte('quantite-elevage').data, '4,5${_nb}kg');
      await tester.tap(find.byTooltip('Moins'));
      await tester.pump();
      expect(texte('quantite-elevage').data, '4${_nb}kg');

      await tester.tap(
        find.text('Ajouter au panier · ${formatMontant(10000)}'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(panier.ajouts, [(2, 4)]);
      expect(panier.ajouts.single.$2, isA<int>());
    });

    testWidgets('pièces entières', (tester) async {
      final panier = _FauxPanier();
      await _monter(
        tester,
        const EcranProduit(produitId: 1, gabarit: Gabarit.elevage),
        overrides: [
          _detail(_plat(_poulet)),
          ordersRepositoryProvider.overrideWithValue(panier),
        ],
        stabiliser: false,
      );
      expect(find.text('Nombre de pièces'), findsOneWidget);
      expect(find.text('4 mois'), findsOneWidget);
      expect(find.text('Possible'), findsOneWidget);
      await tester.tap(find.byTooltip('Plus'));
      await tester.pump();
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('quantite-elevage')))
            .data,
        '2 pièces',
      );
      await tester.tap(find.text('Ajouter au panier · ${formatMontant(7000)}'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(panier.ajouts, [(1, 2)]);
    });

    testWidgets('stock à 0 : Ajouter désactivé', (tester) async {
      await _monter(
        tester,
        const EcranProduit(produitId: 4, gabarit: Gabarit.elevage),
        overrides: [_detail(_plat(_mouton))],
        stabiliser: false,
      );
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Épuisé'))
            .onPressed,
        isNull,
      );
      expect(find.byKey(const ValueKey('quantite-elevage')), findsNothing);
    });

    testWidgets('non commandable : Ajouter désactivé, pas de sélecteur', (
      tester,
    ) async {
      final bloque = Plat.fromJson(
        _produit(
          5,
          'Canard',
          fiche: {'unite_prix': 'piece'},
          commandable: false,
        ),
      );
      await _monter(
        tester,
        const EcranProduit(produitId: 5, gabarit: Gabarit.elevage),
        overrides: [_detail(bloque)],
        stabiliser: false,
      );
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Indisponible à la commande'),
            )
            .onPressed,
        isNull,
      );
      expect(find.byKey(const ValueKey('quantite-elevage')), findsNothing);
    });
  });
}
