import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/app_shell.dart';
import 'core/notifications/fcm_service.dart';
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

/// Aiguille selon l'état d'authentification.
class _Racine extends ConsumerWidget {
  const _Racine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    // Des qu'un utilisateur est connecte, on active les notifications push.
    ref.listen(authProvider, (avant, apres) {
      final user = apres.value;
      if (user != null && avant?.value == null) {
        ref.read(fcmServiceProvider).initialiser();
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