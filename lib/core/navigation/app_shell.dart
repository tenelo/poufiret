import 'package:flutter/material.dart';
import 'package:poufiret/features/chat/screens/ecran_conversations.dart';

import 'destinations.dart';
import 'placeholder_screens.dart';
import '../../features/catalogue/screens/ecran_categories.dart';
import '../../features/favoris/screens/ecran_favoris.dart';
import '../../features/publicites/screens/ecran_publicites.dart';


/// Coquille principale : héberge les onglets et bascule entre
/// barre basse (mobile) et rail latéral (tablette / web) selon la largeur.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

static const _pages = [
    EcranCategories(),
    EcranPublicites(),
    EcranFavoris(),
    EcranConversations(),
    AccountScreen(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 600;
        final extended = constraints.maxWidth >= 1024;
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
