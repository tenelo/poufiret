import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/points_pin.dart';

enum _Etape { telephone, otp, nouveauPin, confirmerPin }

class EcranPinOublie extends ConsumerStatefulWidget {
  const EcranPinOublie({super.key});

  @override
  ConsumerState<EcranPinOublie> createState() => _EcranPinOublieState();
}

class _EcranPinOublieState extends ConsumerState<EcranPinOublie> {
  final _telephone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _Etape _etape = _Etape.telephone;
  String _otp = '';
  String _nouveauPin = '';
  String _confirmation = '';
  bool _erreur = false;
  bool _enCours = false;

  static const _but = 'reinit_pin';

  @override
  void dispose() {
    _telephone.dispose();
    super.dispose();
  }

  String get _telephoneComplet => '+225${_telephone.text.trim()}';

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String _messageErreur(Object? e) =>
      e is ApiException ? e.messageLisible : 'Une erreur est survenue.';

  // ── Étape 1 : demander l'OTP ────────────────────────────────────────────
  Future<void> _demanderOtp() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _enCours = true);
    try {
      await ref.read(authProvider.notifier).demanderOtp(
            telephone: _telephoneComplet,
            but: _but,
          );
      if (!mounted) return;
      setState(() {
        _etape = _Etape.otp;
        _otp = '';
        _erreur = false;
      });
    } catch (e) {
      _snack(_messageErreur(e));
    } finally {
      if (mounted) setState(() => _enCours = false);
    }
  }

  // ── Étape 2 : vérifier l'OTP ────────────────────────────────────────────
  void _onOtp(String c) {
    if (_otp.length >= 4) return;
    setState(() {
      _erreur = false;
      _otp += c;
    });
    if (_otp.length == 4) _verifierOtp();
  }

  Future<void> _verifierOtp() async {
    setState(() => _enCours = true);
    try {
      await ref.read(authProvider.notifier).verifierOtp(
            telephone: _telephoneComplet,
            code: _otp,
            but: _but,
          );
      if (!mounted) return;
      setState(() {
        _etape = _Etape.nouveauPin;
        _erreur = false;
      });
    } catch (e) {
      setState(() {
        _erreur = true;
        _otp = '';
      });
      _snack(_messageErreur(e));
    } finally {
      if (mounted) setState(() => _enCours = false);
    }
  }

  // ── Étapes 3 & 4 : nouveau PIN + confirmation ───────────────────────────
  void _onPin(String c) {
    if (_etape == _Etape.nouveauPin) {
      if (_nouveauPin.length >= 4) return;
      setState(() {
        _erreur = false;
        _nouveauPin += c;
      });
      if (_nouveauPin.length == 4) {
        setState(() => _etape = _Etape.confirmerPin);
      }
    } else {
      if (_confirmation.length >= 4) return;
      setState(() {
        _erreur = false;
        _confirmation += c;
      });
      if (_confirmation.length == 4) _confirmer();
    }
  }

  void _onSupprimerPin() {
    setState(() {
      _erreur = false;
      if (_etape == _Etape.confirmerPin) {
        if (_confirmation.isEmpty) {
          _etape = _Etape.nouveauPin;
          _nouveauPin = '';
        } else {
          _confirmation =
              _confirmation.substring(0, _confirmation.length - 1);
        }
      } else if (_nouveauPin.isNotEmpty) {
        _nouveauPin = _nouveauPin.substring(0, _nouveauPin.length - 1);
      }
    });
  }

  Future<void> _confirmer() async {
    if (_nouveauPin != _confirmation) {
      setState(() {
        _erreur = true;
        _nouveauPin = '';
        _confirmation = '';
        _etape = _Etape.nouveauPin;
      });
      _snack('Le code PIN ne correspond pas. Recommencez.');
      return;
    }
    setState(() => _enCours = true);
    // definirPin(reinit_pin) reconnecte directement (tokens renvoyés).
    await ref.read(authProvider.notifier).definirPin(
          telephone: _telephoneComplet,
          password: _nouveauPin,
          but: _but,
        );
  }

  @override
  Widget build(BuildContext context) {
    // Réagit au succès/échec de definirPin (dernière étape).
    ref.listen(authProvider, (avant, next) {
      final connecte = next.value != null && avant?.value == null;
      if (connecte) {
        // On dépile jusqu'à la racine : l'utilisateur est connecté.
        Navigator.of(context).popUntil((r) => r.isFirst);
        return;
      }
      if (next.hasError && !next.isLoading && _etape == _Etape.confirmerPin) {
        setState(() {
          _enCours = false;
          _erreur = true;
          _nouveauPin = '';
          _confirmation = '';
          _etape = _Etape.nouveauPin;
        });
        _snack(_messageErreur(next.error));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Code PIN oublié')),
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: switch (_etape) {
            _Etape.telephone => _buildTelephone(),
            _Etape.otp => _buildOtp(),
            _Etape.nouveauPin ||
            _Etape.confirmerPin => _buildNouveauPin(),
          },
        ),
      ),
    );
  }

  Widget _buildTelephone() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.lock_reset,
              size: 56, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          Text('Réinitialiser votre PIN',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Entrez votre numéro pour recevoir un code SMS',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          TextFormField(
            controller: _telephone,
            keyboardType: TextInputType.number,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Téléphone',
              prefixText: '+225 ',
              counterText: '',
              border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().length != 10)
                ? 'Entre tes 10 chiffres'
                : null,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _enCours ? null : _demanderOtp,
            child: _enCours
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Recevoir le code'),
          ),
        ],
      ),
    );
  }

  Widget _buildOtp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.sms_outlined,
            size: 56, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text('Code de vérification',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Code envoyé au $_telephoneComplet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: 32),
        PointsPin(remplis: _otp.length, erreur: _erreur),
        const SizedBox(height: 32),
        if (_enCours)
          const CircularProgressIndicator()
        else
          ClavierNumerique(onChiffre: _onOtp, onSupprimer: () {
            if (_otp.isNotEmpty) {
              setState(() => _otp = _otp.substring(0, _otp.length - 1));
            }
          }),
      ],
    );
  }

  Widget _buildNouveauPin() {
    final enConfirmation = _etape == _Etape.confirmerPin;
    final courant = enConfirmation ? _confirmation : _nouveauPin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock_outline,
            size: 56, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text(
          enConfirmation ? 'Confirmez votre PIN' : 'Nouveau code PIN',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          enConfirmation
              ? 'Saisissez à nouveau votre code'
              : 'Choisissez un code à 4 chiffres',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        PointsPin(remplis: courant.length, erreur: _erreur),
        const SizedBox(height: 32),
        if (_enCours)
          const CircularProgressIndicator()
        else
          ClavierNumerique(onChiffre: _onPin, onSupprimer: _onSupprimerPin),
      ],
    );
  }
}
