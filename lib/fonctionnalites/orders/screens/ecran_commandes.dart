import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/orders_providers.dart';
import '../../../global/config/config.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/ui/squelette.dart';
import '../metier_domaine/orders_models.dart';

const _mois = [
  'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin',
  'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.',
];

/// « 19 oct. 2026 · 11:25 ».
String formatDateHeure(DateTime d) {
  String deux(int n) => n.toString().padLeft(2, '0');
  return '${d.day} ${_mois[d.month - 1]} ${d.year} · '
      '${deux(d.hour)}:${deux(d.minute)}';
}

/// « 19 oct. 2026 ».
String _formatJour(DateTime d) => '${d.day} ${_mois[d.month - 1]} ${d.year}';

/// AAAA-MM-JJ, format attendu par les filtres `du` / `au` du serveur.
String _versIso(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// Liste des commandes du client, avec recherche et filtre de dates.
class EcranCommandes extends ConsumerStatefulWidget {
  const EcranCommandes({super.key});

  @override
  ConsumerState<EcranCommandes> createState() => _EcranCommandesState();
}

class _EcranCommandesState extends ConsumerState<EcranCommandes> {
  final _champ = TextEditingController();
  Timer? _attente;

  /// Terme envoyé au serveur (après 400 ms sans frappe).
  String _q = '';
  DateTimeRange? _plage;

  @override
  void dispose() {
    _attente?.cancel();
    _champ.dispose();
    super.dispose();
  }

  void _surSaisie(String valeur) {
    _attente?.cancel();
    _attente = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _q = valeur.trim());
    });
    setState(() {}); // bouton d'effacement
  }

  void _effacer() {
    _attente?.cancel();
    _champ.clear();
    setState(() => _q = '');
  }

  Future<void> _choisirDates() async {
    final aujourdhui = DateTime.now();
    final plage = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(aujourdhui.year, aujourdhui.month, aujourdhui.day),
      initialDateRange: _plage,
      helpText: 'Période des commandes',
      fieldStartLabelText: 'Du',
      fieldEndLabelText: 'Au',
    );
    if (plage != null && mounted) setState(() => _plage = plage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = commandesProvider(
      q: _q.isEmpty ? null : _q,
      du: _plage == null ? null : _versIso(_plage!.start),
      au: _plage == null ? null : _versIso(_plage!.end),
    );
    final async = ref.watch(provider);
    final plage = _plage;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes commandes')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 700
              ? 700.0
              : constraints.maxWidth;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _champ,
                            onChanged: _surSaisie,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: 'Référence, produit, partenaire…',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _champ.text.isEmpty
                                  ? null
                                  : IconButton(
                                      icon: const Icon(Icons.close),
                                      tooltip: 'Effacer',
                                      onPressed: _effacer,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: Icon(
                            plage == null
                                ? Icons.date_range_outlined
                                : Icons.date_range,
                          ),
                          tooltip: 'Filtrer par dates',
                          onPressed: _choisirDates,
                        ),
                      ],
                    ),
                  ),
                  if (plage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InputChip(
                          label: Text(
                            'Du ${_formatJour(plage.start)} '
                            'au ${_formatJour(plage.end)}',
                          ),
                          onPressed: _choisirDates,
                          onDeleted: () => setState(() => _plage = null),
                        ),
                      ),
                    ),
                  Expanded(
                    child: async.when(
                      loading: () => const SqueletteCartes(),
                      error: (e, _) =>
                          _Erreur(onRetry: () => ref.invalidate(provider)),
                      data: (commandes) => RefreshIndicator(
                        onRefresh: () async => ref.invalidate(provider),
                        child: commandes.isEmpty
                            ? const _Vide()
                            : ListView.separated(
                                padding: const EdgeInsets.all(12),
                                itemCount: commandes.length,
                                separatorBuilder: (_, i) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, i) =>
                                    _CarteCommande(commande: commandes[i]),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Couleur d'accompagnement selon le statut.
Color _couleurStatut(BuildContext context, String statut) {
  final scheme = Theme.of(context).colorScheme;
  switch (statut) {
    case 'livree':
      return Config.couleurSucces;
    case 'refusee':
    case 'annulee':
    case 'expiree':
      return scheme.error;
    case 'nouvelle':
      return scheme.primary;
    default:
      return Config.couleurAvertissement;
  }
}

class _CarteCommande extends StatelessWidget {
  const _CarteCommande({required this.commande});
  final Commande commande;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = commande;

    return Card(
      child: ListTile(
        title: Text(c.numero, style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c.partenaireNom),
            if (c.creeLe case final date?)
              Text(formatDateHeure(date), style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _couleurStatut(
                      context,
                      c.statut,
                    ).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    c.statutLibelle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _couleurStatut(context, c.statut),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${c.total} FCFA',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EcranCommandeDetail(commandeId: c.id),
          ),
        ),
      ),
    );
  }
}

/// Détail d'une commande, avec annulation possible si "nouvelle".
class EcranCommandeDetail extends ConsumerStatefulWidget {
  const EcranCommandeDetail({super.key, required this.commandeId});
  final int commandeId;

  @override
  ConsumerState<EcranCommandeDetail> createState() =>
      _EcranCommandeDetailState();
}

class _EcranCommandeDetailState extends ConsumerState<EcranCommandeDetail> {
  bool _occupe = false;

  Future<void> _annuler() async {
    if (_occupe) return;
    final messenger = ScaffoldMessenger.of(context);
    final confirme = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Annuler la commande ?'),
        content: const Text('Cette action est définitive.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Non'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
    if (confirme != true) return;

    setState(() => _occupe = true);
    try {
      await ref
          .read(ordersRepositoryProvider)
          .transition(commandeId: widget.commandeId, statut: 'annulee');
      ref.invalidate(commandeDetailProvider(id: widget.commandeId));
      // Toutes les listes (quels que soient recherche et dates).
      ref.invalidate(commandesProvider);
      messenger.showSnackBar(
        Notificateur.snackSucces('Commande annulée.'),
      );
    } catch (_) {
      messenger.showSnackBar(
        Notificateur.snackErreur('Impossible d\'annuler.'),
      );
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(commandeDetailProvider(id: widget.commandeId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Détail commande')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Erreur(
          onRetry: () =>
              ref.invalidate(commandeDetailProvider(id: widget.commandeId)),
        ),
        data: (c) => LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 700
                ? 700.0
                : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(c.numero, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      c.partenaireNom,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _couleurStatut(
                              context,
                              c.statut,
                            ).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            c.statutLibelle,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: _couleurStatut(context, c.statut),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (c.raisonRefus.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Motif : ${c.raisonRefus}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const Divider(height: 32),

                    Text('Articles', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    for (final l in c.lignes)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${l.nomArticle} ×${l.quantite}'),
                                  if (l.varianteNom.isNotEmpty)
                                    Text(
                                      l.varianteNom,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  for (final s in l.supplements)
                                    Text(
                                      '+ ${s.nom}',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                ],
                              ),
                            ),
                            Text('${l.prixLigne} FCFA'),
                          ],
                        ),
                      ),
                    const Divider(height: 32),

                    _LigneInfo('Retrait', c.modeLivraisonLibelle),
                    _LigneInfo('Paiement', 'À la remise'),
                    if (c.adresseSnapshot.isNotEmpty)
                      _LigneInfo('Adresse', c.adresseSnapshot),
                    const Divider(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: theme.textTheme.titleLarge),
                        Text(
                          '${c.total} FCFA',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    if (c.peutAnnuler) ...[
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: _occupe ? null : _annuler,
                        icon: const Icon(Icons.close),
                        label: const Text('Annuler la commande'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.error,
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LigneInfo extends StatelessWidget {
  const _LigneInfo(this.label, this.valeur);
  final String label;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                //color: theme.colorScheme.outline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(valeur)),
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
      // Défilable pour garder le « tirer pour rafraîchir ».
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Aucune commande trouvée',
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
