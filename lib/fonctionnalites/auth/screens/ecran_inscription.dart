import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/global/ui/notificateur.dart';
import 'package:poufiret/fonctionnalites/auth/donnees/service_auth_firebase.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/points_pin.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/dialogue_biometrie.dart';
import 'package:poufiret/global/network/providers.dart';
import 'package:poufiret/fonctionnalites/geo/widgets/champ_departement.dart';

enum _Etape { infos, otp, nouveauPin, confirmerPin }

/// Longueur d'un code SMS Firebase (standard, distincte du PIN a 4 chiffres).
const _longueurCodeSms = 6;

class EcranInscription extends ConsumerStatefulWidget {
  const EcranInscription({super.key});

  @override
  ConsumerState<EcranInscription> createState() => _EcranInscriptionState();
}

class _EcranInscriptionState extends ConsumerState<EcranInscription> {
  final _prenom = TextEditingController();
  final _nom = TextEditingController();
  final _telephone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Bloc facultatif : sert au referencement et a l'analyse cote client.
  int? _departement;
  String? _trancheAge;
  String? _sexe;

  _Etape _etape = _Etape.infos;
  String _otp = '';
  String _nouveauPin = '';
  String _confirmation = '';
  bool _erreur = false;
  bool _enCours = false;

  // Firebase Phone Auth : une instance par tentative de vérification, et
  // l'idToken obtenu une fois le numéro prouvé (saisie manuelle ou
  // vérification automatique Android), consommé à l'étape finale.
  final _serviceFirebase = ServiceAuthFirebase();
  String? _idToken;

  @override
  void dispose() {
    _prenom.dispose();
    _nom.dispose();
    _telephone.dispose();
    super.dispose();
  }

  String get _telephoneComplet => '+225${_telephone.text.trim()}';

  String _messageErreur(Object? e) =>
      e is ApiException ? e.messageLisible : 'Une erreur est survenue.';

  // ── Étape 1 : valider les infos + envoyer le code SMS (Firebase) ────────
  Future<void> _demarrer() async {
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
        // déjà prouvé, on saute directement à la création du PIN.
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

  // ── Étapes 3 & 4 : PIN + confirmation ───────────────────────────────────
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
          _confirmation = _confirmation.substring(0, _confirmation.length - 1);
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
      Notificateur.erreur(
        context,
        'Le code PIN ne correspond pas. Recommencez.',
      );
      return;
    }
    final idToken = _idToken;
    if (idToken == null) {
      // Ne devrait pas arriver (numéro pas encore prouvé), garde-fou.
      Notificateur.erreur(
        context,
        'Vérification du numéro expirée. Recommencez.',
      );
      setState(() {
        _etape = _Etape.infos;
        _nouveauPin = '';
        _confirmation = '';
      });
      return;
    }
    setState(() => _enCours = true);
    // inscriptionFirebase(...) connecte directement (tokens renvoyés).
    await ref
        .read(authProvider.notifier)
        .inscriptionFirebase(
          idToken: idToken,
          password: _nouveauPin,
          prenom: _prenom.text.trim(),
          nom: _nom.text.trim(),
        );
  }

  // ── Après connexion : enregistrer le bloc facultatif (PATCH /moi) ───────
  Future<void> _enregistrerBlocFacultatif() async {
    final donnees = <String, dynamic>{
      if (_departement != null) 'departement': _departement,
      if (_trancheAge != null && _trancheAge!.isNotEmpty)
        'tranche_age': _trancheAge,
      if (_sexe != null && _sexe!.isNotEmpty) 'sexe': _sexe,
    };
    if (donnees.isEmpty) return;
    try {
      await ref.read(authProvider.notifier).modifierProfil(donnees);
    } catch (_) {
      // Non bloquant : l'inscription a réussi, le profil pourra être
      // complété plus tard depuis les paramètres.
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (avant, next) async {
      final connecte = next.value != null && avant?.value == null;
      if (connecte) {
        await _enregistrerBlocFacultatif();
        if (!context.mounted) return;
        final tokens = ref.read(tokenStorageProvider);
        await proposerActivationBiometrie(
          context: context,
          biometrieDejaChoisie: () => tokens.biometrieDefinie,
          definirBiometrie: tokens.definirBiometrie,
        );
        if (!context.mounted) return;
        Navigator.of(context).popUntil((r) => r.isFirst);
        return;
      }
      if (next.hasError && !next.isLoading && _etape == _Etape.confirmerPin) {
        final err = next.error;
        // 400 sur /auth/firebase/inscription/ : le contrat backend le
        // reserve au cas "un compte existe deja pour ce numero" — le
        // numero venait pourtant d'etre prouve par Firebase, donc on
        // redirige simplement vers la connexion plutot que de laisser
        // l'utilisateur recommencer une inscription qui echouera toujours.
        if (err is ApiException && err.code == 400) {
          setState(() => _enCours = false);
          Notificateur.avertissement(context, err.messageLisible);
          Navigator.of(context).pop();
          return;
        }
        setState(() {
          _enCours = false;
          _erreur = true;
          _nouveauPin = '';
          _confirmation = '';
          _etape = _Etape.nouveauPin;
        });
        Notificateur.erreur(context, _messageErreur(err));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte'), centerTitle: true),
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: switch (_etape) {
            _Etape.infos => _buildInfos(),
            _Etape.otp => _buildOtp(),
            _Etape.nouveauPin || _Etape.confirmerPin => _buildPin(),
          },
        ),
      ),
    );
  }

  Widget _buildInfos() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nom,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nom *',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Entre ton nom' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _prenom,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Prénoms *',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Entre ton prénom' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _telephone,
            keyboardType: TextInputType.number,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Téléphone *',
              prefixText: '+225 ',
              counterText: '',
              border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().length != 10)
                ? 'Entre tes 10 chiffres'
                : null,
          ),
          const SizedBox(height: 16),
          ChampDepartement(
            valeur: _departement,
            libelle: 'Votre département',
            obligatoire: true,
            onChange: (v) => setState(() => _departement = v),
          ),
          const SizedBox(height: 20),
          _BlocFacultatif(
            trancheAge: _trancheAge,
            sexe: _sexe,
            onTrancheAge: (v) => setState(() => _trancheAge = v),
            onSexe: (v) => setState(() => _sexe = v),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _enCours ? null : _demarrer,
            child: _enCours
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Continuer'),
          ),
        ],
      ),
    );
  }

  Widget _buildOtp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.sms_outlined,
          size: 56,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Code de vérification',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Code envoyé au $_telephoneComplet',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        PointsPin(
          remplis: _otp.length,
          total: _longueurCodeSms,
          erreur: _erreur,
        ),
        const SizedBox(height: 32),
        if (_enCours)
          const CircularProgressIndicator()
        else ...[
          ClavierNumerique(
            onChiffre: _onOtp,
            onSupprimer: () {
              if (_otp.isNotEmpty) {
                setState(() => _otp = _otp.substring(0, _otp.length - 1));
              }
            },
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _renvoyerCode,
            child: const Text('Renvoyer le code'),
          ),
        ],
      ],
    );
  }

  Widget _buildPin() {
    final enConfirmation = _etape == _Etape.confirmerPin;
    final courant = enConfirmation ? _confirmation : _nouveauPin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_outline,
          size: 56,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          enConfirmation ? 'Confirmez votre PIN' : 'Créez votre code PIN',
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

/// Bloc separe, non obligatoire : tranche d'age, sexe.
///
/// Volontairement mis a l'ecart du reste du formulaire et introduit par
/// un rappel qu'il n'est pas obligatoire — mais utile pour proposer un
/// contenu pertinent. Sans ce cadrage, demander l'age et le sexe fait
/// fuir a l'inscription.
class _BlocFacultatif extends StatelessWidget {
  const _BlocFacultatif({
    required this.trancheAge,
    required this.sexe,
    required this.onTrancheAge,
    required this.onSexe,
  });

  final String? trancheAge;
  final String? sexe;
  final ValueChanged<String?> onTrancheAge;
  final ValueChanged<String?> onSexe;

  static const _tranches = {
    'moins_18': 'Moins de 18 ans',
    '18_24': '18 - 24 ans',
    '25_34': '25 - 34 ans',
    '35_44': '35 - 44 ans',
    '45_54': '45 - 54 ans',
    '55_plus': '55 ans et plus',
  };
  static const _sexes = {
    'homme': 'Homme',
    'femme': 'Femme',
    'non_precise': 'Préfère ne pas préciser',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.tune, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pour mieux vous servir (facultatif)',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Ces informations ne sont pas obligatoires, mais elles nous '
            'aident à vous proposer les commerces les plus pertinents près '
            'de chez vous.',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: trancheAge,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Tranche d\'âge',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cake_outlined),
            ),
            items: [
              for (final e in _tranches.entries)
                DropdownMenuItem(value: e.key, child: Text(e.value)),
            ],
            onChanged: onTrancheAge,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: sexe,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Sexe',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
            items: [
              for (final e in _sexes.entries)
                DropdownMenuItem(value: e.key, child: Text(e.value)),
            ],
            onChanged: onSexe,
          ),
        ],
      ),
    );
  }
}
