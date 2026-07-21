import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/app_shell.dart';
import 'core/notifications/fcm_service.dart';
import 'features/analytics/data/analytics_providers.dart';
import 'features/auth/screens/auth_notifier.dart';
import 'features/auth/screens/ecran_connexion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
  runApp(const ProviderScope(child: PoufiretApp()));
}

class PoufiretApp extends StatelessWidget {
  const PoufiretApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poufiret',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const _Racine(),
    );
  }
}

/// Aiguille selon l'etat d'authentification et pilote le suivi de session.
class _Racine extends ConsumerStatefulWidget {
  const _Racine();

  @override
  ConsumerState<_Racine> createState() => _RacineState();
}

class _RacineState extends ConsumerState<_Racine> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Le heartbeat ne tourne que quand l'app est reellement au premier plan :
  /// une session mise en pause s'arrete au dernier ping recu par le serveur.
  @override
  void didChangeAppLifecycleState(AppLifecycleState etat) {
    final connecte = ref.read(authProvider).value != null;
    if (!connecte) return;
    final session = ref.read(sessionAnalyticsProvider.notifier);
    switch (etat) {
      case AppLifecycleState.resumed:
        session.reprendre();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        session.arreter();
      case AppLifecycleState.inactive:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen(authProvider, (avant, apres) {
      final user = apres.value;
      final etaitConnecte = avant?.value != null;
      if (user != null && !etaitConnecte) {
        // Connexion : notifications push + ouverture de la session analytics.
        ref.read(fcmServiceProvider).initialiser();
        ref.read(sessionAnalyticsProvider.notifier).demarrer();
      } else if (user == null && etaitConnecte) {
        ref.read(sessionAnalyticsProvider.notifier).arreter();
      }
    });

    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => const EcranConnexion(),
      data: (user) => user == null ? const EcranConnexion() : const AppShell(),
    );
  }
}
