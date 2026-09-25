import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'carte_google.dart';
import 'carte_osm.dart';
import 'modeles_carte.dart';
import 'services_google.dart';

/// LA carte de l'app : Google Maps quand les services Google sont disponibles,
/// OpenStreetMap sinon (ex. Huawei). Tous les ecrans passent par ce widget ;
/// leur logique metier ne connait aucune des deux bibliotheques.
class CartePoufiret extends ConsumerWidget {
  const CartePoufiret({
    super.key,
    required this.centreInitial,
    this.zoomInitial = 14,
    this.marqueurs = const [],
    this.polylignes = const [],
    this.controleur,
    this.onTap,
    this.onPrete,
    this.afficherPosition = false,
    this.positionUtilisateur,
    this.boutonsZoom = false,
    this.satellite = false,
  });

  final PointCarte centreInitial;
  final double zoomInitial;
  final List<MarqueurCarte> marqueurs;
  final List<PolyligneCarte> polylignes;
  final ControleurCarte? controleur;
  final ValueChanged<PointCarte>? onTap;
  final VoidCallback? onPrete;
  final bool afficherPosition;
  final PointCarte? positionUtilisateur;
  final bool boutonsZoom;
  final bool satellite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final google = ref.watch(servicesGoogleProvider);
    // La detection est lancee au demarrage : ce chargement n'est visible que
    // si la carte s'ouvre avant sa reponse.
    if (google.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Erreur de detection : on prefere OSM (qui marche) a une carte grise.
    return (google.value ?? false)
        ? CarteGoogle(
            centreInitial: centreInitial,
            zoomInitial: zoomInitial,
            marqueurs: marqueurs,
            polylignes: polylignes,
            controleur: controleur,
            onTap: onTap,
            onPrete: onPrete,
            afficherPosition: afficherPosition,
            positionUtilisateur: positionUtilisateur,
            boutonsZoom: boutonsZoom,
            satellite: satellite,
          )
        : CarteOsm(
            centreInitial: centreInitial,
            zoomInitial: zoomInitial,
            marqueurs: marqueurs,
            polylignes: polylignes,
            controleur: controleur,
            onTap: onTap,
            onPrete: onPrete,
            afficherPosition: afficherPosition,
            positionUtilisateur: positionUtilisateur,
            boutonsZoom: boutonsZoom,
            satellite: satellite,
          );
  }
}

/// Vrai si la vue satellite est disponible (Google seulement) : les ecrans
/// masquent alors leur bouton de bascule.
final satelliteDisponibleProvider = Provider<bool>(
  (ref) => ref.watch(servicesGoogleProvider).value ?? false,
);
