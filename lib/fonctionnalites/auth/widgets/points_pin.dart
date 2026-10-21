import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Rangée de pastilles indiquant la progression de saisie d'un PIN/OTP.
///
/// [total] pastilles au total, [remplis] déjà saisies : une pastille
/// remplie grossit puis se pose. En cas d'[erreur], la rangée passe au rouge
/// et tremble. S'appuie sur le [Theme] Material courant.
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
    // Six pastilles (code SMS) un peu plus serrées que quatre (PIN).
    final ecart = total > 4 ? 7.0 : 11.0;

    return Tremblement(
      actif: erreur,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (i) {
          final rempli = i < remplis;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: ecart),
            child: AnimatedScale(
              scale: rempli ? 1.15 : 1,
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOutBack,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rempli
                      ? couleurActive
                      : couleurActive.withValues(alpha: 0.10),
                  border: Border.all(
                    color: rempli
                        ? couleurActive
                        : couleurActive.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Fait trembler [child] (oscillation amortie) quand [actif] passe à vrai :
/// signal d'un code refusé.
class Tremblement extends StatefulWidget {
  const Tremblement({super.key, required this.actif, required this.child});

  final bool actif;
  final Widget child;

  @override
  State<Tremblement> createState() => _TremblementState();
}

class _TremblementState extends State<Tremblement>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  @override
  void didUpdateWidget(Tremblement ancien) {
    super.didUpdateWidget(ancien);
    if (widget.actif && !ancien.actif) _animation.forward(from: 0);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, enfant) {
        final t = _animation.value;
        // Trois allers-retours, de plus en plus faibles.
        final dx = math.sin(t * math.pi * 6) * 10 * (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: enfant);
      },
      child: widget.child,
    );
  }
}
