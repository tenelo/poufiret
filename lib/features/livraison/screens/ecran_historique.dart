import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/livraison_providers.dart';
import '../domain/livraison_models.dart';
import 'ecran_suivi.dart';

/// Filtres de l'historique des courses.
enum _FiltreCourse {
  toutes('Toutes'),
  enCours('En cours'),
  livrees('Livrées'),
  annulees('Annulées');

  const _FiltreCourse(this.libelle);
  final String libelle;
}

const _actifs = {
  'demandee', 'assignee', 'acceptee', 'vers_a', 'colis_pris', 'vers_b',
};

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

/// Historique des courses du demandeur, filtrable par statut.
class EcranHistorique extends ConsumerStatefulWidget {
  const EcranHistorique({super.key});

  @override
  ConsumerState<EcranHistorique> createState() => _EcranHistoriqueState();
}

class _EcranHistoriqueState extends ConsumerState<EcranHistorique> {
  _FiltreCourse _filtre = _FiltreCourse.toutes;

  bool _correspond(Course c) {
    switch (_filtre) {
      case _FiltreCourse.toutes:
        return true;
      case _FiltreCourse.enCours:
        return _actifs.contains(c.statut);
      case _FiltreCourse.livrees:
        return c.statut == 'livree';
      case _FiltreCourse.annulees:
        return c.statut == 'annulee' || c.statut == 'refusee';
    }
  }

  IconData _icone(String statut) {
    if (statut == 'livree') return Icons.check_circle;
    if (statut == 'annulee' || statut == 'refusee') return Icons.cancel;
    return Icons.two_wheeler;
  }

  Color _couleur(String statut, ThemeData theme) {
    if (statut == 'livree') return Colors.green;
    if (statut == 'annulee' || statut == 'refusee') {
      return theme.colorScheme.error;
    }
    return theme.colorScheme.primary;
  }

  String _dateCourte(String? iso) {
    if (iso == null) return '';
    final d = DateTime.tryParse(iso);
    if (d == null) return '';
    final l = d.toLocal();
    String deux(int n) => n.toString().padLeft(2, '0');
    return '${deux(l.day)}/${deux(l.month)}/${l.year} ${deux(l.hour)}:${deux(l.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mesCoursesProvider());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Historique des livraisons')),
      body: Column(
        children: [
          // Barre de filtres.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                for (final f in _FiltreCourse.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f.libelle),
                      selected: _filtre == f,
                      onSelected: (_) => setState(() => _filtre = f),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: async.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Impossible de charger l\'historique.'),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => ref.invalidate(mesCoursesProvider),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
              data: (courses) {
                final liste = courses.where(_correspond).toList();
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mesCoursesProvider),
                  child: liste.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 80),
                            Center(child: Text('Aucune course.')),
                          ],
                        )
                      : ListView.builder(
                          itemCount: liste.length,
                          itemBuilder: (context, i) {
                            final c = liste[i];
                            return Center(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 700),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: ListTile(
                                    leading: Icon(_icone(c.statut),
                                        color: _couleur(c.statut, theme)),
                                    title: Text(c.numero),
                                    subtitle: Text(
                                      '${_libelleStatut[c.statut] ?? c.statut}\n'
                                      '${c.pointA.quartier} → ${c.pointB.quartier}'
                                      '${c.creeLe != null ? '\n${_dateCourte(c.creeLe)}' : ''}',
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
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
