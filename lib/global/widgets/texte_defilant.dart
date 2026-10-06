import 'dart:async';

import 'package:flutter/material.dart';

/// Texte sur une ligne qui défile horizontalement quand il ne tient pas dans
/// la largeur disponible : il glisse jusqu'à sa fin, marque une pause, puis
/// reprend au début. S'il tient en entier, il reste fixe.
///
/// Si l'utilisateur a désactivé les animations du système, le texte est
/// simplement tronqué par « … ».
class TexteDefilant extends StatefulWidget {
  const TexteDefilant(
    this.texte, {
    super.key,
    this.style,
    this.vitesse = 35,
    this.pause = const Duration(milliseconds: 1500),
  });

  final String texte;
  final TextStyle? style;

  /// Vitesse de défilement, en pixels logiques par seconde.
  final double vitesse;

  /// Arrêt au début et à la fin du texte.
  final Duration pause;

  @override
  State<TexteDefilant> createState() => _TexteDefilantState();
}

class _TexteDefilantState extends State<TexteDefilant> {
  final _defilement = ScrollController();
  Timer? _minuteur;

  /// Largeur pour laquelle le cycle en cours a été lancé.
  double? _largeur;

  @override
  void didUpdateWidget(TexteDefilant ancien) {
    super.didUpdateWidget(ancien);
    if (ancien.texte != widget.texte) _largeur = null; // nouveau cycle
  }

  @override
  void dispose() {
    _minuteur?.cancel();
    _defilement.dispose();
    super.dispose();
  }

  /// (Re)lance le cycle une fois le texte mesuré.
  void _lancer(double largeur) {
    if (_largeur == largeur) return;
    _largeur = largeur;
    _minuteur?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_defilement.hasClients) return;
      _defilement.jumpTo(0);
      _attendrePuis(_avancer);
    });
  }

  void _attendrePuis(VoidCallback suite) {
    _minuteur?.cancel();
    _minuteur = Timer(widget.pause, () {
      if (mounted && _defilement.hasClients) suite();
    });
  }

  Future<void> _avancer() async {
    final fin = _defilement.position.maxScrollExtent;
    if (fin <= 0) return; // le texte tient en entier : il reste fixe
    await _defilement.animateTo(
      fin,
      duration: Duration(milliseconds: (fin / widget.vitesse * 1000).round()),
      curve: Curves.linear,
    );
    if (!mounted) return;
    _attendrePuis(() {
      _defilement.jumpTo(0);
      _attendrePuis(_avancer);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _minuteur?.cancel();
      _largeur = null;
      return Text(
        widget.texte,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: widget.style,
      );
    }
    return LayoutBuilder(
      builder: (context, contraintes) {
        _lancer(contraintes.maxWidth);
        // Décoratif : les touchers vont à ce qui se trouve dessous.
        return IgnorePointer(
          child: SingleChildScrollView(
            controller: _defilement,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Text(
              widget.texte,
              maxLines: 1,
              softWrap: false,
              style: widget.style,
            ),
          ),
        );
      },
    );
  }
}
