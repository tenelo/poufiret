import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../data/prestations_providers.dart';

/// Formulaire de création d'une demande d'intervention (artisans).
class EcranDemandeIntervention extends ConsumerStatefulWidget {
  const EcranDemandeIntervention({
    super.key,
    required this.artisanId,
    required this.artisanNom,
  });

  final int artisanId;
  final String artisanNom;

  @override
  ConsumerState<EcranDemandeIntervention> createState() =>
      _EcranDemandeInterventionState();
}

class _EcranDemandeInterventionState
    extends ConsumerState<EcranDemandeIntervention> {
  final _cleFormulaire = GlobalKey<FormState>();
  final _ctrlDescription = TextEditingController();
  final _ctrlTypeLibre = TextEditingController();
  final _ctrlAcces = TextEditingController();

  String _type = 'reparation';
  String _urgence = 'flexible';
  String _disponibilite = 'indifferent';
  bool _envoyerPosition = true;
  bool _envoiEnCours = false;
  final List<XFile> _photos = [];

  static const _types = {
    'reparation': 'Réparation',
    'installation': 'Installation',
    'depannage_urgent': 'Dépannage urgent',
    'devis': 'Demande de devis',
    'autre': 'Autre',
  };
  static const _urgences = {
    'urgent': 'Urgent (dans la journée)',
    'cette_semaine': 'Cette semaine',
    'flexible': 'Flexible',
  };
  static const _disponibilites = {
    'matin': 'Matin',
    'aprem': 'Après-midi',
    'soir': 'Soir',
    'indifferent': 'Indifférent',
  };

  @override
  void dispose() {
    _ctrlDescription.dispose();
    _ctrlTypeLibre.dispose();
    _ctrlAcces.dispose();
    super.dispose();
  }

  Future<void> _choisirPhotos() async {
    final picker = ImagePicker();
    final choix = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Prendre une photo'),
              onTap: () => Navigator.pop(ctx, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Depuis la galerie'),
              onTap: () => Navigator.pop(ctx, 'galerie'),
            ),
          ],
        ),
      ),
    );
    if (choix == null) return;
    if (choix == 'camera') {
      final photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1600,
        imageQuality: 80,
      );
      if (photo != null) setState(() => _photos.add(photo));
    } else {
      final images = await picker.pickMultiImage(
        maxWidth: 1600,
        imageQuality: 80,
        limit: 5,
      );
      if (images.isNotEmpty) setState(() => _photos.addAll(images.take(5)));
    }
  }

  /// Récupère la position GPS (demande la permission si besoin).
  /// Retourne null si refus ou service désactivé (avec message).
  Future<Position?> _obtenirPosition() async {
    final serviceActif = await Geolocator.isLocationServiceEnabled();
    if (!serviceActif) {
      _message('Activez la localisation (GPS) de votre téléphone.');
      return null;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _message('Autorisation de localisation refusée.');
      return null;
    }
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> _envoyer() async {
    if (!_cleFormulaire.currentState!.validate()) return;
    setState(() => _envoiEnCours = true);
    try {
      double? lat;
      double? lng;
      if (_envoyerPosition) {
        final pos = await _obtenirPosition();
        if (pos == null) {
          setState(() => _envoiEnCours = false);
          return; // le client décoche ou réessaie
        }
        lat = pos.latitude;
        lng = pos.longitude;
      }
      final repo = ref.read(prestationsRepositoryProvider);
      final demande = await repo.creer(
        artisanId: widget.artisanId,
        typeIntervention: _type,
        typeLibre: _type == 'autre' ? _ctrlTypeLibre.text.trim() : '',
        description: _ctrlDescription.text.trim(),
        urgence: _urgence,
        descriptionAcces: _ctrlAcces.text.trim(),
        disponibilitePreferee: _disponibilite,
        latitude: lat,
        longitude: lng,
      );
      // Photos : envoi après création, échec non bloquant.
      var photosEchouees = 0;
      for (var i = 0; i < _photos.length; i++) {
        try {
          await repo.ajouterPhoto(
            demande.id,
            cheminFichier: _photos[i].path,
            ordre: i,
          );
        } catch (_) {
          photosEchouees++;
        }
      }
      ref.invalidate(mesDemandesInterventionProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            photosEchouees == 0
                ? 'Demande ${demande.numero} envoyée.'
                : 'Demande ${demande.numero} envoyée ($photosEchouees photo(s) non transmise(s)).',
          ),
        ),
      );
      Navigator.of(context).pop(demande);
    } catch (_) {
      _message('Impossible d\'envoyer la demande. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intervention — ${widget.artisanNom}')),
      body: LayoutBuilder(
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
                    DropdownButtonFormField<String>(
                      initialValue: _type,
                      decoration: const InputDecoration(
                        labelText: 'Type d\'intervention',
                      ),
                      items: _types.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _type = v!),
                    ),
                    if (_type == 'autre') ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _ctrlTypeLibre,
                        decoration: const InputDecoration(
                          labelText: 'Précisez le type',
                        ),
                        maxLength: 200,
                        validator: (v) =>
                            _type == 'autre' && (v == null || v.trim().isEmpty)
                            ? 'Précisez le type d\'intervention.'
                            : null,
                      ),
                    ],
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlDescription,
                      decoration: const InputDecoration(
                        labelText: 'Description du problème',
                        hintText:
                            'Ex : fuite sous l\'évier de la cuisine depuis hier…',
                        alignLabelWithHint: true,
                      ),
                      minLines: 3,
                      maxLines: 6,
                      validator: (v) => v == null || v.trim().length < 10
                          ? 'Décrivez le problème (10 caractères minimum).'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _urgence,
                      decoration: const InputDecoration(labelText: 'Urgence'),
                      items: _urgences.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _urgence = v!),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _disponibilite,
                      decoration: const InputDecoration(
                        labelText: 'Disponibilité préférée',
                      ),
                      items: _disponibilites.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _disponibilite = v!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ctrlAcces,
                      decoration: const InputDecoration(
                        labelText: 'Comment trouver le lieu',
                        hintText:
                            'Quartier, repère, portail bleu, appeler en arrivant…',
                        alignLabelWithHint: true,
                      ),
                      minLines: 2,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      value: _envoyerPosition,
                      onChanged: (v) => setState(() => _envoyerPosition = v),
                      title: const Text(
                        'Envoyer ma position',
                        style: TextStyle(fontSize: 14),
                      ),
                      // subtitle: const Text(
                      //   'L\'artisan recevra votre position GPS.',
                      //   style: TextStyle(fontSize: 12),
                      // ),
                      secondary: const Icon(Icons.my_location, size: 16),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(height: 8),
                    // ── Photos ─────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Photos du problème (${_photos.length}/5)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _photos.length >= 5
                              ? null
                              : _choisirPhotos,
                          icon: const Icon(Icons.add_a_photo),
                          label: const Text('Ajouter'),
                        ),
                      ],
                    ),
                    if (_photos.isNotEmpty)
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _photos.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, i) => Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(_photos[i].path),
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _photos.removeAt(i)),
                                  child: const CircleAvatar(
                                    radius: 12,
                                    child: Icon(Icons.close, size: 14),
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
                  onPressed: _envoiEnCours ? null : _envoyer,
                  icon: _envoiEnCours
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: const Text('Envoyer la demande'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
