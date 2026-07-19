import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/errors/api_exception.dart';
import '../data/prestations_providers.dart';
import '../domain/demande_intervention.dart';
import 'ecran_mes_demandes.dart' show couleurStatut;

/// Détail d'une demande d'intervention, actions selon le rôle.
class EcranDemandeDetail extends ConsumerStatefulWidget {
  const EcranDemandeDetail({
    super.key,
    required this.demandeId,
    required this.estArtisan,
  });

  final int demandeId;
  final bool estArtisan;

  @override
  ConsumerState<EcranDemandeDetail> createState() =>
      _EcranDemandeDetailState();
}

class _EcranDemandeDetailState extends ConsumerState<EcranDemandeDetail> {
  bool _actionEnCours = false;

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  void _rafraichir() {
    ref.invalidate(demandeInterventionDetailProvider(id: widget.demandeId));
    ref.invalidate(mesDemandesInterventionProvider);
    ref.invalidate(demandesInterventionRecuesProvider);
  }

  Future<void> _appeler(String numero) async {
    final uri = Uri(scheme: 'tel', path: numero);
    if (!await launchUrl(uri)) _message('Impossible de lancer l\'appel.');
  }

  Future<void> _itineraire(double lat, double lng) async {
    // geo: ouvre l'app de cartes du téléphone ; repli navigateur.
    final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng(Client)');
    if (await canLaunchUrl(geo)) {
      await launchUrl(geo);
      return;
    }
    final web = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (!await launchUrl(web, mode: LaunchMode.externalApplication)) {
      _message('Impossible d\'ouvrir l\'itinéraire.');
    }
  }

  Future<void> _transitionner(
    String cible, {
    String? dateProposee,
    int? prixPropose,
    String? raisonRefus,
  }) async {
    setState(() => _actionEnCours = true);
    try {
      await ref.read(prestationsRepositoryProvider).transitionner(
            widget.demandeId,
            cible,
            dateProposee: dateProposee,
            prixPropose: prixPropose,
            raisonRefus: raisonRefus,
          );
      _rafraichir();
      _message('Demande mise à jour.');
    } catch (e) {
      _message(e is ApiException
          ? e.messageLisible
          : 'Action impossible. Réessayez.');
    } finally {
      if (mounted) setState(() => _actionEnCours = false);
    }
  }

  Future<void> _confirmer(String question, VoidCallback action) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(question),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Non')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Oui')),
        ],
      ),
    );
    if (ok == true) action();
  }

  /// Dialogue artisan : accepter avec prix et date proposés (optionnels).
  Future<void> _accepter() async {
    final ctrlPrix = TextEditingController();
    DateTime? date;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Accepter la demande'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrlPrix,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Prix proposé (FCFA, optionnel)',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.event),
                label: Text(date == null
                    ? 'Proposer une date (optionnel)'
                    : '${date!.day}/${date!.month}/${date!.year} '
                        '${date!.hour}h${date!.minute.toString().padLeft(2, '0')}'),
                onPressed: () async {
                  final jour = await showDatePicker(
                    context: ctx,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                  );
                  if (jour == null || !ctx.mounted) return;
                  final heure = await showTimePicker(
                      context: ctx, initialTime: TimeOfDay.now());
                  if (heure == null) return;
                  setDialogState(() => date = DateTime(jour.year, jour.month,
                      jour.day, heure.hour, heure.minute));
                },
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Annuler')),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Accepter')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    await _transitionner(
      'acceptee',
      prixPropose: int.tryParse(ctrlPrix.text.trim()),
      dateProposee: date?.toIso8601String(),
    );
  }

  /// Dialogue artisan : refuser avec raison.
  Future<void> _refuser() async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Refuser la demande'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Raison (optionnel)'),
          maxLines: 2,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Refuser')),
        ],
      ),
    );
    if (ok != true) return;
    await _transitionner('refusee', raisonRefus: ctrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync =
        ref.watch(demandeInterventionDetailProvider(id: widget.demandeId));
    return Scaffold(
      appBar: AppBar(title: const Text('Demande d\'intervention')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(err is ApiException
                  ? err.messageLisible
                  : 'Erreur de chargement.'),
              const SizedBox(height: 12),
              FilledButton(
                  onPressed: _rafraichir, child: const Text('Réessayer')),
            ],
          ),
        ),
        data: (d) => LayoutBuilder(
          builder: (context, contraintes) {
            final largeur =
                contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
            return Center(
              child: SizedBox(
                width: largeur,
                child: _Contenu(
                  demande: d,
                  estArtisan: widget.estArtisan,
                  actionEnCours: _actionEnCours,
                  onAppeler: _appeler,
                  onItineraire: _itineraire,
                  onAccepter: _accepter,
                  onRefuser: _refuser,
                  onDemarrer: () => _confirmer(
                      'Démarrer l\'intervention ?',
                      () => _transitionner('en_cours')),
                  onTerminer: () => _confirmer(
                      'Marquer comme terminée ?',
                      () => _transitionner('terminee')),
                  onAnnuler: () => _confirmer('Annuler cette demande ?',
                      () => _transitionner('annulee')),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu({
    required this.demande,
    required this.estArtisan,
    required this.actionEnCours,
    required this.onAppeler,
    required this.onItineraire,
    required this.onAccepter,
    required this.onRefuser,
    required this.onDemarrer,
    required this.onTerminer,
    required this.onAnnuler,
  });

  final DemandeIntervention demande;
  final bool estArtisan;
  final bool actionEnCours;
  final void Function(String) onAppeler;
  final void Function(double, double) onItineraire;
  final VoidCallback onAccepter;
  final VoidCallback onRefuser;
  final VoidCallback onDemarrer;
  final VoidCallback onTerminer;
  final VoidCallback onAnnuler;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur = couleurStatut(demande.statut, theme.colorScheme);
    final autreNumero =
        estArtisan ? demande.clientTelephone : demande.artisanTelephone;
    final autreNom = estArtisan ? demande.clientNom : demande.artisanNom;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── En-tête ────────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: Text(demande.numero,
                  style: theme.textTheme.titleMedium),
            ),
            Chip(
              label: Text(demande.statutLibelle,
                  style: TextStyle(fontSize: 12, color: couleur)),
              side: BorderSide(color: couleur),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text('${demande.typeLibelle} · ${demande.urgenceLibelle}',
            style: theme.textTheme.bodyMedium),
        Text('Disponibilité : ${demande.disponibiliteLibelle}',
            style: theme.textTheme.bodySmall),
        const Divider(height: 24),

        // ── Contact ────────────────────────────────────────────────
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.person),
          title: Text(autreNom),
          subtitle: Text(autreNumero),
          trailing: IconButton.filledTonal(
            icon: const Icon(Icons.call),
            onPressed:
                autreNumero.isEmpty ? null : () => onAppeler(autreNumero),
          ),
        ),
        if (estArtisan && demande.aPosition)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on),
            title: const Text('Position du client'),
            subtitle: const Text('Ouvrir l\'itinéraire dans Maps'),
            trailing: IconButton.filledTonal(
              icon: const Icon(Icons.directions),
              onPressed: () =>
                  onItineraire(demande.latitude!, demande.longitude!),
            ),
          ),
        const Divider(height: 24),

        // ── Description ────────────────────────────────────────────
        Text('Description', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(demande.description),
        if (demande.descriptionAcces.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Comment trouver le lieu',
              style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(demande.descriptionAcces),
        ],

        // ── Photos ─────────────────────────────────────────────────
        if (demande.photos.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Photos', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: demande.photos.length,
              separatorBuilder: (_, i) => const SizedBox(width: 8),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  demande.photos[i].image,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => Container(
                    width: 110,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          ),
        ],

        // ── Proposition de l'artisan ───────────────────────────────
        if (demande.prixPropose != null || demande.dateProposee != null) ...[
          const Divider(height: 24),
          Text('Proposition de l\'artisan',
              style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          if (demande.prixPropose != null)
            Text('Prix : ${demande.prixPropose} FCFA'),
          if (demande.dateProposee != null)
            Text('Date : ${demande.dateProposee!.split('T').first}'),
        ],
        if (demande.raisonRefus.isNotEmpty) ...[
          const Divider(height: 24),
          Text('Raison du refus', style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(demande.raisonRefus),
        ],

        const SizedBox(height: 24),

        // ── Actions selon rôle et statut ───────────────────────────
        if (actionEnCours)
          const Center(child: CircularProgressIndicator())
        else ...[
          if (estArtisan) ...[
            if (demande.statut == 'en_attente') ...[
              FilledButton.icon(
                onPressed: onAccepter,
                icon: const Icon(Icons.check),
                label: const Text('Accepter'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: onRefuser,
                icon: const Icon(Icons.close),
                label: const Text('Refuser'),
              ),
            ],
            if (demande.statut == 'acceptee')
              FilledButton.icon(
                onPressed: onDemarrer,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Démarrer l\'intervention'),
              ),
            if (demande.statut == 'en_cours')
              FilledButton.icon(
                onPressed: onTerminer,
                icon: const Icon(Icons.task_alt),
                label: const Text('Marquer comme terminée'),
              ),
          ],
          // Annuler : client à tout moment (hors états finaux),
          // artisan aussi (accepte/en_cours) selon TRANSITIONS.
          if (!demande.estFinale &&
              (!estArtisan || demande.statut != 'en_attente')) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onAnnuler,
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Annuler la demande'),
            ),
          ],
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}
