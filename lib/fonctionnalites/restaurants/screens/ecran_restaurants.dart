import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/restaurants_providers.dart';
import '../metier_domaine/tri_restaurants.dart';
import '../widgets/carte_restaurant.dart';

/// Écran « Restaurants » : remplace l'annuaire générique pour les catégories
/// de restauration.
class EcranRestaurants extends StatelessWidget {
  const EcranRestaurants({
    super.key,
    this.titre = 'Restaurants',
    this.categorieId,
  });

  final String titre;
  final int? categorieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: ContenuRestaurants(categorieId: categorieId),
    );
  }
}

/// Contenu de l'écran (recherche, filtres, cartes), sans barre ni Scaffold :
/// partagé avec l'onglet de la catégorie sur l'accueil.
class ContenuRestaurants extends ConsumerStatefulWidget {
  const ContenuRestaurants({super.key, this.categorieId});

  /// Catégorie d'origine, pour compter la visite (statistiques).
  final int? categorieId;

  @override
  ConsumerState<ContenuRestaurants> createState() => _ContenuRestaurantsState();
}

class _ContenuRestaurantsState extends ConsumerState<ContenuRestaurants> {
  String _recherche = '';
  bool _livraison = false;
  bool _emporter = false;

  @override
  Widget build(BuildContext context) {
    final categorieId = widget.categorieId;
    if (categorieId != null) {
      ref.watch(visiteCategorieProvider(categorieId: categorieId));
    }
    final async = ref.watch(restaurantsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: TextField(
            onChanged: (v) => setState(() => _recherche = v),
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Nom ou spécialité',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              FilterChip(
                label: const Text('Livraison'),
                selected: _livraison,
                onSelected: (v) => setState(() => _livraison = v),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('À emporter'),
                selected: _emporter,
                onSelected: (v) => setState(() => _emporter = v),
              ),
            ],
          ),
        ),
        Expanded(
          child: async.when(
            skipLoadingOnReload: true,
            loading: () => const SqueletteListePartenaires(),
            error: (err, _) => MessageErreur(
              message: messageErreurApi(
                err,
                repli: 'Impossible de charger les restaurants.',
              ),
              onReessayer: () => ref.invalidate(restaurantsProvider),
            ),
            data: (tous) {
              final restaurants = filtrerRestaurants(
                tous,
                recherche: _recherche,
                livraison: _livraison,
                emporter: _emporter,
              );
              return LayoutBuilder(
                builder: (context, contraintes) {
                  final largeur = contraintes.maxWidth > 700
                      ? 700.0
                      : contraintes.maxWidth;
                  return Center(
                    child: SizedBox(
                      width: largeur,
                      child: RefreshIndicator(
                        onRefresh: () => rafraichir(ref, restaurantsProvider),
                        child: restaurants.isEmpty
                            // Défilable même vide : le geste « tirer pour
                            // rafraîchir » reste possible.
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(32),
                                children: [
                                  Text(
                                    tous.isEmpty
                                        ? 'Aucun restaurant pour le moment.'
                                        : 'Aucun restaurant ne correspond à '
                                              'votre recherche.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(12),
                                itemCount: restaurants.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, i) => CarteRestaurant(
                                  key: ValueKey(restaurants[i].id),
                                  restaurant: restaurants[i],
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
