import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_notifier.dart';

class EcranAccueil extends ConsumerWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poufiret'),
        
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).deconnexion(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user == null
              ? 'Connecté'
              : 'Bienvenue ${user.nomComplet}\nRôle : ${user.role}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
