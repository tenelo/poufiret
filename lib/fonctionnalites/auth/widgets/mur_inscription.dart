import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../screens/auth_notifier.dart';
import '../screens/ecran_connexion.dart';

/// Accès réservé aux comptes connectés : UN mécanisme pour toute l'app.
///
/// Sans connexion, la feuille « Connexion requise » s'ouvre ; « Se
/// connecter » mène à l'écran de connexion, puis l'action demandée reprend
/// une fois connecté.
///
///   onTap: () => murInscription(context, ref, () => Navigator.push(...))
///   if (!await exigerConnexion(context)) return;

/// Vrai si un compte est connecté.
bool estConnecte(BuildContext context) =>
    ProviderScope.containerOf(context, listen: false).read(authProvider).value !=
    null;

/// Session lue jusqu'au bout : au lancement, elle peut être encore en cours
/// de restauration (un compte connecté ne doit pas voir la feuille).
Future<void> _attendreSession(BuildContext context) async {
  final conteneur = ProviderScope.containerOf(context, listen: false);
  final etat = conteneur.read(authProvider);
  if (!etat.isLoading || etat.hasValue) return;
  final ecoute = conteneur.listen(authProvider, (_, _) {});
  try {
    await conteneur
        .read(authProvider.future)
        .timeout(const Duration(seconds: 5));
  } catch (_) {
    // Session illisible : traitée comme non connectée.
  } finally {
    ecoute.close();
  }
}

/// Renvoie vrai si l'utilisateur est (ou vient d'être) connecté ; sinon
/// propose la connexion et renvoie faux s'il y renonce.
Future<bool> exigerConnexion(BuildContext context) async {
  await _attendreSession(context);
  if (!context.mounted) return false;
  if (estConnecte(context)) return true;
  final seConnecter = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: 520),
    builder: (_) => const FeuilleConnexionRequise(),
  );
  if (seConnecter != true || !context.mounted) return false;
  await Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => const EcranConnexion()));
  return context.mounted && estConnecte(context);
}

/// Exécute [action] si un compte est connecté, après la connexion sinon.
Future<void> murInscription(
  BuildContext context,
  WidgetRef ref,
  VoidCallback action,
) async {
  if (await exigerConnexion(context)) action();
}

/// Variante quand l'état de connexion est déjà connu ([connecte]).
Future<void> murInscriptionSi(
  BuildContext context, {
  required bool connecte,
  required VoidCallback action,
}) async {
  if (connecte || await exigerConnexion(context)) action();
}

/// Feuille « Connexion requise » : texte court, « Se connecter » (renvoie
/// vrai) et « Plus tard ».
class FeuilleConnexionRequise extends StatelessWidget {
  const FeuilleConnexionRequise({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Défilante : rien ne déborde sur un petit écran ou en grand texte.
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_open_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Connexion requise',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Connectez-vous pour continuer. Pas encore de compte ? '
            "L'inscription est gratuite.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Config.couleurTexteSecondaire,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Se connecter'),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurfaceVariant,
            ),
            child: const Text('Plus tard'),
          ),
        ],
      ),
    );
  }
}
