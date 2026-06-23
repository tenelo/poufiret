import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/screens/auth_notifier.dart';
import 'features/auth/screens/ecran_connexion.dart';
import 'features/auth/screens/ecran_accueil.dart';

void main() {
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

    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const EcranConnexion(),
      data: (user) =>
          user == null ? const EcranConnexion() : const EcranAccueil(),
    );
  }
}
