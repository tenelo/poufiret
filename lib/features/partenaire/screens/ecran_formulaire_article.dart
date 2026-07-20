// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/errors/api_exception.dart';
import '../../catalogue/data/catalogue_providers.dart';
import '../data/espace_partenaire_providers.dart';

/// Création (slug == null) ou modification (slug fourni) d'un article.
class EcranFormulaireArticle extends ConsumerStatefulWidget {
  const EcranFormulaireArticle({super.key, this.slug});

  final String? slug;

  @override
  ConsumerState<EcranFormulaireArticle> createState() =>
      _EcranFormulaireArticleState();
}

class _EcranFormulaireArticleState
    extends ConsumerState<EcranFormulaireArticle> {
  final _cleFormulaire = GlobalKey<FormState>();
  final _ctrlNom = TextEditingController();
  final _ctrlPrix = TextEditingController();
  final _ctrlPrixPromo = TextEditingController();
  final _ctrlDescription = TextEditingController();

  int? _categorieId;
  String _type = 'produit';
  bool _disponible = true;
  bool _actif = true;
  bool _enPromotion = false;
  bool _envoiEnCours = false;
  bool _prerempli = false;
  int? _articleId; // renseigné en édition, pour les photos
  final List<XFile> _nouvellesPhotos = [];

  static const _types = {
    'produit': 'Produit',
    'plat': 'Plat',
    'service': 'Service',
    'logement': 'Logement',
    'vehicule': 'Véhicule',
    'modele_couture': 'Modèle de couture',
    'modele_menuiserie': 'Modèle de menuiserie',
  };

  bool get _estEdition => widget.slug != null;

  @override
  void dispose() {
    _ctrlNom.dispose();
    _ctrlPrix.dispose();
    _ctrlPrixPromo.dispose();
    _ctrlDescription.dispose();
    super.dispose();
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> _choisirPhotos() async {
    final images = await ImagePicker()
        .pickMultiImage(maxWidth: 1600, imageQuality: 80, limit: 5);
    if (images.isNotEmpty) {
      setState(() => _nouvellesPhotos.addAll(images.take(5)));
    }
  }

  Future<void> _enregistrer() async {
    if (!_cleFormulaire.currentState!.validate()) return;
    if (_categorieId == null) {
      _message('Choisissez une catégorie.');
      return;
    }
    setState(() => _envoiEnCours = true);
    final repo = ref.read(espacePartenaireRepositoryProvider);
    try {
      final donnees = <String, dynamic>{
        'nom': _ctrlNom.text.trim(),
        'categorie': _categorieId,
        'type': _type,
        'prix': int.tryParse(_ctrlPrix.text.trim()) ?? 0,
        'description': _ctrlDescription.text.trim(),
        'est_disponible': _disponible,
        'est_actif': _actif,
        'est_en_promotion': _enPromotion,
        if (_enPromotion)
          'prix_promotion': int.tryParse(_ctrlPrixPromo.text.trim()) ?? 0,
      };
      int idPourPhotos;
      if (_estEdition) {
        final r = await repo.modifierArticle(widget.slug!, donnees);
        idPourPhotos = (r['id'] as num).toInt();
      } else {
        final r = await repo.creerArticle(donnees);
        idPourPhotos = (r['id'] as num).toInt();
      }
      var echecs = 0;
      for (var i = 0; i < _nouvellesPhotos.length; i++) {
        try {
          await repo.ajouterImage(
            idPourPhotos,
            cheminFichier: _nouvellesPhotos[i].path,
            estPrincipale: i == 0 && !_estEdition,
            ordre: i,
          );
        } catch (_) {
          echecs++;
        }
      }
      if (!mounted) return;
      _message(echecs == 0
          ? (_estEdition ? 'Article modifié.' : 'Article créé.')
          : 'Enregistré, mais $echecs photo(s) refusée(s) (quota du plan ?).');
      Navigator.of(context).pop(true);
    } catch (e) {
      _message(e is ApiException
          ? e.messageLisible
          : 'Enregistrement impossible. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  Future<void> _supprimer() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
            'Supprimer cet article ? Cette action est définitive.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Supprimer')),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _envoiEnCours = true);
    try {
      await ref
          .read(espacePartenaireRepositoryProvider)
          .supprimerArticle(widget.slug!);
      if (!mounted) return;
      _message('Article supprimé.');
      Navigator.of(context).pop(true);
    } catch (e) {
      _message(e is ApiException
          ? e.messageLisible
          : 'Suppression impossible.');
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    // En édition : préremplir une seule fois depuis la fiche.
    if (_estEdition && !_prerempli) {
      final detailAsync =
          ref.watch(articleDetailProvider(slug: widget.slug!));
      final article = detailAsync.whenOrNull(data: (a) => a);
      if (article != null) {
        _prerempli = true;
        _articleId = article.id;
        _ctrlNom.text = article.nom;
        _ctrlPrix.text = article.prix;
        _ctrlDescription.text = article.description;
        _categorieId = article.categorie;
        _type = article.type.isNotEmpty ? article.type : 'produit';
        _disponible = article.estDisponible;
        _actif = article.estActif;
        _enPromotion = article.estEnPromotion;
        if (article.estEnPromotion) {
          _ctrlPrixPromo.text = article.prixPromotion ?? '';
        }
      }
    }

    final chargementEdition = _estEdition && !_prerempli;

    return Scaffold(
      appBar: AppBar(
        title: Text(_estEdition ? 'Modifier l\'article' : 'Nouvel article'),
        actions: [
          if (_estEdition)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _envoiEnCours ? null : _supprimer,
            ),
        ],
      ),
      body: chargementEdition
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, contraintes) {
                final largeur = contraintes.maxWidth > 700
                    ? 700.0
                    : contraintes.maxWidth;
                return Center(
                  child: SizedBox(
                    width: largeur,
                    child: Form(
                      key: _cleFormulaire,
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          TextFormField(
                            controller: _ctrlNom,
                            decoration: const InputDecoration(
                                labelText: 'Nom de l\'article'),
                            maxLength: 150,
                            validator: (v) =>
                                v == null || v.trim().length < 3
                                    ? 'Nom trop court.'
                                    : null,
                          ),
                          const SizedBox(height: 8),
                          categoriesAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (e, s) =>
                                const Text('Catégories indisponibles.'),
                            data: (cats) =>
                                DropdownButtonFormField<int>(
                              initialValue: _categorieId,
                              decoration: const InputDecoration(
                                  labelText: 'Catégorie'),
                              items: cats
                                  .map((c) => DropdownMenuItem(
                                      value: c.id, child: Text(c.nom)))
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _categorieId = v),
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _type,
                            decoration:
                                const InputDecoration(labelText: 'Type'),
                            items: _types.entries
                                .map((e) => DropdownMenuItem(
                                    value: e.key, child: Text(e.value)))
                                .toList(),
                            onChanged: (v) => setState(() => _type = v!),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _ctrlPrix,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Prix (FCFA)',
                                helperText:
                                    'Laissez 0 pour une prestation sur devis.'),
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            value: _enPromotion,
                            onChanged: (v) =>
                                setState(() => _enPromotion = v),
                            title: const Text('En promotion'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          if (_enPromotion)
                            TextFormField(
                              controller: _ctrlPrixPromo,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Prix promotionnel (FCFA)'),
                              validator: (v) {
                                if (!_enPromotion) return null;
                                final promo =
                                    int.tryParse(v?.trim() ?? '');
                                final prix = int.tryParse(
                                    _ctrlPrix.text.trim());
                                if (promo == null) {
                                  return 'Prix promo requis.';
                                }
                                if (prix != null && promo >= prix) {
                                  return 'Doit être inférieur au prix normal.';
                                }
                                return null;
                              },
                            ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _ctrlDescription,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              alignLabelWithHint: true,
                            ),
                            minLines: 3,
                            maxLines: 6,
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            value: _disponible,
                            onChanged: (v) =>
                                setState(() => _disponible = v),
                            title: const Text('Disponible'),
                            subtitle: const Text(
                                'Indisponible = visible mais non commandable.'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          SwitchListTile(
                            value: _actif,
                            onChanged: (v) => setState(() => _actif = v),
                            title: const Text('Actif'),
                            subtitle: const Text(
                                'Inactif = retiré de l\'application (non supprimé).'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    'Nouvelles photos (${_nouvellesPhotos.length})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall),
                              ),
                              TextButton.icon(
                                onPressed: _choisirPhotos,
                                icon: const Icon(Icons.add_a_photo),
                                label: const Text('Ajouter'),
                              ),
                            ],
                          ),
                          if (_nouvellesPhotos.isNotEmpty)
                            SizedBox(
                              height: 90,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: _nouvellesPhotos.length,
                                separatorBuilder: (_, i) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (_, i) => Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      child: Image.file(
                                          File(_nouvellesPhotos[i].path),
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () => setState(() =>
                                            _nouvellesPhotos.removeAt(i)),
                                        child: const CircleAvatar(
                                          radius: 12,
                                          child: Icon(Icons.close,
                                              size: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                  onPressed:
                      _envoiEnCours || chargementEdition ? null : _enregistrer,
                  icon: _envoiEnCours
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.save),
                  label: Text(_estEdition ? 'Enregistrer' : 'Créer'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
