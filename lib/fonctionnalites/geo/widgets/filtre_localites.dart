import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../../catalogue/donnees/catalogue_providers.dart';
import '../donnees/geo_providers.dart';
import '../metier_domaine/departement.dart';

/// Barre de filtre geographique en haut de la liste des partenaires.
///
/// Deux raccourcis — « Mon département » (defaut) et « Tout » — plus un
/// bouton qui ouvre un panneau de REGIONS a cocher librement. Cocher une
/// region revient a selectionner tous ses departements ; le backend
/// applique ensuite la regle de portee a chacun.
class FiltreLocalites extends ConsumerWidget {
  const FiltreLocalites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final choisies = ref.watch(localitesChoisiesProvider);
    final notifier = ref.read(localitesChoisiesProvider.notifier);

    // Precharge la liste des departements : sans ce watch, le premier
    // clic sur « Par région » tombe sur une liste encore vide.
    ref.watch(departementsProvider);

    final montreTout = choisies.contains('all');
    final surDepartement = !montreTout && choisies.isEmpty;
    final nbRegionsChoisies = _regionsDepuisChoix(ref, choisies).length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.place_outlined, size: 16),
          const SizedBox(width: 8),
          _Puce(
            label: user != null && user.departementNom.isNotEmpty
                ? user.departementNom
                : 'Mon département',
            actif: surDepartement,
            onTap: () => murInscriptionSi(
              context,
              connecte: user != null,
              action: () => notifier.reinitialiser(),
            ),
          ),
          const SizedBox(width: 6),
          _Puce(
            label: nbRegionsChoisies > 0
                ? 'Régions ($nbRegionsChoisies)'
                : 'Par région',
            actif: nbRegionsChoisies > 0,
            icone: Icons.tune,
            onTap: () => _ouvrirPanneauRegions(context, ref),
          ),
          const SizedBox(width: 6),
          _Puce(
            label: 'Tout',
            actif: montreTout,
            onTap: () => notifier.tout(),
          ),
        ],
      ),
    );
  }

  /// Regroupe les departements par region a partir de l'endpoint geo.
  Map<String, List<Departement>> _regionsDisponibles(WidgetRef ref) {
    final deps = ref.read(departementsProvider).value ?? const <Departement>[];
    final parRegion = <String, List<Departement>>{};
    for (final d in deps) {
      parRegion.putIfAbsent(d.region, () => []).add(d);
    }
    return parRegion;
  }

  /// Quelles regions sont entierement selectionnees dans le choix courant.
  Set<String> _regionsDepuisChoix(WidgetRef ref, List<String> choisies) {
    if (choisies.isEmpty || choisies.contains('all')) return {};
    final ids = choisies.toSet();
    final resultat = <String>{};
    _regionsDisponibles(ref).forEach((region, deps) {
      if (deps.isNotEmpty && deps.every((d) => ids.contains('${d.id}'))) {
        resultat.add(region);
      }
    });
    return resultat;
  }

  void _ouvrirPanneauRegions(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).value;
    // Le filtre par region ne concerne que les inscrits (vue localisee).
    if (user == null) {
      murInscriptionSi(context, connecte: false, action: () {});
      return;
    }

    final async = ref.read(departementsProvider);
    if (async.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chargement des régions…')),
      );
      return;
    }
    final parRegion = _regionsDisponibles(ref);
    if (parRegion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Régions indisponibles.')),
      );
      return;
    }

    final choix =
        _regionsDepuisChoix(ref, ref.read(localitesChoisiesProvider)).toSet();
    // Si rien n'est encore choisi, on part de la region de l'utilisateur :
    // c'est sa zone par defaut, elle doit apparaitre deja cochee.
    if (choix.isEmpty && user.regionNom.isNotEmpty &&
        parRegion.containsKey(user.regionNom)) {
      choix.add(user.regionNom);
    }

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            final theme = Theme.of(ctx);
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Row(
                      children: [
                        Icon(Icons.tune, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Choisir des régions',
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final region in parRegion.keys)
                          CheckboxListTile(
                            title: Text(region),
                            subtitle: Text(
                              '${parRegion[region]!.length} département(s)',
                              style: theme.textTheme.bodySmall,
                            ),
                            value: choix.contains(region),
                            onChanged: (v) => setSheet(() {
                              v == true
                                  ? choix.add(region)
                                  : choix.remove(region);
                            }),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              ref
                                  .read(localitesChoisiesProvider.notifier)
                                  .reinitialiser();
                              Navigator.pop(ctx);
                            },
                            child: const Text('Réinitialiser'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              // Concatene les ids des departements des
                              // regions cochees.
                              final ids = <String>[];
                              for (final region in choix) {
                                for (final d in parRegion[region] ?? []) {
                                  ids.add('${d.id}');
                                }
                              }
                              ref
                                  .read(localitesChoisiesProvider.notifier)
                                  .definir(ids);
                              Navigator.pop(ctx);
                            },
                            child: const Text('Appliquer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _Puce extends StatelessWidget {
  const _Puce({
    required this.label,
    required this.actif,
    required this.onTap,
    this.icone,
  });

  final String label;
  final bool actif;
  final VoidCallback onTap;
  final IconData? icone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChoiceChip(
      avatar: icone != null
          ? Icon(icone,
              size: 16,
              color:
                  actif ? theme.colorScheme.onPrimary : theme.colorScheme.primary)
          : null,
      label: Text(label, style: const TextStyle(fontSize: 13)),
      selected: actif,
      onSelected: (_) => onTap(),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
      selectedColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color:
            actif ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
      ),
    );
  }
}
