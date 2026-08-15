import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../map/data/service_position.dart';
import '../data/livraison_providers.dart';
import '../domain/livraison_models.dart';

/// Depot de position du destinataire (Option A : bouton GPS simple).
///
/// Le destinataire pose sa position reelle sur SON point (B) pour que le
/// livreur le trouve. Reutilise ServicePosition (permission + service + GPS).
/// N'affecte pas le statut de la course (endpoint dedie position-contact).
class EcranDeposerPosition extends ConsumerStatefulWidget {
  const EcranDeposerPosition({super.key, required this.course});

  final Course course;

  @override
  ConsumerState<EcranDeposerPosition> createState() =>
      _EcranDeposerPositionState();
}

class _EcranDeposerPositionState extends ConsumerState<EcranDeposerPosition> {
  final _service = ServicePosition();
  bool _envoi = false;
  bool _depose = false;

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _deposer() async {
    setState(() => _envoi = true);
    final res = await _service.positionActuelle();
    if (!mounted) return;

    switch (res) {
      case PositionObtenue(:final latitude, :final longitude):
        try {
          await ref.read(livraisonRepositoryProvider).deposerPositionContact(
                courseId: widget.course.id,
                latitude: latitude,
                longitude: longitude,
              );
          if (!mounted) return;
          setState(() => _depose = true);
          // Rafraichit les surfaces qui affichent cette course.
          ref.invalidate(coursesRecuesProvider);
          ref.invalidate(courseDetailProvider(id: widget.course.id));
          _snack('Position enregistrée. Le livreur pourra vous localiser.');
        } catch (_) {
          _snack('Échec de l\'envoi. Réessayez.');
        }
      case ServiceDesactive():
        _snack('Activez la localisation (GPS) de votre téléphone.');
        await _service.ouvrirParametresLocalisation();
      case PermissionRefusee(:final definitif):
        if (definitif) {
          _snack('Permission refusée. Ouvrez les réglages pour l\'autoriser.');
          await _service.ouvrirParametresApp();
        } else {
          _snack('La position est nécessaire pour être localisé.');
        }
      case ErreurPosition(:final message):
        _snack('Erreur GPS : $message');
    }

    if (mounted) setState(() => _envoi = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = widget.course;

    return Scaffold(
      appBar: AppBar(title: const Text('Déposer ma position')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Colis ${c.numero}',
                          style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Destination : ${c.pointB.quartier}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Posez votre position actuelle pour que le livreur '
                'vous trouve facilement.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              if (_depose)
                Card(
                  color: Colors.green.withValues(alpha: 0.12),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text('Localisation envoyée. '
                              'Le livreur pourra vous localiser.'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                FilledButton.icon(
                  onPressed: _envoi ? null : _deposer,
                  icon: _envoi
                      ? const SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.my_location),
                  label: Text(_envoi
                      ? 'Envoi…'
                      : 'Utiliser ma position actuelle'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
