import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/partenaire_categorie.dart';
import 'package:poufiret/features/map/data/service_position.dart';

part 'map_providers.g.dart';

/// Service de position (geolocator), partagé.
@Riverpod(keepAlive: true)
ServicePosition servicePosition(Ref ref) => ServicePosition();

/// Catégorie sélectionnée dans les filtres de la carte.
/// null = onglet « Tous ».
@riverpod
class CategorieCarte extends _$CategorieCarte {
  @override
  String? build() => null;

  void choisir(String? slug) => state = slug;
}

/// Position actuelle de l'utilisateur (demandée une fois, mémorisée).
@Riverpod(keepAlive: true)
Future<ResultatPosition> positionUtilisateur(Ref ref) {
  return ref.watch(servicePositionProvider).positionActuelle();
}

/// Partenaires géolocalisés selon le filtre catégorie courant.
/// Rechargé quand la catégorie change (un seul appel réseau à chaque fois).
@riverpod
Future<List<PartenaireCategorie>> partenairesCarte(Ref ref) async {
  final categorie = ref.watch(categorieCarteProvider);
  final partenaires = await ref
      .watch(catalogueRepositoryProvider)
      .cartePartenaires(categorie: categorie);
  return partenaires.where((p) => p.aPosition).toList();
}
