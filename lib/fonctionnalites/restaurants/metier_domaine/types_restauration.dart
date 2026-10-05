/// Types de partenaire servis par l'expérience « restaurant » (écran
/// Restaurants, page restaurant, fiche plat) au lieu de l'annuaire et de la
/// vitrine génériques. Ajouter un type ici (ex. fast-food) suffit à
/// l'y faire entrer.
const typesRestauration = {'restaurateur'};

/// Vrai si une catégorie portant ces types de partenaire relève de la
/// restauration.
bool estRestauration(Iterable<String> typesPartenaire) =>
    typesPartenaire.any(typesRestauration.contains);

/// Libellés des services proposés par un restaurant.
const libellesService = {
  'livraison': 'Livraison',
  'emporter': 'À emporter',
  'sur_place': 'Sur place',
};

/// Libellés des services d'un menu du jour.
const libellesServiceMenu = {
  'midi': 'Midi',
  'soir': 'Soir',
  'journee': 'Journée',
};
