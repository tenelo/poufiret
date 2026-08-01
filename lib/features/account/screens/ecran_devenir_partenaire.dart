import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/api_exception.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../catalogue/data/catalogue_providers.dart';
import '../../geo/widgets/champ_departement.dart';

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

  int? _departement;
  String _type = 'commercant';
  bool _envoiEnCours = false;

  /// Categories choisies. La premiere devient la principale cote backend.
  final List<int> _categories = [];

  /// Vrai tant que l'utilisateur n'a rien coche lui-meme : on peut alors
  /// re-deduire la selection du type d'activite choisi.
  bool _selectionAuto = true;

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
        if (_departement != null) 'departement': _departement,
        if (_categories.isNotEmpty) 'categories': _categories,
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
                      onChanged: (v) => setState(() {
                        _type = v!;
                        if (_selectionAuto) _categories.clear();
                      }),
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
                    _ChoixCategories(
                      type: _type,
                      selection: _categories,
                      onChange: (ids, parUtilisateur) => setState(() {
                        _categories
                          ..clear()
                          ..addAll(ids);
                        if (parUtilisateur) _selectionAuto = false;
                      }),
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
                    ChampDepartement(
                      valeur: _departement,
                      obligatoire: true,
                      onChange: (v) => setState(() => _departement = v),
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

/// Choix des categories du partenaire.
///
/// La categorie correspondant au type d'activite est pre-cochee (via le
/// champ `types_partenaire` de chaque categorie), mais le partenaire peut
/// en ajouter : a Ferke, beaucoup cumulent les activites (un restaurant
/// qui vend aussi du pain).
class _ChoixCategories extends ConsumerStatefulWidget {
  const _ChoixCategories({
    required this.type,
    required this.selection,
    required this.onChange,
  });

  final String type;
  final List<int> selection;

  /// [parUtilisateur] distingue un clic reel d'une pre-selection auto.
  final void Function(List<int> ids, bool parUtilisateur) onChange;

  @override
  ConsumerState<_ChoixCategories> createState() => _ChoixCategoriesState();
}

class _ChoixCategoriesState extends ConsumerState<_ChoixCategories> {
  @override
  Widget build(BuildContext context) {
    final async = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (categories) {
        // Pre-selection : la categorie qui declare ce type d'activite.
        if (widget.selection.isEmpty) {
          final auto = categories
              .where((c) => c.typesPartenaire.contains(widget.type))
              .map((c) => c.id)
              .toList();
          if (auto.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) widget.onChange(auto, false);
            });
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vos catégories', style: theme.textTheme.titleSmall),
            const SizedBox(height: 2),
            Text(
              'Où les clients vous trouveront. Vous pouvez en choisir '
              'plusieurs ; la première sera votre catégorie principale.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final c in categories.where((c) => c.estActive))
                  FilterChip(
                    label: Text(
                      '${c.icone.isNotEmpty ? '${c.icone} ' : ''}${c.nom}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    selected: widget.selection.contains(c.id),
                    onSelected: (coche) {
                      final ids = List<int>.from(widget.selection);
                      coche ? ids.add(c.id) : ids.remove(c.id);
                      widget.onChange(ids, true);
                    },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
