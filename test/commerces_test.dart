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
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/fiche_produit.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/metier_domaine/meta_gabarits.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/ecran_catalogue.dart';
import 'package:poufiret/fonctionnalites/commerces/screens/ecran_produit.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/galerie_miniatures.dart';
import 'package:poufiret/fonctionnalites/commerces/widgets/tuiles_produits.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/filtre_localites.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_providers.dart';
import 'package:poufiret/fonctionnalites/orders/donnees/orders_repository.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_providers.dart';
import 'package:poufiret/fonctionnalites/restaurants/donnees/restaurants_repository.dart';
import 'package:poufiret/fonctionnalites/restaurants/metier_domaine/restaurant_models.dart';
import 'package:poufiret/fonctionnalites/restaurants/screens/ecran_restaurant.dart';
import 'package:poufiret/global/ui/format_montant.dart';
import 'package:poufiret/global/widgets/visionneuse_images.dart';

// L'API de production n'était pas joignable depuis l'environnement de
// développement : les réponses ci-dessous suivent le contrat des gabarits
// (décimaux en chaîne, objets {valeur, libelle}, champs à la racine...).

final _restaurants = RestaurantsRepository(Dio());
final _commerces = CommercesRepository(Dio());

Restaurant _fiche(Map<String, dynamic> json) =>
    _restaurants.detailDepuis(jsonDecode(jsonEncode(json)));

Map<String, dynamic> _commerce(
  int id,
  String gabarit, {
  List<Map<String, dynamic>> sections = const [],
  bool pagine = true,
  Map<String, dynamic> fiche = const {},
}) => {
  'id': id,
  'gabarit': gabarit,
  'nom': 'Commerce $id',
  'telephone_pro': '0700000$id',
  'whatsapp': '0700000$id',
  'est_ouvert': true,
  'pagination_publique': pagine,
  'fiche': fiche,
  'sections': sections,
};

final _pharmacie = _fiche(
  _commerce(
    60,
    'pharmacie',
    fiche: {'de_garde': true, 'de_garde_jusqu_au': '2026-10-21T08:00:00'},
    sections: [
      {'id': 1, 'nom': 'Médicaments', 'nb_produits': 25},
      {'id': 2, 'nom': 'Hygiène', 'nb_produits': 3},
    ],
  ),
);

Map<String, dynamic> _produit(
  int id, {
  Map<String, dynamic> extra = const {},
}) => {
  'id': id,
  'nom': 'Produit $id',
  'prix': '1000.00',
  'prix_effectif': '1000.00',
  'images': [],
  'commandable': true,
  ...extra,
};

final _paracetamol = Plat.fromJson(
  _produit(
    1,
    extra: {
      'nom': 'Paracétamol',
      'fiche_specifique': {
        'forme': 'Comprimé',
        'dosage': '500 mg',
        'laboratoire': 'Cipla',
        'sur_ordonnance': false,
      },
    },
  ),
);

final _amoxicilline = Plat.fromJson(
  _produit(
    2,
    extra: {
      'nom': 'Amoxicilline',
      'fiche_specifique': {
        'forme': {'valeur': 'gelule', 'libelle': 'Gélule'},
        'dosage': '1 g',
        'sur_ordonnance': true,
      },
    },
  ),
);

/// Une chaussure : 41 épuisée, 42 en stock (+500 F), 43 stock non suivi.
final _basket = Plat.fromJson({
  ..._produit(10),
  'nom': 'Basket Air',
  'prix': '25000.00',
  'prix_effectif': '25000.00',
  'images': [
    {'image': 'https://exemple.test/a.jpg'},
    {'image': 'https://exemple.test/b.jpg'},
    {'image': 'https://exemple.test/c.jpg'},
  ],
  'fiche_specifique': {
    'marque': 'Nike',
    'couleur': 'Blanc',
    'matiere': 'Cuir',
    'genre': 'homme',
    'genre_libelle': 'Homme',
  },
  'variantes': [
    {'id': 41, 'nom': '41', 'prix_supplement': 0, 'stock': 0},
    {'id': 42, 'nom': '42', 'prix_supplement': '500.00', 'stock': 3},
    {'id': 43, 'nom': '43', 'prix_supplement': 0, 'est_epuise': false},
  ],
});

final _livre = Plat.fromJson({
  ..._produit(20),
  'nom': 'Le Petit Prince',
  // Champs à la racine : repris dans la fiche spécifique.
  'auteur': 'Antoine de Saint-Exupéry',
  'editeur': 'Gallimard',
  'annee': 1943,
  'isbn': '9782070612758',
  'langue': 'Français',
  'niveau': 'primaire',
  'niveau_libelle': 'Primaire',
  'classe': 'CM2',
  'etat': 'occasion',
});

const _utilisateur = Utilisateur(id: 7, telephone: '0707070707');

class _Session extends AuthNotifier {
  @override
  Future<Utilisateur?> build() async => _utilisateur;
}

/// Serveur factice des catalogues : 25 produits par rayon, en pages.
class _FauxCommerces extends CommercesRepository {
  _FauxCommerces({this.produitsParRayon = const {}}) : super(Dio());

  final Map<int?, List<Plat>> produitsParRayon;
  final requetes = <Map<String, dynamic>>[];
  final details = <int, ProduitDetail>{};

  @override
  Future<PageProduits> produits(RequeteProduits requete, {int page = 1}) async {
    requetes.add(requete.parametres(page));
    final tous =
        produitsParRayon[requete.sectionId] ??
        [for (var i = 1; i <= 25; i++) Plat.fromJson(_produit(100 + i))];
    final debut = (page - 1) * RequeteProduits.taillePage;
    final fin = (debut + RequeteProduits.taillePage).clamp(0, tous.length);
    return PageProduits(
      count: tous.length,
      results: tous.sublist(debut.clamp(0, tous.length), fin),
      next: fin < tous.length ? 'page=${page + 1}' : null,
    );
  }
}

class _FauxPanier extends OrdersRepository {
  _FauxPanier() : super(dio: Dio());

  final ajouts = <(int?, int?)>[];

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
    ajouts.add((articleId, varianteId));
    return const Panier(id: 1);
  }
}

Future<void> _monter(
  WidgetTester tester,
  Widget ecran, {
  List<Override> overrides = const [],
  bool stabiliser = true,
}) async {
  tester.view.physicalSize = const Size(420, 1600);
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

Override _detailProduit(Plat p, {List<Plat> autres = const []}) =>
    produitDetailProvider(id: p.id).overrideWith(
      (ref) => Stream.value(ProduitDetail(produit: p, autres: autres)),
    );

void main() {
  group('parsing', () {
    test('fiche à gabarit : sections, pagination publique, garde', () {
      expect(_pharmacie.gabarit, 'pharmacie');
      expect(_pharmacie.paginationPublique, isTrue);
      expect(_pharmacie.carte.map((s) => s.nom), ['Médicaments', 'Hygiène']);
      expect(_pharmacie.carte.first.nbProduits, 25);
      expect(_pharmacie.carte.first.plats, isEmpty);
      expect(_pharmacie.fiche.deGarde, isTrue);
      expect(
        formatGarde(_pharmacie.fiche.deGardeJusquAu!),
        '21/10/2026 à 08h00',
      );
      expect(formatGarde('2026-10-21'), '21/10/2026');
      // Garde à la racine.
      final racine = _fiche({..._commerce(61, 'pharmacie'), 'de_garde': true});
      expect(racine.fiche.deGarde, isTrue);
    });

    test('sections avec produits : variantes en stock, non commandable', () {
      final r = _fiche(
        _commerce(
          70,
          'boulangerie',
          pagine: false,
          sections: [
            {
              'id': 5,
              'nom': 'Pains',
              'produits': [
                {
                  ..._produit(1),
                  'titre': 'Baguette',
                  'nom': null,
                  'commandable': false,
                  'fiche_specifique': {
                    'sur_commande': true,
                    'delai_heures': 24,
                  },
                },
              ],
            },
          ],
        ),
      );
      final baguette = r.carte.single.plats.single;
      expect(baguette.nom, 'Baguette');
      expect(baguette.commandable, isFalse);
      expect(baguette.mentionSurCommande, "Sur commande · 24 h à l'avance");
      // L'ancienne carte (avant les gabarits) reste lue.
      final ancienne = _fiche({
        'id': 53,
        'est_ouvert': false,
        'carte': [
          {
            'id': 1,
            'nom': 'Plats',
            'plats': [_produit(9)],
          },
        ],
      });
      expect(ancienne.carte.single.plats.single.id, 9);
      expect(ancienne.carte.single.plats.single.commandable, isTrue);
    });

    test('fiche spécifique : valeurs, objets, libellés, racine', () {
      expect(_paracetamol.formeDosage, 'Comprimé · 500 mg');
      expect(_paracetamol.laboratoire, 'Cipla');
      expect(_paracetamol.surOrdonnance, isFalse);
      expect(_amoxicilline.formeDosage, 'Gélule · 1 g');
      expect(_amoxicilline.surOrdonnance, isTrue);
      expect(_basket.marque, 'Nike');
      expect(_basket.genre, 'Homme');
      expect(_basket.valeur('genre'), 'homme');
      expect(_livre.auteur, 'Antoine de Saint-Exupéry');
      expect(_livre.annee, '1943');
      expect(_livre.niveauClasse, 'Primaire · CM2');
      expect(_livre.etatLivre, 'Occasion');
    });

    test('variantes : stock 0 ou est_epuise = épuisée', () {
      final v = _basket.variantesActives;
      expect(v.map((x) => x.epuisee), [true, false, false]);
      expect(v[1].prixSupplement, 500);
      expect(_basket.toutEpuise, isFalse);
      expect(_basket.copyWith(variantes: [v.first]).toutEpuise, isTrue);
      // « à partir de » : les pointures épuisées ne comptent pas.
      expect(prixAPartirDeProduit(_basket), 25000);
    });

    test('page de produits, fiche produit et autres produits', () {
      final page = PageProduits.fromJson({
        'count': '45',
        'next': 'https://x/?page=2',
        'previous': null,
        'results': [_produit(1), _produit(2)],
      });
      expect(page.count, 45);
      expect(page.aSuite, isTrue);
      expect(page.results.map((p) => p.id), [1, 2]);
      final detail = _commerces.produitDepuis({
        ..._produit(3),
        'restaurant': 60,
        'autres_produits': [_produit(4)],
      });
      expect(detail.produit.id, 3);
      expect(detail.commerceId, 60);
      expect(detail.autres.single.id, 4);
    });

    test('requête : rayon, recherche, filtres, page de 20', () {
      const requete = RequeteProduits(
        commerceId: 60,
        sectionId: 1,
        recherche: ' doli ',
        filtre: FiltreCatalogue(valeurs: {'etat': 'neuf'}, prixMax: 5000),
      );
      expect(requete.parametres(2), {
        'section': 1,
        'q': 'doli',
        'etat': 'neuf',
        'prix_max': 5000,
        'page': 2,
        'page_size': 20,
      });
      expect(const RequeteProduits(commerceId: 60).parametres(1), {
        'page': 1,
        'page_size': 20,
      });
    });

    test('filtre réappliqué sur place', () {
      const neufs = FiltreCatalogue(valeurs: {'etat': 'neuf'});
      expect(neufs.garde(_livre), isFalse);
      expect(
        const FiltreCatalogue(valeurs: {'etat': 'occasion'}).garde(_livre),
        isTrue,
      );
      // Champ absent du produit : pas exclu.
      expect(neufs.garde(_paracetamol), isTrue);
      expect(const FiltreCatalogue(prixMax: 20000).garde(_basket), isFalse);
    });

    test('meta des gabarits : choix trouvés, sinon par défaut', () {
      const meta = MetaGabarits({
        'gabarits': [
          {
            'valeur': 'librairie',
            'champs': [
              {
                'nom': 'etat',
                'choix': [
                  ['neuf', 'Neuf'],
                  ['occasion', "D'occasion"],
                ],
              },
            ],
          },
        ],
      });
      expect(meta.choix(Gabarit.librairie, 'etat').map((c) => c.libelle), [
        'Neuf',
        "D'occasion",
      ]);
      expect(
        meta.choix(Gabarit.librairie, 'niveau').first.libelle,
        'Maternelle',
      );
      expect(MetaGabarits.vide.champsFiltre(Gabarit.mode).single.cle, 'genre');
      expect(MetaGabarits.vide.champsFiltre(Gabarit.pharmacie), isEmpty);
    });
  });

  group('aiguillage', () {
    test('gabarit de la carte, sinon type du partenaire, sinon catégorie', () {
      expect(gabaritPartenaire(gabarit: 'pharmacie'), Gabarit.pharmacie);
      expect(
        gabaritPartenaire(typesPartenaire: ['fast_food']),
        Gabarit.restaurant,
      );
      expect(
        gabaritPartenaire(typesPartenaire: ['boulanger']),
        Gabarit.boulangerie,
      );
      expect(
        gabaritPartenaire(typesCategorie: ['pharmacien']),
        Gabarit.pharmacie,
      );
      expect(
        gabaritPartenaire(typesCategorie: ['boutique_mode']),
        Gabarit.mode,
      );
      expect(
        gabaritPartenaire(typesCategorie: ['libraire']),
        Gabarit.librairie,
      );
      expect(gabaritPartenaire(gabarit: 'inconnu'), isNull);
      expect(gabaritPartenaire(typesCategorie: ['loueur_maison']), isNull);
      // Le gabarit de la carte prime sur le type de la catégorie.
      expect(
        gabaritPartenaire(gabarit: 'mode', typesCategorie: ['pharmacien']),
        Gabarit.mode,
      );
    });

    test('carte de l\'annuaire : gabarit et type, texte ou liste', () {
      final a = PartenaireCategorie.fromJson(const {
        'id': 1,
        'gabarit': 'librairie',
        'type_partenaire': 'libraire',
      });
      expect(a.gabarit, 'librairie');
      expect(a.typesPartenaire, ['libraire']);
      final b = PartenaireCategorie.fromJson(const {
        'id': 2,
        'types_partenaire': ['boulanger'],
      });
      expect(b.gabarit, '');
      expect(b.typesPartenaire, ['boulanger']);
    });

    const partenaires = [
      PartenaireCategorie(
        id: 80,
        nomCommerce: 'Fast Food',
        typesPartenaire: ['fast_food'],
      ),
      PartenaireCategorie(
        id: 81,
        nomCommerce: 'Boulangerie',
        gabarit: 'boulangerie',
      ),
      PartenaireCategorie(
        id: 82,
        nomCommerce: 'Pharmacie',
        typesPartenaire: ['pharmacien'],
      ),
      PartenaireCategorie(id: 83, nomCommerce: 'Mode', gabarit: 'mode'),
      PartenaireCategorie(
        id: 84,
        nomCommerce: 'Librairie',
        typesPartenaire: ['libraire'],
      ),
    ];

    List<Override> overrides(_FauxCommerces serveur) => [
      departementsProvider.overrideWith(
        (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
      ),
      visiteCategorieProvider(categorieId: 20).overrideWith((ref) async {}),
      partenairesParCategorieProvider(
        slug: 'commerces',
      ).overrideWith((ref) => Stream.value(partenaires)),
      for (final p in partenaires) ...[
        vueVitrineProvider(partenaireId: p.id).overrideWith((ref) async {}),
        restaurantDetailProvider(id: p.id).overrideWith(
          (ref) =>
              Stream.value(_fiche(_commerce(p.id, p.gabarit, pagine: false))),
        ),
      ],
      commercesRepositoryProvider.overrideWithValue(serveur),
    ];

    const annuaire = EcranPrestataires(
      categorieId: 20,
      categorieNom: 'Commerces',
      categorieSlug: 'commerces',
      modeTransaction: 'vitrine_chat',
    );

    testWidgets("l'annuaire ne change pas", (tester) async {
      await _monter(tester, annuaire, overrides: overrides(_FauxCommerces()));
      expect(find.byType(FiltreLocalites), findsOneWidget);
      expect(find.byType(GrillePrestataires), findsOneWidget);
      expect(find.text('Pharmacie'), findsOneWidget);
      expect(find.byType(EcranCatalogue), findsNothing);
    });

    for (final (nom, attendu) in [
      ('Fast Food', 'restaurant'),
      ('Boulangerie', 'boulangerie'),
      ('Pharmacie', 'pharmacie'),
      ('Mode', 'mode'),
      ('Librairie', 'librairie'),
    ]) {
      testWidgets('toucher « $nom » ouvre la page $attendu', (tester) async {
        await _monter(tester, annuaire, overrides: overrides(_FauxCommerces()));
        await tester.tap(find.text(nom));
        await tester.pumpAndSettle();
        switch (attendu) {
          case 'restaurant':
            expect(
              tester
                  .widget<EcranRestaurant>(find.byType(EcranRestaurant))
                  .grille,
              isFalse,
            );
          case 'boulangerie':
            expect(
              tester
                  .widget<EcranRestaurant>(find.byType(EcranRestaurant))
                  .grille,
              isTrue,
            );
          default:
            expect(
              tester
                  .widget<EcranCatalogue>(find.byType(EcranCatalogue))
                  .gabarit
                  .name,
              attendu,
            );
        }
      });
    }
  });

  group('galerie à miniatures', () {
    testWidgets('miniature touchée en grand, encadrée ; plein écran', (
      tester,
    ) async {
      await _monter(
        tester,
        const Scaffold(
          body: GalerieMiniatures(
            images: [
              'https://exemple.test/a.jpg',
              'https://exemple.test/b.jpg',
              'https://exemple.test/c.jpg',
            ],
          ),
        ),
        stabiliser: false,
      );
      expect(
        find.byKey(const ValueKey('grande-https://exemple.test/a.jpg')),
        findsOneWidget,
      );
      Color bordure(int i) {
        final boite = tester.widget<AnimatedContainer>(
          find.descendant(
            of: find.byKey(ValueKey('miniature-$i')),
            matching: find.byType(AnimatedContainer),
          ),
        );
        return ((boite.decoration! as BoxDecoration).border! as Border)
            .top
            .color;
      }

      expect(bordure(0), isNot(Colors.transparent));
      expect(bordure(2), Colors.transparent);

      await tester.tap(find.byKey(const ValueKey('miniature-2')));
      await tester.pump();
      expect(
        find.byKey(const ValueKey('grande-https://exemple.test/c.jpg')),
        findsOneWidget,
      );
      expect(bordure(2), isNot(Colors.transparent));
      expect(bordure(0), Colors.transparent);

      // La grande image ouvre la visionneuse plein écran, sur la même photo.
      await tester.tap(find.byKey(const ValueKey('galerie-grande')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      final visionneuse = tester.widget<VisionneuseImages>(
        find.byType(VisionneuseImages),
      );
      expect(visionneuse.indexInitial, 2);
      expect(visionneuse.images, hasLength(3));
    });

    testWidgets('une seule image : pas de miniatures', (tester) async {
      await _monter(
        tester,
        const Scaffold(
          body: GalerieMiniatures(images: ['https://exemple.test/a.jpg']),
        ),
        stabiliser: false,
      );
      expect(find.byKey(const ValueKey('miniature-0')), findsNothing);
    });
  });

  group('mode : pointures', () {
    testWidgets('épuisée grisée et non sélectionnable, prix selon pointure', (
      tester,
    ) async {
      final panier = _FauxPanier();
      await _monter(
        tester,
        const EcranProduit(produitId: 10, gabarit: Gabarit.mode),
        overrides: [
          _detailProduit(
            _basket,
            autres: [_livre.copyWith(id: 11, nom: 'Sandale')],
          ),
          ordersRepositoryProvider.overrideWithValue(panier),
        ],
        stabiliser: false,
      );
      expect(find.text('Nike'), findsWidgets);
      expect(find.text('Blanc'), findsOneWidget);
      expect(find.text('Cuir'), findsOneWidget);
      expect(find.text('Homme'), findsOneWidget);
      expect(find.text('Autres articles'), findsOneWidget);
      expect(find.text('Sandale'), findsOneWidget);

      final puce41 = tester.widget<ChoiceChip>(
        find.byKey(const ValueKey('variante-41')),
      );
      expect(puce41.onSelected, isNull);
      // Pointure à choisir avant l'ajout.
      expect(find.text('Choisissez une pointure'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('variante-41')));
      await tester.pump();
      expect(find.text('Choisissez une pointure'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('variante-42')));
      await tester.pump();
      expect(
        tester.widget<Text>(find.byKey(const ValueKey('prix-produit'))).data,
        formatMontant(25500),
      );
      expect(
        find.text('Ajouter au panier · ${formatMontant(25500)}'),
        findsOneWidget,
      );
      await tester.tap(
        find.text('Ajouter au panier · ${formatMontant(25500)}'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(panier.ajouts, [(10, 42)]);
      expect(find.text('Ajouté au panier.'), findsOneWidget);
    });

    testWidgets('toutes pointures épuisées : bouton Épuisé', (tester) async {
      final epuise = _basket.copyWith(
        variantes: [
          for (final v in _basket.variantes) v.copyWith(estEpuise: true),
        ],
      );
      await _monter(
        tester,
        const EcranProduit(produitId: 10, gabarit: Gabarit.mode),
        overrides: [_detailProduit(epuise)],
        stabiliser: false,
      );
      final bouton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Épuisé'),
      );
      expect(bouton.onPressed, isNull);
    });

    testWidgets('grille 2 colonnes : marque, nom, prix, Épuisé ; Filtrer', (
      tester,
    ) async {
      final serveur = _FauxCommerces(
        produitsParRayon: {
          null: [
            _basket,
            _basket.copyWith(
              id: 12,
              nom: 'Mocassin',
              variantes: [_basket.variantes.first],
            ),
          ],
        },
      );
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 83, gabarit: Gabarit.mode),
        overrides: [
          vueVitrineProvider(partenaireId: 83).overrideWith((ref) async {}),
          restaurantDetailProvider(
            id: 83,
          ).overrideWith((ref) => Stream.value(_fiche(_commerce(83, 'mode')))),
          commercesRepositoryProvider.overrideWithValue(serveur),
        ],
      );
      expect(find.byType(TuileGrilleProduit), findsNWidgets(2));
      expect(find.text('NIKE'), findsNWidgets(2));
      expect(find.text('Basket Air'), findsOneWidget);
      expect(find.text(formatMontant(25000)), findsOneWidget);
      expect(find.text('Épuisé'), findsOneWidget);
      // Pas de recherche, pas de puces : un seul bouton « Filtrer ».
      expect(find.byType(TextField), findsNothing);
      expect(find.byType(FilterChip), findsNothing);
      await tester.tap(find.text('Filtrer'));
      await tester.pumpAndSettle();
      expect(find.text('Genre'), findsOneWidget);
      expect(find.text('Prix maximum'), findsOneWidget);
      await tester.enterText(find.byType(TextField), '20000');
      await tester.tap(find.text('Appliquer'));
      await tester.pumpAndSettle();
      expect(find.text('Filtrer (1)'), findsOneWidget);
      expect(serveur.requetes.last['prix_max'], 20000);
      // Réappliqué sur place : la basket à 25 000 F disparaît.
      expect(find.text('Basket Air'), findsNothing);
    });
  });

  group('pharmacie', () {
    List<Override> overrides(_FauxCommerces serveur) => [
      vueVitrineProvider(partenaireId: 60).overrideWith((ref) async {}),
      restaurantDetailProvider(
        id: 60,
      ).overrideWith((ref) => Stream.value(_pharmacie)),
      commercesRepositoryProvider.overrideWithValue(serveur),
    ];

    testWidgets('garde, contacts, recherche, rayons, sur ordonnance', (
      tester,
    ) async {
      final serveur = _FauxCommerces(
        produitsParRayon: {
          1: [_paracetamol, _amoxicilline],
          2: [
            Plat.fromJson({..._produit(3), 'nom': 'Savon'}),
          ],
          null: [_paracetamol],
        },
      );
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 60, gabarit: Gabarit.pharmacie),
        overrides: overrides(serveur),
      );
      expect(
        find.text("Pharmacie de garde jusqu'au 21/10/2026 à 08h00"),
        findsOneWidget,
      );
      expect(find.text('Appeler'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(
        find.widgetWithText(TextField, 'Rechercher un médicament, un produit…'),
        findsOneWidget,
      );
      // Premier rayon seulement.
      expect(serveur.requetes.single['section'], 1);
      expect(find.text('Paracétamol'), findsOneWidget);
      expect(find.text('Comprimé · 500 mg'), findsOneWidget);
      expect(find.text('Cipla'), findsOneWidget);
      expect(find.text('Savon'), findsNothing);
      // Sur ordonnance : mention et appel au lieu d'Ajouter.
      expect(find.text('Sur ordonnance'), findsOneWidget);
      expect(find.text('Appeler la pharmacie'), findsOneWidget);
      expect(find.text('Ajouter'), findsOneWidget);

      // Onglet suivant : un rayon à la fois.
      await tester.tap(find.text('Hygiène'));
      await tester.pumpAndSettle();
      expect(serveur.requetes.last['section'], 2);
      expect(find.text('Savon'), findsOneWidget);
      expect(find.text('Paracétamol'), findsNothing);

      // Recherche : toute la pharmacie.
      await tester.enterText(find.byType(TextField), 'para');
      await tester.pump(const Duration(milliseconds: 450));
      await tester.pumpAndSettle();
      expect(serveur.requetes.last['q'], 'para');
      expect(serveur.requetes.last.containsKey('section'), isFalse);
      expect(find.text('Résultats pour « para »'), findsOneWidget);
      expect(find.text('Hygiène'), findsNothing);
    });

    testWidgets('fiche sur ordonnance : Appeler la pharmacie', (tester) async {
      await _monter(
        tester,
        const EcranProduit(
          produitId: 2,
          gabarit: Gabarit.pharmacie,
          telephoneCommerce: '0700000060',
        ),
        overrides: [_detailProduit(_amoxicilline)],
      );
      expect(find.text('Sur ordonnance'), findsOneWidget);
      expect(find.text('Gélule · 1 g'), findsOneWidget);
      expect(find.text('Appeler la pharmacie'), findsOneWidget);
      expect(find.textContaining('Ajouter au panier'), findsNothing);
    });

    testWidgets('non commandable : pas de bouton d\'ajout', (tester) async {
      await _monter(
        tester,
        const EcranProduit(produitId: 1, gabarit: Gabarit.pharmacie),
        overrides: [_detailProduit(_paracetamol.copyWith(commandable: false))],
      );
      expect(find.textContaining('Ajouter'), findsNothing);
      expect(find.text('Appeler la pharmacie'), findsNothing);
    });

    testWidgets('pagination : la page 2 se charge en bas de liste', (
      tester,
    ) async {
      final serveur = _FauxCommerces();
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 60, gabarit: Gabarit.pharmacie),
        overrides: overrides(serveur),
      );
      expect(serveur.requetes.first['page'], 1);
      expect(serveur.requetes.first['page_size'], 20);
      expect(find.text('Produit 101'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Produit 125'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(serveur.requetes.map((r) => r['page']), [1, 2]);
      expect(find.text('Produit 125'), findsOneWidget);
      // Fin de liste : plus de requête.
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -2000));
      await tester.pumpAndSettle();
      expect(serveur.requetes, hasLength(2));
    });
  });

  group('librairie', () {
    testWidgets('liste : couverture, auteur, niveau, état ; Filtrer', (
      tester,
    ) async {
      final serveur = _FauxCommerces(
        produitsParRayon: {
          null: [_livre],
        },
      );
      await _monter(
        tester,
        const EcranCatalogue(commerceId: 84, gabarit: Gabarit.librairie),
        overrides: [
          vueVitrineProvider(partenaireId: 84).overrideWith((ref) async {}),
          restaurantDetailProvider(id: 84).overrideWith(
            (ref) => Stream.value(_fiche(_commerce(84, 'librairie'))),
          ),
          commercesRepositoryProvider.overrideWithValue(serveur),
        ],
      );
      expect(
        find.widgetWithText(TextField, 'Titre, auteur ou ISBN'),
        findsOneWidget,
      );
      expect(find.text('Le Petit Prince'), findsOneWidget);
      expect(find.text('Antoine de Saint-Exupéry'), findsOneWidget);
      expect(find.text('Primaire · CM2'), findsOneWidget);
      expect(find.text('Occasion'), findsOneWidget);
      await tester.tap(find.text('Filtrer'));
      await tester.pumpAndSettle();
      expect(find.text('Niveau'), findsOneWidget);
      expect(find.text('Genre'), findsOneWidget);
      expect(find.text('État'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('filtre-etat')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Neuf').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Appliquer'));
      await tester.pumpAndSettle();
      expect(serveur.requetes.last['etat'], 'neuf');
      expect(find.text('Filtrer (1)'), findsOneWidget);
      // Le livre d'occasion n'est pas gardé.
      expect(find.text('Le Petit Prince'), findsNothing);
    });

    testWidgets('fiche livre : informations, Ajouter, autres livres', (
      tester,
    ) async {
      await _monter(
        tester,
        const EcranProduit(produitId: 20, gabarit: Gabarit.librairie),
        overrides: [
          _detailProduit(
            _livre,
            autres: [_livre.copyWith(id: 21, nom: 'Vol de nuit')],
          ),
        ],
        stabiliser: false,
      );
      for (final texte in [
        'Gallimard',
        '1943',
        '9782070612758',
        'Français',
        'Primaire · CM2',
        'Occasion',
        'Autres livres',
        'Vol de nuit',
      ]) {
        expect(find.text(texte), findsWidgets, reason: texte);
      }
      expect(
        find.text('Ajouter au panier · ${formatMontant(1000)}'),
        findsOneWidget,
      );
    });
  });

  group('boulangerie', () {
    final r = _fiche(
      _commerce(
        81,
        'boulangerie',
        pagine: false,
        sections: [
          {
            'id': 1,
            'nom': 'Pains',
            'produits': [
              {..._produit(1), 'nom': 'Baguette'},
              {..._produit(2), 'nom': 'Pain de mie'},
            ],
          },
          {
            'id': 2,
            'nom': 'Gâteaux',
            'produits': [
              {
                ..._produit(3),
                'nom': "Gâteau d'anniversaire",
                'fiche_specifique': {'sur_commande': true, 'delai_heures': 48},
              },
            ],
          },
        ],
      ),
    );

    testWidgets('grille, un rayon à la fois, sur commande', (tester) async {
      await _monter(
        tester,
        const EcranRestaurant(restaurantId: 81, grille: true),
        overrides: [
          vueVitrineProvider(partenaireId: 81).overrideWith((ref) async {}),
          restaurantDetailProvider(
            id: 81,
          ).overrideWith((ref) => Stream.value(r)),
        ],
      );
      expect(find.byType(SliverGrid), findsOneWidget);
      expect(find.byType(TuileGrilleProduit), findsNWidgets(2));
      expect(find.text('Baguette'), findsOneWidget);
      expect(find.text("Gâteau d'anniversaire"), findsNothing);

      await tester.tap(find.text('Gâteaux'));
      await tester.pumpAndSettle();
      expect(find.text('Baguette'), findsNothing);
      expect(find.text("Gâteau d'anniversaire"), findsOneWidget);
      expect(find.text("Sur commande · 48 h à l'avance"), findsOneWidget);

      // Recherche : tous les rayons.
      await tester.enterText(find.byType(TextField), 'pain');
      await tester.pumpAndSettle();
      expect(find.text('Pain de mie'), findsOneWidget);
    });
  });
}
