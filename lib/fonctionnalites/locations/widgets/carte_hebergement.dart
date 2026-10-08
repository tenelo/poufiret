import 'package:flutter/material.dart';

import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../screens/ecran_hebergement.dart';
import 'carte_logement.dart';

/// Carte d'un hébergement : photo à gauche ; à droite le titre, le type,
/// « 2 adultes · 1 enfant », les lits et « 25 000 F/nuit ».
class CarteHebergement extends StatelessWidget {
  const CarteHebergement({super.key, required this.hebergement});

  final HebergementResume hebergement;

  @override
  Widget build(BuildContext context) {
    final h = hebergement;
    return CarteLocation(
      photo: h.photo,
      iconeSansPhoto: Icons.hotel_outlined,
      titre: h.titre,
      sousTitre: h.type,
      prix: formatPrixNuit(h.prixNuit),
      puces: [
        if (h.capacite.isNotEmpty) h.capacite,
        if (h.lits.isNotEmpty) h.lits,
      ],
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EcranHebergement(hebergementId: h.id, titre: h.titre),
        ),
      ),
    );
  }
}
