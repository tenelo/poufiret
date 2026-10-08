import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';

/// « Mes demandes » : les visites de logement et les réservations
/// (véhicule, séjour) du client, avec leur statut, le motif d'un refus, et
/// l'annulation tant qu'elles ne sont pas terminées.
class EcranMesDemandes extends ConsumerWidget {
  const EcranMesDemandes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesDemandesReservationProvider);
    Future<void> actualiser() async {
      ref.invalidate(mesDemandesReservationProvider);
      try {
        await ref.read(mesDemandesReservationProvider.future);
      } catch (_) {
        // L'erreur s'affiche dans l'écran.
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mes demandes')),
      body: async.when(
        skipLoadingOnReload: true,
        loading: () => const SqueletteCartes(),
        error: (err, _) => MessageErreur(
          message: messageErreurApi(
            err,
            repli: 'Impossible de charger vos demandes.',
          ),
          onReessayer: () => ref.invalidate(mesDemandesReservationProvider),
        ),
        data: (demandes) => LayoutBuilder(
          builder: (context, contraintes) {
            final largeur = contraintes.maxWidth > 700
                ? 700.0
                : contraintes.maxWidth;
            return Center(
              child: SizedBox(
                width: largeur,
                child: RefreshIndicator(
                  onRefresh: actualiser,
                  child: demandes.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(32),
                          children: const [
                            Text(
                              "Vous n'avez encore aucune demande de visite ni de réservation.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          itemCount: demandes.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (context, i) => _CarteDemande(
                            key: ValueKey(demandes[i].id),
                            demande: demandes[i],
                          ),
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

class _CarteDemande extends ConsumerStatefulWidget {
  const _CarteDemande({super.key, required this.demande});

  final DemandeReservation demande;

  @override
  ConsumerState<_CarteDemande> createState() => _CarteDemandeState();
}

class _CarteDemandeState extends ConsumerState<_CarteDemande> {
  bool _envoi = false;

  Future<void> _annuler() async {
    var commentaire = '';
    final confirme = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Annuler cette demande ?'),
        content: TextField(
          onChanged: (v) => commentaire = v,
          maxLines: 2,
          decoration: const InputDecoration(labelText: 'Motif (optionnel)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Garder'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Annuler la demande'),
          ),
        ],
      ),
    );
    final texte = commentaire.trim();
    if (confirme != true || !mounted) return;

    setState(() => _envoi = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(locationsRepositoryProvider)
          .annulerDemande(widget.demande.id, commentaire: texte);
      ref.invalidate(mesDemandesReservationProvider);
      messenger.showSnackBar(Notificateur.snackSucces('Demande annulée.'));
    } catch (e) {
      messenger.showSnackBar(
        Notificateur.snackErreur(
          messageErreurApi(e, repli: 'Annulation impossible. Réessayez.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = widget.demande;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    d.objetNom.isEmpty ? d.natureLibelle : d.objetNom,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    d.statutLibelle.isEmpty ? d.statut : d.statutLibelle,
                    style: theme.textTheme.labelSmall,
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            if (d.partenaireNom.isNotEmpty)
              Text(
                d.partenaireNom,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              ),
            const SizedBox(height: 6),
            if (d.estSejour) ...[
              _Info(Icons.date_range_outlined, d.sejourLisible),
              if (d.voyageursLisible.isNotEmpty)
                _Info(Icons.people_outline, d.voyageursLisible),
              if (d.nbUnites != null)
                _Info(Icons.bed_outlined, pluriel(d.nbUnites!, 'chambre')),
              if (d.montantEstime != null)
                _Info(
                  Icons.payments_outlined,
                  'Montant estimé : ${formatMontant(d.montantEstime!)}',
                ),
            ] else if (d.estReservation) ...[
              _Info(Icons.date_range_outlined, d.periodeLisible),
              if (d.avecChauffeur)
                const _Info(Icons.person_outline, 'Avec chauffeur'),
              if (d.lieuPriseEnCharge.isNotEmpty)
                _Info(
                  Icons.place_outlined,
                  'Prise en charge : ${d.lieuPriseEnCharge}',
                ),
              if (d.montantEstime != null)
                _Info(
                  Icons.payments_outlined,
                  'Montant estimé : ${formatMontant(d.montantEstime!)}',
                ),
            ] else
              _Info(
                Icons.event_outlined,
                'Visite souhaitée le ${d.dateLisible}',
              ),
            if (d.numero.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Demande ${d.numero}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  ),
                ),
              ),
            if (d.raisonRefus.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Motif du refus : ${d.raisonRefus}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Config.couleurErreur,
                  ),
                ),
              ),
            if (d.peutAnnuler)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _envoi ? null : _annuler,
                  child: Text(_envoi ? 'Annulation…' : 'Annuler la demande'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Ligne « icône + texte » d'une demande.
class _Info extends StatelessWidget {
  const _Info(this.icone, this.texte);

  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icone, size: 16),
          const SizedBox(width: 6),
          Expanded(child: Text(texte)),
        ],
      ),
    );
  }
}
