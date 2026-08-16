import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Borne la largeur du contenu et le centre sur grand écran.
/// Sur téléphone : prend toute la largeur (moins le padding).
/// Sur tablette : reste lisible, centré, au lieu de s'étirer.
class ConteneurAdaptatif extends StatelessWidget {
  final Widget child;
  final double largeurMax;
  final EdgeInsetsGeometry padding;
  final bool defilable;

  const ConteneurAdaptatif({
    super.key,
    required this.child,
    this.largeurMax = Breakpoints.largeurContenu,
    this.padding = const EdgeInsets.all(24),
    this.defilable = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget contenu = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: largeurMax),
      child: Padding(padding: padding, child: child),
    );

    contenu = Center(child: contenu);

    // Defilable : évite le débordement quand le clavier monte.
    if (defilable) {
      contenu = SingleChildScrollView(child: contenu);
    }

    return contenu;
  }
}
