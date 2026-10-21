import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/cadre_auth.dart';
import 'package:poufiret/global/ui/notificateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/points_pin.dart';

enum _Etape { ancien, nouveau, confirmer }

/// Écran de changement de PIN.
///
/// [bloquant] : vrai quand il est imposé (compte créé par admin,
/// pin_par_defaut=true). Dans ce cas l'utilisateur ne peut pas quitter
/// sans avoir changé son PIN (pas de retour, pas de pop système).
class EcranChangerPin extends ConsumerStatefulWidget {
  const EcranChangerPin({super.key, this.bloquant = false});

  final bool bloquant;

  @override
  ConsumerState<EcranChangerPin> createState() => _EcranChangerPinState();
}

class _EcranChangerPinState extends ConsumerState<EcranChangerPin> {
  _Etape _etape = _Etape.ancien;
  String _ancien = '';
  String _nouveau = '';
  String _confirmation = '';
  bool _erreur = false;
  bool _enCours = false;
  String? _messageErr;

  String _messageErreur(Object? e) {
    // L'intercepteur Dio rejette une DioException qui enveloppe l'ApiException.
    if (e is DioException && e.error is ApiException) {
      return (e.error as ApiException).messageLisible;
    }
    if (e is ApiException) return e.messageLisible;
    return 'Une erreur est survenue.';
  }

  void _onChiffre(String c) {
    switch (_etape) {
      case _Etape.ancien:
        if (_ancien.length >= 4) return;
        setState(() {
          _erreur = false;
          _messageErr = null;
          _ancien += c;
        });
        if (_ancien.length == 4) setState(() => _etape = _Etape.nouveau);
      case _Etape.nouveau:
        if (_nouveau.length >= 4) return;
        setState(() {
          _erreur = false;
          _messageErr = null;
          _nouveau += c;
        });
        if (_nouveau.length == 4) setState(() => _etape = _Etape.confirmer);
      case _Etape.confirmer:
        if (_confirmation.length >= 4) return;
        setState(() {
          _erreur = false;
          _messageErr = null;
          _confirmation += c;
        });
        if (_confirmation.length == 4) _valider();
    }
  }

  void _onSupprimer() {
    setState(() {
      _erreur = false;
      switch (_etape) {
        case _Etape.ancien:
          if (_ancien.isNotEmpty) {
            _ancien = _ancien.substring(0, _ancien.length - 1);
          }
        case _Etape.nouveau:
          if (_nouveau.isEmpty) {
            _etape = _Etape.ancien;
          } else {
            _nouveau = _nouveau.substring(0, _nouveau.length - 1);
          }
        case _Etape.confirmer:
          if (_confirmation.isEmpty) {
            _etape = _Etape.nouveau;
            _nouveau = '';
          } else {
            _confirmation =
                _confirmation.substring(0, _confirmation.length - 1);
          }
      }
    });
  }

  Future<void> _valider() async {
    if (_nouveau != _confirmation) {
      setState(() {
        _erreur = true;
        _nouveau = '';
        _confirmation = '';
        _etape = _Etape.nouveau;
      });
      Notificateur.erreur(context, 'Le nouveau code ne correspond pas. Recommencez.');
      return;
    }
    setState(() {
      _enCours = true;
      _messageErr = null;
    });
    await ref.read(authProvider.notifier).changerPin(
          ancienPin: _ancien,
          nouveauPin: _nouveau,
        );
    if (!mounted) return;

    final etat = ref.read(authProvider);
    if (etat.hasError) {
      // Echec (PIN refuse, etc.) : on affiche le message et on reste
      // a l'etape 'nouveau' pour ressaisir.
      _reinitialiser(message: _messageErreur(etat.error));
      return;
    }
    // Succes : le profil a pin_par_defaut=false. On sort de l'ecran.
    setState(() => _enCours = false);
    Notificateur.succes(context, 'Code PIN mis a jour.');
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _reinitialiser({String? message}) {
    setState(() {
      _nouveau = '';
      _confirmation = '';
      _etape = _Etape.nouveau;
      _erreur = true;
      _enCours = false;
      _messageErr = message;
    });
  }

  @override
  Widget build(BuildContext context) {

    final (titre, sousTitre, numero) = switch (_etape) {
      _Etape.ancien => (
        'Code PIN actuel',
        widget.bloquant
            ? 'Entrez le code fourni par l\'administrateur.'
            : 'Entrez votre code PIN actuel.',
        1,
      ),
      _Etape.nouveau => (
        'Nouveau code PIN',
        'Choisissez un nouveau code à 4 chiffres.',
        2,
      ),
      _Etape.confirmer => (
        'Confirmez le code',
        'Saisissez à nouveau votre nouveau code.',
        3,
      ),
    };

    return PopScope(
      canPop: !widget.bloquant,
      child: CadreAuth(
        titre: titre,
        sousTitre: sousTitre,
        etape: (numero: numero, total: 3),
        // Changement imposé : on ne peut pas quitter l'écran.
        onRetour:
            widget.bloquant || _enCours || !Navigator.of(context).canPop()
            ? null
            : () => Navigator.of(context).pop(),
        child: TransitionEtapes(etape: _etape, child: _buildEtape()),
      ),
    );
  }

  Widget _buildEtape() {
    final theme = Theme.of(context);
    final courant = switch (_etape) {
      _Etape.ancien => _ancien,
      _Etape.nouveau => _nouveau,
      _Etape.confirmer => _confirmation,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.bloquant && _etape == _Etape.ancien) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pour votre sécurité, vous devez définir votre propre '
                    'code PIN avant de continuer.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ] else
          const SizedBox(height: 8),
        PointsPin(remplis: courant.length, erreur: _erreur),
        if (_messageErr != null) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _messageErr!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        const SizedBox(height: 28),
        if (_enCours)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          )
        else
          ClavierNumerique(onChiffre: _onChiffre, onSupprimer: _onSupprimer),
      ],
    );
  }
}
