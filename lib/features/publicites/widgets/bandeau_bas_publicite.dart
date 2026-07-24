import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config.dart';
import '../../analytics/data/analytics_providers.dart';
import '../data/publicites_providers.dart';
import '../data/publicites_repository.dart';
import '../domain/publicite_liste.dart';
import '../screens/ecran_publicite_detail.dart';

/// Bandeau publicitaire discret, ancre en bas de l'ecran.
///
/// Semi-transparent pour ne pas masquer le contenu. Invisible s'il n'y a
/// aucune pub a servir, et refermable par l'utilisateur.
class BandeauBasPublicite extends ConsumerStatefulWidget {
  const BandeauBasPublicite({super.key});

  @override
  ConsumerState<BandeauBasPublicite> createState() =>
      _BandeauBasPubliciteState();
}

class _BandeauBasPubliciteState extends ConsumerState<BandeauBasPublicite> {
  bool _ferme = false;
  bool _impressionTracee = false;

  void _tracer(PubliciteListe pub) {
    if (_impressionTracee) return;
    _impressionTracee = true;
    ref.read(publicitesRepositoryProvider).enregistrerImpression(
          pub.id,
          typeAffichage: TypeAffichage.bandeauBas,
          sessionId: ref.read(sessionAnalyticsProvider).sessionId,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_ferme) return const SizedBox.shrink();

    return ref.watch(bandeauBasPubliciteProvider).maybeWhen(
          // Silencieux pendant le chargement ou en cas d'erreur.
          orElse: () => const SizedBox.shrink(),
          data: (pub) {
            if (pub == null) return const SizedBox.shrink();
            _tracer(pub);
            return _Bandeau(
              pub: pub,
              onFermer: () => setState(() => _ferme = true),
            );
          },
        );
  }
}

class _Bandeau extends StatelessWidget {
  const _Bandeau({required this.pub, required this.onFermer});

  final PubliciteListe pub;
  final VoidCallback onFermer;

  @override
  Widget build(BuildContext context) {
    final url = pub.imageCouverture ?? '';

    return Material(
      color: Colors.transparent,
      child: Container(
        // Transparence : le contenu reste lisible derriere.
        decoration: BoxDecoration(
          color: Config.couleurFond.withValues(alpha: 0.92),
          border: Border(
            top: BorderSide(
              color: Config.couleurClaire.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 58,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EcranPubliciteDetail(
                          id: pub.id,
                          typeAffichageSource: TypeAffichage.bandeauBas,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                      child: Row(
                        children: [
                          if (url.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                url,
                                width: 46,
                                height: 46,
                                fit: BoxFit.cover,
                                errorBuilder: (_, e, s) =>
                                    const SizedBox(width: 46, height: 46),
                              ),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pub.titre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Config.couleurTexte,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Publicité — appuyez pour voir',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Config.couleurTexteSecondaire,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  color: Config.couleurTexteSecondaire,
                  tooltip: 'Masquer',
                  onPressed: onFermer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
