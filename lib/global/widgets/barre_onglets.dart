import 'package:flutter/material.dart';

/// Barre d'onglets horizontale défilante. L'onglet actif est en couleur
/// d'accent avec un court trait dessous ; les autres sont en gris. Quand la
/// sélection change (glissement de page, défilement suivi), l'onglet actif
/// est ramené dans la zone visible.
class BarreOnglets extends StatefulWidget {
  const BarreOnglets({
    super.key,
    required this.libelles,
    required this.selectionIndex,
    required this.onChoisir,
  });

  final List<String> libelles;
  final int selectionIndex;
  final ValueChanged<int> onChoisir;

  @override
  State<BarreOnglets> createState() => _BarreOngletsState();
}

class _BarreOngletsState extends State<BarreOnglets> {
  final _cles = <int, GlobalKey>{};

  GlobalKey _cle(int i) => _cles.putIfAbsent(i, GlobalKey.new);

  @override
  void didUpdateWidget(BarreOnglets ancien) {
    super.didUpdateWidget(ancien);
    if (ancien.selectionIndex != widget.selectionIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _cle(widget.selectionIndex).currentContext;
        final objet = ctx?.findRenderObject();
        if (ctx == null || objet == null) return;
        // Seule la barre défile : Scrollable.ensureVisible ferait aussi
        // défiler la page qui la contient.
        Scrollable.of(ctx).position.ensureVisible(
          objet,
          alignment: 0.5,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (var i = 0; i < widget.libelles.length; i++)
            _Onglet(
              key: _cle(i),
              libelle: widget.libelles[i],
              actif: widget.selectionIndex == i,
              onTap: () => widget.onChoisir(i),
            ),
        ],
      ),
    );
  }
}

class _Onglet extends StatelessWidget {
  const _Onglet({
    super.key,
    required this.libelle,
    required this.actif,
    required this.onTap,
  });

  final String libelle;
  final bool actif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur = actif
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              libelle,
              style: theme.textTheme.titleSmall?.copyWith(
                color: couleur,
                fontWeight: actif ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: 28,
              decoration: BoxDecoration(
                color: actif ? theme.colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
