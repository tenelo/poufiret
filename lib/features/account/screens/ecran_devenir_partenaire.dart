import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/api_exception.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/screens/auth_notifier.dart';

/// Formulaire « Devenir partenaire » : crée le ProfilPartenaire
/// (statut en attente de validation par un administrateur).
class EcranDevenirPartenaire extends ConsumerStatefulWidget {
  const EcranDevenirPartenaire({super.key});

  @override
  ConsumerState<EcranDevenirPartenaire> createState() =>
      _EcranDevenirPartenaireState();
}

class _EcranDevenirPartenaireState
    extends ConsumerState<EcranDevenirPartenaire> {
  final _cleFormulaire = GlobalKey<FormState>();
  final _ctrlNomCommerce = TextEditingController();
  final _ctrlDescription = TextEditingController();
  final _ctrlAdresse = TextEditingController();
  final _ctrlQuartier = TextEditingController();
  final _ctrlTelephonePro = TextEditingController();
  final _ctrlWhatsapp = TextEditingController();

  String _type = 'commercant';
  bool _envoiEnCours = false;

  static const _types = {
    'commercant': 'Commerçant',
    'pharmacien': 'Pharmacien',
    'boulanger': 'Boulanger',
    'restaurateur': 'Restaurateur',
    'couturier': 'Couturier / Couturière',
    'menuisier': 'Menuisier',
    'plombier': 'Plombier',
    'electricien': 'Électricien',
    'macon': 'Maçon',
    'coiffeur': 'Coiffeur / Coiffeuse',
    'libraire': 'Libraire',
    'hotelier': 'Hôtelier',
    'mecanicien': 'Mécanicien',
    'loueur_maison': 'Loueur de maison',
    'loueur_voiture': 'Loueur de voiture',
    'autre': 'Autre',
  };

  @override
  void dispose() {
    _ctrlNomCommerce.dispose();
    _ctrlDescription.dispose();
    _ctrlAdresse.dispose();
    _ctrlQuartier.dispose();
    _ctrlTelephonePro.dispose();
    _ctrlWhatsapp.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (!_cleFormulaire.currentState!.validate()) return;
    setState(() => _envoiEnCours = true);
    try {
      await ref.read(authRepositoryProvider).devenirPartenaire({
        'type_partenaire': _type,
        'nom_commerce': _ctrlNomCommerce.text.trim(),
        'description': _ctrlDescription.text.trim(),
        'adresse': _ctrlAdresse.text.trim(),
        'quartier': _ctrlQuartier.text.trim(),
        if (_ctrlTelephonePro.text.trim().isNotEmpty)
          'telephone_pro': _ctrlTelephonePro.text.trim(),
        if (_ctrlWhatsapp.text.trim().isNotEmpty)
          'whatsapp': _ctrlWhatsapp.text.trim(),
      });
      ref.invalidate(authProvider);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Demande envoyée'),
          content: const Text(
              'Votre profil partenaire est créé. Il sera visible après '
              'validation par un administrateur.'),
          actions: [
            FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Compris')),
          ],
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e is ApiException
              ? e.messageLisible
              : 'Envoi impossible. Réessayez.')));
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devenir partenaire')),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur =
              contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: Form(
                key: _cleFormulaire,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _type,
                      decoration: const InputDecoration(
                          labelText: 'Type d\'activité'),
                      items: _types.entries
                          .map((e) => DropdownMenuItem(
                              value: e.key, child: Text(e.value)))
                          .toList(),
                      onChanged: (v) => setState(() => _type = v!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlNomCommerce,
                      decoration: const InputDecoration(
                          labelText: 'Nom de l\'enseigne'),
                      maxLength: 150,
                      validator: (v) => v == null || v.trim().length < 3
                          ? 'Nom trop court.'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ctrlDescription,
                      decoration: const InputDecoration(
                        labelText: 'Description de l\'activité',
                        alignLabelWithHint: true,
                      ),
                      minLines: 2,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlAdresse,
                      decoration:
                          const InputDecoration(labelText: 'Adresse'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlQuartier,
                      decoration:
                          const InputDecoration(labelText: 'Quartier'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlTelephonePro,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'Téléphone professionnel (optionnel)'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlWhatsapp,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'WhatsApp (optionnel)'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _envoiEnCours ? null : _envoyer,
                  icon: _envoiEnCours
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.send),
                  label: const Text('Envoyer ma demande'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
