import 'package:flutter/material.dart';

/// Rangée de pastilles indiquant la progression de saisie d'un PIN/OTP.
///
/// [total] pastilles au total, [remplis] déjà saisies. En cas d'[erreur],
/// la bordure passe au rouge. S'appuie sur le [Theme] Material courant.
class PointsPin extends StatelessWidget {
  const PointsPin({
    super.key,
    required this.remplis,
    this.total = 4,
    this.erreur = false,
  });

  final int remplis;
  final int total;
  final bool erreur;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final couleurActive = erreur ? scheme.error : scheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final rempli = i < remplis;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: rempli ? couleurActive : Colors.transparent,
            border: Border.all(color: couleurActive, width: 2),
          ),
        );
      }),
    );
  }
}
