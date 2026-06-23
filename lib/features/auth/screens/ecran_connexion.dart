import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/core/responsive/conteneur_adaptatif.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';

class EcranConnexion extends ConsumerStatefulWidget {
  const EcranConnexion({super.key});

  @override
  ConsumerState<EcranConnexion> createState() => _EcranConnexionState();
}

class _EcranConnexionState extends ConsumerState<EcranConnexion> {
  final _telephone = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _telephone.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _connecter() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authProvider.notifier)
        .connexion(
          telephone: '+225${_telephone.text.trim()}',
          password: _password.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final enCours = auth.isLoading;

    // Affiche un message si la dernière tentative a échoué.
    ref.listen(authProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        final err = next.error;
        final message = err is ApiException
            ? err.message
            : 'Connexion impossible.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: ConteneurAdaptatif(
          child: Form(
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Entre ton mot de passe'
                      : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: enCours ? null : _connecter,
                  child: enCours
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
