import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/config.dart';
import '../../../core/errors/api_exception.dart';
import '../data/espace_partenaire_providers.dart';
import '../../../core/widgets/image_reseau.dart';

/// Le partenaire gere sa vitrine : identite, contacts, localisation.
///
/// Les champs de controle (statut, visibilite, plan, badge) sont affiches
/// mais non modifiables : ils relevent de l'administration Poufiret.
class EcranMonProfilPartenaire extends ConsumerWidget {
  const EcranMonProfilPartenaire({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(monProfilPartenaireProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ma vitrine')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(monProfilPartenaireProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (profil) => _Formulaire(profil: profil),
      ),
    );
  }
}

class _Formulaire extends ConsumerStatefulWidget {
  const _Formulaire({required this.profil});
  final Map<String, dynamic> profil;

  @override
  ConsumerState<_Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends ConsumerState<_Formulaire> {
  final _cle = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _champs;
  XFile? _logo;
  XFile? _couverture;
  bool _envoi = false;

  /// Champs modifiables : cle API -> libelle affiche.
  static const _libelles = {
    'nom_commerce': 'Nom de l\'enseigne',
    'description': 'Description',
    'adresse': 'Adresse',
    'quartier': 'Quartier',
    'secteur': 'Secteur',
    'ville': 'Ville',
    'description_acces': 'Comment vous trouver',
    'telephone_pro': 'Téléphone professionnel',
    'whatsapp': 'WhatsApp',
    'email_pro': 'Email professionnel',
  };

  @override
  void initState() {
    super.initState();
    _champs = {
      for (final cle in _libelles.keys)
        cle: TextEditingController(
            text: (widget.profil[cle] ?? '').toString()),
    };
  }

  @override
  void dispose() {
    for (final c in _champs.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _choisir(bool estLogo) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;
    setState(() => estLogo ? _logo = image : _couverture = image);
  }

  Future<void> _enregistrer() async {
    if (!_cle.currentState!.validate()) return;
    setState(() => _envoi = true);
    try {
      await ref.read(espacePartenaireRepositoryProvider).modifierProfil(
            {for (final e in _champs.entries) e.key: e.value.text.trim()},
            cheminLogo: _logo?.path,
            cheminCouverture: _couverture?.path,
          );
      ref.invalidate(monProfilPartenaireProvider);
      if (!mounted) return;
      setState(() {
        _logo = null;
        _couverture = null;
      });
      _message('Vitrine mise à jour.');
    } on ApiException catch (e) {
      _message(e.messageLisible);
    } catch (_) {
      _message('Enregistrement impossible. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(texte)));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profil;

    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur =
            contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
        return Center(
          child: SizedBox(
            width: largeur,
            child: Form(
              key: _cle,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Etat(profil: p),
                  const SizedBox(height: 16),

                  Text('Images', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _ZoneImage(
                          titre: 'Logo',
                          fichier: _logo,
                          urlActuelle: p['logo']?.toString(),
                          onTap: () => _choisir(true),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ZoneImage(
                          titre: 'Couverture',
                          fichier: _couverture,
                          urlActuelle: p['photo_couverture']?.toString(),
                          onTap: () => _choisir(false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  for (final e in _libelles.entries) ...[
                    TextFormField(
                      controller: _champs[e.key],
                      maxLines: e.key == 'description' ||
                              e.key == 'description_acces'
                          ? 3
                          : 1,
                      keyboardType: e.key.contains('telephone') ||
                              e.key == 'whatsapp'
                          ? TextInputType.phone
                          : e.key == 'email_pro'
                              ? TextInputType.emailAddress
                              : TextInputType.text,
                      decoration: InputDecoration(
                        labelText: e.value,
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      validator: e.key == 'nom_commerce'
                          ? (v) => (v ?? '').trim().isEmpty
                              ? 'Le nom de l\'enseigne est obligatoire.'
                              : null
                          : null,
                    ),
                    const SizedBox(height: 12),
                  ],

                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: _envoi ? null : _enregistrer,
                    icon: _envoi
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(_envoi ? 'Enregistrement…' : 'Enregistrer'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Bandeau des informations pilotees par l'administration.
class _Etat extends StatelessWidget {
  const _Etat({required this.profil});
  final Map<String, dynamic> profil;

  @override
  Widget build(BuildContext context) {
    final visible = profil['est_visible'] == true;
    final certifie = profil['badge_certifie'] == true;

    return Card(
      color: Config.couleurFond,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  visible ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: visible
                      ? Config.couleurSucces
                      : Config.couleurTexteSecondaire,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    visible
                        ? 'Votre vitrine est visible par les clients'
                        : 'Votre vitrine n\'est pas encore visible',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                _Puce(texte: profil['statut_libelle']?.toString() ?? '—'),
                _Puce(texte: 'Plan ${profil['plan_libelle'] ?? '—'}'),
                _Puce(texte: '${profil['nb_vues'] ?? 0} vues'),
                if (certifie) const _Puce(texte: '✓ Certifié'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Puce extends StatelessWidget {
  const _Puce({required this.texte});
  final String texte;

  @override
  Widget build(BuildContext context) => Chip(
        label: Text(texte, style: const TextStyle(fontSize: 11)),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
}

class _ZoneImage extends StatelessWidget {
  const _ZoneImage({
    required this.titre,
    required this.fichier,
    required this.urlActuelle,
    required this.onTap,
  });

  final String titre;
  final XFile? fichier;
  final String? urlActuelle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final url = urlActuelle ?? '';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Config.couleurFond,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Config.couleurClaire),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (fichier != null)
              Image.file(File(fichier!.path), fit: BoxFit.cover)
            else if (url.isNotEmpty)
              ImageReseau(url, fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => const SizedBox.shrink())
            else
              const Center(
                child: Icon(Icons.add_photo_alternate_outlined,
                    color: Config.couleurTexteSecondaire),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black45,
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
