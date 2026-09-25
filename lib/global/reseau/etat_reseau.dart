import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config.dart';

/// Vrai quand le serveur est injoignable (aucune réponse HTTP, ou 502/503/504).
///
/// Alimenté par le client HTTP lui-même : chaque réponse remet l'état « en
/// ligne », chaque échec réseau le passe « hors connexion ». Aucune
/// dépendance de détection de connectivité n'est nécessaire.
final etatReseauProvider = NotifierProvider<EtatReseau, bool>(EtatReseau.new);

class EtatReseau extends Notifier<bool> {
  @override
  bool build() => false;

  void signaler({required bool horsLigne}) {
    if (state != horsLigne) state = horsLigne;
  }
}

/// Bandeau « Hors connexion », discret, visible tant que le serveur est
/// injoignable. Les données affichées viennent alors du cache.
class BandeauHorsLigne extends ConsumerWidget {
  const BandeauHorsLigne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horsLigne = ref.watch(etatReseauProvider);
    if (!horsLigne) return const SizedBox.shrink();
    return Material(
      color: Config.couleurTexteSecondaire,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 13, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                'Hors connexion',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
