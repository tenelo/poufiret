import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../donnees/publicites_providers.dart';
import '../metier_domaine/stats_publicite.dart';
import 'ecran_faire_publicite.dart';

/// Campagnes du partenaire et leurs resultats.
class EcranMesPublicites extends ConsumerWidget {
  const EcranMesPublicites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesStatsPublicitesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes publicités')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EcranFairePublicite()),
          );
          ref.invalidate(mesStatsPublicitesProvider);
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle publicité'),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(mesStatsPublicitesProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (pubs) {
          if (pubs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucune publicité pour le moment.\n'
                  'Créez-en une pour mettre votre commerce en avant.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.couleurTexteSecondaire),
                ),
              ),
            );
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur =
                  contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(mesStatsPublicitesProvider),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
                      children: [
                        for (final p in pubs) _CartePub(stats: p),
                      ],
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

class _CartePub extends StatelessWidget {
  const _CartePub({required this.stats});
  final StatsPublicite stats;

  Color get _couleurStatut => switch (stats.statut) {
        'active' => Config.couleurSucces,
        'rejetee' => Config.couleurErreur,
        'terminee' => Config.couleurTexteSecondaire,
        _ => Config.couleurAvertissement,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    stats.titre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _couleurStatut.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    stats.statutLisible,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _couleurStatut,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Forfait ${stats.formule}',
              style: const TextStyle(
                  fontSize: 12, color: Config.couleurTexteSecondaire),
            ),
            const SizedBox(height: 12),

            if (!stats.statsDisponibles)
              Text(
                stats.message ?? 'Statistiques bientôt disponibles.',
                style: const TextStyle(
                    fontSize: 13, color: Config.couleurTexteSecondaire),
              )
            else ...[
              Row(
                children: [
                  _Chiffre(
                    valeur: '${stats.personnesTouchees}',
                    libelle: 'personnes\ntouchées',
                  ),
                  _Chiffre(
                    valeur: '${stats.impressions}',
                    libelle: 'affichages',
                  ),
                  _Chiffre(
                    valeur: '${stats.clics}',
                    libelle: 'clics',
                  ),
                  _Chiffre(
                    valeur: '${stats.tauxClic}%',
                    libelle: 'taux\nde clic',
                  ),
                ],
              ),
              if (stats.ciblePourcentage != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      stats.cibleAtteinte
                          ? Icons.verified
                          : Icons.hourglass_bottom,
                      size: 15,
                      color: stats.cibleAtteinte
                          ? Config.couleurSucces
                          : Config.couleurAvertissement,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        stats.cibleAtteinte
                            ? 'Garantie atteinte : ${stats.ciblePourcentage}% '
                                'des clients actifs touchés'
                            : 'Diffusion prolongée jusqu\'à toucher '
                                '${stats.ciblePourcentage}% des clients actifs',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _Chiffre extends StatelessWidget {
  const _Chiffre({required this.valeur, required this.libelle});
  final String valeur;
  final String libelle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valeur,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Config.couleurPrimaire,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            libelle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10, color: Config.couleurTexteSecondaire),
          ),
        ],
      ),
    );
  }
}
