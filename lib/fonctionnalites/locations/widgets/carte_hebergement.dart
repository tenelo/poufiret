import 'package:flutter/material.dart';

import '../../../global/widgets/image_reseau.dart';
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
      onTap: () => ouvrirHebergement(context, h),
    );
  }
}

/// Ouvre la fiche d'un hébergement.
void ouvrirHebergement(BuildContext context, HebergementResume h) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => EcranHebergement(hebergementId: h.id, titre: h.titre),
    ),
  );
}

/// Carte verticale d'un hébergement (carrousel de la page établissement) :
/// photo en haut, puis nom, prix par nuit et capacité.
class CarteHebergementCompacte extends StatelessWidget {
  const CarteHebergementCompacte({super.key, required this.hebergement});

  final HebergementResume hebergement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final h = hebergement;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => ouvrirHebergement(context, h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: h.photo.isEmpty
                  ? ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.hotel_outlined,
                        size: 36,
                        color: theme.colorScheme.outline,
                      ),
                    )
                  : ImageReseau(h.photo, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h.titre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatPrixNuit(h.prixNuit),
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (h.capacite.isNotEmpty)
                    Text(
                      h.capacite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
