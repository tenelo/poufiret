import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/json/convertisseurs.dart';
import '../donnees/mes_annonces_repository.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vente_models.dart';

/// Ouvre le formulaire « Type d'annonce et vente » ; renvoie l'annonce
/// enregistrée (null si fermé sans enregistrer).
Future<AnnonceGestion?> ouvrirFormulaireVente(
  BuildContext context, {
  required TypeAnnonce type,
  required AnnonceGestion annonce,
  required List<ChampVente> champs,
}) => showModalBottomSheet<AnnonceGestion>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  constraints: const BoxConstraints(maxWidth: 700),
  builder: (_) => FormulaireVente(type: type, annonce: annonce, champs: champs),
);

/// Type d'annonce (Location / Vente / Location et vente), prix, puis les
/// champs de vente, affichés seulement si l'annonce est à vendre
/// (`visible_si` du méta). Validation locale identique au serveur ; un refus
/// du serveur est affiché tel quel.
class FormulaireVente extends ConsumerStatefulWidget {
  const FormulaireVente({
    super.key,
    required this.type,
    required this.annonce,
    required this.champs,
  });

  final TypeAnnonce type;
  final AnnonceGestion annonce;
  final List<ChampVente> champs;

  @override
  ConsumerState<FormulaireVente> createState() => _FormulaireVenteState();
}

class _FormulaireVenteState extends ConsumerState<FormulaireVente> {
  late final Map<String, Object?> _valeurs = valeursVente(
    widget.annonce,
    widget.champs,
  );

  /// Champs entiers : un contrôleur chacun.
  late final Map<String, TextEditingController> _textes = {
    for (final c in widget.champs)
      if (c.type == 'entier')
        c.cle: TextEditingController(text: '${_valeurs[c.cle] ?? ''}'),
  };

  Map<String, String> _erreurs = const {};
  String? _erreurServeur;
  bool _envoi = false;

  @override
  void dispose() {
    for (final c in _textes.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _enregistrer() async {
    final erreurs = erreursFormulaireVente(_valeurs);
    setState(() {
      _erreurs = erreurs;
      _erreurServeur = null;
    });
    if (erreurs.isNotEmpty || _envoi) return;
    setState(() => _envoi = true);
    final navigator = Navigator.of(context);
    try {
      final enregistree = await ref
          .read(mesAnnoncesRepositoryProvider)
          .modifier(
            widget.type,
            widget.annonce.id,
            donneesVente(_valeurs, widget.champs),
          );
      navigator.pop(enregistree);
    } catch (e) {
      if (!mounted) return;
      setState(
        () => _erreurServeur = messageErreurApi(
          e,
          repli: 'Enregistrement impossible. Réessayez.',
        ),
      );
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  Widget _champ(ChampVente c) {
    final libelle = c.obligatoire ? '${c.libelle} *' : c.libelle;
    switch (c.type) {
      case 'choix':
        final options = optionsChamp(c);
        final valeur = _valeurs[c.cle] as String?;
        return DropdownButtonFormField<String>(
          key: ValueKey('champ-${c.cle}'),
          initialValue: options.any((o) => o.valeur == valeur) ? valeur : null,
          isExpanded: true,
          decoration: InputDecoration(labelText: libelle),
          items: [
            if (!c.obligatoire)
              const DropdownMenuItem(value: '', child: Text('Non renseigné')),
            for (final o in options)
              DropdownMenuItem(value: o.valeur, child: Text(o.libelle)),
          ],
          onChanged: (v) =>
              setState(() => _valeurs[c.cle] = (v ?? '').isEmpty ? null : v),
        );
      case 'entier':
        return TextFormField(
          key: ValueKey('champ-${c.cle}'),
          controller: _textes[c.cle],
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: libelle,
            errorText: _erreurs[c.cle],
          ),
          onChanged: (v) => _valeurs[c.cle] = versIntNullable(v.trim()),
        );
      case 'booleen':
        return SwitchListTile(
          key: ValueKey('champ-${c.cle}'),
          contentPadding: EdgeInsets.zero,
          title: Text(c.libelle),
          value: _valeurs[c.cle] == true,
          onChanged: (v) => setState(() => _valeurs[c.cle] = v),
        );
      case 'date':
        final iso = _valeurs[c.cle] as String?;
        return InkWell(
          key: ValueKey('champ-${c.cle}'),
          borderRadius: BorderRadius.circular(8),
          onTap: () => _choisirDate(c.cle, c.libelle),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: libelle,
              suffixIcon: (iso ?? '').isEmpty
                  ? const Icon(Icons.event_outlined)
                  : IconButton(
                      tooltip: 'Effacer',
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() => _valeurs[c.cle] = null),
                    ),
            ),
            child: Text(
              (iso ?? '').isEmpty ? 'Non renseignée' : formatDateCourte(iso),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _choisirDate(String cle, String libelle) async {
    final actuelle = DateTime.tryParse('${_valeurs[cle] ?? ''}');
    final aujourdhui = DateUtils.dateOnly(DateTime.now());
    final date = await showDatePicker(
      context: context,
      initialDate: actuelle ?? aujourdhui,
      firstDate: DateTime(aujourdhui.year - 5),
      lastDate: DateTime(aujourdhui.year + 10),
      helpText: libelle,
    );
    if (date != null) setState(() => _valeurs[cle] = formatDateIso(date));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibles = widget.champs.where((c) => c.visible(_valeurs));
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
              "Type d'annonce et vente",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.annonce.nom,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
            const SizedBox(height: 12),
            for (final c in visibles)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _champ(c),
              ),
            if (_erreurServeur != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _erreurServeur!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Config.couleurErreur,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            FilledButton(
              onPressed: _envoi ? null : _enregistrer,
              child: _envoi
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
