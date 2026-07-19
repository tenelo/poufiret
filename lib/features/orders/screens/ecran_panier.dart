import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/orders_providers.dart';
import '../domain/orders_models.dart';

/// Écran panier : regroupe les paniers par catégorie (option A).
/// Chaque ligne indique le commerçant. Un bouton "Commander" par catégorie.
class EcranPanier extends ConsumerWidget {
  const EcranPanier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(paniersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon panier')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            _Erreur(onRetry: () => ref.invalidate(paniersProvider)),
        data: (paniers) {
          if (paniers.isEmpty) return const _Vide();

          // Regroupe les paniers par catégorie.
          final parCategorie = <String, List<Panier>>{};
          for (final p in paniers) {
            final cle = p.categorieNom.isEmpty ? 'Autres' : p.categorieNom;
            parCategorie.putIfAbsent(cle, () => []).add(p);
          }
          final categories = parCategorie.keys.toList();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(paniersProvider),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth > 700
                    ? 700.0
                    : constraints.maxWidth;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: categories.length,
                      itemBuilder: (context, i) => _BlocCategorie(
                        titre: categories[i],
                        paniers: parCategorie[categories[i]]!,
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

/// Un bloc = une catégorie, contenant les lignes de plusieurs commerçants.
class _BlocCategorie extends ConsumerWidget {
  const _BlocCategorie({required this.titre, required this.paniers});
  final String titre;
  final List<Panier> paniers;

  int get _totalCategorie => paniers.fold(0, (somme, p) => somme + p.total);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titre, style: theme.textTheme.titleLarge),
            const Divider(),
            // Pour chaque panier (= un commerçant) de cette catégorie.
            for (final panier in paniers) ...[
              for (final ligne in panier.lignes)
                _LigneTuile(ligne: ligne, commercant: panier.partenaireNom),
            ],
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: theme.textTheme.titleMedium),
                Text(
                  '$_totalCategorie FCFA',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO étape suivante : ouvrir l'écran de validation
                  // qui commandera chaque panier de cette catégorie.
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Commander : $titre')));
                },
                child: const Text('Commander'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Une ligne d'article, avec commerçant, quantité (−/+) et suppression.
class _LigneTuile extends ConsumerStatefulWidget {
  const _LigneTuile({required this.ligne, required this.commercant});
  final LignePanier ligne;
  final String commercant;

  @override
  ConsumerState<_LigneTuile> createState() => _LigneTuileState();
}

class _LigneTuileState extends ConsumerState<_LigneTuile> {
  bool _occupe = false;

  Future<void> _modifierQuantite(int nouvelle) async {
    if (nouvelle < 1 || _occupe) return;
    setState(() => _occupe = true);
    try {
      await ref
          .read(ordersRepositoryProvider)
          .modifierLigne(ligneId: widget.ligne.id, quantite: nouvelle);
      ref.invalidate(paniersProvider);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erreur, réessayez.')));
      }
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _supprimer() async {
    if (_occupe) return;
    setState(() => _occupe = true);
    try {
      await ref.read(ordersRepositoryProvider).supprimerLigne(widget.ligne.id);
      ref.invalidate(paniersProvider);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erreur, réessayez.')));
      }
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = widget.ligne;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.articleNom,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'chez ${widget.commercant}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                Text(
                  '${l.prixLigne} FCFA',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          // Contrôles quantité.
          IconButton(
            onPressed: _occupe ? null : () => _modifierQuantite(l.quantite - 1),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('${l.quantite}', style: theme.textTheme.titleMedium),
          IconButton(
            onPressed: _occupe ? null : () => _modifierQuantite(l.quantite + 1),
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(
            onPressed: _occupe ? null : _supprimer,
            icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          ),
        ],
      ),
    );
  }
}

class _Vide extends StatelessWidget {
  const _Vide();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Votre panier est vide.\n'
                'Ajoutez des articles depuis une fiche produit.',
                textAlign: TextAlign.center,
              ),
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
          const Text('Impossible de charger le panier.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
