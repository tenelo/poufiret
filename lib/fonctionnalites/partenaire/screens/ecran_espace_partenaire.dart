import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../donnees/espace_partenaire_providers.dart';
import '../metier_domaine/stats_vues.dart';
import 'ecran_formulaire_article.dart';
import 'ecran_mes_categories.dart';
import 'ecran_mon_profil_partenaire.dart';
import '../../publicites/screens/ecran_mes_publicites.dart';

/// Tableau de bord du partenaire : total de vues + articles avec stats,
/// création/modification/suppression d'articles.
class EcranEspacePartenaire extends ConsumerWidget {
  const EcranEspacePartenaire({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsVuesPartenaireProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mon espace partenaire')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final cree = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => const EcranFormulaireArticle()),
          );
          if (cree == true) ref.invalidate(statsVuesPartenaireProvider);
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvel article'),
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.',
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(statsVuesPartenaireProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (stats) => LayoutBuilder(
          builder: (context, contraintes) {
            final largeur = contraintes.maxWidth > 700
                ? 700.0
                : contraintes.maxWidth;
            return Center(
              child: SizedBox(
                width: largeur,
                child: RefreshIndicator(
                  onRefresh: () async =>
                      ref.invalidate(statsVuesPartenaireProvider),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
                    children: [
                      _CarteTotal(
                        totalVues: stats.totalVues,
                        nbArticles: stats.articles.length,
                      ),
                      const SizedBox(height: 12),
                      // Raccourcis de gestion de la vitrine.
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.storefront_outlined),
                              title: const Text('Ma vitrine'),
                              subtitle: const Text(
                                'Nom, description, contacts, images',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const EcranMonProfilPartenaire(),
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.category_outlined),
                              title: const Text('Mes catégories'),
                              subtitle: const Text('Une image par catégorie'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const EcranMesCategories(),
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.campaign_outlined),
                              title: const Text('Mes publicités'),
                              subtitle: const Text('Campagnes et résultats'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const EcranMesPublicites(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Mes articles',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (stats.articles.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text('Aucun article. Créez le premier !'),
                          ),
                        )
                      else
                        ...stats.articles.map(
                          (a) => _CarteArticle(
                            stats: a,
                            onModifie: () =>
                                ref.invalidate(statsVuesPartenaireProvider),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CarteTotal extends StatelessWidget {
  const _CarteTotal({required this.totalVues, required this.nbArticles});
  final int totalVues;
  final int nbArticles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          // Aligne les colonnes par le haut : sans cela, la colonne au
          // libelle le plus court est centree et son chiffre descend.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    '$totalVues',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Vues totales de tous mes articles',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '$nbArticles',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Nombre total d’articles',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarteArticle extends ConsumerWidget {
  const _CarteArticle({required this.stats, required this.onModifie});
  final StatsArticle stats;
  final VoidCallback onModifie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: () async {
          final modifie = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (_) => EcranFormulaireArticle(slug: stats.slug),
            ),
          );
          if (modifie == true) onModifie();
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                stats.nom,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!stats.estActif)
              Chip(
                label: const Text('Inactif', style: TextStyle(fontSize: 11)),
                side: BorderSide(color: theme.colorScheme.outline),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        subtitle: Text(
          'Vues — 24h : ${stats.jour} · 7j : ${stats.semaine} · '
          '30j : ${stats.mois} · total : ${stats.total}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
