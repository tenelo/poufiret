import 'package:flutter/material.dart';

import 'bandeau_bas_publicite.dart';

/// Ecrans ou le bandeau publicitaire ne doit pas apparaitre.
///
/// Le chat et la validation de commande sont des moments ou une
/// distraction coute une conversion : mieux vaut perdre une impression
/// qu'une vente ou une conversation.
const Set<String> ecransSansBandeau = {
  'discussion',
  'panier',
};

/// Etat partage de la couche publicitaire.
///
/// Deux informations : l'ecran sensible eventuellement au premier plan,
/// et la profondeur de navigation (pour savoir s'il faut laisser la
/// place a la barre d'onglets).
class EtatCouchePub {
  EtatCouchePub._();

  static final ValueNotifier<String?> ecranSensible = ValueNotifier(null);
  static final ValueNotifier<int> profondeur = ValueNotifier(0);
}

/// Suit les ecrans empiles au-dessus de la coquille a onglets.
class ObservateurNavigation extends NavigatorObserver {
  int _profondeur = 0;

  void _maj(int delta) {
    _profondeur = (_profondeur + delta).clamp(0, 99);
    EtatCouchePub.profondeur.value = _profondeur;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) _maj(1);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _maj(-1);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _maj(-1);
}

final observateurNavigation = ObservateurNavigation();

/// Superpose le bandeau publicitaire au-dessus de toute l'application.
///
/// Place a la racine plutot que dans la coquille a onglets, il reste
/// visible sur les ecrans pousses par-dessus : fiche article, vitrine,
/// detail d'une publicite.
class CouchePublicites extends StatelessWidget {
  const CouchePublicites({
    super.key,
    required this.enfant,
    this.hauteurBarreOnglets = 80,
  });

  final Widget enfant;

  /// Hauteur reservee a la barre d'onglets quand on est sur la coquille.
  final double hauteurBarreOnglets;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        enfant,
        ValueListenableBuilder<String?>(
          valueListenable: EtatCouchePub.ecranSensible,
          builder: (context, sensible, _) {
            if (sensible != null && ecransSansBandeau.contains(sensible)) {
              return const SizedBox.shrink();
            }
            return ValueListenableBuilder<int>(
              valueListenable: EtatCouchePub.profondeur,
              builder: (context, profondeur, _) {
                // A la racine, la barre d'onglets occupe le bas : on se
                // place juste au-dessus. Sur un ecran pousse, elle n'est
                // pas la, le bandeau descend au ras du bord.
                final aLaRacine = profondeur == 0;
                final large = MediaQuery.sizeOf(context).width >= 600;
                final bas = (aLaRacine && !large)
                    ? hauteurBarreOnglets +
                        MediaQuery.paddingOf(context).bottom
                    : 0.0;
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: bas,
                  child: Material(
                    type: MaterialType.transparency,
                    child: SafeArea(
                      top: false,
                      bottom: !aLaRacine,
                      child: const BandeauBasPublicite(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

/// Enveloppe un ecran ou le bandeau doit disparaitre.
class PageSansBandeau extends StatefulWidget {
  const PageSansBandeau({super.key, required this.nom, required this.enfant});

  final String nom;
  final Widget enfant;

  @override
  State<PageSansBandeau> createState() => _PageSansBandeauState();
}

class _PageSansBandeauState extends State<PageSansBandeau> {
  @override
  void initState() {
    super.initState();
    EtatCouchePub.ecranSensible.value = widget.nom;
  }

  @override
  void dispose() {
    if (EtatCouchePub.ecranSensible.value == widget.nom) {
      EtatCouchePub.ecranSensible.value = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.enfant;
}
