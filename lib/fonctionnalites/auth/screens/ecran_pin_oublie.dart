import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/cadre_auth.dart';
import 'package:poufiret/global/ui/notificateur.dart';
import 'package:poufiret/fonctionnalites/auth/donnees/service_auth_firebase.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/points_pin.dart';

enum _Etape { telephone, otp, nouveauPin, confirmerPin }

/// Longueur d'un code SMS Firebase (standard, distincte du PIN a 4 chiffres).
const _longueurCodeSms = 6;

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

  // Firebase Phone Auth : une instance par tentative de vérification, et
  // l'idToken obtenu une fois le numéro prouvé, consommé à l'étape finale.
  // Créé au premier envoi de SMS (pas à l'ouverture de l'écran).
  late final _serviceFirebase = ServiceAuthFirebase();
  String? _idToken;

  @override
  void dispose() {
    _telephone.dispose();
    super.dispose();
  }

  String get _telephoneComplet => '+225${_telephone.text.trim()}';

  String _messageErreur(Object? e) =>
      e is ApiException ? e.messageLisible : 'Une erreur est survenue.';

  // ── Étape 1 : envoyer le code SMS (Firebase) ────────────────────────────
  Future<void> _demanderOtp() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _enCours = true);
    await _serviceFirebase.demanderCode(
      telephone: _telephoneComplet,
      onCodeEnvoye: () {
        if (!mounted) return;
        setState(() {
          _enCours = false;
          _etape = _Etape.otp;
          _otp = '';
          _erreur = false;
        });
      },
      onVerifieAuto: (idToken) {
        // Vérification automatique (auto-retrieval Android) : le numéro est
        // déjà prouvé, on saute directement à la saisie du nouveau PIN.
        if (!mounted) return;
        setState(() {
          _enCours = false;
          _idToken = idToken;
          _etape = _Etape.nouveauPin;
          _erreur = false;
        });
      },
      onErreur: (message) {
        if (!mounted) return;
        setState(() => _enCours = false);
        Notificateur.erreur(context, message);
      },
    );
  }

  Future<void> _renvoyerCode() async {
    if (_enCours) return;
    setState(() => _enCours = true);
    await _serviceFirebase.demanderCode(
      telephone: _telephoneComplet,
      renvoi: true,
      onCodeEnvoye: () {
        if (!mounted) return;
        setState(() {
          _enCours = false;
          _otp = '';
          _erreur = false;
        });
        Notificateur.succes(context, 'Un nouveau code a été envoyé.');
      },
      onVerifieAuto: (idToken) {
        if (!mounted) return;
        setState(() {
          _enCours = false;
          _idToken = idToken;
          _etape = _Etape.nouveauPin;
          _erreur = false;
        });
      },
      onErreur: (message) {
        if (!mounted) return;
        setState(() => _enCours = false);
        Notificateur.erreur(context, message);
      },
    );
  }

  // ── Étape 2 : code SMS (Firebase) ────────────────────────────────────────
  void _onOtp(String c) {
    if (_otp.length >= _longueurCodeSms) return;
    setState(() {
      _erreur = false;
      _otp += c;
    });
    if (_otp.length == _longueurCodeSms) _verifierOtp();
  }

  Future<void> _verifierOtp() async {
    setState(() => _enCours = true);
    try {
      final idToken = await _serviceFirebase.confirmerCode(_otp);
      if (!mounted) return;
      setState(() {
        _idToken = idToken;
        _etape = _Etape.nouveauPin;
        _erreur = false;
      });
    } on ServiceAuthFirebaseException catch (e) {
      setState(() {
        _erreur = true;
        _otp = '';
      });
      if (mounted) Notificateur.erreur(context, e.message);
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
      Notificateur.erreur(context, 'Le code PIN ne correspond pas. Recommencez.');
      return;
    }
    final idToken = _idToken;
    if (idToken == null) {
      // Ne devrait pas arriver (numéro pas encore prouvé), garde-fou.
      Notificateur.erreur(context, 'Vérification du numéro expirée. Recommencez.');
      setState(() {
        _etape = _Etape.telephone;
        _nouveauPin = '';
        _confirmation = '';
      });
      return;
    }
    setState(() => _enCours = true);
    // reinitPinFirebase(...) reconnecte directement (tokens renvoyés).
    await ref.read(authProvider.notifier).reinitPinFirebase(
          idToken: idToken,
          password: _nouveauPin,
        );
  }

  @override
  Widget build(BuildContext context) {
    // Réagit au succès/échec de reinitPinFirebase (dernière étape).
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
        Notificateur.erreur(context, _messageErreur(next.error));
      }
    });

    final (titre, sousTitre) = switch (_etape) {
      _Etape.telephone => (
        'Code PIN oublié',
        'Entrez votre numéro pour recevoir un code SMS.',
      ),
      _Etape.otp => (
        'Code de vérification',
        'Saisissez le code reçu par SMS.',
      ),
      _Etape.nouveauPin => (
        'Nouveau code PIN',
        'Choisissez un code à 4 chiffres.',
      ),
      _Etape.confirmerPin => (
        'Confirmez votre PIN',
        'Saisissez à nouveau votre code.',
      ),
    };
    final numero = switch (_etape) {
      _Etape.telephone => 1,
      _Etape.otp => 2,
      _Etape.nouveauPin || _Etape.confirmerPin => 3,
    };
    // Retour : étape précédente quand elle a un sens, sinon l'écran
    // précédent.
    final VoidCallback? retour = _enCours
        ? null
        : switch (_etape) {
            _Etape.otp => () => setState(() {
              _etape = _Etape.telephone;
              _otp = '';
              _erreur = false;
            }),
            _Etape.confirmerPin => () => setState(() {
              _etape = _Etape.nouveauPin;
              _nouveauPin = '';
              _confirmation = '';
              _erreur = false;
            }),
            _ => () => Navigator.of(context).pop(),
          };

    return CadreAuth(
      titre: titre,
      sousTitre: sousTitre,
      etape: (numero: numero, total: 3),
      onRetour: retour,
      child: TransitionEtapes(
        etape: _etape,
        child: switch (_etape) {
          _Etape.telephone => _buildTelephone(),
          _Etape.otp => _buildOtp(),
          _Etape.nouveauPin || _Etape.confirmerPin => _buildNouveauPin(),
        },
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
          TextFormField(
            controller: _telephone,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _enCours ? null : _demanderOtp(),
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            decoration: const InputDecoration(
              hintText: 'Numéro de téléphone',
              prefixIcon: PrefixeTelephone(),
              counterText: '',
            ),
            validator: (v) => (v == null || v.trim().length != 10)
                ? 'Entre tes 10 chiffres'
                : null,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _enCours ? null : _demanderOtp,
            child: _enCours
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
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
        PastilleTelephone(_telephoneComplet),
        const SizedBox(height: 24),
        CasesCode(code: _otp, longueur: _longueurCodeSms, erreur: _erreur),
        const SizedBox(height: 24),
        if (_enCours)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          )
        else ...[
          ClavierNumerique(
            onChiffre: _onOtp,
            onSupprimer: () {
              if (_otp.isNotEmpty) {
                setState(() => _otp = _otp.substring(0, _otp.length - 1));
              }
            },
          ),
          const SizedBox(height: 4),
          LienAuth(
            question: 'Rien reçu ?',
            action: 'Renvoyer le code',
            onTap: _renvoyerCode,
          ),
        ],
      ],
    );
  }

  Widget _buildNouveauPin() {
    final enConfirmation = _etape == _Etape.confirmerPin;
    final courant = enConfirmation ? _confirmation : _nouveauPin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        PointsPin(remplis: courant.length, erreur: _erreur),
        const SizedBox(height: 28),
        if (_enCours)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          )
        else
          ClavierNumerique(onChiffre: _onPin, onSupprimer: _onSupprimerPin),
      ],
    );
  }
}
