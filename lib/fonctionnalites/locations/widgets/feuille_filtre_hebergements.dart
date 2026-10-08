import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';

/// Ouvre la feuille « Filtrer » des hébergements d'un établissement. Les
/// types proposés sont ceux de ses hébergements. Renvoie le nouveau filtre,
/// ou null si la feuille est refermée sans appliquer.
Future<FiltreHebergements?> ouvrirFiltreHebergements(
  BuildContext context,
  FiltreHebergements actuel, {
  required List<HebergementResume> hebergements,
}) {
  final types = <String, String>{
    for (final h in hebergements)
      if (h.typeHebergement.isNotEmpty) h.typeHebergement: h.type,
  };
  return showModalBottomSheet<FiltreHebergements>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => _FeuilleFiltre(
      actuel: actuel,
      types: [
        for (final e in types.entries)
          OptionMeta(valeur: e.key, libelle: e.value),
      ],
    ),
  );
}

class _FeuilleFiltre extends StatefulWidget {
  const _FeuilleFiltre({required this.actuel, required this.types});

  final FiltreHebergements actuel;
  final List<OptionMeta> types;

  @override
  State<_FeuilleFiltre> createState() => _FeuilleFiltreState();
}

class _FeuilleFiltreState extends State<_FeuilleFiltre> {
  late String? _type = widget.actuel.type;
  late int? _capacite = widget.actuel.capacite;
  late final _prixMax = TextEditingController(
    text: widget.actuel.prixMax?.toString() ?? '',
  );

  @override
  void dispose() {
    _prixMax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // La feuille remonte au-dessus du clavier.
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
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              initialValue: widget.types.any((t) => t.valeur == _type)
                  ? _type
                  : null,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: "Type d'hébergement",
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tous')),
                for (final t in widget.types)
                  DropdownMenuItem(value: t.valeur, child: Text(t.libelle)),
              ],
              onChanged: (v) => setState(() => _type = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _prixMax,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Prix maximum',
                suffixText: 'F/nuit',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int?>(
              initialValue: _capacite,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Capacité'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Peu importe')),
                for (var n = 1; n <= 6; n++)
                  DropdownMenuItem(
                    value: n,
                    child: Text('${pluriel(n, 'personne')} et plus'),
                  ),
              ],
              onChanged: (v) => setState(() => _capacite = v),
            ),
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
                        type: _type,
                        prixMax: int.tryParse(_prixMax.text),
                        capacite: _capacite,
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
