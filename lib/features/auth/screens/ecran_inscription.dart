import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';

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
        );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final enCours = auth.isLoading;

    ref.listen(authProvider, (_, next) {
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
