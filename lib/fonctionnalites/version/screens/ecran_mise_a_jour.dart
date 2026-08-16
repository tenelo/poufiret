import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global/config/config.dart';
import '../metier_domaine/info_version.dart';

/// Écran plein bloquant affiché quand une mise à jour est OBLIGATOIRE.
///
/// Même niveau de blocage que le mur d'authentification : l'utilisateur
/// ne peut pas revenir en arrière (PopScope) ; la seule action est
/// d'ouvrir le store pour se mettre à jour.
class EcranMiseAJour extends StatelessWidget {
  const EcranMiseAJour({super.key, required this.info});

  final InfoVersion info;

  Future<void> _ouvrirStore(BuildContext context) async {
    final lien = info.lienStore;
    if (lien.isEmpty) return;
    final uri = Uri.tryParse(lien);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir le store.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = info.message.isNotEmpty
        ? info.message
        : 'Une nouvelle version de Poufiret est disponible. '
            'Mettez à jour l\'application pour continuer.';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Config.couleurFond,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, contraintes) {
              final largeur =
                  contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: largeur),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.system_update,
                            size: 72, color: Config.couleurPrimaire),
                        const SizedBox(height: 24),
                        Text(
                          'Mise à jour requise',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Config.couleurTexteSecondaire,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: info.lienStore.isEmpty
                                ? null
                                : () => _ouvrirStore(context),
                            icon: const Icon(Icons.download),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text('Mettre à jour maintenant'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
