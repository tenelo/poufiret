import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/auth_notifier.dart';
import '../screens/ecran_connexion.dart';

/// Mur d'inscription : le visiteur peut parcourir l'ecran principal et la
/// liste des partenaires, mais toute action qui mene a une fiche exige un
/// compte. Chaque utilisateur compte — l'analyse porte sur les inscrits.
///
/// Usage : envelopper l'action de navigation.
///   onTap: () => murInscription(context, ref, () => Navigator.push(...))
///
/// Si l'utilisateur est connecte, [action] s'execute directement. Sinon,
/// un dialogue l'invite a s'enregistrer.
void murInscription(
  BuildContext context,
  WidgetRef ref,
  VoidCallback action,
) {
  final connecte = ref.read(authProvider).value != null;
  if (connecte) {
    action();
    return;
  }
  _afficherDialogue(context);
}

/// Variante pour un WidgetRef non disponible : lit l'etat via [connecte].
void murInscriptionSi(
  BuildContext context, {
  required bool connecte,
  required VoidCallback action,
}) {
  if (connecte) {
    action();
    return;
  }
  _afficherDialogue(context);
}

void _afficherDialogue(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: Icon(Icons.lock_outline,
          color: Theme.of(ctx).colorScheme.primary, size: 32),
      title: const Text('Enregistrez-vous pour continuer'),
      content: const Text(
        'Créez un compte gratuit pour découvrir les commerces, '
        'consulter les articles et contacter les vendeurs près de '
        'chez vous.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Plus tard'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const EcranConnexion()),
            );
          },
          child: const Text('S\'enregistrer'),
        ),
      ],
    ),
  );
}
