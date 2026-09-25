import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/cache_providers.dart';
import 'publicites_providers.dart';

/// Apres l'activation d'une publicite : les listes publiques (carrousel,
/// onglet, bandeau) doivent aller au reseau au prochain affichage.
void invaliderPublicites(WidgetRef ref) {
  ref.read(cacheApiProvider).perimer('pubs/');
  ref.invalidate(carrouselPublicitesProvider);
  ref.invalidate(pagePublicitesProvider);
  ref.invalidate(bandeauBasPubliciteProvider);
}
