import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';

/// Ouvre la feuille « Filtrer » des logements d'un loueur. Renvoie le
/// nouveau filtre, ou null si la feuille est refermée sans appliquer.
Future<FiltreLogements?> ouvrirFiltreLogements(
  BuildContext context,
  FiltreLogements actuel,
) {
  return showModalBottomSheet<FiltreLogements>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => _FeuilleFiltre(actuel: actuel),
  );
}

class _FeuilleFiltre extends ConsumerStatefulWidget {
  const _FeuilleFiltre({required this.actuel});

  final FiltreLogements actuel;

  @override
  ConsumerState<_FeuilleFiltre> createState() => _FeuilleFiltreState();
}

class _FeuilleFiltreState extends ConsumerState<_FeuilleFiltre> {
  late String? _type = widget.actuel.type;
  late int? _chambresMin = widget.actuel.chambresMin;
  late bool _meuble = widget.actuel.meuble;
  late final _quartier = TextEditingController(text: widget.actuel.quartier);
  late final _loyerMax = TextEditingController(
    text: widget.actuel.loyerMax?.toString() ?? '',
  );

  @override
  void dispose() {
    _quartier.dispose();
    _loyerMax.dispose();
    super.dispose();
  }

  void _appliquer() => Navigator.of(context).pop(
    FiltreLogements(
      type: _type,
      quartier: _quartier.text,
      loyerMax: int.tryParse(_loyerMax.text),
      chambresMin: _chambresMin,
      meuble: _meuble,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final types =
        ref.watch(metaLocationsProvider).value?.typesLogement ?? const [];
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
              'Filtrer les logements',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              initialValue: types.any((t) => t.valeur == _type) ? _type : null,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Type de logement'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tous')),
                for (final t in types)
                  DropdownMenuItem(value: t.valeur, child: Text(t.libelle)),
              ],
              onChanged: (v) => setState(() => _type = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quartier,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Quartier'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _loyerMax,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Loyer maximum',
                suffixText: 'F/mois',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int?>(
              initialValue: _chambresMin,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Chambres (minimum)',
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Peu importe')),
                for (var n = 1; n <= 5; n++)
                  DropdownMenuItem(value: n, child: Text('$n et plus')),
              ],
              onChanged: (v) => setState(() => _chambresMin = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Meublé uniquement'),
              value: _meuble,
              onChanged: (v) => setState(() => _meuble = v),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(const FiltreLogements()),
                    child: const Text('Tout effacer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _appliquer,
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
