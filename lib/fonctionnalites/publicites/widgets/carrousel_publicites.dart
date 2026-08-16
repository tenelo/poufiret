import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/publicites_providers.dart';
import '../donnees/publicites_repository.dart';
import '../metier_domaine/publicite_liste.dart';
import '../screens/ecran_publicite_detail.dart';
import '../../../global/widgets/image_reseau.dart';

/// Carrousel de publicites pour l'accueil.
///
/// Defile automatiquement, chaque pub restant affichee pendant la duree
/// prevue par sa formule. Invisible s'il n'y a aucune pub active.
class CarrouselPublicites extends ConsumerStatefulWidget {
  const CarrouselPublicites({super.key});

  @override
  ConsumerState<CarrouselPublicites> createState() =>
      _CarrouselPublicitesState();
}

class _CarrouselPublicitesState extends ConsumerState<CarrouselPublicites> {
  final _controleur = PageController();
  Timer? _minuteur;
  int _index = 0;
  final Set<String> _tracees = {};

  @override
  void dispose() {
    _minuteur?.cancel();
    _controleur.dispose();
    super.dispose();
  }

  /// Programme le passage a la pub suivante selon la duree de la formule.
  void _programmerSuivant(List<PubliciteListe> pubs) {
    _minuteur?.cancel();
    if (pubs.length < 2) return;
    _minuteur = Timer(pubs[_index].dureePassage, () {
      if (!mounted || !_controleur.hasClients) return;
      final suivant = (_index + 1) % pubs.length;
      _controleur.animateToPage(
        suivant,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  /// Trace une impression une seule fois par pub et par session d'ecran.
  void _tracerImpression(PubliciteListe pub) {
    if (!_tracees.add(pub.id)) return;
    ref
        .read(publicitesRepositoryProvider)
        .enregistrerImpression(
          pub.id,
          typeAffichage: TypeAffichage.carrousel,
          sessionId: ref.read(sessionAnalyticsProvider).sessionId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(carrouselPublicitesProvider);

    return async.maybeWhen(
      // Silencieux : un carrousel qui charge ou echoue ne doit pas
      // perturber l'accueil.
      orElse: () => const SizedBox.shrink(),
      data: (pubs) {
        if (pubs.isEmpty) return const SizedBox.shrink();

        if (_index >= pubs.length) _index = 0;
        _tracerImpression(pubs[_index]);
        _programmerSuivant(pubs);

        return LayoutBuilder(
          builder: (context, contraintes) {
            // Hauteur proportionnelle a la largeur (ratio ~16/9 borne).
            final largeur = contraintes.maxWidth;
            final hauteur = (largeur * 0.30).clamp(140.0, 260.0);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: hauteur,
                  child: PageView.builder(
                    controller: _controleur,
                    itemCount: pubs.length,
                    onPageChanged: (i) {
                      setState(() => _index = i);
                      _tracerImpression(pubs[i]);
                    },
                    itemBuilder: (context, i) => _Diapositive(pub: pubs[i]),
                  ),
                ),
                if (pubs.length > 1) ...[
                  const SizedBox(height: 4),
                  _Indicateurs(nombre: pubs.length, actif: _index),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

class _Diapositive extends StatelessWidget {
  const _Diapositive({required this.pub});
  final PubliciteListe pub;

  @override
  Widget build(BuildContext context) {
    final url = pub.imageCouverture ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Config.couleurFond,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EcranPubliciteDetail(
                  id: pub.id,
                  typeAffichageSource: TypeAffichage.carrousel,
                ),
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (url.isNotEmpty)
                  ImageReseau(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, e, s) => const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Config.couleurTexteSecondaire,
                      ),
                    ),
                  ),
                // Degrade bas pour la lisibilite du titre.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 24, 12, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.65),
                        ],
                      ),
                    ),
                    child: Text(
                      pub.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Indicateurs extends StatelessWidget {
  const _Indicateurs({required this.nombre, required this.actif});
  final int nombre;
  final int actif;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < nombre; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == actif ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == actif ? Config.couleurPrimaire : Config.couleurClaire,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
