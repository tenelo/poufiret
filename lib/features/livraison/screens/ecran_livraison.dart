import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../../map/data/service_position.dart';
import '../data/livraison_providers.dart';
import 'ecran_colis_recus.dart';
import 'ecran_commande.dart';
import 'ecran_historique.dart';
import 'ecran_suivi.dart';

/// Onglet Livraison — hub TeneLivr.
///
/// Garde localisation : l'onglet exige que le service GPS de l'appareil soit
/// activé (pour tout le monde, visiteur inclus). Independant du mur
/// d'inscription (activer le GPS ne demande pas de compte).
///
/// Le visiteur voit le hub (option B) ; le tap sur « Demander une livraison »
/// declenche l'invite d'inscription. Le connecte accede au formulaire et voit
/// ses courses en cours.
class EcranLivraison extends ConsumerWidget {
  const EcranLivraison({super.key});

  static const _statutsActifs = {
    'demandee', 'assignee', 'acceptee', 'vers_a', 'colis_pris', 'vers_b',
  };

  static const _libellesStatut = {
    'demandee': 'En recherche de livreur',
    'assignee': 'Livreur assigné',
    'acceptee': 'Acceptée',
    'vers_a': 'En route vers le retrait',
    'colis_pris': 'Colis récupéré',
    'vers_b': 'En route vers la livraison',
  };

  Future<void> _ouvrirCommande(BuildContext context, WidgetRef ref) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EcranCommande()),
    );
    ref.invalidate(mesCoursesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connecte = ref.watch(authProvider).whenOrNull(data: (u) => u) != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Livraison')),
      body: _GardeLocalisation(
        child: LayoutBuilder(
          builder: (context, _) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Faites livrer, simplement',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          const Text(
                            'Un point de retrait, un point de livraison. '
                            'On assigne le livreur le plus proche.',
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () => murInscription(
                              context,
                              ref,
                              () => _ouvrirCommande(context, ref),
                            ),
                            icon: const Icon(Icons.two_wheeler),
                            label: const Text('Demander une livraison'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (connecte) ...[
                    Row(
                      children: [
                        Text('Mes courses en cours',
                            style: Theme.of(context).textTheme.titleMedium),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const EcranHistorique(),
                          ),
                        ),
                          icon: const Icon(Icons.history, size: 18),
                          label: const Text('Historique'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _CoursesEnCours(
                        statutsActifs: _statutsActifs,
                        libelles: _libellesStatut),
                    const SizedBox(height: 24),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2),
                        title: const Text('Colis qui m\'arrivent'),
                        subtitle: const Text(
                            'Déposez votre position, suivez vos réceptions.'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const EcranColisRecus(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Garde localisation : bloque le contenu tant que le service GPS de
/// l'appareil n'est pas activé. Re-teste automatiquement au retour dans l'app.
class _GardeLocalisation extends StatefulWidget {
  const _GardeLocalisation({required this.child});
  final Widget child;

  @override
  State<_GardeLocalisation> createState() => _GardeLocalisationState();
}

class _GardeLocalisationState extends State<_GardeLocalisation>
    with WidgetsBindingObserver {
  final _service = ServicePosition();
  bool? _actif; // null = verification en cours
  bool _check = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _verifier();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Au retour des reglages, on re-teste automatiquement.
    if (state == AppLifecycleState.resumed && _actif != true) {
      _verifier();
    }
  }

  Future<void> _verifier() async {
    if (_check) return;
    _check = true;
    final actif = await _service.serviceActive();
    if (!mounted) return;
    setState(() {
      _actif = actif;
      _check = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_actif == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_actif == true) return widget.child;

    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off,
                  size: 56, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text('Activez la localisation',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text(
                'La localisation de votre appareil est nécessaire pour '
                'utiliser la livraison. Activez-la pour continuer.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => _service.ouvrirParametresLocalisation(),
                icon: const Icon(Icons.my_location),
                label: const Text('Activer'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _verifier,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoursesEnCours extends ConsumerWidget {
  const _CoursesEnCours({required this.statutsActifs, required this.libelles});

  final Set<String> statutsActifs;
  final Map<String, String> libelles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesCoursesProvider());

    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            const Expanded(child: Text('Courses indisponibles.')),
            TextButton(
              onPressed: () => ref.invalidate(mesCoursesProvider),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
      data: (courses) {
        final actives =
            courses.where((c) => statutsActifs.contains(c.statut)).toList();
        if (actives.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Aucune course en cours.'),
          );
        }
        return Column(
          children: [
            for (final c in actives)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.two_wheeler),
                  title: Text(c.numero),
                  subtitle: Text(
                      '${libelles[c.statut] ?? c.statut} • ${c.pointB.quartier}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          EcranSuivi(courseId: c.id, courseInitiale: c),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
