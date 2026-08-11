import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/network/providers.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';
import 'package:poufiret/features/auth/screens/ecran_inscription.dart';
import 'package:poufiret/features/auth/screens/ecran_pin_oublie.dart';
import 'package:poufiret/features/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/features/auth/widgets/points_pin.dart';
import 'package:poufiret/features/auth/widgets/service_biometrie.dart';

enum _Etape { telephone, pin }

class EcranConnexion extends ConsumerStatefulWidget {
  const EcranConnexion({super.key});

  @override
  ConsumerState<EcranConnexion> createState() => _EcranConnexionState();
}

class _EcranConnexionState extends ConsumerState<EcranConnexion> {
  final _telephone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _Etape _etape = _Etape.telephone;
  String _pin = '';
  bool _erreurPin = false;
  bool _empreinteDispo = false; // matériel + biométrie activée + PIN mémorisé

  @override
  void dispose() {
    _telephone.dispose();
    super.dispose();
  }

  String get _telephoneComplet => '+225${_telephone.text.trim()}';

  Future<void> _continuer() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    // Le bouton empreinte n'apparaît que si le numéro saisi correspond au
    // compte mémorisé sur cet appareil (sinon on reconnecterait un autre compte).
    final tokens = ref.read(tokenStorageProvider);
    final telMemorise = await tokens.telephone;
    final aPin = await tokens.aPinMemorise;
    final bioActivee = await tokens.biometrieActivee;
    final bioMaterielle = await ServiceBiometrie().estDisponible();

    final empreinteOk = aPin &&
        bioActivee &&
        bioMaterielle &&
        telMemorise == _telephoneComplet;

    setState(() {
      _etape = _Etape.pin;
      _pin = '';
      _erreurPin = false;
      _empreinteDispo = empreinteOk;
    });

    if (empreinteOk) {
      // Invite biométrique automatique à l'arrivée sur l'étape PIN.
      _deverrouillerEmpreinte();
    }
  }

  void _onChiffre(String c) {
    if (_pin.length >= 4) return;
    setState(() {
      _erreurPin = false;
      _pin += c;
    });
    if (_pin.length == 4) _connecterAvecPin();
  }

  void _onSupprimer() {
    if (_pin.isEmpty) return;
    setState(() {
      _erreurPin = false;
      _pin = _pin.substring(0, _pin.length - 1);
    });
  }

  Future<void> _connecterAvecPin() async {
    await ref.read(authProvider.notifier).connexion(
          telephone: _telephoneComplet,
          password: _pin,
        );
  }

  Future<void> _deverrouillerEmpreinte() async {
    final ok = await ServiceBiometrie().authentifier(
      raison: 'Déverrouillez Poufiret avec votre empreinte',
    );
    if (!ok) return; // annulation → l'utilisateur peut taper son PIN
    await ref.read(authProvider.notifier).deverrouillerParEmpreinte();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final enCours = auth.isLoading;

    ref.listen(authProvider, (avant, next) {
      final connecteMaintenant = next.value != null;
      final etaitConnecte = avant?.value != null;
      if (connecteMaintenant && !etaitConnecte) {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        return;
      }
      if (next.hasError && !next.isLoading) {
        setState(() {
          _erreurPin = true;
          _pin = '';
        });
        final err = next.error;
        final message =
            err is ApiException ? err.messageLisible : 'Connexion impossible.';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: _etape == _Etape.telephone
              ? _buildTelephone(enCours)
              : _buildPin(enCours),
        ),
      ),
    );
  }

  Widget _buildTelephone(bool enCours) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Poufiret',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
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
            onPressed: enCours ? null : _continuer,
            child: enCours
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Continuer'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: enCours
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EcranInscription(),
                      ),
                    ),
            child: const Text('Pas de compte ? Créer un compte'),
          ),
        ],
      ),
    );
  }

  Widget _buildPin(bool enCours) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: enCours
                ? null
                : () => setState(() {
                      _etape = _Etape.telephone;
                      _pin = '';
                      _erreurPin = false;
                    }),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Entrez votre code PIN',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          _telephoneComplet,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 32),
        PointsPin(remplis: _pin.length, erreur: _erreurPin),
        const SizedBox(height: 32),
        if (enCours)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          )
        else ...[
          ClavierNumerique(onChiffre: _onChiffre, onSupprimer: _onSupprimer),
          const SizedBox(height: 16),
          if (_empreinteDispo)
            TextButton.icon(
              onPressed: _deverrouillerEmpreinte,
              icon: const Icon(Icons.fingerprint),
              label: const Text('Utiliser l\'empreinte'),
            ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EcranPinOublie()),
            ),
            child: const Text('Code PIN oublié ?'),
          ),
        ],
      ],
    );
  }
}
