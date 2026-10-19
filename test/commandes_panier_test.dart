import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/orders/metier_domaine/orders_models.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_commandes.dart';
import 'package:poufiret/fonctionnalites/orders/screens/ecran_panier.dart';

void main() {
  group('ligne de panier', () {
    test('une option renvoyée deux fois ne s\'affiche qu\'une fois', () {
      final ligne = LignePanier.fromJson({
        'id': 1,
        'article_nom': 'Poulet braisé',
        'variante_nom': 'Demi',
        'options': [
          {'id': 7, 'nom': 'Frites', 'prix_supplement': '0'},
          {'id': 8, 'nom': 'Alloco', 'prix_supplement': '1000'},
        ],
        'supplements': [
          {'id': 3, 'nom': 'Frites', 'prix': 0},
        ],
      });
      expect(ligne.choix.map((o) => o.nom), ['Frites', 'Alloco']);
      expect(ligne.detailChoix, startsWith('Demi · Frites · Alloco'));
    });

    test('image : URL, ou null', () {
      expect(
        LignePanier.fromJson({'id': 1, 'image': 'https://x.test/a.jpg'}).image,
        'https://x.test/a.jpg',
      );
      expect(LignePanier.fromJson({'id': 1, 'image': null}).image, isNull);
      expect(
        LigneCommande.fromJson({'id': 1, 'image': 'https://x.test/b.jpg'})
            .image,
        'https://x.test/b.jpg',
      );
    });
  });

  test('« chez » n\'est pas doublé', () {
    expect(chezCommercant('Chez Capi'), 'Chez Capi');
    expect(chezCommercant('Maquis chez Tantie'), 'Maquis chez Tantie');
    expect(chezCommercant('Business Center'), 'chez Business Center');
    expect(chezCommercant('Sanchez Shop'), 'chez Sanchez Shop');
  });

  test('date de création d\'une commande', () {
    expect(
      formatDateHeure(DateTime(2026, 10, 19, 11, 5)),
      '19 oct. 2026 · 11:05',
    );
    final c = Commande.fromJson({
      'id': 1,
      'created_at': '2026-10-19T11:25:00Z',
    });
    expect(c.creeLe, DateTime.utc(2026, 10, 19, 11, 25).toLocal());
    expect(const Commande(id: 2).creeLe, isNull);
  });
}
