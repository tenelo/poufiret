import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../metier_domaine/catalogue_commerce.dart';
import '../metier_domaine/meta_gabarits.dart';

/// Ouvre la feuille « Filtrer » d'un catalogue : une liste déroulante par
/// critère, et le prix maximum si [avecPrixMax]. Renvoie le nouveau filtre,
/// ou null si la feuille est refermée sans appliquer.
Future<FiltreCatalogue?> ouvrirFiltreCatalogue(
  BuildContext context, {
  required FiltreCatalogue actuel,
  required List<ChampFiltre> champs,
  bool avecPrixMax = false,
  String titre = 'Filtrer',
}) {
  return showModalBottomSheet<FiltreCatalogue>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => FeuilleFiltreCatalogue(
      actuel: actuel,
      champs: champs,
      avecPrixMax: avecPrixMax,
      titre: titre,
    ),
  );
}

class FeuilleFiltreCatalogue extends StatefulWidget {
  const FeuilleFiltreCatalogue({
    super.key,
    required this.actuel,
    required this.champs,
    required this.avecPrixMax,
    required this.titre,
  });

  final FiltreCatalogue actuel;
  final List<ChampFiltre> champs;
  final bool avecPrixMax;
  final String titre;

  @override
  State<FeuilleFiltreCatalogue> createState() => _FeuilleFiltreCatalogueState();
}

class _FeuilleFiltreCatalogueState extends State<FeuilleFiltreCatalogue> {
  late final _valeurs = {...widget.actuel.valeurs};
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
              widget.titre,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            for (final champ in widget.champs) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                key: ValueKey('filtre-${champ.cle}'),
                initialValue:
                    champ.choix.any((c) => c.valeur == _valeurs[champ.cle])
                    ? _valeurs[champ.cle]
                    : null,
                isExpanded: true,
                decoration: InputDecoration(labelText: champ.libelle),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Tous')),
                  for (final c in champ.choix)
                    DropdownMenuItem(value: c.valeur, child: Text(c.libelle)),
                ],
                onChanged: (v) => setState(
                  () => v == null
                      ? _valeurs.remove(champ.cle)
                      : _valeurs[champ.cle] = v,
                ),
              ),
            ],
            if (widget.avecPrixMax) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _prixMax,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Prix maximum',
                  suffixText: 'F',
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(const FiltreCatalogue()),
                    child: const Text('Tout effacer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(
                      FiltreCatalogue(
                        valeurs: Map.unmodifiable(_valeurs),
                        prixMax: int.tryParse(_prixMax.text),
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
