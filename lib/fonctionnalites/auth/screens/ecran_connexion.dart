import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/global/errors/api_exception.dart';
import 'package:poufiret/global/network/providers.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/cadre_auth.dart';
import 'package:poufiret/global/ui/notificateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_inscription.dart';
import 'package:poufiret/fonctionnalites/auth/screens/ecran_pin_oublie.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/clavier_numerique.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/dialogue_biometrie.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/points_pin.dart';
import 'package:poufiret/fonctionnalites/auth/widgets/service_biometrie.dart';

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
  // Matériel biométrique dispo + numéro saisi == compte mémorisé + PIN
  // mémorisé. NE dépend PAS de biometrieActivee : le bouton est proposé dès
  // la première fois, l'activation se fait au premier tap réussi.
  bool _empreinteVisible = false;

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
    // compte mémorisé sur cet appareil (sinon on reconnecterait un autre
    // compte) ET qu'un PIN est mémorisé (au moins une connexion déjà faite).
    // Il est proposé MÊME SI la préférence biometrieActivee est encore
    // fausse : le premier tap réussi vaut activation (voir
    // _deverrouillerEmpreinte).
    final tokens = ref.read(tokenStorageProvider);
    final telMemorise = await tokens.telephone;
    final aPin = await tokens.aPinMemorise;
    final bioActivee = await tokens.biometrieActivee;
    final bioMaterielle = await ServiceBiometrie().estDisponible();
    final memeCompte = telMemorise == _telephoneComplet;

    final empreinteVisible = aPin && bioMaterielle && memeCompte;
    // L'invite automatique à l'arrivée sur l'étape PIN reste réservée aux
    // comptes ayant déjà explicitement activé la biométrie.
    final declencherAuto = empreinteVisible && bioActivee;

    setState(() {
      _etape = _Etape.pin;
      _pin = '';
      _erreurPin = false;
      _empreinteVisible = empreinteVisible;
    });

    if (declencherAuto) {
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
    await ref
        .read(authProvider.notifier)
        .connexion(telephone: _telephoneComplet, password: _pin);
  }

  Future<void> _apresConnexion() async {
    final tokens = ref.read(tokenStorageProvider);
    await proposerActivationBiometrie(
      context: context,
      biometrieDejaChoisie: () => tokens.biometrieDefinie,
      definirBiometrie: tokens.definirBiometrie,
    );
    if (!mounted) return;
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  Future<void> _deverrouillerEmpreinte() async {
    final ok = await ServiceBiometrie().authentifier(
      raison: 'Déverrouillez Poufiret avec votre empreinte',
    );
    if (!ok) return; // annulation/échec → l'utilisateur peut taper son PIN

    final tokens = ref.read(tokenStorageProvider);
    if (!await tokens.biometrieDefinie) {
      // Aucun choix encore enregistré (ni "Activer", ni "Non merci") : le
      // tap reussi ici vaut activation, pour ne plus reproposer la popup
      // apres une prochaine connexion. Un refus explicite anterieur
      // (biometrieDefinie deja vrai) n'est en revanche jamais ecrase.
      await tokens.definirBiometrie(true);
    }
    if (!mounted) return;
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
        _apresConnexion();
        return;
      }
      if (next.hasError && !next.isLoading) {
        setState(() {
          _erreurPin = true;
          _pin = '';
        });
        final err = next.error;
        final message = err is ApiException
            ? err.messageLisible
            : 'Connexion impossible.';
        Notificateur.erreur(context, message);
      }
    });

    final surPin = _etape == _Etape.pin;
    // Étape PIN : retour au numéro. Étape numéro : retour à l'écran
    // précédent s'il y en a un (connexion ouverte depuis le menu).
    final VoidCallback? retour = surPin
        ? (enCours ? null : _revenirAuTelephone)
        : Navigator.of(context).canPop()
        ? () => Navigator.of(context).pop()
        : null;

    return CadreAuth(
      titre: surPin ? 'Votre code PIN' : 'Bienvenue',
      sousTitre: surPin
          ? 'Saisissez les 4 chiffres de votre code.'
          : 'Connectez-vous avec votre numéro de téléphone.',
      onRetour: retour,
      pied: surPin
          ? LienAuth(
              action: 'Code PIN oublié ?',
              onTap: enCours
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranPinOublie()),
                    ),
            )
          : LienAuth(
              question: 'Pas encore de compte ?',
              action: 'Créer un compte',
              onTap: enCours
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EcranInscription(),
                      ),
                    ),
            ),
      child: TransitionEtapes(
        etape: _etape,
        child: surPin ? _buildPin(enCours) : _buildTelephone(enCours),
      ),
    );
  }

  void _revenirAuTelephone() => setState(() {
    _etape = _Etape.telephone;
    _pin = '';
    _erreurPin = false;
  });

  Widget _buildTelephone(bool enCours) {
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
            onFieldSubmitted: (_) => enCours ? null : _continuer(),
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
            onPressed: enCours ? null : _continuer,
            child: enCours
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

  Widget _buildPin(bool enCours) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PastilleTelephone(_telephoneComplet),
        const SizedBox(height: 28),
        PointsPin(remplis: _pin.length, erreur: _erreurPin),
        const SizedBox(height: 28),
        if (enCours)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          )
        else ...[
          ClavierNumerique(onChiffre: _onChiffre, onSupprimer: _onSupprimer),
          if (_empreinteVisible) ...[
            const SizedBox(height: 16),
            _BoutonEmpreinte(onTap: _deverrouillerEmpreinte),
          ],
        ],
      ],
    );
  }
}

/// Déverrouillage par empreinte : grand bouton rond, libellé dessous.
class _BoutonEmpreinte extends StatelessWidget {
  const _BoutonEmpreinte({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Material(
          color: theme.colorScheme.primaryContainer,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Icon(
                Icons.fingerprint_rounded,
                size: 34,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Se connecter avec l'empreinte",
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
