import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../map/donnees/map_providers.dart';
import '../../map/donnees/service_position.dart';
import '../donnees/espace_partenaire_providers.dart';
import '../../../global/widgets/image_reseau.dart';

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
      Notificateur.succes(context, 'Vitrine mise à jour.');
    } on ApiException catch (e) {
      if (mounted) Notificateur.erreur(context, e.messageLisible);
    } catch (_) {
      if (mounted) {
        Notificateur.erreur(context, 'Enregistrement impossible. Réessayez.');
      }
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
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

                  _SectionLocalisation(
                    latitude: (p['latitude'] as num?)?.toDouble(),
                    longitude: (p['longitude'] as num?)?.toDouble(),
                  ),
                  const SizedBox(height: 20),

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

/// Section « Localisation (point GPS) » du profil partenaire.
///
/// Independante du formulaire textuel : elle envoie ses propres PATCH
/// (latitude+longitude ensemble, jamais un seul) sans toucher aux autres
/// champs du profil (le PATCH backend est partiel).
class _SectionLocalisation extends ConsumerStatefulWidget {
  const _SectionLocalisation({this.latitude, this.longitude});
  final double? latitude;
  final double? longitude;

  @override
  ConsumerState<_SectionLocalisation> createState() =>
      _SectionLocalisationState();
}

class _SectionLocalisationState extends ConsumerState<_SectionLocalisation> {
  late double? _lat = widget.latitude;
  late double? _lng = widget.longitude;
  bool _envoi = false;
  bool _localisationEnCours = false;
  GoogleMapController? _controller;

  bool get _aUnPoint => _lat != null && _lng != null;
  bool get _modifie => _lat != widget.latitude || _lng != widget.longitude;

  String _messageErreur(Object e) {
    if (e is DioException && e.error is ApiException) {
      return (e.error as ApiException).messageLisible;
    }
    if (e is ApiException) return e.messageLisible;
    return 'Enregistrement impossible. Réessayez.';
  }

  /// Utilise la mecanique GPS partagee (TeneLivr) : permission + service.
  /// Ne fait que mettre a jour le marqueur/les coordonnees localement ;
  /// l'enregistrement se fait via le bouton dedie.
  Future<void> _utiliserPositionActuelle() async {
    if (_localisationEnCours) return;
    setState(() => _localisationEnCours = true);
    final res = await ref.read(servicePositionProvider).positionActuelle();
    if (!mounted) return;
    setState(() => _localisationEnCours = false);

    switch (res) {
      case PositionObtenue(:final latitude, :final longitude):
        setState(() {
          _lat = latitude;
          _lng = longitude;
        });
        if (_controller != null) {
          _controller!.animateCamera(
            CameraUpdate.newLatLng(LatLng(latitude, longitude)),
          );
        }
      case ServiceDesactive():
        Notificateur.avertissement(
            context, 'Activez la localisation (GPS) de votre téléphone.');
      case PermissionRefusee(:final definitif):
        Notificateur.avertissement(
          context,
          definitif
              ? 'Permission de localisation refusée. Ouvrez les réglages '
                  'pour l\'autoriser.'
              : 'Autorisez la localisation pour définir le point GPS de '
                  'votre commerce.',
        );
      case ErreurPosition(:final message):
        Notificateur.avertissement(context, 'Position indisponible : $message');
    }
  }

  /// Ajustement fin : deplace le marqueur au point tape sur la carte.
  void _ajusterPoint(LatLng point) {
    setState(() {
      _lat = point.latitude;
      _lng = point.longitude;
    });
  }

  Future<void> _enregistrerPoint() async {
    await _envoyer(_lat, _lng);
  }

  Future<void> _retirerPoint() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Retirer le point GPS de votre commerce ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Retirer'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _envoyer(null, null);
  }

  /// Envoie TOUJOURS latitude et longitude ensemble (jamais un seul), pour
  /// respecter le contrat backend (un seul des deux -> 400).
  Future<void> _envoyer(double? lat, double? lng) async {
    if (_envoi) return;
    setState(() => _envoi = true);
    try {
      await ref.read(espacePartenaireRepositoryProvider).modifierProfil({
        'latitude': lat,
        'longitude': lng,
      });
      ref.invalidate(monProfilPartenaireProvider);
      if (!mounted) return;
      setState(() {
        _lat = lat;
        _lng = lng;
      });
      Notificateur.succes(
        context,
        lat == null ? 'Point GPS retiré.' : 'Point GPS enregistré.',
      );
    } catch (e) {
      if (mounted) Notificateur.erreur(context, _messageErreur(e));
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.place_outlined, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Localisation (point GPS)',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Ce point precis aide les clients a vous trouver sur la carte.',
              style: TextStyle(
                fontSize: 12,
                color: Config.couleurTexteSecondaire,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _aUnPoint
                  ? '${_lat!.toStringAsFixed(5)}, ${_lng!.toStringAsFixed(5)}'
                  : 'Non renseigné',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            if (_aUnPoint) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_lat!, _lng!),
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('commerce'),
                        position: LatLng(_lat!, _lng!),
                      ),
                    },
                    onMapCreated: (c) => _controller = c,
                    onTap: _ajusterPoint,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Touchez la carte pour ajuster précisément l\'emplacement.',
                style: TextStyle(
                  fontSize: 11,
                  color: Config.couleurTexteSecondaire,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _localisationEnCours
                      ? null
                      : _utiliserPositionActuelle,
                  icon: _localisationEnCours
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location, size: 18),
                  label: const Text('Utiliser ma position actuelle'),
                ),
                if (_aUnPoint)
                  OutlinedButton.icon(
                    onPressed: _envoi ? null : _retirerPoint,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Config.couleurErreur,
                      side: const BorderSide(color: Config.couleurErreur),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Retirer le point GPS'),
                  ),
              ],
            ),
            if (_modifie) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _envoi ? null : _enregistrerPoint,
                  icon: _envoi
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(_envoi ? 'Enregistrement…' : 'Enregistrer le point'),
                ),
              ),
            ],
          ],
        ),
      ),
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
