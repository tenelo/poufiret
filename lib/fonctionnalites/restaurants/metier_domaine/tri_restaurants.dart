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
