import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../../catalogue/data/catalogue_providers.dart';
import '../data/geo_providers.dart';

/// Barre de filtre geographique en haut de la liste des partenaires.
///
/// Trois niveaux hierarchiques : Mon departement / Ma region / Tout. Un
/// visiteur non connecte voit "Tout" par defaut ; s'il veut filtrer sur
/// sa zone, on l'invite a s'enregistrer (le departement vient du compte).
class FiltreLocalites extends ConsumerWidget {
  const FiltreLocalites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final choisies = ref.watch(localitesChoisiesProvider);
    final notifier = ref.read(localitesChoisiesProvider.notifier);

    // Etat courant : quel niveau est actif.
    final montreTout = choisies.contains('all');
    final departementUser = user?.departement;

    // Ids des departements de la region de l'utilisateur (pour "Ma region").
    final depsRegion = ref.watch(departementsProvider).maybeWhen(
          data: (deps) {
            if (user == null || user.regionNom.isEmpty) return <int>[];
            return deps
                .where((d) => d.region == user.regionNom)
                .map((d) => d.id)
                .toList();
          },
          orElse: () => <int>[],
        );

    final surRegion = !montreTout &&
        depsRegion.isNotEmpty &&
        choisies.length == depsRegion.length &&
        depsRegion.every((id) => choisies.contains('$id'));

    // "Mon departement" = vue par defaut (liste vide cote etat).
    final surDepartement = !montreTout && !surRegion && choisies.isEmpty;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.place_outlined, size: 16),
          const SizedBox(width: 8),
          _Puce(
            label: departementUser != null && user!.departementNom.isNotEmpty
                ? user.departementNom
                : 'Mon département',
            actif: surDepartement,
            onTap: () {
              // Filtrer sur sa zone exige un compte (departement lie au profil).
              murInscriptionSi(
                context,
                connecte: user != null,
                action: () => notifier.reinitialiser(),
              );
            },
          ),
          const SizedBox(width: 6),
          _Puce(
            label: user != null && user.regionNom.isNotEmpty
                ? user.regionNom
                : 'Ma région',
            actif: surRegion,
            onTap: () {
              murInscriptionSi(
                context,
                connecte: user != null,
                action: () {
                  if (depsRegion.isNotEmpty) {
                    notifier.definir(depsRegion.map((e) => '$e').toList());
                  }
                },
              );
            },
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
}

class _Puce extends StatelessWidget {
  const _Puce({
    required this.label,
    required this.actif,
    required this.onTap,
  });

  final String label;
  final bool actif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 13)),
      selected: actif,
      onSelected: (_) => onTap(),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
      selectedColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: actif ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
      ),
    );
  }
}
