import 'package:flutter/material.dart';

import '../../../global/ui/format_montant.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';

/// Ouvre la feuille « Filtrer » des véhicules d'un loueur. Les lignes ne
/// proposent que les valeurs présentes chez lui ([options], calculées sur
/// les annonces du type affiché) ; [achat] : prix de vente au lieu du prix
/// par jour. Renvoie le nouveau filtre, ou null si la feuille est refermée
/// sans appliquer.
Future<FiltreVehicules?> ouvrirFiltreVehicules(
  BuildContext context,
  FiltreVehicules actuel, {
  required OptionsFiltreVehicules options,
  required bool achat,
}) {
  return showModalBottomSheet<FiltreVehicules>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) =>
        _FeuilleFiltre(actuel: actuel, options: options, achat: achat),
  );
}

class _FeuilleFiltre extends StatefulWidget {
  const _FeuilleFiltre({
    required this.actuel,
    required this.options,
    required this.achat,
  });

  final FiltreVehicules actuel;
  final OptionsFiltreVehicules options;
  final bool achat;

  @override
  State<_FeuilleFiltre> createState() => _FeuilleFiltreState();
}

class _FeuilleFiltreState extends State<_FeuilleFiltre> {
  late String? _categorie = widget.actuel.categorie;
  late String? _marque = widget.actuel.marque;
  late int? _prixMax = widget.actuel.prixMax;
  late int? _placesMin = widget.actuel.placesMin;
  late String? _boite = widget.actuel.boite;
  late bool _avecChauffeur = widget.actuel.avecChauffeur;

  OptionsFiltreVehicules get _o => widget.options;

  /// Valeur gardée seulement si la ligne la propose encore.
  T? _siProposee<T>(T? valeur, Iterable<T> proposees) =>
      proposees.contains(valeur) ? valeur : null;

  void _appliquer() => Navigator.of(context).pop(
    FiltreVehicules(
      categorie: _siProposee(_categorie, _o.categories.map((c) => c.$1)),
      marque: _siProposee(_marque, _o.marques),
      prixMax: _siProposee(_prixMax, _o.prix),
      placesMin: _siProposee(_placesMin, _o.places),
      boite: _siProposee(_boite, _o.boites),
      avecChauffeur: _o.chauffeur && _avecChauffeur,
      mode: widget.actuel.mode,
    ),
  );

  /// Liste déroulante : [tous] (valeur null) + les options du loueur.
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
      if (_o.categories.isNotEmpty)
        _liste<String>(
          libelle: 'Catégorie',
          tous: 'Toutes',
          options: _o.categories,
          valeur: _categorie,
          onChanged: (v) => setState(() => _categorie = v),
        ),
      if (_o.marques.isNotEmpty)
        _liste<String>(
          libelle: 'Marque',
          tous: 'Toutes',
          options: [for (final m in _o.marques) (m, m)],
          valeur: _marque,
          onChanged: (v) => setState(() => _marque = v),
        ),
      if (_o.prix.isNotEmpty)
        _liste<int>(
          libelle: 'Prix maximum',
          tous: 'Tous',
          options: [
            for (final p in _o.prix)
              (p, widget.achat ? formatMontant(p) : formatPrixJour(p)),
          ],
          valeur: _prixMax,
          onChanged: (v) => setState(() => _prixMax = v),
        ),
      if (_o.places.isNotEmpty)
        _liste<int>(
          libelle: 'Places (minimum)',
          tous: 'Peu importe',
          options: [for (final n in _o.places) (n, '$n et plus')],
          valeur: _placesMin,
          onChanged: (v) => setState(() => _placesMin = v),
        ),
      if (_o.boites.isNotEmpty)
        _liste<String>(
          libelle: 'Boîte de vitesses',
          tous: 'Toutes',
          options: [for (final b in _o.boites) (b, b)],
          valeur: _boite,
          onChanged: (v) => setState(() => _boite = v),
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
              'Filtrer les véhicules',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            for (final (i, ligne) in lignes.indexed) ...[
              if (i > 0) const SizedBox(height: 12),
              ligne,
            ],
            if (_o.chauffeur)
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
