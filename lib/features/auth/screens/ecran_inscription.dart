import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';
import 'package:poufiret/features/geo/widgets/champ_departement.dart';

class EcranInscription extends ConsumerStatefulWidget {
  const EcranInscription({super.key});

  @override
  ConsumerState<EcranInscription> createState() => _EcranInscriptionState();
}

class _EcranInscriptionState extends ConsumerState<EcranInscription> {
  final _prenom = TextEditingController();
  final _nom = TextEditingController();
  final _telephone = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Bloc facultatif : sert au referencement et a l'analyse cote client.
  int? _departement;
  String? _trancheAge;
  String? _sexe;

  @override
  void dispose() {
    _prenom.dispose();
    _nom.dispose();
    _telephone.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  Future<void> _inscrire() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authProvider.notifier)
        .inscription(
          prenom: _prenom.text.trim(),
          nom: _nom.text.trim(),
          telephone: '+225${_telephone.text.trim()}',
          password: _password.text,
          departement: _departement,
          trancheAge: _trancheAge,
          sexe: _sexe,
        );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final enCours = auth.isLoading;

    ref.listen(authProvider, (avant, next) {
      // Succes : le compte est cree et l'utilisateur connecte. On ferme
      // l'ecran d'inscription (et, si on venait du mur via la connexion,
      // le retour ne ramene pas sur ces ecrans).
      final connecteMaintenant = next.value != null;
      final etaitConnecte = avant?.value != null;
      if (connecteMaintenant && !etaitConnecte) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        return;
      }
      if (next.hasError && !next.isLoading) {
        final err = next.error;
        final message = err is ApiException
            ? err.messageLisible
            : 'Inscription impossible.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _prenom,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Entre ton prénom'
                      : null,
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    helperText: 'Au moins 8 caractères',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.length < 8)
                      ? 'Au moins 8 caractères'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmation,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirme le mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v != _password.text)
                      ? 'Les mots de passe ne correspondent pas'
                      : null,
                ),
                const SizedBox(height: 24),
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
                  onPressed: enCours ? null : _inscrire,
                  child: enCours
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Créer mon compte'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: enCours ? null : () => Navigator.pop(context),
                  child: const Text('Déjà un compte ? Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
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
