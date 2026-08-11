import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';
import 'package:poufiret/features/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/features/auth/widgets/points_pin.dart';
import 'package:poufiret/features/auth/widgets/dialogue_biometrie.dart';
import 'package:poufiret/core/network/providers.dart';
import 'package:poufiret/features/geo/widgets/champ_departement.dart';

enum _Etape { infos, otp, nouveauPin, confirmerPin }

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

  static const _but = 'inscription';

  @override
  void dispose() {
    _prenom.dispose();
    _nom.dispose();
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

  // ── Étape 1 : valider les infos + demander l'OTP ────────────────────────
  Future<void> _demarrer() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _enCours = true);
    try {
      final res = await ref.read(authProvider.notifier).demanderOtp(
            telephone: _telephoneComplet,
            but: _but,
          );
      if (!mounted) return;

      // Un compte existe déjà → on redirige vers la connexion.
      if (res['compte_existe'] == true) {
        _snack('Un compte existe déjà pour ce numéro. Connectez-vous.');
        Navigator.of(context).pop();
        return;
      }

      // Numéro déjà vérifié → pas de SMS, on saute l'OTP.
      if (res['deja_verifie'] == true || res['otp_envoye'] != true) {
        setState(() {
          _etape = _Etape.nouveauPin;
          _erreur = false;
        });
      } else {
        setState(() {
          _etape = _Etape.otp;
          _otp = '';
          _erreur = false;
        });
      }
    } catch (e) {
      _snack(_messageErreur(e));
    } finally {
      if (mounted) setState(() => _enCours = false);
    }
  }

  // ── Étape 2 : OTP ───────────────────────────────────────────────────────
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
    // definirPin(inscription) connecte directement (tokens renvoyés).
    await ref.read(authProvider.notifier).definirPin(
          telephone: _telephoneComplet,
          password: _nouveauPin,
          but: _but,
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
      appBar: AppBar(title: const Text('Créer un compte')),
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: switch (_etape) {
            _Etape.infos => _buildInfos(),
            _Etape.otp => _buildOtp(),
            _Etape.nouveauPin ||
            _Etape.confirmerPin => _buildPin(),
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
            controller: _prenom,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Entre ton prénom' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nom,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Entre ton nom' : null,
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 20),
          _BlocFacultatif(
            departement: _departement,
            trancheAge: _trancheAge,
            sexe: _sexe,
            onDepartement: (v) => setState(() => _departement = v),
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
                    child: CircularProgressIndicator(strokeWidth: 2))
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

  Widget _buildPin() {
    final enConfirmation = _etape == _Etape.confirmerPin;
    final courant = enConfirmation ? _confirmation : _nouveauPin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock_outline,
            size: 56, color: Theme.of(context).colorScheme.primary),
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

/// Bloc separe, non obligatoire : departement, tranche d'age, sexe.
///
/// Volontairement mis a l'ecart du reste du formulaire et introduit par
/// un rappel qu'il n'est pas obligatoire — mais utile pour proposer un
/// contenu pertinent. Sans ce cadrage, demander l'age et le sexe fait
/// fuir a l'inscription.
class _BlocFacultatif extends StatelessWidget {
  const _BlocFacultatif({
    required this.departement,
    required this.trancheAge,
    required this.sexe,
    required this.onDepartement,
    required this.onTrancheAge,
    required this.onSexe,
  });

  final int? departement;
  final String? trancheAge;
  final String? sexe;
  final ValueChanged<int?> onDepartement;
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
                child: Text('Pour mieux vous servir (facultatif)',
                    style: theme.textTheme.titleSmall),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Ces informations ne sont pas obligatoires, mais elles nous '
            'aident à vous proposer les commerces les plus pertinents près '
            'de chez vous.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 14),
          ChampDepartement(
            valeur: departement,
            libelle: 'Votre département',
            onChange: onDepartement,
          ),
          const SizedBox(height: 12),
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
