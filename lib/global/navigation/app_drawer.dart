import '../../fonctionnalites/account/screens/ecran_mon_compte.dart';
import '../../fonctionnalites/favoris/screens/ecran_favoris.dart';
import '../../fonctionnalites/partenaire/screens/ecran_espace_partenaire.dart';
import '../../fonctionnalites/publicites/screens/ecran_mes_publicites.dart';
import '../../fonctionnalites/prestations/screens/ecran_mes_demandes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config.dart';
import '../ui/mode_theme.dart';

import '../../fonctionnalites/auth/screens/auth_notifier.dart';
import '../../fonctionnalites/auth/screens/ecran_connexion.dart';
import '../../fonctionnalites/orders/screens/ecran_commandes.dart';
import '../../fonctionnalites/orders/screens/ecran_panier.dart';
import '../../fonctionnalites/orders/screens/ecran_commandes_partenaire.dart';

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
      // Pas de marge haute : le dégradé de l'en-tête passe sous la barre
      // d'état (sa hauteur est ajoutée à son padding).
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // En-tête : qui est connecté, sur un dégradé bleu de marque.
            _EnTete(
              initiale: user == null || user.nomComplet.isEmpty
                  ? '?'
                  : user.nomComplet[0].toUpperCase(),
              nom: user?.nomComplet ?? 'Invité',
              telephone: user?.telephone ?? '',
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Espace client : reserve aux utilisateurs connectes.
                  // Un visiteur ne voit que l'invitation a s'enregistrer
                  // en bas du menu.
                  if (user != null) ...[
                    ListTile(
                      leading: const Icon(Icons.favorite_outline),
                      title: const Text('Mes favoris'),
                      onTap: () => ouvrir(const EcranFavoris()),
                    ),
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
                    ),
                  ],
                  // Réservé aux partenaires : leur espace pro.
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

                  if (user != null)
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Mon compte'),
                      onTap: () => ouvrir(const EcranMonCompte()),
                    ),
                ],
              ),
            ),

            const _ChoixApparence(),
            const SizedBox(height: 8),
            const Divider(height: 1),
            // Connecte : deconnexion. Visiteur : invitation a s'enregistrer.
            if (user != null)
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
              )
            else
              ListTile(
                leading: Icon(Icons.login, color: theme.colorScheme.primary),
                title: Text(
                  'Se connecter',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EcranConnexion()),
                  );
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// En-tête du menu : avatar carré arrondi, nom et téléphone sur un dégradé
/// bleu de marque, coin inférieur droit arrondi (maquette).
class _EnTete extends StatelessWidget {
  const _EnTete({
    required this.initiale,
    required this.nom,
    required this.telephone,
  });

  final String initiale;
  final String nom;
  final String telephone;

  @override
  Widget build(BuildContext context) {
    final textes = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.paddingOf(context).top + 26,
        22,
        24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1D4FA3), Config.couleurPrimaireFoncee],
        ),
        // Coin haut droit identique à celui du Drawer.
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              initiale,
              style: textes.headlineMedium?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            nom,
            style: textes.headlineSmall?.copyWith(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          if (telephone.isNotEmpty)
            Text(
              telephone,
              style: textes.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
        ],
      ),
    );
  }
}

/// Sélecteur d'apparence : automatique (réglage du téléphone), clair, sombre.
class _ChoixApparence extends ConsumerWidget {
  const _ChoixApparence();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(modeThemeProvider);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 8),
            child: Text(
              'Apparence',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('Auto'),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Clair'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Sombre'),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (choix) =>
                  ref.read(modeThemeProvider.notifier).choisir(choix.first),
            ),
          ),
        ],
      ),
    );
  }
}
