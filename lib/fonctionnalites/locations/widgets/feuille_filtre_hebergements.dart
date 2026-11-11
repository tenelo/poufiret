import 'package:flutter/material.dart';

import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';

/// Ouvre la feuille « Filtrer » des hébergements d'un établissement. Chaque
/// ligne ne propose que les valeurs de ses [hebergements] ; une ligne qui
/// n'offrirait qu'une valeur est masquée. Renvoie le nouveau filtre, ou null
/// si la feuille est refermée sans appliquer.
Future<FiltreHebergements?> ouvrirFiltreHebergements(
  BuildContext context,
  FiltreHebergements actuel, {
  required List<HebergementResume> hebergements,
}) {
  return showModalBottomSheet<FiltreHebergements>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => _FeuilleFiltre(
      actuel: actuel,
      options: OptionsFiltreHebergements.depuis(hebergements),
    ),
  );
}

class _FeuilleFiltre extends StatefulWidget {
  const _FeuilleFiltre({required this.actuel, required this.options});

  final FiltreHebergements actuel;
  final OptionsFiltreHebergements options;

  @override
  State<_FeuilleFiltre> createState() => _FeuilleFiltreState();
}

class _FeuilleFiltreState extends State<_FeuilleFiltre> {
  late String? _type = widget.actuel.type;
  late int? _prixMax = widget.actuel.prixMax;
  late int? _capacite = widget.actuel.capacite;

  OptionsFiltreHebergements get _o => widget.options;

  /// Valeur gardée seulement si la ligne la propose encore.
  T? _siProposee<T>(T? valeur, Iterable<T> proposees) =>
      proposees.contains(valeur) ? valeur : null;

  /// Liste déroulante : [tous] (valeur null) + les options du partenaire.
  Widget _liste<T>({
    required String libelle,
    required String tous,
    required List<(T, String)> options,
    required T? valeur,
    required ValueChanged<T?> onChanged,
  }) => DropdownButtonFormField<T?>(
    initialValue: options.any((o) => o.$1 == valeur) ? valeur : null,
    isExpanded: true,
    decoration: InputDecoration(labelText: libelle),
    items: [
      DropdownMenuItem<T?>(value: null, child: Text(tous)),
      for (final (v, texte) in options)
        DropdownMenuItem<T?>(value: v, child: Text(texte)),
    ],
    onChanged: onChanged,
  );

  @override
  Widget build(BuildContext context) {
    // Lignes affichées : seulement celles qui offrent un vrai choix.
    final lignes = <Widget>[
      if (_o.types.isNotEmpty)
        _liste<String>(
          libelle: "Type d'hébergement",
          tous: 'Tous',
          options: _o.types,
          valeur: _type,
          onChanged: (v) => setState(() => _type = v),
        ),
      if (_o.prix.isNotEmpty)
        _liste<int>(
          libelle: 'Prix maximum',
          tous: 'Tous',
          options: [for (final p in _o.prix) (p, formatPrixNuit(p))],
          valeur: _prixMax,
          onChanged: (v) => setState(() => _prixMax = v),
        ),
      if (_o.capacites.isNotEmpty)
        _liste<int>(
          libelle: 'Capacité',
          tous: 'Peu importe',
          options: [
            for (final n in _o.capacites)
              (n, '${pluriel(n, 'personne')} et plus'),
          ],
          valeur: _capacite,
          onChanged: (v) => setState(() => _capacite = v),
        ),
    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filtrer les hébergements',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            for (final (i, ligne) in lignes.indexed) ...[
              if (i > 0) const SizedBox(height: 12),
              ligne,
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(const FiltreHebergements()),
                    child: const Text('Tout effacer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(
                      FiltreHebergements(
                        type: _siProposee(_type, _o.types.map((t) => t.$1)),
                        prixMax: _siProposee(_prixMax, _o.prix),
                        capacite: _siProposee(_capacite, _o.capacites),
                      ),
                    ),
                    child: const Text('Appliquer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
