import 'hebergement_models.dart';
import 'location_models.dart';

/// Séjour cherché sur la page d'un établissement : dates et voyageurs.
/// Il filtre la liste des hébergements et pré-remplit la réservation.
class Sejour {
  const Sejour({
    required this.arrivee,
    required this.depart,
    this.adultes = 1,
    this.enfants = 0,
  });

  final DateTime arrivee;
  final DateTime depart;
  final int adultes;
  final int enfants;

  int get voyageurs => adultes + enfants;

  int get nuits => nombreNuits(arrivee, depart);

  /// Assez de place pour ces voyageurs (capacité inconnue : gardé).
  bool capaciteSuffisante(HebergementResume h) {
    if (h.capaciteAdultes <= 0) return true;
    return h.capaciteAdultes >= adultes && h.capaciteTotale >= voyageurs;
  }

  /// « Du 10/11/2026 au 13/11/2026 · 3 nuits ».
  String get libelleDates {
    final du = formatDateCourte(formatDateIso(arrivee));
    final au = formatDateCourte(formatDateIso(depart));
    return 'Du $du au $au · ${pluriel(nuits, 'nuit')}';
  }

  /// « 2 adultes · 1 enfant ».
  String get libelleVoyageurs => capaciteLisible(adultes, enfants);

  @override
  bool operator ==(Object other) =>
      other is Sejour &&
      other.arrivee == arrivee &&
      other.depart == depart &&
      other.adultes == adultes &&
      other.enfants == enfants;

  @override
  int get hashCode => Object.hash(arrivee, depart, adultes, enfants);
}

/// Hébergements à montrer pour [sejour] : capacité suffisante, les complets
/// ([complets] : id → complet, absent = pas encore connu) en fin de liste.
List<HebergementResume> hebergementsPourSejour(
  List<HebergementResume> hebergements,
  Sejour sejour,
  Map<int, bool> complets,
) {
  final places = hebergements.where(sejour.capaciteSuffisante).toList();
  return [
    for (final h in places)
      if (complets[h.id] != true) h,
    for (final h in places)
      if (complets[h.id] == true) h,
  ];
}
