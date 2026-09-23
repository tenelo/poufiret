import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../donnees/publicites_providers.dart';
import '../metier_domaine/credit_formule.dart';

/// Recapitulatif des faveurs publicitaires (credits de formule) accordees
/// au partenaire : celles encore disponibles et celles deja consommees.
class EcranMesFaveursPub extends ConsumerWidget {
  const EcranMesFaveursPub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesCreditsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes faveurs pub')),
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
                  onPressed: () => ref.invalidate(mesCreditsProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (credits) {
          if (credits.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucune faveur publicitaire pour le moment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.couleurTexteSecondaire),
                ),
              ),
            );
          }
          // Les credits encore disponibles sont mis en avant, en tete de liste.
          final tries = [...credits]
            ..sort((a, b) {
              if (a.estDisponible == b.estDisponible) return 0;
              return a.estDisponible ? -1 : 1;
            });
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur =
                  contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: largeur),
                  child: RefreshIndicator(
                    onRefresh: () async => ref.invalidate(mesCreditsProvider),
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        for (final c in tries) ...[
                          _CarteCredit(credit: c),
                          const SizedBox(height: 10),
                        ],
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

class _CarteCredit extends StatelessWidget {
  const _CarteCredit({required this.credit});
  final CreditFormule credit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur =
        credit.estDisponible ? Config.couleurSucces : Config.couleurTexteSecondaire;

    return Card(
      color: credit.estDisponible
          ? Config.couleurSucces.withValues(alpha: 0.06)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.card_giftcard, size: 18, color: couleur),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    credit.formuleNom,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: couleur.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    credit.estDisponible ? 'Disponible' : 'Consommé',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: couleur,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Valeur : ${credit.formulePrix} FCFA',
              style: const TextStyle(
                  fontSize: 12, color: Config.couleurTexteSecondaire),
            ),
            const SizedBox(height: 2),
            Text(
              'Octroyée le ${_dateLisible(credit.creeLe)}',
              style: const TextStyle(
                  fontSize: 12, color: Config.couleurTexteSecondaire),
            ),
            if (!credit.estDisponible && credit.consommeLe != null) ...[
              const SizedBox(height: 2),
              Text(
                'Utilisée le ${_dateLisible(credit.consommeLe)}',
                style: const TextStyle(
                    fontSize: 12, color: Config.couleurTexteSecondaire),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Date lisible a partir d'une chaine ISO (repli sur '—' si absente).
  String _dateLisible(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    return iso.split('T').first;
  }
}
