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

/// Mots d'un texte, en minuscules sans accents (« Œufs frais » → oeufs,
/// frais ; « d'Alfred » → d, alfred).
List<String> _motsNormalises(String texte) => sansAccents(texte)
    .replaceAll('œ', 'oe')
    .replaceAll('æ', 'ae')
    .split(RegExp(r'[^a-z0-9]+'))
    .where((m) => m.isNotEmpty)
    .toList();

/// Plats dont le nom ou la description a, pour chaque mot de [recherche],
/// un mot qui commence par lui (« poul » trouve « Poulet bicyclette »,
/// « oeuf » trouve « Œufs frais », pas « bœuf »). Casse et accents ignorés.
List<Plat> filtrerPlatsDebutDeMot(List<Plat> plats, String recherche) {
  final termes = _motsNormalises(recherche);
  if (termes.isEmpty) return plats;
  return plats.where((p) {
    final mots = _motsNormalises('${p.nom} ${p.description}');
    return termes.every((t) => mots.any((m) => m.startsWith(t)));
  }).toList();
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
