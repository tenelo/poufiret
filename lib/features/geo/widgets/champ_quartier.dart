import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/geo_providers.dart';

/// Champ de saisie du quartier avec autocompletion.
///
/// Propose les quartiers connus du departement pendant la frappe, tout en
/// autorisant la saisie libre (un quartier pas encore en base reste valide :
/// la liste s'enrichit au fil de l'eau cote admin). Si aucun departement
/// n'est choisi, se comporte comme un simple champ texte.
class ChampQuartier extends ConsumerStatefulWidget {
  const ChampQuartier({
    super.key,
    required this.controller,
    required this.departementId,
    this.libelle = 'Quartier',
    this.obligatoire = true,
  });

  final TextEditingController controller;
  final int? departementId;
  final String libelle;
  final bool obligatoire;

  @override
  ConsumerState<ChampQuartier> createState() => _ChampQuartierState();
}

class _ChampQuartierState extends ConsumerState<ChampQuartier> {
  static String _normaliser(String s) {
    var t = s.toLowerCase().trim();
    const from = 'àáâãäçèéêëìíîïñòóôõöùúûü';
    const to = 'aaaaaceeeeiiiinooooouuuu';
    for (var i = 0; i < from.length; i++) {
      t = t.replaceAll(from[i], to[i]);
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.obligatoire ? '${widget.libelle} *' : widget.libelle;

    // Sans departement : champ texte simple (pas de suggestions).
    if (widget.departementId == null) {
      return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.map_outlined),
        ),
        validator: widget.obligatoire
            ? (v) =>
                (v == null || v.trim().isEmpty) ? 'Quartier requis.' : null
            : null,
      );
    }

    final async = ref.watch(
      quartiersProvider(departementId: widget.departementId!),
    );
    final noms = async.maybeWhen(
      data: (liste) => liste.map((q) => q.nom).toList(),
      orElse: () => <String>[],
    );

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: widget.controller.text),
      optionsBuilder: (value) {
        final saisie = _normaliser(value.text);
        if (saisie.isEmpty) return noms;
        return noms.where((n) => _normaliser(n).contains(saisie));
      },
      onSelected: (s) => widget.controller.text = s,
      fieldViewBuilder: (context, textCtrl, focus, onSubmit) {
        // Synchronise le controller interne de l'Autocomplete avec le notre.
        textCtrl.addListener(() => widget.controller.text = textCtrl.text);
        return TextFormField(
          controller: textCtrl,
          focusNode: focus,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.map_outlined),
            helperText: 'Choisissez ou saisissez votre quartier',
          ),
          validator: widget.obligatoire
              ? (v) =>
                  (v == null || v.trim().isEmpty) ? 'Quartier requis.' : null
              : null,
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240, maxWidth: 400),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  for (final o in options)
                    ListTile(
                      dense: true,
                      title: Text(o),
                      onTap: () => onSelected(o),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
