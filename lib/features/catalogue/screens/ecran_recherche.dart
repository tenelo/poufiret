import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/catalogue_providers.dart';
import 'ecran_article_detail.dart';

/// Onglet Recherche : cherche un article par son nom.
class EcranRecherche extends ConsumerStatefulWidget {
  const EcranRecherche({super.key});

  @override
  ConsumerState<EcranRecherche> createState() => _EcranRechercheState();
}

class _EcranRechercheState extends ConsumerState<EcranRecherche> {
  final _controleur = TextEditingController();
  Timer? _debounce;
  String _terme = '';

  void _surSaisie(String valeur) {
    // Attend 400 ms d'inactivité avant d'interroger le serveur.
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _terme = valeur.trim());
    });
  }

  void _effacer() {
    _debounce?.cancel();
    _controleur.clear();
    setState(() => _terme = '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controleur.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controleur,
              autofocus: false,
              textInputAction: TextInputAction.search,
              onChanged: _surSaisie,
              decoration: InputDecoration(
                hintText: 'Rechercher un produit…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controleur.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _effacer,
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _terme.isEmpty
                ? _Invite(theme: theme)
                : _Resultats(terme: _terme),
          ),
        ],
      ),
    );
  }
}

/// Écran d'accueil de la recherche, avant toute saisie.
class _Invite extends StatelessWidget {
  const _Invite({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search,
                size: 64, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'Tapez le nom d\'un produit pour le trouver.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Resultats extends ConsumerWidget {
  const _Resultats({required this.terme});
  final String terme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(rechercheArticlesProvider(terme: terme));
    final theme = Theme.of(context);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Erreur lors de la recherche.'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () =>
                    ref.invalidate(rechercheArticlesProvider(terme: terme)),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Aucun résultat pour « $terme ».',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth =
                constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: articles.length,
                  separatorBuilder: (_, i) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final a = articles[i];
                    return ListTile(
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: a.imagePrincipale != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  a.imagePrincipale!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, e, s) =>
                                      _vignetteVide(theme),
                                ),
                              )
                            : _vignetteVide(theme),
                      ),
                      title: Text(a.nom,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(a.partenaireNom),
                      trailing: Text(
                        '${a.prix} FCFA',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
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
          },
        );
      },
    );
  }

  Widget _vignetteVide(ThemeData theme) => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.image_outlined,
            size: 24, color: theme.colorScheme.outline),
      );
}
