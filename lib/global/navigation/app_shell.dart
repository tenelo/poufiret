import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_conversations.dart';

import 'destinations.dart';
import '../../fonctionnalites/catalogue/screens/ecran_categories.dart';
import '../../fonctionnalites/publicites/screens/ecran_publicites.dart';
import '../../fonctionnalites/livraison/screens/ecran_livraison.dart';
import '../../fonctionnalites/map/screens/ecran_map.dart';


/// Coquille principale : héberge les onglets et bascule entre
/// barre basse (mobile) et rail latéral (tablette / web) selon la largeur.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

static const _pages = [
    EcranCategories(),
    EcranPublicites(),
    EcranConversations(),
    EcranLivraison(),
    EcranMap(),
  ];

  static const int _indexLivraison = 3;

  void _onTap(int i) {
    // Trace la consultation du service livraison (fire-and-forget, silencieux).
    if (i == _indexLivraison && i != _index) {
      ref.read(analyticsRepositoryProvider).enregistrerVueServiceLivraison();
    }
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 600;
        final extended = constraints.maxWidth >= 1024;
        // Le bandeau publicitaire est desormais gere globalement par
        // CouchePublicites, a la racine de l'application : il reste
        // visible sur les ecrans pousses par-dessus la coquille.
        final body = IndexedStack(index: _index, children: _pages);

        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: _onTap,
                  extended: extended,
                  labelType: extended ? null : NavigationRailLabelType.all,
                  destinations: [
                    for (final d in kDestinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            height: 64,
            selectedIndex: _index,
            onDestinationSelected: _onTap,
            destinations: [
              for (final d in kDestinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
