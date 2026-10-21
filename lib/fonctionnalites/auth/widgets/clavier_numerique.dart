import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              childAspectRatio: 1.3,
              children: touches.map((t) {
                if (t.isEmpty) return const SizedBox.shrink();
                if (t == 'del') {
                  return _Touche(
                    onTap: desactive ? null : onSupprimer,
                    discrete: true,
                    child: const Icon(Icons.backspace_outlined, size: 24),
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

/// Touche ronde légère : fond doux, chiffre en gras, vibration discrète au
/// toucher. [discrete] (effacer) : sans fond.
class _Touche extends StatelessWidget {
  const _Touche({required this.child, this.onTap, this.discrete = false});

  final Widget child;
  final VoidCallback? onTap;
  final bool discrete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actif = onTap != null;
    final fond = theme.colorScheme.surfaceContainerHighest;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: discrete
            ? Colors.transparent
            : fond.withValues(alpha: actif ? 1 : 0.4),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap!();
                },
          child: Center(
            child: DefaultTextStyle.merge(
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
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
