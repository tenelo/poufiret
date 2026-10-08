import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global/carte/carte_poufiret.dart';
import '../../../global/carte/modeles_carte.dart';
import '../../../global/config/config.dart';
import '../../../global/ui/liens_externes.dart';

// Briques communes aux fiches de location (logement, véhicule).

/// Section titrée d'une fiche.
class SectionFiche extends StatelessWidget {
  const SectionFiche({super.key, required this.titre, required this.child});

  final String titre;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// Caractéristique en icône : « 3 chambres », « Automatique »...
class CaracteristiqueFiche extends StatelessWidget {
  const CaracteristiqueFiche(this.icone, this.texte, {super.key});

  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Config.couleurSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(texte, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

/// Ligne « libellé ........ valeur » des conditions et tarifs.
class LigneFiche extends StatelessWidget {
  const LigneFiche(this.libelle, this.valeur, {super.key});

  final String libelle;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              libelle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              valeur,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Itinéraire et Localisation (carte en feuille) d'un point. Rien sans
/// coordonnées.
class BoutonsPosition extends StatelessWidget {
  const BoutonsPosition({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.titreCarte,
    required this.nomMarqueur,
  });

  final double? latitude;
  final double? longitude;

  /// Titre de la feuille « Localisation ».
  final String titreCarte;
  final String nomMarqueur;

  void _montrerCarte(BuildContext context) {
    final point = PointCarte(latitude!, longitude!);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titreCarte, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: CartePoufiret(
                  centreInitial: point,
                  zoomInitial: 15,
                  boutonsZoom: true,
                  marqueurs: [
                    MarqueurCarte(
                      id: 'position',
                      position: point,
                      titre: nomMarqueur,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (latitude == null || longitude == null) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () =>
                ouvrirLien(context, uriItineraire(latitude!, longitude!)),
            icon: const Icon(Icons.directions_outlined, size: 18),
            label: const Text('Itinéraire'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _montrerCarte(context),
            icon: const Icon(Icons.map_outlined, size: 18),
            label: const Text('Localisation'),
          ),
        ),
      ],
    );
  }
}

/// Appeler et WhatsApp (chacun seulement si le numéro est connu).
class BoutonsContact extends StatelessWidget {
  const BoutonsContact({
    super.key,
    required this.telephone,
    required this.whatsapp,
  });

  final String telephone;
  final String whatsapp;

  @override
  Widget build(BuildContext context) {
    if (telephone.isEmpty && whatsapp.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        if (telephone.isNotEmpty)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => ouvrirLien(context, uriAppel(telephone)),
              icon: const Icon(Icons.call, size: 18),
              label: const Text('Appeler'),
            ),
          ),
        if (telephone.isNotEmpty && whatsapp.isNotEmpty)
          const SizedBox(width: 12),
        if (whatsapp.isNotEmpty)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => ouvrirLien(context, uriWhatsapp(whatsapp)),
              icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
              label: const Text('WhatsApp'),
            ),
          ),
      ],
    );
  }
}

/// Barre du bas d'une fiche : Itinéraire et Localisation (seulement avec
/// des coordonnées), puis l'action principale.
class BarreActionsFiche extends StatelessWidget {
  const BarreActionsFiche({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.titreCarte,
    required this.nomMarqueur,
    required this.action,
  });

  final double? latitude;
  final double? longitude;
  final String titreCarte;
  final String nomMarqueur;

  /// Bouton principal (« Demander une visite », « Réserver »).
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final aPosition = latitude != null && longitude != null;
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (aPosition) ...[
                  BoutonsPosition(
                    latitude: latitude,
                    longitude: longitude,
                    titreCarte: titreCarte,
                    nomMarqueur: nomMarqueur,
                  ),
                  const SizedBox(height: 8),
                ],
                action,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Encadré « Montant estimé » d'une feuille de réservation.
class EncadreMontant extends StatelessWidget {
  const EncadreMontant({super.key, required this.libelle, this.vide = ''});

  /// « 3 jours × 25 000 F = 75 000 F » ; null tant qu'il manque un choix.
  final String? libelle;

  /// Invitation affichée tant que [libelle] est null.
  final String vide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texte = libelle;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Config.couleurFond,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Montant estimé', style: theme.textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(
            texte ?? vide,
            style: texte == null
                ? theme.textTheme.bodyMedium?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  )
                : theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
          ),
          if (texte != null)
            Text(
              'Hors caution et frais éventuels ; le loueur confirme le prix.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
        ],
      ),
    );
  }
}
