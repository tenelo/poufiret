import 'package:flutter/material.dart';

/// Champ « Rechercher… » des pages de commerce (carte d'un restaurant,
/// catalogue d'un éleveur) et de l'annuaire d'une catégorie : loupe à
/// gauche, compact. Avec [onEffacer], une croix efface la saisie dès qu'il
/// y a du texte.
class ChampRecherche extends StatelessWidget {
  const ChampRecherche({
    super.key,
    required this.controleur,
    required this.indice,
    required this.onChanged,
    this.onEffacer,
  });

  final TextEditingController controleur;
  final String indice;
  final ValueChanged<String> onChanged;
  final VoidCallback? onEffacer;

  /// Hauteur de la bande qui porte le champ (marges comprises).
  static const double hauteurBande = 56;

  /// Marges du champ dans sa bande.
  static const EdgeInsets marges = EdgeInsets.fromLTRB(16, 8, 16, 4);

  @override
  Widget build(BuildContext context) {
    TextField champ(Widget? croix) => TextField(
      controller: controleur,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: indice,
        prefixIcon: const Icon(Icons.search),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        suffixIcon: croix,
      ),
    );
    final effacer = onEffacer;
    if (effacer == null) return champ(null);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controleur,
      builder: (context, valeur, _) => champ(
        valeur.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Effacer',
                icon: const Icon(Icons.close),
                onPressed: effacer,
              ),
      ),
    );
  }
}
