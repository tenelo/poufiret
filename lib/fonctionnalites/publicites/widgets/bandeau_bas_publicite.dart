import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/publicites_providers.dart';
import '../donnees/publicites_repository.dart';
import '../metier_domaine/publicite_liste.dart';
import '../screens/ecran_publicite_detail.dart';
import '../../../global/widgets/image_reseau.dart';

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
    ref
        .read(publicitesRepositoryProvider)
        .enregistrerImpression(
          pub.id,
          typeAffichage: TypeAffichage.bandeauBas,
          sessionId: ref.read(sessionAnalyticsProvider).sessionId,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_ferme) return const SizedBox.shrink();

    final async = ref.watch(bandeauBasPubliciteProvider);
    // On garde la derniere pub connue pendant un rechargement : sinon le
    // bandeau clignote a chaque navigation. `value` reste renseigne
    // pendant un rechargement, contrairement a maybeWhen(data:).
    final pub = async.value;
    if (pub == null) return const SizedBox.shrink();

    _tracer(pub);
    return _Bandeau(pub: pub, onFermer: () => setState(() => _ferme = true));
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // Transparence : le contenu reste lisible derriere.
        decoration: BoxDecoration(
          color: Config.couleurFond.withValues(alpha: 0.92),
          border: Border.all(
            color: Config.couleurClaire.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth;
              // Hauteur proportionnelle a la largeur, bornee.
              final hauteur = (largeur * 0.14).clamp(54.0, 74.0);
              // TAILLE DE L'IMAGE : reduire le "- 12" pour AGRANDIR l'image,
              // l'augmenter (ex. "- 20") pour la DIMINUER.
              final tailleImage = hauteur - 12;
              final tailleTitre = (largeur * 0.035).clamp(12.0, 15.0);
              final tailleSous = (largeur * 0.030).clamp(10.0, 13.0);
              return SizedBox(
                height: hauteur,
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
                                  // ARRONDI DE L'IMAGE : monter le "6" pour des
                                  // coins plus ronds sur la vignette.
                                  borderRadius: BorderRadius.circular(6),
                                  child: ImageReseau(
                                    url,
                                    width: tailleImage,
                                    height: tailleImage,
                                    // CADRAGE DE L'IMAGE :
                                    // BoxFit.cover   -> remplit, rogne les bords (actuel)
                                    // BoxFit.contain -> image entiere visible, sans rogner
                                    // BoxFit.fill    -> etire (peut deformer)
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, e, s) => SizedBox(
                                      width: tailleImage,
                                      height: tailleImage,
                                    ),
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: tailleTitre,
                                        color: Config.couleurTexte,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Publicité — appuyez pour voir',
                                      style: TextStyle(
                                        fontSize: tailleSous,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
