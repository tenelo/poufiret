// Gabarits de page des commerces servis par l'API « restaurants » : un
// grilleur et un fast-food reprennent la page restaurant sans menus du
// jour, une boulangerie la réutilise en grille, pharmacie, mode, librairie
// et élevage ont leur page catalogue.

/// Page dédiée ouverte par le toucher d'un partenaire.
enum Gabarit {
  restaurant,

  /// Grillades & braisés : page restaurant sans menus du jour (la carte).
  grillades,

  /// Fast-food : page restaurant sans menus du jour, « Les plus commandés ».
  fastFood,
  boulangerie,
  pharmacie,
  mode,
  librairie,
  elevage,
}

/// Gabarit par valeur reçue du serveur (« restaurant », « pharmacie »...).
Gabarit? gabaritDepuis(String? valeur) => switch ((valeur ?? '').trim()) {
  'restaurant' => Gabarit.restaurant,
  'fast_food' || 'fastfood' => Gabarit.fastFood,
  'grillades' || 'grilleur' => Gabarit.grillades,
  'boulangerie' => Gabarit.boulangerie,
  'pharmacie' => Gabarit.pharmacie,
  'mode' || 'boutique_mode' || 'chaussures' => Gabarit.mode,
  'librairie' => Gabarit.librairie,
  'elevage' || 'eleveur' => Gabarit.elevage,
  _ => null,
};

/// Déduction depuis le type de partenaire quand la carte ne porte pas de
/// gabarit. `restaurateur` y figure : il ouvrait déjà la page restaurant.
const gabaritsParType = {
  'restaurateur': Gabarit.restaurant,
  'fast_food': Gabarit.fastFood,
  'grilleur': Gabarit.grillades,
  'boulanger': Gabarit.boulangerie,
  'pharmacien': Gabarit.pharmacie,
  'boutique_mode': Gabarit.mode,
  'libraire': Gabarit.librairie,
  'eleveur': Gabarit.elevage,
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
