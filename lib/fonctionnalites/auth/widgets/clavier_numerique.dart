import 'package:flutter/material.dart';

/// Clavier numérique 3×4 pour la saisie du PIN et de l'OTP.
///
/// Émet [onChiffre] à chaque touche 0-9 et [onSupprimer] sur le retour arrière.
/// La touche bas-gauche est laissée vide (comme un pavé natif).
/// S'appuie sur le [Theme] Material courant plutôt que sur des couleurs
/// passées en paramètre.
class ClavierNumerique extends StatelessWidget {
  const ClavierNumerique({
    super.key,
    required this.onChiffre,
    required this.onSupprimer,
    this.desactive = false,
  });

  final ValueChanged<String> onChiffre;
  final VoidCallback onSupprimer;
  final bool desactive;

  @override
  Widget build(BuildContext context) {
    // Grille de touches ; '' = case vide, 'del' = retour arrière.
    const touches = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '', '0', 'del',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Largeur d'une touche : 3 colonnes, on borne pour rester lisible
        // sur grand écran (le contenu est déjà plafonné en amont).
        final largeurDispo = constraints.maxWidth;
        final tailleTouche = (largeurDispo / 3).clamp(64.0, 104.0);

        return Center(
          child: SizedBox(
            width: tailleTouche * 3,
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.25,
              children: touches.map((t) {
                if (t.isEmpty) return const SizedBox.shrink();
                if (t == 'del') {
                  return _Touche(
                    onTap: desactive ? null : onSupprimer,
                    child: const Icon(Icons.backspace_outlined),
                  );
                }
                return _Touche(
                  onTap: desactive ? null : () => onChiffre(t),
                  child: Text(t),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _Touche extends StatelessWidget {
  const _Touche({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actif = onTap != null;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: actif ? 1 : 0.4,
        ),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: DefaultTextStyle.merge(
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: actif
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: actif
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
