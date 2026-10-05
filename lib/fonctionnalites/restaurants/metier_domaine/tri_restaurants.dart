import 'restaurant_models.dart';

const _accents = {
  'à': 'a',
  'â': 'a',
  'ä': 'a',
  'ç': 'c',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'î': 'i',
  'ï': 'i',
  'ô': 'o',
  'ö': 'o',
  'ù': 'u',
  'û': 'u',
  'ü': 'u',
};

/// Minuscules sans accents, pour comparer « Ferké » et « ferke ».
String sansAccents(String texte) =>
    texte.toLowerCase().split('').map((c) => _accents[c] ?? c).join();

/// Restaurants correspondant aux filtres, les ouverts d'abord (les fermés
/// restent listés, à la suite). L'ordre du serveur est conservé à statut égal.
List<Restaurant> filtrerRestaurants(
  List<Restaurant> restaurants, {
  String recherche = '',
  bool ouvertMaintenant = false,
  bool livraison = false,
  bool emporter = false,
}) {
  final terme = sansAccents(recherche.trim());
  bool correspond(Restaurant r) {
    if (ouvertMaintenant && !r.estOuvert) return false;
    if (livraison && !r.fiche.services.contains('livraison')) return false;
    if (emporter && !r.fiche.services.contains('emporter')) return false;
    if (terme.isEmpty) return true;
    return [
      r.nom,
      ...r.fiche.specialites,
    ].any((t) => sansAccents(t).contains(terme));
  }

  final retenus = restaurants.where(correspond).toList();
  return [
    ...retenus.where((r) => !r.estFerme),
    ...retenus.where((r) => r.estFerme),
  ];
}

/// Plats d'une section dont le nom ou la description contient [recherche].
List<Plat> filtrerPlats(List<Plat> plats, String recherche) {
  final terme = sansAccents(recherche.trim());
  if (terme.isEmpty) return plats;
  return plats
      .where(
        (p) =>
            sansAccents(p.nom).contains(terme) ||
            sansAccents(p.description).contains(terme),
      )
      .toList();
}
