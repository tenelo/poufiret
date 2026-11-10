import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/fonctionnalites/locations/metier_domaine/disponibilites.dart';

DateTime _j(int jour) => DateTime(2026, 11, jour);

void main() {
  group('modèle', () {
    test('lecture complète', () {
      final d = Disponibilites.fromJson({
        'unites_total': 5,
        'jours_complets': ['2026-11-12', '2026-11-13'],
        'unites_restantes': {'2026-11-14': 1, '2026-11-15': '3'},
      });
      expect(d.unitesTotal, 5);
      expect(d.estComplet(_j(12)), isTrue);
      expect(d.estComplet(DateTime(2026, 11, 13, 15, 30)), isTrue);
      expect(d.estComplet(_j(14)), isFalse);
      expect(d.unitesRestantes, {_j(14): 1, _j(15): 3});
    });

    test('clés absentes ou illisibles : rien de bloqué', () {
      for (final json in <Object?>[
        null,
        'oups',
        <String, dynamic>{},
        {'jours_complets': null, 'unites_restantes': 'x'},
        {
          'jours_complets': ['pas une date'],
        },
      ]) {
        final d = Disponibilites.fromJson(json);
        expect(d.joursComplets, isEmpty);
        expect(d.unitesRestantes, isEmpty);
        expect(d.erreurPlage(_j(1), _j(30)), isNull);
      }
    });

    test('jours refusés par le serveur (400 details.jours_complets)', () {
      expect(
        joursRefuses({
          'jours_complets': ['2026-11-12'],
        }),
        ['2026-11-12'],
      );
      expect(joursRefuses({'date_debut': 'x'}), isNull);
    });
  });

  group('véhicule : jour de restitution libre', () {
    final d = Disponibilites.fromJson({
      'jours_complets': ['2026-11-12'],
    });

    test('jour complet grisé, sauf comme jour de fin', () {
      expect(d.selectionnable(_j(12), null, null), isFalse);
      expect(d.selectionnable(_j(12), _j(10), null), isTrue);
      expect(d.selectionnable(_j(12), _j(10), _j(12)), isTrue);
      expect(d.selectionnable(_j(13), _j(10), null), isTrue);
    });

    test('seuls les jours du début à la veille de la fin comptent', () {
      expect(d.erreurPlage(_j(10), _j(14)), messageDatesReservees);
      expect(d.erreurPlage(_j(12), _j(14)), messageDatesReservees);
      // Rendu le 12 : accepté.
      expect(d.erreurPlage(_j(10), _j(12)), isNull);
      expect(d.erreurPlage(_j(13), _j(15)), isNull);
    });
  });

  group('hébergement : jour de départ libre', () {
    final d = Disponibilites.fromJson({
      'unites_total': 3,
      'jours_complets': ['2026-11-12'],
      'unites_restantes': {'2026-11-10': 1, '2026-11-11': 2},
    });

    test(
      'un jour complet peut être choisi comme départ, pas comme arrivée',
      () {
        expect(d.selectionnable(_j(12), null, null), isFalse);
        expect(d.selectionnable(_j(12), _j(10), null), isTrue);
        // Plage déjà choisie jusqu'au 12 : le 12 reste valable.
        expect(d.selectionnable(_j(12), _j(10), _j(12)), isTrue);
        expect(d.selectionnable(_j(12), _j(14), null), isFalse);
      },
    );

    test('arriver le jour où un autre part : départ le 12 accepté', () {
      expect(d.erreurPlage(_j(11), _j(12)), isNull);
      expect(d.erreurPlage(_j(11), _j(13)), messageDatesReservees);
    });

    test('plus de chambres demandées qu\'il n\'en reste', () {
      expect(d.erreurPlage(_j(10), _j(12), unites: 1), isNull);
      final message = d.erreurPlage(_j(10), _j(12), unites: 2);
      expect(message, contains('Certaines dates de cette période'));
      expect(message, contains('il ne reste que 1 chambre'));
      expect(d.erreurPlage(_j(11), _j(12), unites: 2), isNull);
    });
  });

  group('échec réseau : pas de blocage', () {
    test('erreur : aucun jour bloqué', () async {
      final d = await Disponibilites.ouAucune(
        () async => throw Exception('hors ligne'),
      );
      expect(identical(d, Disponibilites.aucune), isTrue);
    });

    test('réponse trop lente : aucun jour bloqué', () async {
      final jamais = Completer<Disponibilites>();
      final d = await Disponibilites.ouAucune(
        () => jamais.future,
        delai: const Duration(milliseconds: 10),
      );
      expect(d.joursComplets, isEmpty);
    });
  });
}
