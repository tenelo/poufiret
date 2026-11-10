import '../../../global/json/convertisseurs.dart';
import 'location_models.dart';

/// Message affiché quand la période choisie touche un jour déjà réservé.
const messageDatesReservees =
    'Certaines dates de cette période sont déjà réservées.';

/// Texte d'aide sous le choix des dates.
const aideDatesReservees =
    'Les dates grisées sont déjà réservées. Votre demande sera confirmée '
    'par le loueur.';

/// Jours déjà réservés (confirmés par le partenaire) d'un véhicule ou d'un
/// hébergement : `GET /locations/<type>/<id>/disponibilites/?du=&au=`.
///
/// Une réservation occupe [début, fin[ : le jour de fin (restitution d'un
/// véhicule, départ d'un hébergement) reste libre — on peut prendre le bien
/// le jour où un autre client le rend.
class Disponibilites {
  const Disponibilites({
    this.unitesTotal,
    this.joursComplets = const {},
    this.unitesRestantes = const {},
  });

  /// Rien de connu : aucun jour bloqué (le serveur tranchera).
  static const aucune = Disponibilites();

  /// Lecture tolérante : clé absente ou illisible = rien de bloqué.
  factory Disponibilites.fromJson(Object? json) {
    if (json is! Map) return aucune;
    final jours = json['jours_complets'];
    final restantes = json['unites_restantes'];
    return Disponibilites(
      unitesTotal: versIntNullable(json['unites_total']),
      joursComplets: {
        if (jours is List)
          for (final j in jours) ?_jour(j),
      },
      unitesRestantes: {
        if (restantes is Map)
          for (final e in restantes.entries) ?_jour(e.key): versInt(e.value),
      },
    );
  }

  final int? unitesTotal;

  /// Jours sans aucune unité libre (dates seules, sans l'heure).
  final Set<DateTime> joursComplets;

  /// Unités encore libres par jour (hébergement).
  final Map<DateTime, int> unitesRestantes;

  static DateTime? _jour(Object? valeur) {
    final date = DateTime.tryParse('${valeur ?? ''}');
    return date == null ? null : DateTime(date.year, date.month, date.day);
  }

  static DateTime _seul(DateTime d) => DateTime(d.year, d.month, d.day);

  bool estComplet(DateTime jour) => joursComplets.contains(_seul(jour));

  /// Jours occupés par une plage : de [du] à la veille de [au].
  static Iterable<DateTime> joursOccupes(DateTime du, DateTime au) sync* {
    var jour = _seul(du);
    final fin = _seul(au);
    while (jour.isBefore(fin)) {
      yield jour;
      jour = DateTime(jour.year, jour.month, jour.day + 1);
    }
  }

  /// Prédicat du calendrier (jour, début choisi, fin choisie). Un jour
  /// complet est grisé, mais reste choisissable comme jour de FIN (après un
  /// début déjà choisi).
  bool selectionnable(DateTime jour, DateTime? debut, DateTime? fin) {
    if (!estComplet(jour)) return true;
    if (debut == null || !_seul(jour).isAfter(_seul(debut))) {
      return false;
    }
    return fin == null || _seul(fin) == _seul(jour);
  }

  /// Problème de la plage choisie, ou null si elle convient : un jour
  /// complet entre [du] et la veille de [au], ou (hébergement) moins
  /// d'unités restantes que demandées sur l'un de ces jours.
  String? erreurPlage(DateTime du, DateTime au, {int unites = 1}) {
    final jours = joursOccupes(du, au).toList();
    if (jours.any(estComplet)) return messageDatesReservees;
    final restantes = [for (final j in jours) ?unitesRestantes[j]];
    if (restantes.isNotEmpty) {
      final minimum = restantes.reduce((a, b) => a < b ? a : b);
      if (unites > minimum) {
        return 'Certaines dates de cette période sont déjà réservées : '
            'il ne reste que ${pluriel(minimum, 'chambre')} sur une '
            'partie du séjour.';
      }
    }
    return null;
  }

  /// Charge les disponibilités ; en cas d'échec (réseau, endpoint absent),
  /// rien n'est bloqué : le calendrier s'ouvre et le serveur refusera si
  /// besoin.
  static Future<Disponibilites> ouAucune(
    Future<Disponibilites> Function() charger, {
    Duration delai = const Duration(seconds: 8),
  }) async {
    try {
      return await charger().timeout(delai);
    } catch (_) {
      return aucune;
    }
  }
}

/// Jours refusés par le serveur (400 `details.jours_complets`), ou null.
List<String>? joursRefuses(Map<String, dynamic> details) {
  final jours = details['jours_complets'];
  return jours is List ? [for (final j in jours) '$j'] : null;
}
