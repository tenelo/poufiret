import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/orders_providers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/orders_models.dart';

/// Transitions autorisées côté partenaire, calquées sur le backend.
/// Clé = statut courant, valeur = liste (statut cible, libellé du bouton).
const _actionsPartenaire = <String, List<(String, String)>>{
  'nouvelle': [('acceptee', 'Accepter'), ('refusee', 'Refuser')],
  'acceptee': [('en_preparation', 'Mettre en préparation')],
  'en_preparation': [('prete', 'Marquer prête')],
  'prete': [('en_livraison', 'En livraison'), ('livree', 'Livrée')],
  'en_livraison': [('livree', 'Livrée')],
};

/// Commandes reçues par le partenaire connecté.
class EcranCommandesPartenaire extends ConsumerWidget {
  const EcranCommandesPartenaire({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(commandesPartenaireProvider());

    return Scaffold(
      appBar: AppBar(title: const Text('Commandes reçues')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Erreur(
          onRetry: () => ref.invalidate(commandesPartenaireProvider()),
        ),
        data: (commandes) {
          if (commandes.isEmpty) return const _Vide();
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(commandesPartenaireProvider()),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth =
                    constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: commandes.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 12),
                      itemBuilder: (context, i) =>
                          _CarteCommandeRecue(commande: commandes[i]),
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

class _CarteCommandeRecue extends ConsumerStatefulWidget {
  const _CarteCommandeRecue({required this.commande});
  final Commande commande;

  @override
  ConsumerState<_CarteCommandeRecue> createState() =>
      _CarteCommandeRecueState();
}

class _CarteCommandeRecueState extends ConsumerState<_CarteCommandeRecue> {
  bool _occupe = false;

  Future<void> _transition(String cible, String libelle) async {
    if (_occupe) return;
    final messenger = ScaffoldMessenger.of(context);

    // Le refus demande un motif.
    String? motif;
    if (cible == 'refusee') {
      motif = await _demanderMotif();
      if (motif == null) return; // annulé
    }

    setState(() => _occupe = true);
    try {
      await ref.read(ordersRepositoryProvider).transition(
            commandeId: widget.commande.id,
            statut: cible,
            raisonRefus: motif,
          );
      ref.invalidate(commandesPartenaireProvider());
      messenger.showSnackBar(
        SnackBar(content: Text('Commande mise à jour : $libelle.')),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Action impossible.')),
      );
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _commanderLivreur() async {
    if (_occupe) return;
    setState(() => _occupe = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final reponse = await ref
          .read(ordersRepositoryProvider)
          .commanderLivreur(widget.commande.id);
      ref.invalidate(commandesPartenaireProvider());
      final assigne = reponse['assigne'] == true;
      if (assigne) {
        messenger.showSnackBar(const SnackBar(
          content: Text('Livreur trouve, en route vers vous.'),
        ));
      } else if (mounted) {
        final msg = (reponse['message'] as String?) ??
            'Aucun livreur disponible pour l\'instant.';
        await _dialogueAucunLivreur(msg);
      }
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Impossible de commander un livreur.')),
      );
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _dialogueAucunLivreur(String message) async {
    final tel = widget.commande.clientTelephone;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Aucun livreur'),
        content: Text('$message\n\nVous pouvez appeler le client en attendant.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fermer'),
          ),
          if (tel.isNotEmpty)
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _appelerClient(tel);
              },
              icon: const Icon(Icons.phone),
              label: const Text('Appeler le client'),
            ),
        ],
      ),
    );
  }

  Future<void> _appelerClient(String numero) async {
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri(scheme: 'tel', path: numero);
    if (!await launchUrl(uri)) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Impossible de lancer l\'appel.')),
      );
    }
  }

  Future<String?> _demanderMotif() {
    final controleur = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Motif du refus'),
        content: TextField(
          controller: controleur,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Ex : article indisponible',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controleur.text.trim()),
            child: const Text('Refuser'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = widget.commande;
    var actions = _actionsPartenaire[c.statut] ?? const <(String, String)>[];
    // Commande en livraison + prete : le pont livreur remplace les
    // transitions manuelles (en_livraison / livree sont pilotes par la course).
    final bool proposerLivreur =
        c.statut == 'prete' && c.modeLivraison == 'livraison';
    if (proposerLivreur) {
      actions = const <(String, String)>[];
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(c.numero, style: theme.textTheme.titleMedium),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    c.statutLibelle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Client : ${c.clientNom}',
                style: theme.textTheme.bodyMedium),
            Text(c.modeLivraisonLibelle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                )),
            const Divider(height: 20),

            // Les articles commandés.
            for (final l in c.lignes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${l.nomArticle} ×${l.quantite}'),
                          if (l.varianteNom.isNotEmpty)
                            Text(l.varianteNom,
                                style: theme.textTheme.bodySmall),
                          if (l.noteSpeciale.isNotEmpty)
                            Text('Note : ${l.noteSpeciale}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                )),
                        ],
                      ),
                    ),
                    Text('${l.prixLigne} FCFA'),
                  ],
                ),
              ),

            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: theme.textTheme.titleSmall),
                Text('${c.total} FCFA',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),

            if (proposerLivreur) ...[
              const SizedBox(height: 12),
              if (_occupe)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                FilledButton.icon(
                  onPressed: _commanderLivreur,
                  icon: const Icon(Icons.delivery_dining),
                  label: const Text('Commander un livreur'),
                ),
            ],
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 12),
              if (_occupe)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final (cible, libelle) in actions)
                      if (cible == 'refusee')
                        OutlinedButton(
                          onPressed: () => _transition(cible, libelle),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                          ),
                          child: Text(libelle),
                        )
                      else
                        FilledButton(
                          onPressed: () => _transition(cible, libelle),
                          child: Text(libelle),
                        ),
                  ],
                ),
            ],
          ],
        ),
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
                'Aucune commande reçue pour le moment.',
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
          const Text('Impossible de charger les commandes.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
