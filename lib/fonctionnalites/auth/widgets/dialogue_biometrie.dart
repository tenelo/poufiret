import 'package:flutter/material.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/service_biometrie.dart';

/// Propose (une seule fois) d'activer le déverrouillage par empreinte,
/// juste après une connexion/inscription réussie.
///
/// Ne fait rien si le matériel biométrique est absent ou si la préférence
/// a déjà été fixée. Renvoie true si la biométrie vient d'être activée.
Future<bool> proposerActivationBiometrie({
  required BuildContext context,
  required Future<bool> Function() biometrieDejaChoisie,
  required Future<void> Function(bool) definirBiometrie,
}) async {
  // Déjà répondu (activée ou refusée) → on ne redemande pas.
  if (await biometrieDejaChoisie()) return false;

  final service = ServiceBiometrie();
  if (!await service.estDisponible()) return false;
  if (!context.mounted) return false;

  final veutActiver = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      icon: Icon(Icons.fingerprint,
          size: 48, color: Theme.of(ctx).colorScheme.primary),
      title: const Text('Activer l\'empreinte ?'),
      content: const Text(
        'Déverrouillez Poufiret plus rapidement avec votre empreinte '
        'digitale, sans retaper votre code PIN.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Non merci'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Activer'),
        ),
      ],
    ),
  );

  if (veutActiver != true) {
    // Refus explicite : on mémorise "false" pour ne plus reproposer.
    await definirBiometrie(false);
    return false;
  }

  // Confirmation par une vraie authentification biométrique.
  final ok = await service.authentifier(
    raison: 'Confirmez votre empreinte pour activer le déverrouillage',
  );
  await definirBiometrie(ok);
  return ok;
}
