import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/livraison_providers.dart';
import '../data/marqueur_icone.dart';
import '../data/position_socket.dart';
import '../../map/data/map_providers.dart';
import '../../map/data/service_position.dart';
import '../../../core/network/providers.dart';
import '../domain/livraison_models.dart';

const _ordreStatuts = [
  'demandee',
  'assignee',
  'acceptee',
  'vers_a',
  'colis_pris',
  'vers_b',
  'livree',
];

const _libelleStatut = {
  'demandee': 'Demande envoyée',
  'assignee': 'Livreur assigné',
  'acceptee': 'Course acceptée',
  'vers_a': 'En route vers le retrait',
  'colis_pris': 'Colis récupéré',
  'vers_b': 'En route vers la livraison',
  'livree': 'Livrée',
};

/// Suivi d'une course : timeline des etats + carte (A, B, moto du livreur).
///
/// Phase 2 : la position du livreur est rafraichie par POLLING (10 s) via
/// /livreurs/proches/ (option a, pas d'ajout backend). Le temps reel continu
/// (WebSocket) viendra en Phase 4. La carte s'affiche des qu'un point a un GPS.
class EcranSuivi extends ConsumerStatefulWidget {
  const EcranSuivi({super.key, required this.courseId, this.courseInitiale});

  final String courseId;
  final Course? courseInitiale;

  @override
  ConsumerState<EcranSuivi> createState() => _EcranSuiviState();
}

class _EcranSuiviState extends ConsumerState<EcranSuivi> {
  static const _terminaux = {'livree', 'annulee', 'refusee'};

  Timer? _timer;
  Course? _course;
  BitmapDescriptor? _iconeStandard;
  BitmapDescriptor? _iconeTerminee;
  bool _iconeDemandee = false;
  LatLng? _posLivreur;
  GoogleMapController? _controller;
  bool _annulation = false;
  PositionSocket? _positionSocket;
  StreamSubscription<Position>? _fluxPosition;
  bool _emissionDemarree = false;
  bool _positionDeposee = false;
  bool _depotEnCours = false;

  @override
  void initState() {
    super.initState();
    _course = widget.courseInitiale;
    _chargerIconeMoto();
    _poll();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _poll());
    _connecterPosition();
  }

  void _connecterPosition() {
    final socket = PositionSocket(
      courseId: widget.courseId,
      tokens: ref.read(tokenStorageProvider),
    );
    _positionSocket = socket;
    socket.positions.listen((p) {
      if (!mounted) return;
      setState(() => _posLivreur = LatLng(p.latitude, p.longitude));
      _ajusterCamera();
    });
    socket.connecter();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_iconeDemandee) {
      _iconeDemandee = true;
      _chargerIconeMoto();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fluxPosition?.cancel();
    _positionSocket?.fermer();
    super.dispose();
  }

  void _demarrerEmissionPosition() {
    _emissionDemarree = true;
    // Emet la position du livreur a chaque deplacement de ~10 m.
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    _fluxPosition = Geolocator.getPositionStream(locationSettings: settings)
        .listen((pos) {
          _positionSocket?.envoyerPosition(pos.latitude, pos.longitude);
        });
  }

  void _arreterEmissionPosition() {
    _fluxPosition?.cancel();
    _fluxPosition = null;
  }

  Future<void> _deposerPosition() async {
    if (_depotEnCours) return;
    setState(() => _depotEnCours = true);
    final messenger = ScaffoldMessenger.of(context);
    final res = await ref.read(servicePositionProvider).positionActuelle();
    if (!mounted) return;
    switch (res) {
      case PositionObtenue(:final latitude, :final longitude):
        try {
          await ref
              .read(livraisonRepositoryProvider)
              .deposerPositionContact(
                courseId: widget.courseId,
                latitude: latitude,
                longitude: longitude,
              );
          if (!mounted) return;
          setState(() => _positionDeposee = true);
          messenger.showSnackBar(
            const SnackBar(content: Text('Localisation envoyée.')),
          );
        } catch (_) {
          messenger.showSnackBar(
            const SnackBar(content: Text('Échec de l\'envoi. Réessayez.')),
          );
        }
      case ServiceDesactive():
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Activez la localisation (GPS) de votre téléphone.'),
          ),
        );
        await ref.read(servicePositionProvider).ouvrirParametresLocalisation();
      case PermissionRefusee(:final definitif):
        if (definitif) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text('Permission refusée. Ouvrez les réglages.'),
            ),
          );
          await ref.read(servicePositionProvider).ouvrirParametresApp();
        } else {
          messenger.showSnackBar(
            const SnackBar(
              content: Text('La position est nécessaire pour être localisé.'),
            ),
          );
        }
      case ErreurPosition(:final message):
        messenger.showSnackBar(
          SnackBar(content: Text('Erreur GPS : $message')),
        );
    }
    if (mounted) setState(() => _depotEnCours = false);
  }

  Widget _blocPositionDestinataire(Course c) {
    if (!c.jeSuisDestinataire) return const SizedBox.shrink();
    final envoyee = _positionDeposee || c.positionBDeposee;
    if (envoyee) {
      return Card(
        color: Colors.green.withValues(alpha: 0.12),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 12),
              Expanded(child: Text('Localisation envoyée.')),
            ],
          ),
        ),
      );
    }
    return FilledButton.icon(
      onPressed: _depotEnCours ? null : _deposerPosition,
      icon: _depotEnCours
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.my_location),
      label: Text(_depotEnCours ? 'Envoi…' : 'Déposer ma localisation'),
    );
  }

  Future<void> _chargerIconeMoto() async {
    // Icones du marqueur livreur : uniquement les PNG definis dans l'admin.
    try {
      // Taille adaptee a la densite d'ecran pour un rendu net partout.
      final dpr = MediaQuery.of(context).devicePixelRatio;
      final taille = (30 * dpr).round().clamp(60, 180);
      final urls = await ref.read(livraisonRepositoryProvider).iconesMotard();
      BitmapDescriptor? std;
      BitmapDescriptor? term;
      if (urls.standard != null) {
        std = await bitmapDepuisUrl(urls.standard!, taille: taille);
      }
      if (urls.terminee != null) {
        term = await bitmapDepuisUrl(urls.terminee!, taille: taille);
      }
      if (!mounted) return;
      setState(() {
        _iconeStandard = std;
        _iconeTerminee = term;
      });
    } catch (_) {
      // Pas d'icone : le marqueur livreur n'apparaitra pas tant que
      // le PNG n'est pas disponible (choix assume : aucune icone de repli).
    }
  }

  Future<void> _poll() async {
    final repo = ref.read(livraisonRepositoryProvider);
    try {
      final c = await repo.courseDetail(widget.courseId);
      if (!mounted) return;
      final lp = c.livreurPosition;
      setState(() {
        _course = c;
        _posLivreur =
            (lp != null && lp.latitude != null && lp.longitude != null)
            ? LatLng(lp.latitude!, lp.longitude!)
            : null;
      });
      if (_terminaux.contains(c.statut)) {
        _timer?.cancel();
        _arreterEmissionPosition();
      } else if (c.jeSuisLivreur && !_emissionDemarree) {
        _demarrerEmissionPosition();
      }
      // Destinataire : depot automatique de la position a l'ouverture.
      if (c.jeSuisDestinataire &&
          !c.positionBDeposee &&
          !_positionDeposee &&
          !_depotEnCours) {
        _deposerPosition();
      }
      _ajusterCamera();
    } catch (_) {
      // Poll silencieux : on conserve le dernier etat connu.
    }
  }

  LatLng? _pt(GpsPoint? g) {
    if (g?.latitude != null && g?.longitude != null) {
      return LatLng(g!.latitude!, g.longitude!);
    }
    return null;
  }

  LatLng? get _posA => _pt(_course?.pointA.gps);
  LatLng? get _posB => _pt(_course?.pointB.gps);

  Set<Marker> _marqueurs() {
    final m = <Marker>{};
    final a = _posA;
    if (a != null) {
      m.add(
        Marker(
          markerId: const MarkerId('A'),
          position: a,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: 'Retrait (A)',
            snippet: _course?.pointA.quartier,
          ),
        ),
      );
    }
    final b = _posB;
    if (b != null) {
      m.add(
        Marker(
          markerId: const MarkerId('B'),
          position: b,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: 'Livraison (B)',
            snippet: _course?.pointB.quartier,
          ),
        ),
      );
    }
    final iconeLivreur = _course?.statut == 'livree'
        ? _iconeTerminee
        : _iconeStandard;
    if (_posLivreur != null && iconeLivreur != null) {
      m.add(
        Marker(
          markerId: const MarkerId('livreur'),
          position: _posLivreur!,
          icon: iconeLivreur,
          infoWindow: const InfoWindow(title: 'Livreur'),
        ),
      );
    }
    return m;
  }

  void _ajusterCamera() {
    final ctrl = _controller;
    if (ctrl == null) return;
    final pts = [_posA, _posB, _posLivreur].whereType<LatLng>().toList();
    if (pts.isEmpty) return;
    if (pts.length == 1) {
      ctrl.animateCamera(CameraUpdate.newLatLngZoom(pts.first, 14));
      return;
    }
    var minLat = pts.first.latitude, maxLat = pts.first.latitude;
    var minLng = pts.first.longitude, maxLng = pts.first.longitude;
    for (final p in pts) {
      minLat = p.latitude < minLat ? p.latitude : minLat;
      maxLat = p.latitude > maxLat ? p.latitude : maxLat;
      minLng = p.longitude < minLng ? p.longitude : minLng;
      maxLng = p.longitude > maxLng ? p.longitude : maxLng;
    }
    ctrl.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        60,
      ),
    );
  }

  bool get _peutAnnuler {
    final s = _course?.statut;
    return s == 'demandee' ||
        s == 'assignee' ||
        s == 'acceptee' ||
        s == 'vers_a';
  }

  Future<void> _annuler() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Annuler la course ?'),
        content: const Text('Cette action est définitive.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Non'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _annulation = true);
    try {
      final c = await ref
          .read(livraisonRepositoryProvider)
          .transition(courseId: widget.courseId, statut: 'annulee');
      if (!mounted) return;
      setState(() => _course = c);
      _timer?.cancel();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Échec de l\'annulation.')));
    } finally {
      if (mounted) setState(() => _annulation = false);
    }
  }

  Future<void> _appeler(String numero) async {
    if (numero.trim().isEmpty) return;
    try {
      await launchUrl(Uri(scheme: 'tel', path: numero.trim()));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de lancer l\'appel.')),
      );
    }
  }

  Widget _enteteStatut(Course c) {
    final theme = Theme.of(context);
    late final Color couleur;
    late final IconData icone;
    late final String texte;
    switch (c.statut) {
      case 'livree':
        couleur = Colors.green;
        icone = Icons.check_circle;
        texte = 'Livrée';
      case 'annulee':
        couleur = theme.colorScheme.error;
        icone = Icons.cancel;
        texte = 'Course annulée';
      case 'refusee':
        couleur = theme.colorScheme.error;
        icone = Icons.block;
        texte = 'Refusée par le livreur';
      default:
        couleur = theme.colorScheme.primary;
        icone = Icons.two_wheeler;
        texte = _libelleStatut[c.statut] ?? c.statut;
    }
    return Row(
      children: [
        Icon(icone, color: couleur, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            texte,
            style: theme.textTheme.titleMedium?.copyWith(
              color: couleur,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeline(Course c) {
    final theme = Theme.of(context);
    final idxCourant = _ordreStatuts.indexOf(c.statut);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < _ordreStatuts.length; i++)
          _etape(i, idxCourant, theme),
      ],
    );
  }

  Widget _etape(int i, int courant, ThemeData theme) {
    final atteint = courant >= 0 && i <= courant;
    final actif = i == courant;
    final couleur = atteint ? theme.colorScheme.primary : theme.dividerColor;
    final dernier = i == _ordreStatuts.length - 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              atteint ? Icons.check_circle : Icons.radio_button_unchecked,
              color: couleur,
              size: 22,
            ),
            if (!dernier) Container(width: 2, height: 22, color: couleur),
          ],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 1, bottom: 10),
          child: Text(
            _libelleStatut[_ordreStatuts[i]] ?? _ordreStatuts[i],
            style: actif
                ? theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : theme.textTheme.bodyMedium?.copyWith(
                    color: atteint ? null : theme.disabledColor,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _ligneContact(String titre, String nom, String tel) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.person_pin_circle_outlined),
      title: Text('$titre — $nom'),
      subtitle: Text(tel.isEmpty ? 'Pas de numéro' : tel),
      trailing: tel.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.call),
              onPressed: () => _appeler(tel),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = _course;
    final aGps = _posA != null || _posB != null || _posLivreur != null;
    return Scaffold(
      appBar: AppBar(title: Text(c?.numero ?? 'Suivi')),
      body: c == null
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, _) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (aGps)
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => _CartePleinEcran(
                                posA: _posA,
                                posB: _posB,
                                posLivreur: _posLivreur,
                                quartierA: c.pointA.quartier,
                                quartierB: c.pointB.quartier,
                                titre: c.numero,
                                iconeLivreur: c.statut == 'livree'
                                    ? _iconeTerminee
                                    : _iconeStandard,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 300,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: _posB ?? _posA ?? _posLivreur!,
                                  zoom: 14,
                                ),
                                markers: _marqueurs(),
                                zoomControlsEnabled: true,
                                zoomGesturesEnabled: true,
                                myLocationEnabled: false,
                                myLocationButtonEnabled: false,
                                onMapCreated: (ctrl) {
                                  _controller = ctrl;
                                  _ajusterCamera();
                                },
                              ),
                            ),
                          ),
                        ),
                      if (aGps) const SizedBox(height: 16),
                      _enteteStatut(c),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _timeline(c),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _blocPositionDestinataire(c),
                      if (c.jeSuisDestinataire) const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Column(
                            children: [
                              _ligneContact(
                                'Expédié par',
                                c.pointA.nomContact,
                                c.pointA.telephoneContact,
                              ),
                              const Divider(height: 1),
                              _ligneContact(
                                'A remettre à',
                                c.pointB.nomContact,
                                c.pointB.telephoneContact,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (c.descriptionColis.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Colis : ${c.descriptionColis}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (_peutAnnuler)
                        OutlinedButton.icon(
                          onPressed: _annulation ? null : _annuler,
                          icon: const Icon(Icons.cancel_outlined),
                          label: Text(
                            _annulation ? 'Annulation…' : 'Annuler la course',
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

/// Carte en plein ecran : suivi detaille (A, B, moto), zoom complet.
class _CartePleinEcran extends StatefulWidget {
  const _CartePleinEcran({
    required this.posA,
    required this.posB,
    required this.posLivreur,
    required this.quartierA,
    required this.quartierB,
    required this.titre,
    required this.iconeLivreur,
  });

  final BitmapDescriptor? iconeLivreur;
  final LatLng? posA;
  final LatLng? posB;
  final LatLng? posLivreur;
  final String quartierA;
  final String quartierB;
  final String titre;

  @override
  State<_CartePleinEcran> createState() => _CartePleinEcranState();
}

class _CartePleinEcranState extends State<_CartePleinEcran> {
  GoogleMapController? _controller;

  Set<Marker> _marqueurs() {
    final m = <Marker>{};
    if (widget.posA != null) {
      m.add(
        Marker(
          markerId: const MarkerId('A'),
          position: widget.posA!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: 'Retrait (A)',
            snippet: widget.quartierA,
          ),
        ),
      );
    }
    if (widget.posB != null) {
      m.add(
        Marker(
          markerId: const MarkerId('B'),
          position: widget.posB!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: 'Livraison (B)',
            snippet: widget.quartierB,
          ),
        ),
      );
    }
    if (widget.posLivreur != null && widget.iconeLivreur != null) {
      m.add(
        Marker(
          markerId: const MarkerId('livreur'),
          position: widget.posLivreur!,
          icon: widget.iconeLivreur!,
          infoWindow: const InfoWindow(title: 'Livreur'),
        ),
      );
    }
    return m;
  }

  void _ajusterCamera() {
    final ctrl = _controller;
    if (ctrl == null) return;
    final pts = [
      widget.posA,
      widget.posB,
      widget.posLivreur,
    ].whereType<LatLng>().toList();
    if (pts.isEmpty) return;
    if (pts.length == 1) {
      ctrl.animateCamera(CameraUpdate.newLatLngZoom(pts.first, 15));
      return;
    }
    var minLat = pts.first.latitude, maxLat = pts.first.latitude;
    var minLng = pts.first.longitude, maxLng = pts.first.longitude;
    for (final p in pts) {
      minLat = p.latitude < minLat ? p.latitude : minLat;
      maxLat = p.latitude > maxLat ? p.latitude : maxLat;
      minLng = p.longitude < minLng ? p.longitude : minLng;
      maxLng = p.longitude > maxLng ? p.longitude : maxLng;
    }
    ctrl.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final premier = widget.posB ?? widget.posA ?? widget.posLivreur;
    return Scaffold(
      appBar: AppBar(title: Text(widget.titre)),
      body: premier == null
          ? const Center(child: Text('Aucune position à afficher.'))
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: premier, zoom: 14),
              markers: _marqueurs(),
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (ctrl) {
                _controller = ctrl;
                _ajusterCamera();
              },
            ),
    );
  }
}
