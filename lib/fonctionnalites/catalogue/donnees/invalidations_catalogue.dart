import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/cache_providers.dart';
import '../../partenaire/donnees/partenaire_providers.dart';
import 'catalogue_providers.dart';

// Apres une ECRITURE (creation, modification, suppression), on declare
// perimees les lectures cachees concernees (disque + memoire) puis on
// invalide leurs providers : le prochain affichage va au reseau au lieu de
// ressortir la valeur d'avant.

/// Articles (listes et fiches) : creation, modification, suppression, photos.
void invaliderArticles(WidgetRef ref) {
  final cache = ref.read(cacheApiProvider);
  cache.perimer('articles/');
  cache.perimer('article/');
  ref.invalidate(articlesProvider);
  ref.invalidate(articleDetailProvider);
}

/// Profil / vitrine d'un partenaire (nom, logo, couverture, position) : touche
/// la vitrine et les annuaires de categories.
void invaliderPartenaires(WidgetRef ref) {
  final cache = ref.read(cacheApiProvider);
  cache.perimer('vitrine/');
  cache.perimer('partenaires/');
  ref.invalidate(partenaireVitrineProvider);
  ref.invalidate(partenairesParCategorieProvider);
}

/// Categories d'un partenaire (image, activation) : touche l'accueil et les
/// annuaires.
void invaliderCategories(WidgetRef ref) {
  final cache = ref.read(cacheApiProvider);
  cache.perimer('categories');
  cache.perimer('partenaires/');
  ref.invalidate(categoriesProvider);
  ref.invalidate(partenairesParCategorieProvider);
}
