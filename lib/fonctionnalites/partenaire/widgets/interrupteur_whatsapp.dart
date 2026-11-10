import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';

/// « Afficher mon WhatsApp aux clients » (`whatsapp_externe_actif`).
/// Enregistré dès qu'il bascule ; désactivé, avec une explication, tant
/// qu'aucun numéro WhatsApp n'est enregistré. Un refus du serveur est
/// affiché tel quel et l'interrupteur revient à sa position.
class InterrupteurWhatsappExterne extends StatefulWidget {
  const InterrupteurWhatsappExterne({
    super.key,
    required this.actif,
    required this.numero,
    required this.enregistrer,
  });

  /// Valeur enregistrée.
  final bool actif;

  /// Numéro WhatsApp enregistré sur le profil (vide : interrupteur grisé).
  final String numero;

  /// Envoie `whatsapp_externe_actif` au serveur.
  final Future<void> Function(bool actif) enregistrer;

  @override
  State<InterrupteurWhatsappExterne> createState() =>
      _InterrupteurWhatsappExterneState();
}

class _InterrupteurWhatsappExterneState
    extends State<InterrupteurWhatsappExterne> {
  late bool _actif = widget.actif;
  bool _envoi = false;
  String? _erreur;

  @override
  void didUpdateWidget(InterrupteurWhatsappExterne ancien) {
    super.didUpdateWidget(ancien);
    if (ancien.actif != widget.actif && !_envoi) _actif = widget.actif;
  }

  Future<void> _basculer(bool valeur) async {
    setState(() {
      _actif = valeur;
      _envoi = true;
      _erreur = null;
    });
    try {
      await widget.enregistrer(valeur);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _actif = !valeur;
        _erreur = messageErreurApi(
          e,
          repli: 'Enregistrement impossible. Réessayez.',
        );
      });
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sansNumero = widget.numero.trim().isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Afficher mon WhatsApp aux clients'),
          subtitle: Text(
            sansNumero
                ? 'Enregistrez d\'abord votre numéro WhatsApp ci-dessus pour '
                      'pouvoir l\'afficher.'
                : 'Un bouton WhatsApp vert apparaît sur vos pages. La '
                      'messagerie Poufiret reste disponible.',
          ),
          value: _actif && !sansNumero,
          onChanged: sansNumero || _envoi ? null : _basculer,
        ),
        if (_erreur != null)
          Text(
            _erreur!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Config.couleurErreur,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
