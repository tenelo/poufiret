import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/metier_domaine/utilisateur.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../geo/widgets/champ_departement.dart';
import '../../geo/widgets/champ_quartier.dart';
import '../../map/donnees/service_position.dart';
import '../donnees/livraison_providers.dart';

/// Position du demandeur par rapport a la course.
enum RoleDemandeur {
  envoie("C'est moi qui envois"),
  recoit('Je reçois la livraison'),
  pourAutrui('Je commande pour d\'autres personnes');

  const RoleDemandeur(this.libelle);
  final String libelle;
}

/// Formulaire de demande de course A -> B (Phase 2 livraison).
///
/// Selon le role du demandeur, le point ou il est partie prenante est
/// pre-rempli avec son compte (nom + telephone verrouilles) et sa position
/// GPS (captee automatiquement, obligatoire). L'autre point est saisi a la
/// main. En "pour autrui", aucun GPS.
class EcranCommande extends ConsumerStatefulWidget {
  const EcranCommande({super.key});

  @override
  ConsumerState<EcranCommande> createState() => _EcranCommandeState();
}

class _EcranCommandeState extends ConsumerState<EcranCommande> {
  final _formKey = GlobalKey<FormState>();
  final _service = ServicePosition();

  final _aQuartier = TextEditingController();
  final _aNom = TextEditingController();
  final _aTel = TextEditingController();
  final _bQuartier = TextEditingController();
  final _bNom = TextEditingController();
  final _bTel = TextEditingController();
  final _description = TextEditingController();

  RoleDemandeur _role = RoleDemandeur.envoie;
  int? _ville;
  double? _maLat, _maLng; // position du demandeur (cas 1 et 2)
  bool _posEnCours = false;
  bool _envoi = false;
  int _prix = 500; // derniere valeur connue du tarif (maj a chaque build, repli 500)

  @override
  void initState() {
    super.initState();
    final Utilisateur? u = ref.read(authProvider).whenOrNull(data: (u) => u);
    _ville = u?.departement;
    // Capture initiale : par defaut "C'est moi qui envois" (position requise).
    WidgetsBinding.instance.addPostFrameCallback((_) => _capterMaPosition());
  }

  @override
  void dispose() {
    for (final c in [
      _aQuartier,
      _aNom,
      _aTel,
      _bQuartier,
      _bNom,
      _bTel,
      _description,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _snack(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  void _snackAction(String m, String label, Future<void> Function() onTap) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(m),
        action: SnackBarAction(label: label, onPressed: () => onTap()),
      ),
    );
  }

  Future<void> _selectRole(RoleDemandeur r) async {
    setState(() {
      _role = r;
      _maLat = null;
      _maLng = null;
    });
    if (r != RoleDemandeur.pourAutrui) {
      await _capterMaPosition();
    }
  }

  Future<void> _capterMaPosition() async {
    if (_role == RoleDemandeur.pourAutrui) return;
    setState(() => _posEnCours = true);
    final res = await _service.positionActuelle();
    if (!mounted) return;
    setState(() => _posEnCours = false);
    switch (res) {
      case PositionObtenue(:final latitude, :final longitude):
        setState(() {
          _maLat = latitude;
          _maLng = longitude;
        });
      case ServiceDesactive():
        _snackAction(
          'Activez la localisation.',
          'Activer',
          _service.ouvrirParametresLocalisation,
        );
      case PermissionRefusee(:final definitif):
        if (definitif) {
          _snackAction(
            'Permission refusée. Ouvrez les réglages.',
            'Réglages',
            _service.ouvrirParametresApp,
          );
        } else {
          _snack('Position refusée. Elle est obligatoire pour ce cas.');
        }
      case ErreurPosition(:final message):
        _snack('Échec localisation : $message');
    }
  }

  Future<void> _envoyer() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_ville == null) {
      _snack('Choisissez la ville.');
      return;
    }
    final user = ref.read(authProvider).whenOrNull(data: (u) => u);
    if (user == null) {
      _snack('Connectez-vous pour demander une livraison.');
      return;
    }

    final estA = _role == RoleDemandeur.envoie;
    final estB = _role == RoleDemandeur.recoit;
    if ((estA || estB) && (_maLat == null || _maLng == null)) {
      _snack('Votre position est obligatoire pour ce cas.');
      return;
    }

    // Resolution nom/tel/gps par point selon le role.
    final aNom = estA ? user.nomComplet : _aNom.text.trim();
    final aTel = estA ? user.telephone : _aTel.text.trim();
    final bNom = estB ? user.nomComplet : _bNom.text.trim();
    final bTel = estB ? user.telephone : _bTel.text.trim();

    setState(() => _envoi = true);
    try {
      final res = await ref
          .read(livraisonRepositoryProvider)
          .creerCourse(
            ville: _ville!,
            aQuartier: _aQuartier.text.trim(),
            aNomContact: aNom,
            aTelephoneContact: aTel,
            aLatitude: estA ? _maLat : null,
            aLongitude: estA ? _maLng : null,
            bQuartier: _bQuartier.text.trim(),
            bNomContact: bNom,
            bTelephoneContact: bTel,
            bLatitude: estB ? _maLat : null,
            bLongitude: estB ? _maLng : null,
            descriptionColis: _description.text.trim(),
            prix: _prix,
          );
      if (!mounted) return;
      final msg = res.assigne
          ? 'Livreur trouvé ! Course ${res.course.numero} assignée.'
          : (res.message.isNotEmpty
                ? res.message
                : 'Aucun livreur disponible pour l\'instant.');
      _snack(msg);
      Navigator.of(context).pop(res.course);
    } catch (_) {
      if (!mounted) return;
      _snack('Échec de la demande. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  /// Encart position verrouillee pour le point du demandeur (cas 1 et 2).
  Widget _encartPosition() {
    final theme = Theme.of(context);
    final aPosition = _maLat != null && _maLng != null;
    if (_posEnCours) {
      return const Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text('Récupération de votre position…'),
        ],
      );
    }
    if (aPosition) {
      return Row(
        children: [
          Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          const Expanded(child: Text('Votre position est utilisée.')),
        ],
      );
    }
    return Row(
      children: [
        const Icon(Icons.location_off, size: 20),
        const SizedBox(width: 8),
        const Expanded(child: Text('Position indisponible.')),
        TextButton(
          onPressed: _capterMaPosition,
          child: const Text('Réessayer'),
        ),
      ],
    );
  }

  /// Ligne d'information verrouillee (affichage seul, non editable).
  Widget _champVerrouille({
    required IconData icone,
    required String libelle,
    required String valeur,
  }) {
    final theme = Theme.of(context);
    return InputDecorator(
      decoration: InputDecoration(
        labelText: libelle,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icone),
        suffixIcon: const Icon(Icons.lock_outline, size: 18),
        enabled: false,
      ),
      child: Text(valeur, style: theme.textTheme.bodyLarge),
    );
  }

  /// Point du demandeur : nom+tel verrouilles (compte), quartier editable,
  /// encart GPS obligatoire.
  Widget _blocMien({
    required String titre,
    required String sousTitre,
    required TextEditingController quartier,
    required Utilisateur user,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(titre, style: theme.textTheme.titleMedium),
            Text(sousTitre, style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            ChampQuartier(
              controller: quartier,
              departementId: _ville,
            ),
            const SizedBox(height: 12),
            _champVerrouille(
              icone: Icons.person_outline,
              libelle: 'Nom du contact',
              valeur: user.nomComplet,
            ),
            const SizedBox(height: 12),
            _champVerrouille(
              icone: Icons.phone_outlined,
              libelle: 'Téléphone du contact',
              valeur: user.telephone,
            ),
            const SizedBox(height: 12),
            _encartPosition(),
          ],
        ),
      ),
    );
  }

  /// Point saisi a la main : quartier + nom + telephone, sans GPS.
  Widget _blocManuel({
    required String titre,
    required String sousTitre,
    required TextEditingController quartier,
    required TextEditingController nom,
    required TextEditingController tel,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(titre, style: theme.textTheme.titleMedium),
            Text(sousTitre, style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            ChampQuartier(
              controller: quartier,
              departementId: _ville,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: nom,
              decoration: const InputDecoration(
                labelText: 'Nom du contact *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Nom du contact requis.'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: tel,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: 'Téléphone du contact *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
                counterText: '',
              ),
              validator: (v) {
                final t = (v ?? '').trim();
                if (t.isEmpty) return 'Téléphone requis.';
                if (t.length != 10) return '10 chiffres requis.';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tarif reactif : la derniere valeur du provider met _prix a jour
    // (repli 500 tant que ca charge ou en cas d'erreur). Reactif a une
    // invalidation du provider, sans quitter l'ecran.
    _prix = ref.watch(tarifCourseProvider).value ?? _prix;
    final user = ref.watch(authProvider).whenOrNull(data: (u) => u);
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Demander une livraison')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Connectez-vous pour demander une livraison.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final estA = _role == RoleDemandeur.envoie;
    final estB = _role == RoleDemandeur.recoit;

    final blocA = estA
        ? _blocMien(
            titre: 'Point de retrait (A)',
            sousTitre: 'Où récupérer le colis — c\'est vous',
            quartier: _aQuartier,
            user: user,
          )
        : _blocManuel(
            titre: 'Point de retrait (A)',
            sousTitre: 'Où récupérer le colis',
            quartier: _aQuartier,
            nom: _aNom,
            tel: _aTel,
          );

    final blocB = estB
        ? _blocMien(
            titre: 'Point de livraison (B)',
            sousTitre: 'Où livrer le colis — c\'est vous',
            quartier: _bQuartier,
            user: user,
          )
        : _blocManuel(
            titre: 'Point de livraison (B)',
            sousTitre: 'Où livrer le colis',
            quartier: _bQuartier,
            nom: _bNom,
            tel: _bTel,
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Demander une livraison')),
      body: LayoutBuilder(
        builder: (context, _) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                              child: Text(
                                'Où êtes-vous ?',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            RadioGroup<RoleDemandeur>(
                              groupValue: _role,
                              onChanged: (v) {
                                if (v != null) _selectRole(v);
                              },
                              child: Column(
                                children: [
                                  for (final r in RoleDemandeur.values)
                                    RadioListTile<RoleDemandeur>(
                                      value: r,
                                      title: Text(r.libelle),
                                      dense: true,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ChampDepartement(
                      valeur: _ville,
                      onChange: (v) => setState(() => _ville = v),
                      libelle: 'Ville',
                      obligatoire: true,
                    ),
                    const SizedBox(height: 16),
                    blocA,
                    const SizedBox(height: 16),
                    blocB,
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _description,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: 'Description du colis (optionnel)',
                        hintText: 'Ex : pain, pagne, chaussures',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory_2_outlined),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _champVerrouille(
                      icone: Icons.payments_outlined,
                      libelle: 'Prix de la livraison',
                      valeur: '$_prix FCFA',
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _envoi ? null : _envoyer,
                      icon: _envoi
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              //local_shipping_outlined
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.two_wheeler_outlined),
                      label: Text(_envoi ? 'Envoi…' : 'Demander la livraison'),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
