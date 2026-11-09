import 'package:flutter/material.dart';

import '../../../global/config/config.dart';

/// Deux choix : statistiques anonymes d'usage, contribution à l'IA.
/// Utilisé par la feuille d'après connexion et par l'écran Confidentialité.
class ChoixConsentements extends StatefulWidget {
  const ChoixConsentements({
    super.key,
    required this.onEnregistrer,
    this.statistiques = false,
    this.ia = false,
    this.enCours = false,
  });

  final bool statistiques;
  final bool ia;
  final bool enCours;
  final void Function(bool statistiques, bool ia) onEnregistrer;

  @override
  State<ChoixConsentements> createState() => _ChoixConsentementsState();
}

class _ChoixConsentementsState extends State<ChoixConsentements> {
  late bool _statistiques = widget.statistiques;
  late bool _ia = widget.ia;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _statistiques,
          onChanged: widget.enCours
              ? null
              : (v) => setState(() => _statistiques = v),
          title: const Text(
            'Aider à améliorer Poufiret (statistiques anonymes d\'usage)',
          ),
          subtitle: const Text(
            'Nous comptons ce qui est utilisé dans l\'application, sans '
            'savoir que c\'est vous.',
          ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _ia,
          onChanged: widget.enCours ? null : (v) => setState(() => _ia = v),
          title: const Text(
            'Contribuer à l\'IA de Poufiret (amélioration des réponses)',
          ),
          subtitle: const Text(
            'Vos recherches nous aident à donner de meilleures réponses.',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Vous pouvez changer d\'avis à tout moment : Mon compte › '
          'Confidentialité.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Config.couleurTexteSecondaire,
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: widget.enCours
              ? null
              : () => widget.onEnregistrer(_statistiques, _ia),
          child: widget.enCours
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Enregistrer'),
        ),
      ],
    );
  }
}

/// Feuille d'après connexion. Renvoie les choix, ou null si l'utilisateur
/// la ferme sans enregistrer.
Future<(bool statistiques, bool ia)?> ouvrirFeuilleConsentement(
  BuildContext context,
) {
  return showModalBottomSheet<(bool, bool)>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: 560),
    builder: (context) {
      final theme = Theme.of(context);
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Config.couleurBordure,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text('Vos données, vos choix', style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              'Choisissez si Poufiret peut utiliser votre usage de '
              'l\'application pour s\'améliorer. C\'est facultatif.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
            const SizedBox(height: 8),
            ChoixConsentements(
              onEnregistrer: (stats, ia) =>
                  Navigator.of(context).pop((stats, ia)),
            ),
          ],
        ),
      );
    },
  );
}
