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

  @override
  Widget build(BuildContext context) {
    final l = logement;
    return CarteLocation(
      photo: l.photo,
      iconeSansPhoto: Icons.home_outlined,
      titre: l.titre,
      sousTitre: l.localisationTexte,
      prix: formatLoyer(l.loyer),
      puces: l.puces,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EcranLogement(logementId: l.id, titre: l.titre),
        ),
      ),
    );
  }
}

/// Mise en page commune des cartes de location (logement, véhicule) :
/// photo carrée à gauche ; à droite le titre, une ligne secondaire, le prix
/// et des puces.
class CarteLocation extends StatelessWidget {
  const CarteLocation({
    super.key,
    required this.photo,
    required this.iconeSansPhoto,
    required this.titre,
    required this.prix,
    required this.onTap,
    this.sousTitre = '',
    this.puces = const [],
  });

  final String photo;
  final IconData iconeSansPhoto;
  final String titre;
  final String sousTitre;
  final String prix;
  final List<String> puces;
  final VoidCallback onTap;

  static const double _cotePhoto = 108;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: _cotePhoto,
                child: photo.isEmpty
                    ? ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          iconeSansPhoto,
                          size: 36,
                          color: theme.colorScheme.outline,
                        ),
                      )
                    : ImageReseau(
                        photo,
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
                          titre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (sousTitre.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            sousTitre,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Config.couleurTexteSecondaire,
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          prix,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (puces.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              for (final puce in puces) PuceLogement(puce),
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
