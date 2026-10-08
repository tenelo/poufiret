import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';

/// Ouvre la feuille « Filtrer » des véhicules d'un loueur. Renvoie le
/// nouveau filtre, ou null si la feuille est refermée sans appliquer.
Future<FiltreVehicules?> ouvrirFiltreVehicules(
  BuildContext context,
  FiltreVehicules actuel,
) {
  return showModalBottomSheet<FiltreVehicules>(
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

  final FiltreVehicules actuel;

  @override
  ConsumerState<_FeuilleFiltre> createState() => _FeuilleFiltreState();
}

class _FeuilleFiltreState extends ConsumerState<_FeuilleFiltre> {
  late String? _categorie = widget.actuel.categorie;
  late String? _boite = widget.actuel.boite;
  late int? _placesMin = widget.actuel.placesMin;
  late bool _avecChauffeur = widget.actuel.avecChauffeur;
  late final _prixMax = TextEditingController(
    text: widget.actuel.prixMax?.toString() ?? '',
  );

  @override
  void dispose() {
    _prixMax.dispose();
    super.dispose();
  }

  void _appliquer() => Navigator.of(context).pop(
    FiltreVehicules(
      categorie: _categorie,
      prixMax: int.tryParse(_prixMax.text),
      placesMin: _placesMin,
      boite: _boite,
      avecChauffeur: _avecChauffeur,
    ),
  );

  /// Liste déroulante « Tous » + options de référence.
  Widget _choix({
    required String libelle,
    required List<OptionMeta> options,
    required String? valeur,
    required ValueChanged<String?> onChanged,
  }) => DropdownButtonFormField<String?>(
    initialValue: options.any((o) => o.valeur == valeur) ? valeur : null,
    isExpanded: true,
    decoration: InputDecoration(labelText: libelle),
    items: [
      const DropdownMenuItem(value: null, child: Text('Toutes')),
      for (final o in options)
        DropdownMenuItem(value: o.valeur, child: Text(o.libelle)),
    ],
    onChanged: onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(metaLocationsProvider).value;
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
              'Filtrer les véhicules',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _choix(
              libelle: 'Catégorie',
              options: meta?.categoriesVehicule ?? const [],
              valeur: _categorie,
              onChanged: (v) => setState(() => _categorie = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _prixMax,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Prix maximum',
                suffixText: 'F/jour',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int?>(
              initialValue: _placesMin,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Places (minimum)'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Peu importe')),
                for (final n in const [2, 4, 5, 7, 9, 15])
                  DropdownMenuItem(value: n, child: Text('$n et plus')),
              ],
              onChanged: (v) => setState(() => _placesMin = v),
            ),
            const SizedBox(height: 12),
            _choix(
              libelle: 'Boîte de vitesses',
              options: meta?.boites ?? const [],
              valeur: _boite,
              onChanged: (v) => setState(() => _boite = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Avec chauffeur'),
              value: _avecChauffeur,
              onChanged: (v) => setState(() => _avecChauffeur = v),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(const FiltreVehicules()),
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
