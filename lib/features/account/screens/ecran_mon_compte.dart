import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/api_exception.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/screens/auth_notifier.dart';
import 'ecran_appareils.dart';
import 'ecran_devenir_partenaire.dart';

/// Écran « Mon compte » : profil éditable + accès appareils / partenaire.
class EcranMonCompte extends ConsumerStatefulWidget {
  const EcranMonCompte({super.key});

  @override
  ConsumerState<EcranMonCompte> createState() => _EcranMonCompteState();
}

class _EcranMonCompteState extends ConsumerState<EcranMonCompte> {
  final _ctrlPrenom = TextEditingController();
  final _ctrlNom = TextEditingController();
  final _ctrlUsername = TextEditingController();
  bool _prerempli = false;
  bool _envoiEnCours = false;

  @override
  void dispose() {
    _ctrlPrenom.dispose();
    _ctrlNom.dispose();
    _ctrlUsername.dispose();
    super.dispose();
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> _enregistrer() async {
    setState(() => _envoiEnCours = true);
    try {
      await ref.read(authRepositoryProvider).modifierProfil({
        'first_name': _ctrlPrenom.text.trim(),
        'last_name': _ctrlNom.text.trim(),
        'username': _ctrlUsername.text.trim(),
      });
      ref.invalidate(authProvider);
      _message('Profil mis à jour.');
    } catch (e) {
      _message(e is ApiException
          ? e.messageLisible
          : 'Mise à jour impossible.');
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final utilisateurAsync = ref.watch(authProvider);
    final utilisateur = utilisateurAsync.whenOrNull(data: (u) => u);

    if (utilisateur != null && !_prerempli) {
      _prerempli = true;
      _ctrlPrenom.text = utilisateur.prenom;
      _ctrlNom.text = utilisateur.nom;
      _ctrlUsername.text = utilisateur.username ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mon compte')),
      body: utilisateur == null
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, contraintes) {
                final largeur = contraintes.maxWidth > 700
                    ? 700.0
                    : contraintes.maxWidth;
                return Center(
                  child: SizedBox(
                    width: largeur,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // ── Identité ─────────────────────────────────
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                              child: Icon(Icons.person)),
                          title: Text(utilisateur.telephone),
                          subtitle: Text(utilisateur.estPartenaire
                              ? 'Compte partenaire'
                              : 'Compte client'),
                        ),
                        const Divider(height: 24),
                        TextFormField(
                          controller: _ctrlPrenom,
                          decoration: const InputDecoration(
                              labelText: 'Prénom'),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _ctrlNom,
                          decoration:
                              const InputDecoration(labelText: 'Nom'),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _ctrlUsername,
                          decoration: const InputDecoration(
                              labelText: 'Nom d\'utilisateur'),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _envoiEnCours ? null : _enregistrer,
                          icon: _envoiEnCours
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2))
                              : const Icon(Icons.save),
                          label: const Text('Enregistrer'),
                        ),
                        const Divider(height: 32),
                        // ── Sécurité et partenaire ───────────────────
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.devices),
                          title: const Text('Appareils connectés'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const EcranAppareils()),
                          ),
                        ),
                        if (!utilisateur.estPartenaire)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.storefront),
                            title: const Text('Devenir partenaire'),
                            subtitle: const Text(
                                'Vendez vos produits ou services sur Poufiret.'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const EcranDevenirPartenaire()),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
