import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../donnees/prestations_providers.dart';
import '../metier_domaine/demande_intervention.dart';
import 'ecran_demande_detail.dart';

/// Couleur associée à un statut de demande.
Color couleurStatut(String statut, ColorScheme couleurs) => switch (statut) {
      'en_attente' => couleurs.tertiary,
      'acceptee' => Colors.green,
      'en_cours' => couleurs.primary,
      'terminee' => Colors.teal,
      'refusee' => couleurs.error,
      'annulee' => couleurs.outline,
      _ => couleurs.outline,
    };

/// Liste des demandes d'intervention du client connecté.
class EcranMesDemandes extends ConsumerWidget {
  const EcranMesDemandes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demandesAsync = ref.watch(mesDemandesInterventionProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mes demandes d\'intervention')),
      body: demandesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final message = err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.';
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(mesDemandesInterventionProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
        data: (demandes) {
          if (demandes.isEmpty) {
            return const Center(
                child: Text('Aucune demande d\'intervention.'));
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth > 700
                  ? 700.0
                  : contraintes.maxWidth;
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(mesDemandesInterventionProvider),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: demandes.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 8),
                      itemBuilder: (context, i) => _CarteDemande(
                        demande: demandes[i],
                        estArtisan: false,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Carte résumée d'une demande (réutilisée côté client et artisan).
class _CarteDemande extends ConsumerWidget {
  const _CarteDemande({required this.demande, required this.estArtisan});

  final DemandeIntervention demande;
  final bool estArtisan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final couleur = couleurStatut(demande.statut, theme.colorScheme);
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EcranDemandeDetail(
                demandeId: demande.id,
                estArtisan: estArtisan,
              ),
            ),
          );
        },
        title: Text(
          '${demande.typeLibelle} — '
          '${estArtisan ? demande.clientNom : demande.artisanNom}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(demande.numero, style: theme.textTheme.bodySmall),
            Text(
              demande.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Chip(
          label: Text(demande.statutLibelle,
              style: TextStyle(fontSize: 11, color: couleur)),
          side: BorderSide(color: couleur),
          visualDensity: VisualDensity.compact,
        ),
        isThreeLine: true,
      ),
    );
  }
}

/// Liste des demandes reçues par l'artisan connecté.
class EcranDemandesRecues extends ConsumerWidget {
  const EcranDemandesRecues({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demandesAsync = ref.watch(demandesInterventionRecuesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Demandes reçues')),
      body: demandesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final message = err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.';
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(demandesInterventionRecuesProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
        data: (demandes) {
          if (demandes.isEmpty) {
            return const Center(child: Text('Aucune demande reçue.'));
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth > 700
                  ? 700.0
                  : contraintes.maxWidth;
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(demandesInterventionRecuesProvider),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: demandes.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 8),
                      itemBuilder: (context, i) => _CarteDemande(
                        demande: demandes[i],
                        estArtisan: true,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
