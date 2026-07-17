import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/partenaire_providers.dart';
import '../domain/partenaire_vitrine.dart';

/// Vitrine publique d'un partenaire (côté client).
/// Affiche couverture, logo, infos, localisation, contacts.
class EcranVitrinePartenaire extends ConsumerWidget {
  const EcranVitrinePartenaire({super.key, required this.partenaireId});

  final int partenaireId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(partenaireVitrineProvider(id: partenaireId));

    return Scaffold(
      body: async.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Erreur(
          onRetry: () => ref.invalidate(
              partenaireVitrineProvider(id: partenaireId)),
        ),
        data: (p) => _Contenu(partenaire: p),
      ),
      bottomNavigationBar: async.maybeWhen(
        data: (p) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton.icon(
              onPressed: () {
                // TODO: brancher sur le module Chat (Contacter).
              },
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Contacter'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ),
        ),
        orElse: () => null,
      ),
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu({required this.partenaire});
  final PartenaireVitrine partenaire;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Contenu plafonné sur grand écran, comme le reste de l'app.
        final maxWidth =
            constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: _Couverture(partenaire: partenaire, theme: theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _Infos(partenaire: partenaire, theme: theme),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Couverture extends StatelessWidget {
  const _Couverture({required this.partenaire, required this.theme});
  final PartenaireVitrine partenaire;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final couv = partenaire.photoCouverture;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (couv != null && couv.isNotEmpty)
          Image.network(
            couv,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: theme.colorScheme.surfaceContainerHighest),
          )
        else
          Container(color: theme.colorScheme.surfaceContainerHighest),
        // Voile sombre pour lisibilité du logo/titre.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54],
            ),
          ),
        ),
      ],
    );
  }
}

class _Infos extends StatelessWidget {
  const _Infos({required this.partenaire, required this.theme});
  final PartenaireVitrine partenaire;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final p = partenaire;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête : logo + nom + type.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Logo(logo: p.logo, theme: theme),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.nomCommerce,
                      style: theme.textTheme.headlineSmall),
                  if (p.typeLibelle.isNotEmpty)
                    Text(p.typeLibelle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Stats sociales.
        Row(
          children: [
            Icon(Icons.favorite,
                size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 4),
            Text('${p.nombreLikes}'),
          ],
        ),

        if (p.description.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('À propos', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(p.description),
        ],

        if (p.localisationLisible.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Localisation', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.place_outlined, size: 18),
              const SizedBox(width: 4),
              Expanded(child: Text(p.localisationLisible)),
            ],
          ),
          if (p.descriptionAcces.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(p.descriptionAcces,
                style: theme.textTheme.bodySmall),
          ],
        ],

        if (p.telephonePro.isNotEmpty || p.whatsapp.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Contact', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          if (p.telephonePro.isNotEmpty)
            Row(children: [
              const Icon(Icons.phone_outlined, size: 18),
              const SizedBox(width: 4),
              Text(p.telephonePro),
            ]),
          if (p.whatsapp.isNotEmpty)
            Row(children: [
              const Icon(Icons.chat_outlined, size: 18),
              const SizedBox(width: 4),
              Text(p.whatsapp),
            ]),
        ],

        const SizedBox(height: 80), // espace sous le bouton Contacter
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.logo, required this.theme});
  final String? logo;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const size = 64.0;
    if (logo == null || logo!.isEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.storefront_outlined),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.network(
        logo!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => CircleAvatar(
          radius: size / 2,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.storefront_outlined),
        ),
      ),
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
          const Text('Impossible de charger ce partenaire.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
