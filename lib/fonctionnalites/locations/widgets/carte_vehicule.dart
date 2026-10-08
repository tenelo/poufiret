import 'package:flutter/material.dart';

import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';
import '../screens/ecran_vehicule.dart';
import 'carte_logement.dart';

/// Carte d'un véhicule dans une liste : photo à gauche ; à droite
/// « Marque Modèle Année », « 5 places · Automatique · Diesel », le prix par
/// jour et la mention « Avec chauffeur » si un chauffeur est proposé.
class CarteVehicule extends StatelessWidget {
  const CarteVehicule({super.key, required this.vehicule});

  final VehiculeResume vehicule;

  @override
  Widget build(BuildContext context) {
    final v = vehicule;
    return CarteLocation(
      photo: v.photo,
      iconeSansPhoto: Icons.directions_car_outlined,
      titre: v.nomComplet,
      sousTitre: v.caracteristiques,
      prix: formatPrixJour(v.prixAffiche),
      puces: [if (v.avecChauffeur) 'Avec chauffeur'],
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EcranVehicule(vehiculeId: v.id, titre: v.nomComplet),
        ),
      ),
    );
  }
}
