import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';
import 'package:poufiret/features/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/features/auth/widgets/points_pin.dart';

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

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
      _snack('Le nouveau code ne correspond pas. Recommencez.');
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
    _snack('Code PIN mis a jour.');
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

    return PopScope(
      canPop: !widget.bloquant,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Changer le code PIN'),
          automaticallyImplyLeading: !widget.bloquant,
        ),
        body: SafeArea(
          child: ConteneurAdaptatif(
            child: _buildEtape(),
          ),
        ),
      ),
    );
  }

  Widget _buildEtape() {
    final (titre, sousTitre, courant) = switch (_etape) {
      _Etape.ancien => (
          'Code PIN actuel',
          widget.bloquant
              ? 'Entrez le code fourni par l\'administrateur'
              : 'Entrez votre code PIN actuel',
          _ancien,
        ),
      _Etape.nouveau => (
          'Nouveau code PIN',
          'Choisissez un nouveau code à 4 chiffres',
          _nouveau,
        ),
      _Etape.confirmer => (
          'Confirmez le code',
          'Saisissez à nouveau votre nouveau code',
          _confirmation,
        ),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.bloquant && _etape == _Etape.ancien) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pour votre sécurité, vous devez définir votre propre '
                    'code PIN avant de continuer.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        Icon(Icons.lock_outline,
            size: 56, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text(titre, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(sousTitre,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 32),
        PointsPin(remplis: courant.length, erreur: _erreur),
        if (_messageErr != null) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _messageErr!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
        if (_enCours)
          const CircularProgressIndicator()
        else
          ClavierNumerique(onChiffre: _onChiffre, onSupprimer: _onSupprimer),
      ],
    );
  }
}
