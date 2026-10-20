import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_api.dart';
import '../../../global/cache/contexte_cache.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/catalogue_commerce.dart';
import '../metier_domaine/meta_gabarits.dart';
import 'commerces_repository.dart';

part 'commerces_providers.g.dart';

@riverpod
CommercesRepository commercesRepository(Ref ref) {
  return CommercesRepository(ref.watch(dioProvider));
}

/// Meta des gabarits (choix des filtres) : quasi statique.
@Riverpod(keepAlive: true)
Stream<MetaGabarits> metaGabarits(Ref ref) {
  final repo = ref.watch(commercesRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'restaurants/meta/gabarits',
    politique: PolitiqueCache.geographie,
    reseau: repo.metaGabaritsBrut,
    decoder: MetaGabarits.new,
  );
}

/// Fiche d'un produit (avec ses autres produits), cache d'abord.
@riverpod
Stream<ProduitDetail> produitDetail(Ref ref, {required int id}) {
  final repo = ref.watch(commercesRepositoryProvider);
  return fluxCache(
    ref,
    cle: 'restaurants/produits/$id',
    politique: PolitiqueCache.restaurantDetail,
    reseau: () => repo.produitBrut(id),
    decoder: repo.produitDepuis,
  );
}

/// Liste paginée d'un rayon, d'une recherche ou de filtres : la première
/// page à la construction, la suivante à chaque [chargerSuite] (défilement
/// infini). Toujours lue sur le réseau : stock et prix bougent.
@riverpod
class ProduitsPagines extends _$ProduitsPagines {
  @override
  EtatPagination build(RequeteProduits requete) {
    Future.microtask(chargerSuite);
    return const EtatPagination(chargement: true);
  }

  /// Charge la page suivante (sans effet pendant un chargement ou en fin
  /// de liste). Après une erreur, relance la page manquée.
  Future<void> chargerSuite() async {
    if (_enCours || !state.aSuite) return;
    _enCours = true;
    final etat = state;
    state = etat.copyWith(chargement: true, effacerErreur: true);
    final page = etat.pagesChargees + 1;
    try {
      final recu = await ref
          .read(commercesRepositoryProvider)
          .produits(requete, page: page);
      if (!ref.mounted) return;
      final garde = recu.results.where(requete.filtre.garde);
      state = EtatPagination(
        produits: [...state.produits, ...garde],
        total: recu.count,
        pagesChargees: page,
        aSuite: recu.aSuite,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(chargement: false, erreur: e);
    } finally {
      _enCours = false;
    }
  }

  /// Une page à la fois.
  bool _enCours = false;
}
