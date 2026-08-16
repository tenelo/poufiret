import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../catalogue/screens/ecran_article_detail.dart';
import '../../partenaire/screens/ecran_vitrine_partenaire.dart';
import '../donnees/favoris_providers.dart';
import '../metier_domaine/favoris_models.dart';

/// Onglet Favoris : articles et commerçants mis de côté par le client.
class EcranFavoris extends ConsumerWidget {
  const EcranFavoris({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesFavorisProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favoris'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Articles'),
              Tab(text: 'Commerçants'),
            ],
          ),
        ),
        body: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _Erreur(
            onRetry: () => ref.invalidate(mesFavorisProvider),
          ),
          data: (favoris) => TabBarView(
            children: [
              _ListeArticles(
                entrees: favoris.articles,
                onRefresh: () => ref.invalidate(mesFavorisProvider),
              ),
              _ListePartenaires(
                entrees: favoris.partenaires,
                onRefresh: () => ref.invalidate(mesFavorisProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListeArticles extends StatelessWidget {
  const _ListeArticles({required this.entrees, required this.onRefresh});
  final List<EntreeArticleFavori> entrees;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (entrees.isEmpty) {
      return const _Vide(
        message: 'Aucun article en favori.\n'
            'Touchez le marque-page sur une fiche produit.',
      );
    }
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: _Contraint(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: entrees.length,
          separatorBuilder: (_, i) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final a = entrees[i].article;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.fastfood_outlined),
              ),
              title: Text(a.nom,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(a.partenaireNom),
              trailing: Text(
                '${a.prix} FCFA',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EcranArticleDetail(slug: a.slug),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListePartenaires extends StatelessWidget {
  const _ListePartenaires({required this.entrees, required this.onRefresh});
  final List<EntreePartenaireFavori> entrees;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (entrees.isEmpty) {
      return const _Vide(
        message: 'Aucun commerçant en favori.\n'
            'Touchez le marque-page sur une vitrine.',
      );
    }
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: _Contraint(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: entrees.length,
          separatorBuilder: (_, i) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final p = entrees[i].partenaire;
            final lieu = [p.quartier, p.ville]
                .where((x) => x.isNotEmpty)
                .join(' · ');
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                backgroundImage: (p.logo != null && p.logo!.isNotEmpty)
                    ? NetworkImage(p.logo!)
                    : null,
                child: (p.logo == null || p.logo!.isEmpty)
                    ? const Icon(Icons.storefront_outlined)
                    : null,
              ),
              title: Text(p.nomCommerce,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(lieu),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EcranVitrinePartenaire(partenaireId: p.id),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Borne la largeur du contenu sur grand écran.
class _Contraint extends StatelessWidget {
  const _Contraint({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}

class _Vide extends StatelessWidget {
  const _Vide({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }
}

class _Erreur extends StatelessWidget {
  const _Erreur({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Impossible de charger les favoris.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
