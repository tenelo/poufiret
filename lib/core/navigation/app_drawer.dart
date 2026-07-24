import '../../features/account/screens/ecran_mon_compte.dart';
import '../../features/partenaire/screens/ecran_espace_partenaire.dart';
import '../../features/publicites/screens/ecran_mes_publicites.dart';
import '../../features/prestations/screens/ecran_mes_demandes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/screens/auth_notifier.dart';
import '../../features/orders/screens/ecran_commandes.dart';
import '../../features/orders/screens/ecran_panier.dart';
import '../../features/orders/screens/ecran_commandes_partenaire.dart';

/// Menu latéral partagé par les écrans principaux.
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final theme = Theme.of(context);

    void ouvrir(Widget ecran) {
      Navigator.of(context).pop(); // ferme le drawer
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ecran));
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // En-tête : qui est connecté.
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimary,
                child: Text(
                  user == null || user.nomComplet.isEmpty
                      ? '?'
                      : user.nomComplet[0].toUpperCase(),
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
              accountName: Text(user?.nomComplet ?? 'Invité'),
              accountEmail: Text(user?.telephone ?? ''),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: const Text('Mes commandes'),
                    onTap: () => ouvrir(const EcranCommandes()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart_outlined),
                    title: const Text('Mon panier'),
                    onTap: () => ouvrir(const EcranPanier()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.handyman_outlined),
                    title: const Text('Mes demandes d\'intervention'),
                    onTap: () => ouvrir(const EcranMesDemandes()),
                  ), // Réservé aux partenaires : leur espace pro.
                  if (user?.estPartenaire ?? false) ...[
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.storefront_outlined),
                      title: const Text('Commandes reçues'),
                      subtitle: const Text('Espace partenaire'),
                      onTap: () => ouvrir(const EcranCommandesPartenaire()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.build_outlined),
                      title: const Text('Demandes reçues (interventions)'),
                      subtitle: const Text('Espace partenaire'),
                      onTap: () => ouvrir(const EcranDemandesRecues()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.dashboard_outlined),
                      title: const Text('Mon espace partenaire'),
                      subtitle: const Text('Articles et statistiques'),
                      onTap: () => ouvrir(const EcranEspacePartenaire()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.campaign_outlined),
                      title: const Text('Mes publicités'),
                      subtitle: const Text('Campagnes et résultats'),
                      onTap: () => ouvrir(const EcranMesPublicites()),
                    ),
                    const Divider(),
                  ],

                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Mon compte'),
                    onTap: () => ouvrir(const EcranMonCompte()),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),
            ListTile(
              leading: Icon(Icons.logout, color: theme.colorScheme.error),
              title: Text(
                'Déconnexion',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await ref.read(authProvider.notifier).deconnexion();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
