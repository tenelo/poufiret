import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../metier_domaine/location_models.dart';
import '../screens/ecran_logement.dart';

/// Carte d'un logement dans une liste : photo à gauche ; à droite le titre,
/// la localisation, le loyer et les puces (chambres, sdb, meublé).
class CarteLogement extends StatelessWidget {
  const CarteLogement({super.key, required this.logement});

  final LogementResume logement;

  static const double _cotePhoto = 108;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = logement;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EcranLogement(logementId: l.id, titre: l.titre),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: _cotePhoto,
                child: l.photo.isEmpty
                    ? ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.home_outlined,
                          size: 36,
                          color: theme.colorScheme.outline,
                        ),
                      )
                    : ImageReseau(
                        l.photo,
                        fit: BoxFit.cover,
                        largeurAffichee: _cotePhoto,
                      ),
              ),
              Expanded(
                child: ConstrainedBox(
                  // Jamais plus basse que la photo carrée.
                  constraints: const BoxConstraints(minHeight: _cotePhoto),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l.titre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (l.localisationTexte.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            l.localisationTexte,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Config.couleurTexteSecondaire,
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          formatLoyer(l.loyer),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (l.puces.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              for (final puce in l.puces) PuceLogement(puce),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Petite puce d'information (« 3 chambres », « Meublé », un équipement).
class PuceLogement extends StatelessWidget {
  const PuceLogement(this.texte, {super.key});

  final String texte;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Config.couleurFond,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Text(texte, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
