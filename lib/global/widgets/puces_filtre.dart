import 'package:flutter/material.dart';

/// Rangée de pastilles à choix unique, au style des pastilles de
/// localisation (« Mon département | Par région | Tout »).
class PucesFiltre<T> extends StatelessWidget {
  const PucesFiltre({
    super.key,
    required this.options,
    required this.valeur,
    required this.onChange,
  });

  /// (valeur, libellé) dans l'ordre d'affichage.
  final List<(T, String)> options;
  final T valeur;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          for (final (i, (v, libelle)) in options.indexed) ...[
            if (i > 0) const SizedBox(width: 6),
            ChoiceChip(
              label: Text(libelle, style: const TextStyle(fontSize: 12)),
              selected: v == valeur,
              onSelected: (_) => onChange(v),
              visualDensity: VisualDensity.compact,
              showCheckmark: false,
              selectedColor: theme.colorScheme.primary,
              labelStyle: TextStyle(
                color: v == valeur
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
