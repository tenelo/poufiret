// Gabarits de page des commerces servis par l'API « restaurants » : un
// fast-food garde la page restaurant, une boulangerie la réutilise en grille,
// pharmacie, mode et librairie ont leur page catalogue.

/// Page dédiée ouverte par le toucher d'un partenaire.
enum Gabarit { restaurant, boulangerie, pharmacie, mode, librairie }

/// Gabarit par valeur reçue du serveur (« restaurant », « pharmacie »...).
Gabarit? gabaritDepuis(String? valeur) => switch ((valeur ?? '').trim()) {
  'restaurant' || 'fast_food' || 'fastfood' => Gabarit.restaurant,
  'boulangerie' => Gabarit.boulangerie,
  'pharmacie' => Gabarit.pharmacie,
  'mode' || 'boutique_mode' || 'chaussures' => Gabarit.mode,
  'librairie' => Gabarit.librairie,
  _ => null,
};

/// Déduction depuis le type de partenaire quand la carte ne porte pas de
/// gabarit. `restaurateur` y figure : il ouvrait déjà la page restaurant.
const gabaritsParType = {
  'restaurateur': Gabarit.restaurant,
  'fast_food': Gabarit.restaurant,
  'boulanger': Gabarit.boulangerie,
  'pharmacien': Gabarit.pharmacie,
  'boutique_mode': Gabarit.mode,
  'libraire': Gabarit.librairie,
};

/// Gabarit d'un partenaire de l'annuaire : son champ `gabarit`, sinon son
/// type, sinon les types de la catégorie (le premier qui en a un). null :
/// la fiche habituelle (ou une autre page dédiée, comme les locations).
Gabarit? gabaritPartenaire({
  String? gabarit,
  Iterable<String> typesPartenaire = const [],
  Iterable<String> typesCategorie = const [],
}) {
  final direct = gabaritDepuis(gabarit);
  if (direct != null) return direct;
  for (final type in [...typesPartenaire, ...typesCategorie]) {
    final g = gabaritsParType[type];
    if (g != null) return g;
  }
  return null;
}
