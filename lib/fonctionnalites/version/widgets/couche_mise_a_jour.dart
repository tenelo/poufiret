import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/version_providers.dart';
import '../screens/ecran_mise_a_jour.dart';

/// Superpose l'écran de mise à jour obligatoire par-dessus l'app.
///
/// Non bloquant par défaut : tant que le contrôle est en cours (loading),
/// en erreur, ou si la version est à jour / seulement conseillée, on
/// affiche simplement [enfant]. Seul un statut 'obligatoire' remplace tout
/// par [EcranMiseAJour]. Ainsi, un utilisateur à jour ne subit AUCUN délai
/// ni blocage au démarrage.
class CoucheMiseAJour extends ConsumerWidget {
  const CoucheMiseAJour({super.key, required this.enfant});

  final Widget enfant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controle = ref.watch(controleVersionProvider);
    return controle.maybeWhen(
      data: (info) =>
          info.obligatoire ? EcranMiseAJour(info: info) : enfant,
      orElse: () => enfant,
    );
  }
}
