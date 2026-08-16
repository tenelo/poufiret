import 'package:flutter/material.dart';

/// Bouton social réutilisable (like ❤️ ou favori 🔖) avec état optimiste.
/// - bascule l'affichage immédiatement au tap
/// - appelle le serveur en arrière-plan
/// - revient en arrière si l'appel échoue
class BoutonSocial extends StatefulWidget {
  final bool actifInitial;
  final int totalInitial;
  final IconData iconeActive;
  final IconData iconeInactive;
  final Color couleurActive;
  final bool afficherTotal;

  /// Action serveur : reçoit rien, renvoie le résultat (actif + total réels).
  final Future<({bool actif, int total})> Function() onToggle;

  const BoutonSocial({
    super.key,
    required this.actifInitial,
    required this.totalInitial,
    required this.iconeActive,
    required this.iconeInactive,
    required this.couleurActive,
    required this.onToggle,
    this.afficherTotal = true,
  });

  @override
  State<BoutonSocial> createState() => _BoutonSocialState();
}

class _BoutonSocialState extends State<BoutonSocial> {
  late bool _actif;
  late int _total;
  bool _enCours = false;

  @override
  void initState() {
    super.initState();
    _actif = widget.actifInitial;
    _total = widget.totalInitial;
  }

  Future<void> _tap() async {
    if (_enCours) return;

    // État optimiste : on bascule tout de suite.
    final ancienActif = _actif;
    final ancienTotal = _total;
    setState(() {
      _actif = !_actif;
      _total += _actif ? 1 : -1;
      _enCours = true;
    });

    try {
      final res = await widget.onToggle();
      // On aligne sur la vérité du serveur (au cas où).
      setState(() {
        _actif = res.actif;
        _total = res.total;
        _enCours = false;
      });
    } catch (_) {
      // Échec : on annule la bascule optimiste.
      setState(() {
        _actif = ancienActif;
        _total = ancienTotal;
        _enCours = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Action impossible. Réessaie.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final couleur = _actif
        ? widget.couleurActive
        : Theme.of(context).colorScheme.outline;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: _tap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _actif ? widget.iconeActive : widget.iconeInactive,
              color: couleur,
              size: 22,
            ),
            if (widget.afficherTotal) ...[
              const SizedBox(width: 4),
              Text('$_total', style: TextStyle(color: couleur)),
            ],
          ],
        ),
      ),
    );
  }
}
