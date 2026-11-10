import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../fonctionnalites/analytics/donnees/service_suivi.dart';
import '../ui/liens_externes.dart';
import '../ui/whatsapp_externe.dart';
import '../../fonctionnalites/auth/widgets/mur_inscription.dart';

/// Vert WhatsApp.
const couleurWhatsapp = Color(couleurWhatsappValeur);

/// Ouvre le vrai WhatsApp du partenaire (message prérempli) et note
/// l'événement `whatsapp_partenaire`. Sans l'app, le lien web s'ouvre.
Future<void> ouvrirWhatsappExterne(
  BuildContext context,
  String numero, {
  int? partenaireId,
}) async {
  // Contact du partenaire : compte connecté.
  if (!await exigerConnexion(context) || !context.mounted) return;
  suivreEvenement(
    context,
    TypeEvenement.whatsappPartenaire,
    partenaireId: partenaireId,
  );
  return ouvrirLien(context, lienWhatsappExterne(numero));
}

/// Icône WhatsApp verte « WhatsApp » (vrai WhatsApp), à côté de l'icône
/// bleue « Discuter » (messagerie interne). Rien si [numero] est null.
class IconeWhatsappExterne extends StatelessWidget {
  const IconeWhatsappExterne({
    super.key,
    required this.numero,
    this.partenaireId,
    this.taille = 24,
  });

  final String? numero;
  final int? partenaireId;
  final double taille;

  @override
  Widget build(BuildContext context) {
    final n = numero;
    if (n == null || !afficherWhatsappExterne(n)) {
      return const SizedBox.shrink();
    }
    return IconButton(
      tooltip: 'WhatsApp',
      icon: FaIcon(
        FontAwesomeIcons.whatsapp,
        color: couleurWhatsapp,
        size: taille,
      ),
      onPressed: () =>
          ouvrirWhatsappExterne(context, n, partenaireId: partenaireId),
    );
  }
}

/// Bouton « WhatsApp » vert avec libellé (fiches à boutons Appeler /
/// WhatsApp). Rien si [numero] est null.
class BoutonWhatsappExterne extends StatelessWidget {
  const BoutonWhatsappExterne({
    super.key,
    required this.numero,
    this.partenaireId,
  });

  final String? numero;
  final int? partenaireId;

  @override
  Widget build(BuildContext context) {
    final n = numero;
    if (n == null || !afficherWhatsappExterne(n)) {
      return const SizedBox.shrink();
    }
    return OutlinedButton.icon(
      onPressed: () =>
          ouvrirWhatsappExterne(context, n, partenaireId: partenaireId),
      icon: const FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 18,
        color: couleurWhatsapp,
      ),
      label: const Text('WhatsApp'),
    );
  }
}
