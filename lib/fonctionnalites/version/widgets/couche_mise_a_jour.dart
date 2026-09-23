import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/version_providers.dart';
import '../metier_domaine/info_version.dart';
import '../screens/ecran_mise_a_jour.dart';

/// Superpose l'écran de mise à jour obligatoire par-dessus l'app, et
/// propose un rappel ignorable pour une mise à jour conseillée.
///
/// Non bloquant par défaut : tant que le contrôle est en cours (loading),
/// en erreur, ou si la version est à jour, on affiche simplement [enfant].
/// Seul un statut 'obligatoire' remplace tout par [EcranMiseAJour]. Ainsi,
/// un utilisateur à jour ne subit AUCUN délai ni blocage au démarrage.
///
/// Cas 'conseillee' (non obligatoire) : [enfant] reste affiché normalement,
/// mais un dialog ignorable (« Plus tard » / « Mettre à jour ») est proposé
/// UNE SEULE FOIS par lancement d'app, dès que le contrôle répond.
class CoucheMiseAJour extends ConsumerStatefulWidget {
  const CoucheMiseAJour({super.key, required this.enfant});

  final Widget enfant;

  @override
  ConsumerState<CoucheMiseAJour> createState() => _CoucheMiseAJourState();
}

class _CoucheMiseAJourState extends ConsumerState<CoucheMiseAJour> {
  // Garde-fou : n'affiche le rappel ignorable qu'une fois par lancement,
  // meme si le provider re-emet (invalidation, hot reload...).
  bool _rappelAffiche = false;

  void _proposerRappel(InfoVersion info) {
    if (_rappelAffiche) return;
    _rappelAffiche = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
          title: const Text('Mise à jour disponible'),
          content: Text(
            info.message.isNotEmpty
                ? info.message
                : 'Une nouvelle version est disponible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Plus tard'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                await EcranMiseAJour.ouvrirStore(context, info);
              },
              child: const Text('Mettre à jour'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controle = ref.watch(controleVersionProvider);

    // Des que le controle repond, propose le rappel ignorable si conseillee.
    // Le flag _rappelAffiche rend cet appel sans effet des le 2e rebuild.
    controle.whenData((info) {
      if (info.estConseillee && !info.obligatoire) {
        _proposerRappel(info);
      }
    });

    return controle.maybeWhen(
      data: (info) =>
          info.obligatoire ? EcranMiseAJour(info: info) : widget.enfant,
      orElse: () => widget.enfant,
    );
  }
}
