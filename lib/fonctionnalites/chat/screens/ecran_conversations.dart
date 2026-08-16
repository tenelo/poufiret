import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/chat_providers.dart';
import '../metier_domaine/chat_models.dart';
import 'ecran_discussion.dart';

/// Liste des conversations de l'utilisateur (onglet Messages).
class EcranConversations extends ConsumerWidget {
  const EcranConversations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(conversationsProvider);
    final monId = ref.watch(monUtilisateurIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Erreur(
          onRetry: () => ref.invalidate(conversationsProvider),
        ),
        data: (convs) {
          if (convs.isEmpty) {
            return const _Vide();
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(conversationsProvider),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth =
                    constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: ListView.separated(
                      itemCount: convs.length,
                      separatorBuilder: (_, i) => const Divider(height: 1),
                      itemBuilder: (context, i) =>
                          _Tuile(conversation: convs[i], monId: monId),
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

class _Tuile extends ConsumerWidget {
  const _Tuile({required this.conversation, required this.monId});
  final Conversation conversation;
  final int? monId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = conversation;
    // Côté client on montre le partenaire ; si je suis le partenaire, le client.
    final jeSuisPartenaire = monId != null && c.client != monId;
    final titre = jeSuisPartenaire ? c.clientNom : c.partenaireNom;
    final apercu = c.dernierMessage?.contenu ?? 'Aucun message';

    return ListTile(
      leading: CircleAvatar(
        child: Text(
          titre.isNotEmpty ? titre[0].toUpperCase() : '?',
        ),
      ),
      title: Text(
        titre.isEmpty ? 'Conversation' : titre,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        apercu,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EcranDiscussion(
              conversationId: c.id,
              titre: titre.isEmpty ? 'Conversation' : titre,
            ),
          ),
        );
        // Retour de la discussion : la liste se met a jour
        // (dernier message + ordre par derniere activite).
        ref.invalidate(conversationsProvider);
      },
    );
  }
}

class _Vide extends StatelessWidget {
  const _Vide();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) => ListView(
        // ListView pour rester compatible avec RefreshIndicator au besoin.
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucune conversation pour le moment.\n'
                  'Contactez un partenaire depuis une fiche article.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
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
          const Text('Impossible de charger les conversations.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
