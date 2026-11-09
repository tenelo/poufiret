import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/locations_providers.dart';
import '../donnees/mes_annonces_repository.dart';
import '../metier_domaine/location_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/elements_vente.dart';
import '../widgets/formulaire_vente.dart';

/// Espace loueur : mes annonces (véhicules ou logements), vendues comprises.
/// Pour chacune : type d'annonce et champs de vente, et « Marquer vendu » /
/// « Remettre en vente ».
class EcranMesAnnonces extends ConsumerWidget {
  const EcranMesAnnonces({super.key, required this.type});

  final TypeAnnonce type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = mesAnnoncesProvider(type);
    final titre = type == TypeAnnonce.vehicule
        ? 'Mes véhicules'
        : 'Mes logements';
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: ref
          .watch(provider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => MessageErreur(
              message: messageErreurApi(
                e,
                repli: 'Impossible de charger vos annonces.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
            data: (annonces) => RefreshIndicator(
              onRefresh: () => ref.refresh(provider.future),
              child: annonces.isEmpty
                  ? ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            'Aucune annonce pour le moment.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                      itemCount: annonces.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, i) =>
                          _CarteAnnonce(type: type, annonce: annonces[i]),
                    ),
            ),
          ),
    );
  }
}

class _CarteAnnonce extends ConsumerWidget {
  const _CarteAnnonce({required this.type, required this.annonce});

  final TypeAnnonce type;
  final AnnonceGestion annonce;

  Future<void> _modifierVente(BuildContext context, WidgetRef ref) async {
    final meta = ref.read(metaLocationsProvider).value;
    final champs = type == TypeAnnonce.vehicule
        ? meta?.champsVente.vehicule
        : meta?.champsVente.logement;
    if (champs == null || champs.isEmpty) {
      Notificateur.erreur(
        context,
        'Formulaire indisponible. Vérifiez votre connexion et réessayez.',
      );
      ref.invalidate(metaLocationsProvider);
      return;
    }
    final enregistree = await ouvrirFormulaireVente(
      context,
      type: type,
      annonce: annonce,
      champs: champs,
    );
    if (enregistree != null && context.mounted) {
      ref.invalidate(mesAnnoncesProvider(type));
      Notificateur.succes(context, 'Annonce enregistrée.');
    }
  }

  Future<void> _basculerVendu(BuildContext context, WidgetRef ref) async {
    final vendu = !annonce.vente.vendu;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(vendu ? 'Marquer vendu ?' : 'Remettre en vente ?'),
        content: Text(
          vendu
              ? '« ${annonce.nom} » sera retirée des annonces visibles par '
                    'les clients.'
              : '« ${annonce.nom} » sera de nouveau visible par les clients.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(vendu ? 'Marquer vendu' : 'Remettre en vente'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await ref
          .read(mesAnnoncesRepositoryProvider)
          .marquerVendu(type, annonce.id, vendu: vendu);
      ref.invalidate(mesAnnoncesProvider(type));
      if (context.mounted) {
        Notificateur.succes(
          context,
          vendu ? 'Annonce marquée vendue.' : 'Annonce remise en vente.',
        );
      }
    } catch (e) {
      if (context.mounted) {
        Notificateur.erreur(
          context,
          messageErreurApi(e, repli: 'Action impossible. Réessayez.'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final a = annonce;
    final v = a.vente;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.nom,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      PuceLogement(v.mode.libelle),
                      if (v.vendu)
                        const BadgeAVendre(texte: 'Vendu')
                      else if (v.aVendre)
                        const BadgeAVendre(),
                      if (!a.estActif) const PuceLogement('Inactive'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (v.mode.aLouer && a.prix != null)
                    Text(
                      type == TypeAnnonce.vehicule
                          ? formatPrixJour(a.prix!)
                          : formatLoyer(a.prix!),
                      style: theme.textTheme.bodySmall,
                    ),
                  if (v.aVendre && v.prixVente != null)
                    Text(
                      v.prixNegociable
                          ? '${v.prixVenteLisible} · négociable'
                          : v.prixVenteLisible,
                      style: theme.textTheme.bodySmall,
                    ),
                  if (v.vendu && (v.venduLe ?? '').isNotEmpty)
                    Text(
                      'Vendu le ${formatDateCourte(v.venduLe)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Config.couleurTexteSecondaire,
                      ),
                    ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Actions',
              onSelected: (choix) => choix == 'vente'
                  ? _modifierVente(context, ref)
                  : _basculerVendu(context, ref),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'vente',
                  child: Text("Type d'annonce et vente"),
                ),
                if (v.aVendre)
                  PopupMenuItem(
                    value: 'vendu',
                    child: Text(
                      v.vendu ? 'Remettre en vente' : 'Marquer vendu',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
