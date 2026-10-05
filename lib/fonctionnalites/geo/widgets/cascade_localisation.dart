import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../donnees/geo_providers.dart';
import '../metier_domaine/localisation.dart';
import 'champ_departement.dart';

/// Choix de la localisation dans la géographie gérée par l'admin :
/// Département → Localité → Quartier (jamais de saisie libre).
///
/// Widget contrôlé : le parent garde la [selection] et la reçoit, déjà
/// réinitialisée aux niveaux suivants, dans [onChange]. À placer dans un
/// `Form` : la localité est requise dès que le département est choisi, le
/// quartier reste optionnel.
class CascadeLocalisation extends ConsumerWidget {
  const CascadeLocalisation({
    super.key,
    required this.selection,
    required this.onChange,
    this.departementModifiable = true,
    this.departementNom = '',
    this.erreurs = const {},
    this.ancienneSaisie = '',
  });

  final SelectionLocalisation selection;
  final ValueChanged<SelectionLocalisation> onChange;

  /// Faux quand le département est réservé à l'admin (profil partenaire) :
  /// il s'affiche alors en lecture seule, avec [departementNom].
  final bool departementModifiable;
  final String departementNom;

  /// Erreurs du backend à afficher sous le champ concerné.
  final Map<NiveauLocalisation, String> erreurs;

  /// Ancien texte libre (ville, quartier) d'un profil pas encore rattaché.
  final String ancienneSaisie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departement = selection.departement;
    final localite = selection.localite;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (departementModifiable)
          ChampDepartement(
            valeur: departement,
            obligatoire: true,
            erreur: erreurs[NiveauLocalisation.departement],
            onChange: (id) => onChange(selection.avecDepartement(id)),
          )
        else
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Département',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.place_outlined),
              suffixIcon: const Icon(Icons.lock_outline, size: 18),
              helperText: "Géré par l'administration",
              errorText: erreurs[NiveauLocalisation.departement],
            ),
            child: Text(departementNom.isEmpty ? '—' : departementNom),
          ),
        if (ancienneSaisie.isNotEmpty && localite == null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Ancienne saisie : $ancienneSaisie — choisissez dans la liste',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Config.couleurAvertissement,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (departement != null) ...[
          const SizedBox(height: 12),
          _ChampListe(
            // Changer de département repart d'un champ vierge.
            key: ValueKey('localite-$departement'),
            libelle: 'Localité',
            icone: Icons.location_city_outlined,
            elements: ref
                .watch(localitesProvider(departementId: departement))
                .whenData((l) => [for (final e in l) (id: e.id, nom: e.nom)]),
            valeur: localite,
            obligatoire: true,
            messageVide:
                'Aucune localité pour ce département. '
                "Contactez l'administration.",
            messageIndisponible: 'Localités indisponibles',
            erreur: erreurs[NiveauLocalisation.localite],
            onReessayer: () =>
                ref.invalidate(localitesProvider(departementId: departement)),
            onChange: (id) => onChange(selection.avecLocalite(id)),
          ),
        ],
        if (localite != null) ...[
          const SizedBox(height: 12),
          _ChampListe(
            key: ValueKey('quartier-$localite'),
            libelle: 'Quartier',
            icone: Icons.holiday_village_outlined,
            elements: ref
                .watch(quartiersDeLocaliteProvider(localiteId: localite))
                .whenData((l) => [for (final e in l) (id: e.id, nom: e.nom)]),
            valeur: selection.quartier,
            messageVide: 'Aucun quartier enregistré pour cette localité.',
            messageIndisponible: 'Quartiers indisponibles',
            erreur: erreurs[NiveauLocalisation.quartier],
            onReessayer: () => ref.invalidate(
              quartiersDeLocaliteProvider(localiteId: localite),
            ),
            onChange: (id) => onChange(selection.avecQuartier(id)),
          ),
        ],
      ],
    );
  }
}

/// Un niveau de la cascade : liste déroulante, avec ses états de chargement,
/// de liste vide et d'erreur réseau.
class _ChampListe extends StatelessWidget {
  const _ChampListe({
    super.key,
    required this.libelle,
    required this.icone,
    required this.elements,
    required this.valeur,
    required this.onChange,
    required this.onReessayer,
    required this.messageVide,
    required this.messageIndisponible,
    this.obligatoire = false,
    this.erreur,
  });

  final String libelle;
  final IconData icone;
  final AsyncValue<List<({int id, String nom})>> elements;
  final int? valeur;
  final ValueChanged<int?> onChange;
  final VoidCallback onReessayer;
  final String messageVide;
  final String messageIndisponible;
  final bool obligatoire;
  final String? erreur;

  InputDecoration get _decoration => InputDecoration(
    labelText: obligatoire ? '$libelle *' : '$libelle (optionnel)',
    border: const OutlineInputBorder(),
    prefixIcon: Icon(icone),
    errorText: erreur,
    errorMaxLines: 3,
  );

  @override
  Widget build(BuildContext context) {
    return elements.when(
      skipLoadingOnReload: true,
      loading: () => InputDecorator(
        decoration: _decoration,
        child: const SizedBox(
          height: 20,
          child: Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
      error: (_, _) => InputDecorator(
        decoration: _decoration,
        child: Row(
          children: [
            const Icon(Icons.error_outline, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(messageIndisponible)),
            TextButton(onPressed: onReessayer, child: const Text('Réessayer')),
          ],
        ),
      ),
      data: (liste) {
        if (liste.isEmpty) {
          return InputDecorator(
            decoration: _decoration,
            child: Text(messageVide),
          );
        }
        return DropdownButtonFormField<int?>(
          // Un rattachement à un élément retiré de la liste (désactivé par
          // l'admin) n'est pas présélectionné.
          initialValue: liste.any((e) => e.id == valeur) ? valeur : null,
          isExpanded: true,
          decoration: _decoration,
          items: [
            if (!obligatoire)
              const DropdownMenuItem(value: null, child: Text('— Aucun —')),
            for (final e in liste)
              DropdownMenuItem(
                value: e.id,
                child: Text(e.nom, overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: onChange,
          validator: obligatoire
              ? (v) => v == null ? 'Choisissez votre localité.' : null
              : null,
        );
      },
    );
  }
}
