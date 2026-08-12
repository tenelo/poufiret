import 'package:flutter/material.dart';

/// Onglet Map — localisation des services (à venir).
class EcranMap extends StatelessWidget {
  const EcranMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Localisation des Services')),
      body: const Center(child: Text('Carte des services — à venir')),
    );
  }
}
