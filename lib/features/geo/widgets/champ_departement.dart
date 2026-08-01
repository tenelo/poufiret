import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/geo_providers.dart';

/// Menu deroulant de selection du departement.
///
/// Alimente par l'endpoint public /geo/departements/. Affiche le nom du
/// departement et sa region ; le district est deduit cote serveur.
class ChampDepartement extends ConsumerWidget {
  const ChampDepartement({
    super.key,
    required this.valeur,
    required this.onChange,
    this.libelle = 'Département',
    this.obligatoire = false,
  });

  final int? valeur;
  final ValueChanged<int?> onChange;
  final String libelle;
  final bool obligatoire;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(departementsProvider);

    return async.when(
      loading: () => const _Cadre(
        enfant: SizedBox(
          height: 20,
          child: Center(
            child: SizedBox(
              width: 18, height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
      error: (_, _) => _Cadre(
        enfant: Row(
          children: [
            const Icon(Icons.error_outline, size: 18),
            const SizedBox(width: 8),
            const Expanded(child: Text('Départements indisponibles')),
            TextButton(
              onPressed: () => ref.invalidate(departementsProvider),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
      data: (departements) {
        return DropdownButtonFormField<int>(
          initialValue: valeur,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: obligatoire ? '$libelle *' : libelle,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.place_outlined),
          ),
          items: [
            for (final d in departements)
              DropdownMenuItem(
                value: d.id,
                child: Text('${d.nom} (${d.region})',
                    overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: onChange,
          validator: obligatoire
              ? (v) => v == null ? 'Choisissez votre département.' : null
              : null,
        );
      },
    );
  }
}

class _Cadre extends StatelessWidget {
  const _Cadre({required this.enfant});
  final Widget enfant;

  @override
  Widget build(BuildContext context) => InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Département',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.place_outlined),
        ),
        child: enfant,
      );
}
