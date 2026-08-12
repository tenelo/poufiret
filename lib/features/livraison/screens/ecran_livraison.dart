import 'package:flutter/material.dart';

/// Onglet Livraison — module à venir.
class EcranLivraison extends StatelessWidget {
  const EcranLivraison({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livraison')),
      body: const Center(child: Text('Module Livraison — à venir')),
    );
  }
}
