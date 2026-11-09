import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/consentements_repository.dart';
import '../widgets/choix_consentements.dart';

/// Mon compte › Confidentialité : modifier ses choix sur l'usage des
/// données.
class EcranConfidentialite extends ConsumerStatefulWidget {
  const EcranConfidentialite({super.key});

  @override
  ConsumerState<EcranConfidentialite> createState() =>
      _EcranConfidentialiteState();
}

class _EcranConfidentialiteState extends ConsumerState<EcranConfidentialite> {
  bool _enCours = false;

  Future<void> _enregistrer(bool statistiques, bool ia) async {
    setState(() => _enCours = true);
    try {
      await ref
          .read(consentementsRepositoryProvider)
          .enregistrer(statistiques: statistiques, ia: ia);
      ref.invalidate(consentementsProvider);
      if (mounted) Notificateur.succes(context, 'Vos choix sont enregistrés.');
    } catch (e) {
      if (mounted) {
        Notificateur.erreur(
          context,
          messageErreurApi(e, repli: 'Enregistrement impossible. Réessayez.'),
        );
      }
    } finally {
      if (mounted) setState(() => _enCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Confidentialité')),
      body: ref
          .watch(consentementsProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => MessageErreur(
              message: messageErreurApi(
                e,
                repli: 'Impossible de charger vos choix.',
              ),
              onReessayer: () => ref.invalidate(consentementsProvider),
            ),
            data: (c) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      'Choisissez si Poufiret peut utiliser votre usage de '
                      'l\'application pour s\'améliorer. C\'est facultatif.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    ChoixConsentements(
                      statistiques: c.statistiques,
                      ia: c.ia,
                      enCours: _enCours,
                      onEnregistrer: _enregistrer,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
