import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_providers.dart';
import 'package:poufiret/fonctionnalites/catalogue/donnees/catalogue_repository.dart';
import 'package:poufiret/fonctionnalites/catalogue/metier_domaine/partenaire_categorie.dart';
import 'package:poufiret/fonctionnalites/catalogue/screens/ecran_prestataires.dart';
import 'package:poufiret/fonctionnalites/geo/donnees/geo_providers.dart';
import 'package:poufiret/fonctionnalites/geo/metier_domaine/departement.dart';

import 'aide_session.dart';

/// Serveur de l'annuaire : réponse paginée {count, next, previous, results}.
/// « ferme » : 23 résultats (20 + 3) ; « zzz » : aucun ; « panne » : erreur.
class _FauxAnnuaire extends CatalogueRepository {
  _FauxAnnuaire() : super(dio: Dio());

  final appels = <({String q, int? page, int? taille})>[];

  @override
  Future<Object?> partenairesParCategorieBrut(
    String slug, {
    List<String>? localites,
    String? typeEtablissement,
    int? sousCategorie,
    String recherche = '',
    int? page,
    int? taillePage,
    CancelToken? annulation,
  }) async {
    appels.add((q: recherche, page: page, taille: taillePage));
    if (recherche == 'panne') {
      throw DioException(requestOptions: RequestOptions());
    }
    final total = recherche == 'zzz' ? 0 : 23;
    final debut = ((page ?? 1) - 1) * (taillePage ?? 20);
    final fin = (debut + (taillePage ?? 20)).clamp(0, total);
    return {
      'count': total,
      'next': fin < total ? 'page-suivante' : null,
      'previous': null,
      'results': [
        for (var i = debut; i < fin; i++)
          {
            'id': 1000 + i,
            'nom_commerce': 'Ferme ${i + 1}',
            'logo': '',
            'photo_couverture': '',
          },
      ],
    };
  }
}

/// Première page sans recherche (servie par le cache dans l'app).
const _premiere = [
  PartenaireCategorie(id: 1, nomCommerce: 'Ferme Koné'),
  PartenaireCategorie(id: 2, nomCommerce: 'Porcherie Ouattara'),
];

void main() {
  late _FauxAnnuaire serveur;

  setUp(() => serveur = _FauxAnnuaire());

  Future<void> monter(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(SessionTest.new),
          departementsProvider.overrideWith(
            (ref) => Stream.value(const [Departement(id: 1, nom: 'Ferké')]),
          ),
          visiteCategorieProvider(categorieId: 30).overrideWith((ref) async {}),
          catalogueRepositoryProvider.overrideWithValue(serveur),
          partenairesParCategorieProvider(
            slug: 'elevage',
          ).overrideWith((ref) => Stream.value(_premiere)),
        ],
        child: const MaterialApp(
          home: EcranPrestataires(
            categorieId: 30,
            categorieNom: 'Élevage & Ferme',
            categorieSlug: 'elevage',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('barre au-dessus des pastilles', (tester) async {
    await monter(tester);
    expect(find.text('Rechercher un partenaire'), findsOneWidget);
    expect(
      tester.getTopLeft(find.byType(TextField)).dy,
      lessThan(tester.getTopLeft(find.text('Mon département')).dy),
    );
    expect(find.text('Ferme Koné'), findsOneWidget);
  });

  testWidgets('saisie : q et page 1 après la pause ; défilement : page 2', (
    tester,
  ) async {
    await monter(tester);
    await tester.enterText(find.byType(TextField), 'ferme');
    // Pendant la frappe : rien n'est parti.
    await tester.pump(const Duration(milliseconds: 300));
    expect(serveur.appels.where((a) => a.q == 'ferme'), isEmpty);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    expect(serveur.appels.first, (q: 'ferme', page: 1, taille: 20));
    expect(find.text('Ferme 1'), findsOneWidget);
    expect(find.text('Ferme Koné'), findsNothing);

    // Défilement jusqu'en bas : la page 2 arrive.
    await tester.scrollUntilVisible(
      find.text('Ferme 23'),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    expect(serveur.appels, [
      (q: 'ferme', page: 1, taille: 20),
      (q: 'ferme', page: 2, taille: 20),
    ]);
    expect(find.text('Ferme 23'), findsOneWidget);
  });

  testWidgets('aucun résultat ; effacer ramène la liste', (tester) async {
    await monter(tester);
    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();
    expect(find.text('Aucun partenaire trouvé'), findsOneWidget);

    await tester.tap(find.byTooltip('Effacer'));
    await tester.pumpAndSettle();
    expect(find.text('Ferme Koné'), findsOneWidget);
    expect(find.text('Aucun partenaire trouvé'), findsNothing);
  });

  testWidgets('erreur réseau : message et « Réessayer »', (tester) async {
    await monter(tester);
    await tester.enterText(find.byType(TextField), 'panne');
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();
    expect(find.text('Réessayer'), findsOneWidget);
    int appelsPanne() => serveur.appels.where((a) => a.q == 'panne').length;
    final avant = appelsPanne();
    await tester.tap(find.text('Réessayer'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    // « Réessayer » relance la requête (même recherche, page 1).
    expect(appelsPanne(), greaterThan(avant));
    expect(serveur.appels.last, (q: 'panne', page: 1, taille: 20));
  });
}
