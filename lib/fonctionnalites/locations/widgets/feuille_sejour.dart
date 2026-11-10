import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/disponibilites.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/sejour.dart';
import '../metier_domaine/vehicule_models.dart' show jourSeul;
import 'feuille_reservation_hebergement.dart' show Compteur;

/// Choix fait dans la feuille : un séjour, ou « Passer » ([sejour] null :
/// la liste complète, sans filtre).
class ChoixSejour {
  const ChoixSejour(this.sejour);

  final Sejour? sejour;
}

/// Ouvre la feuille « dates et voyageurs » avant la liste des hébergements.
/// Null si elle est fermée sans choix.
Future<ChoixSejour?> choisirSejour(
  BuildContext context, {
  required List<HebergementResume> hebergements,
  Sejour? initial,
}) => showModalBottomSheet<ChoixSejour>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  constraints: const BoxConstraints(maxWidth: 700),
  builder: (_) => FeuilleSejour(hebergements: hebergements, initial: initial),
);

/// Vrai si l'hébergement est complet sur [arrivee, départ[ (endpoint
/// `disponibilites`). Lecture impossible : traité comme disponible, le
/// serveur tranchera à la réservation.
final completSejourProvider = FutureProvider.autoDispose
    .family<bool, (int, DateTime, DateTime)>((ref, cle) async {
      final (id, arrivee, depart) = cle;
      final repo = ref.watch(locationsRepositoryProvider);
      final dispos = await Disponibilites.ouAucune(
        () => repo.disponibilites(
          hebergement: true,
          id: id,
          du: arrivee,
          au: depart,
        ),
      );
      return dispos.erreurPlage(arrivee, depart) != null;
    });

/// Feuille « Vos dates » : arrivée et départ (calendrier, jours où tout est
/// complet grisés), adultes, enfants ; « Voir les disponibilités » ou
/// « Passer ».
class FeuilleSejour extends ConsumerStatefulWidget {
  const FeuilleSejour({super.key, required this.hebergements, this.initial});

  final List<HebergementResume> hebergements;
  final Sejour? initial;

  @override
  ConsumerState<FeuilleSejour> createState() => _FeuilleSejourState();
}

class _FeuilleSejourState extends ConsumerState<FeuilleSejour> {
  late DateTimeRange? _plage = widget.initial == null
      ? null
      : DateTimeRange(
          start: widget.initial!.arrivee,
          end: widget.initial!.depart,
        );
  late int _adultes = widget.initial?.adultes ?? 1;
  late int _enfants = widget.initial?.enfants ?? 0;
  bool _datesManquantes = false;
  String? _erreurDates;

  /// Jours où TOUS les hébergements sont complets (chargés à la première
  /// ouverture du calendrier).
  Disponibilites? _dispos;
  bool _chargement = false;

  Future<Disponibilites> _disponibilites() async {
    final connues = _dispos;
    if (connues != null) return connues;
    setState(() => _chargement = true);
    final aujourdhui = jourSeul(DateTime.now());
    final fin = aujourdhui.add(const Duration(days: 180));
    final repo = ref.read(locationsRepositoryProvider);
    final toutes = await Future.wait([
      for (final h in widget.hebergements)
        Disponibilites.ouAucune(
          () => repo.disponibilites(
            hebergement: true,
            id: h.id,
            du: aujourdhui,
            au: fin,
          ),
        ),
    ]);
    // Un jour n'est grisé que si plus aucun hébergement n'est libre.
    Set<DateTime>? complets;
    for (final d in toutes) {
      complets = complets == null
          ? {...d.joursComplets}
          : complets.intersection(d.joursComplets);
    }
    final dispos = Disponibilites(joursComplets: complets ?? const {});
    if (mounted) {
      setState(() {
        _dispos = dispos;
        _chargement = false;
      });
    }
    return dispos;
  }

  Future<void> _choisirDates() async {
    if (_chargement) return;
    final dispos = await _disponibilites();
    if (!mounted) return;
    final aujourdhui = jourSeul(DateTime.now());
    final dernier = aujourdhui.add(const Duration(days: 365));
    final actuelle = _plage;
    final plage = await showDateRangePicker(
      context: context,
      firstDate: aujourdhui,
      lastDate: dernier,
      initialDateRange:
          actuelle != null &&
              !actuelle.start.isBefore(aujourdhui) &&
              !actuelle.end.isAfter(dernier) &&
              dispos.erreurPlage(actuelle.start, actuelle.end) == null
          ? actuelle
          : null,
      selectableDayPredicate: (jour, debut, fin) =>
          dispos.selectionnable(jour, debut, fin),
      helpText: 'Arrivée et départ',
      fieldStartLabelText: 'Arrivée',
      fieldEndLabelText: 'Départ',
    );
    if (plage == null || !mounted) return;
    final refus = dispos.erreurPlage(plage.start, plage.end);
    final memeJour = !plage.end.isAfter(plage.start);
    setState(() {
      _plage = refus == null && !memeJour ? plage : null;
      _erreurDates =
          refus ?? (memeJour ? 'Choisissez au moins une nuit.' : null);
      _datesManquantes = false;
    });
  }

  void _voir() {
    final plage = _plage;
    if (plage == null) {
      setState(() => _datesManquantes = true);
      return;
    }
    Navigator.pop(
      context,
      ChoixSejour(
        Sejour(
          arrivee: jourSeul(plage.start),
          depart: jourSeul(plage.end),
          adultes: _adultes,
          enfants: _enfants,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plage = _plage;
    final libelleDates = plage == null
        ? 'Choisir les dates'
        : Sejour(arrivee: plage.start, depart: plage.end).libelleDates;
    final erreur =
        _erreurDates ??
        (_datesManquantes
            ? 'Choisissez vos dates d\'arrivée et de départ.'
            : null);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Vos dates', style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Pour voir ce qui est libre pendant votre séjour.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Config.couleurTexteSecondaire,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            key: const ValueKey('dates-sejour'),
            onPressed: _choisirDates,
            icon: _chargement
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.date_range_outlined),
            label: Text(libelleDates),
          ),
          if (erreur != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                erreur,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Compteur(
            libelle: 'Adultes',
            valeur: _adultes,
            min: 1,
            max: 20,
            onChanged: (v) => setState(() => _adultes = v),
          ),
          Compteur(
            libelle: 'Enfants',
            valeur: _enfants,
            min: 0,
            max: 20,
            onChanged: (v) => setState(() => _enfants = v),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _voir,
            child: const Text('Voir les disponibilités'),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () => Navigator.pop(context, const ChoixSejour(null)),
            child: const Text('Passer'),
          ),
        ],
      ),
    );
  }
}

/// Rappel du séjour cherché, en haut de la liste : dates, voyageurs et
/// « Modifier ».
class RappelSejour extends StatelessWidget {
  const RappelSejour({
    super.key,
    required this.sejour,
    required this.onModifier,
  });

  final Sejour sejour;
  final VoidCallback onModifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: Material(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
          child: Row(
            children: [
              Icon(
                Icons.event_available_outlined,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sejour.libelleDates,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      sejour.libelleVoyageurs,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: onModifier, child: const Text('Modifier')),
            ],
          ),
        ),
      ),
    );
  }
}
