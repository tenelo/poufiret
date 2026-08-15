import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/livraison_providers.dart';
import 'ecran_deposer_position.dart';
import 'ecran_suivi.dart';

const _libelleStatut = {
  'demandee': 'En recherche de livreur',
  'assignee': 'Livreur assigné',
  'acceptee': 'Acceptée',
  'vers_a': 'En route vers le retrait',
  'colis_pris': 'Colis récupéré',
  'vers_b': 'En route vers la livraison',
  'livree': 'Livrée',
  'annulee': 'Annulée',
  'refusee': 'Refusée',
};

const _actifs = {
  'demandee', 'assignee', 'acceptee', 'vers_a', 'colis_pris', 'vers_b',
};

/// "Colis qui m'arrivent" : les courses ou je suis le destinataire.
/// Je peux deposer ma position (bouton) et suivre la livraison (tap -> suivi).
class EcranColisRecus extends ConsumerWidget {
  const EcranColisRecus({super.key});

  IconData _icone(String statut) {
    if (statut == 'livree') return Icons.check_circle;
    if (statut == 'annulee' || statut == 'refusee') return Icons.cancel;
    return Icons.inventory_2;
  }

  Color _couleur(String statut, ThemeData theme) {
    if (statut == 'livree') return Colors.green;
    if (statut == 'annulee' || statut == 'refusee') {
      return theme.colorScheme.error;
    }
    return theme.colorScheme.primary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(coursesRecuesProvider());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Colis qui m\'arrivent')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Impossible de charger vos colis.'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => ref.invalidate(coursesRecuesProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (courses) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(coursesRecuesProvider),
            child: courses.isEmpty
                ? ListView(
                    children: const [
                      SizedBox(height: 80),
                      Center(child: Text('Aucun colis en route vers vous.')),
                    ],
                  )
                : ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, i) {
                      final c = courses[i];
                      final actif = _actifs.contains(c.statut);
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(_icone(c.statut),
                                      color: _couleur(c.statut, theme)),
                                  title: Text(c.numero),
                                  subtitle: Text(
                                    '${_libelleStatut[c.statut] ?? c.statut}\n'
                                    '${c.pointA.quartier} → ${c.pointB.quartier}',
                                  ),
                                  isThreeLine: true,
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EcranSuivi(
                                          courseId: c.id, courseInitiale: c),
                                    ),
                                  ),
                                ),
                                if (actif && c.positionBDeposee)
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green, size: 18),
                                        SizedBox(width: 8),
                                        Text('Localisation envoyée',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  )
                                else if (actif)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 0, 12, 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton.icon(
                                            icon: const Icon(
                                                Icons.my_location, size: 18),
                                            label: const Text(
                                                'Déposer ma position'),
                                            onPressed: () =>
                                                Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EcranDeposerPosition(
                                                        course: c),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
