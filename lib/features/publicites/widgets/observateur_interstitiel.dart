import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config.dart';
import '../../analytics/data/analytics_providers.dart';
import '../data/publicites_providers.dart';
import '../data/publicites_repository.dart';
import '../domain/publicite_detail.dart';
import '../screens/ecran_publicite_detail.dart';

/// Duree pendant laquelle l'interstitiel reste non fermable.
const _dureeAvantFermeture = Duration(seconds: 10);

/// Surveille la session et declenche l'interstitiel quand le backend
/// juge le moment venu.
///
/// A placer haut dans l'arbre (coquille de l'app) : il n'affiche rien
/// par lui-meme, il se contente d'ouvrir une boite de dialogue.
class ObservateurInterstitiel extends ConsumerStatefulWidget {
  const ObservateurInterstitiel({super.key, required this.enfant});

  final Widget enfant;

  @override
  ConsumerState<ObservateurInterstitiel> createState() =>
      _ObservateurInterstitielState();
}

class _ObservateurInterstitielState
    extends ConsumerState<ObservateurInterstitiel> {
  bool _enCours = false;
  int _derniereMinuteTestee = -1;

  /// Demande au serveur s'il y a une pub a servir a cette minute.
  ///
  /// C'est le backend qui applique le ciblage (minute cible calculee sur
  /// la duree moyenne de session, intervalle minimum, quotas). L'app ne
  /// fait que demander.
  Future<void> _verifier(int minute) async {
    if (_enCours || minute <= 0 || minute == _derniereMinuteTestee) return;
    _derniereMinuteTestee = minute;
    _enCours = true;
    try {
      final pub = await ref
          .read(publicitesRepositoryProvider)
          .interstitiel(minuteSession: minute);
      if (pub != null && mounted) {
        await _afficher(pub, minute);
      }
    } catch (_) {
      // Silencieux : une pub qui echoue ne doit jamais gener l'utilisateur.
    } finally {
      _enCours = false;
    }
  }

  Future<void> _afficher(PubliciteDetail pub, int minute) async {
    // Impression tracee des l'affichage (le backend s'en sert pour
    // l'intervalle minimum et les quotas).
    ref.read(publicitesRepositoryProvider).enregistrerImpression(
          pub.id,
          typeAffichage: TypeAffichage.interstitiel,
          minuteSession: minute,
        );
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _BoiteInterstitiel(pub: pub),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sessionAnalyticsProvider, (avant, apres) {
      if (avant?.minute != apres.minute) _verifier(apres.minute);
    });
    return widget.enfant;
  }
}

/// Boite plein ecran (70-80%) affichant l'affiche publicitaire.
class _BoiteInterstitiel extends StatefulWidget {
  const _BoiteInterstitiel({required this.pub});
  final PubliciteDetail pub;

  @override
  State<_BoiteInterstitiel> createState() => _BoiteInterstitielState();
}

class _BoiteInterstitielState extends State<_BoiteInterstitiel> {
  late int _restant = _dureeAvantFermeture.inSeconds;
  Timer? _minuteur;

  @override
  void initState() {
    super.initState();
    _minuteur = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _restant--);
      if (_restant <= 0) t.cancel();
    });
  }

  @override
  void dispose() {
    _minuteur?.cancel();
    super.dispose();
  }

  bool get _fermable => _restant <= 0;

  @override
  Widget build(BuildContext context) {
    final taille = MediaQuery.sizeOf(context);
    final url = widget.pub.imageCouverture ?? '';

    return PopScope(
      // Le retour materiel ne ferme qu'apres le decompte.
      canPop: _fermable,
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          // ~80% de l'ecran, borne pour rester correct sur tablette.
          width: (taille.width * 0.85).clamp(280.0, 520.0),
          height: (taille.height * 0.78).clamp(360.0, 760.0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (url.isEmpty)
                      Container(color: Config.couleurFond)
                    else
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EcranPubliciteDetail(
                                id: widget.pub.id,
                                typeAffichageSource:
                                    TypeAffichage.interstitiel,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          errorBuilder: (_, e, s) => Container(
                            color: Config.couleurFond,
                            child: const Center(
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: Config.couleurTexteSecondaire),
                            ),
                          ),
                        ),
                      ),
                    // Decompte / bouton fermer, en haut a droite.
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _BoutonFermeture(
                        restant: _restant,
                        onFermer: _fermable
                            ? () => Navigator.of(context).pop()
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              // Bandeau titre + appel a l'action.
              Container(
                width: double.infinity,
                color: Config.couleurFond,
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.pub.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Config.couleurTexte,
                      ),
                    ),
                    if (widget.pub.nomPartenaire.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.pub.nomPartenaire,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Config.couleurTexteSecondaire,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoutonFermeture extends StatelessWidget {
  const _BoutonFermeture({required this.restant, this.onFermer});
  final int restant;
  final VoidCallback? onFermer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.55),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onFermer,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Center(
            child: onFermer == null
                ? Text(
                    '$restant',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )
                : const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
