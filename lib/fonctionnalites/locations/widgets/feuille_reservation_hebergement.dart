import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart' show jourSeul;
import 'elements_fiche.dart';

/// « Réserver » un hébergement. Un visiteur non inscrit est invité à créer
/// un compte (mur d'inscription) ; sinon la feuille s'ouvre.
void reserverHebergement(
  BuildContext context,
  WidgetRef ref, {
  required Hebergement hebergement,
}) {
  murInscription(context, ref, () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) => FeuilleReservationHebergement(hebergement: hebergement),
    );
  });
}

/// Feuille de réservation d'un séjour : arrivée et départ (nuits, durée
/// minimale), voyageurs et chambres plafonnés par la capacité, disponibilité
/// vérifiée sur les dates, montant estimé en direct.
class FeuilleReservationHebergement extends ConsumerStatefulWidget {
  const FeuilleReservationHebergement({
    super.key,
    required this.hebergement,
    this.plageInitiale,
  });

  final Hebergement hebergement;

  /// Séjour déjà choisi à l'ouverture (sinon le client le choisit).
  final DateTimeRange? plageInitiale;

  @override
  ConsumerState<FeuilleReservationHebergement> createState() =>
      _FeuilleReservationHebergementState();
}

class _FeuilleReservationHebergementState
    extends ConsumerState<FeuilleReservationHebergement> {
  final _cle = GlobalKey<FormState>();
  late final _telephone = TextEditingController(
    text: ref.read(authProvider).value?.telephone ?? '',
  );
  final _message = TextEditingController();
  late DateTimeRange? _plage = widget.plageInitiale;
  int _adultes = 1;
  int _enfants = 0;
  int _unites = 1;
  bool _datesManquantes = false;
  bool _envoi = false;

  /// Refus du serveur (complet, durée minimale...), affiché tel quel.
  String? _erreur;

  Hebergement get _h => widget.hebergement;

  String? get _erreurSejour =>
      _plage == null ? null : _h.erreurSejour(_plage!.start, _plage!.end);

  @override
  void dispose() {
    _telephone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _choisirDates() async {
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
              !actuelle.end.isAfter(dernier)
          ? actuelle
          : null,
      helpText: 'Arrivée et départ',
      fieldStartLabelText: 'Arrivée',
      fieldEndLabelText: 'Départ',
    );
    if (plage != null && mounted) {
      setState(() {
        _plage = plage;
        _datesManquantes = false;
        _erreur = null;
      });
    }
  }

  Future<void> _envoyer({
    required int adultes,
    required int enfants,
    required int unites,
    required int? disponibles,
  }) async {
    final formulaireValide = _cle.currentState!.validate();
    setState(() => _datesManquantes = _plage == null);
    if (!formulaireValide ||
        _plage == null ||
        _erreurSejour != null ||
        (disponibles != null && disponibles <= 0) ||
        _envoi) {
      return;
    }

    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref
          .read(locationsRepositoryProvider)
          .reserverHebergement(
            hebergementId: _h.id,
            arrivee: _plage!.start,
            depart: _plage!.end,
            adultes: adultes,
            enfants: enfants,
            unites: unites,
            telephone: _telephone.text.trim(),
            message: _message.text.trim(),
          );
      ref.invalidate(mesDemandesReservationProvider);
      navigator.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Notificateur.snackSucces(
            "Votre réservation a été envoyée. L'établissement vous recontacte "
            'rapidement.',
          ),
        );
    } catch (e) {
      if (!mounted) return;
      setState(
        () => _erreur = messageErreurApi(
          e,
          repli: 'Envoi impossible. Vérifiez votre connexion et réessayez.',
        ),
      );
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plage = _plage;
    final erreurSejour = _erreurSejour;
    final datesValides = plage != null && erreurSejour == null;

    // Disponibilité vérifiée dès que les dates conviennent.
    final dispo = datesValides
        ? ref.watch(
            disponibiliteHebergementProvider(
              id: _h.id,
              arrivee: formatDateIso(plage.start),
              depart: formatDateIso(plage.end),
            ),
          )
        : null;
    final disponibles = dispo?.value;
    final complet = disponibles != null && disponibles <= 0;

    // Valeurs plafonnées : les plafonds suivent les chambres libres.
    final unites = _unites.clamp(1, _h.maxUnites(disponibles));
    final adultes = _adultes.clamp(1, _h.maxAdultes(unites));
    final enfants = _enfants.clamp(0, _h.maxEnfants(unites));

    final estimation = datesValides && !complet
        ? EstimationSejour(
            nuits: nombreNuits(plage.start, plage.end),
            prixNuit: _h.prixNuit,
            unites: unites,
          )
        : null;

    return Padding(
      // La feuille remonte au-dessus du clavier.
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _cle,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Réserver un séjour',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _h.titre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _envoi ? null : _choisirDates,
                borderRadius: BorderRadius.circular(8),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Arrivée et départ *',
                    prefixIcon: const Icon(Icons.date_range_outlined),
                    helperText: _h.dureeMin > 1
                        ? 'Durée minimale : ${pluriel(_h.dureeMin, 'nuit')}'
                        : null,
                    errorText: _datesManquantes
                        ? 'Choisissez vos dates.'
                        : erreurSejour,
                    errorMaxLines: 2,
                  ),
                  child: Text(
                    plage == null ? 'Choisir les dates' : _libelleSejour(plage),
                  ),
                ),
              ),
              if (dispo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _Disponibilite(etat: dispo),
                ),
              const SizedBox(height: 8),
              Compteur(
                libelle: 'Adultes',
                valeur: adultes,
                min: 1,
                max: _h.maxAdultes(unites),
                actif: !_envoi,
                onChanged: (v) => setState(() => _adultes = v),
              ),
              if (_h.maxEnfants(unites) > 0)
                Compteur(
                  libelle: 'Enfants',
                  valeur: enfants,
                  min: 0,
                  max: _h.maxEnfants(unites),
                  actif: !_envoi,
                  onChanged: (v) => setState(() => _enfants = v),
                ),
              Compteur(
                libelle: 'Chambres',
                valeur: unites,
                min: 1,
                max: _h.maxUnites(disponibles),
                actif: !_envoi && !complet,
                onChanged: (v) => setState(() => _unites = v),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _telephone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Téléphone de contact *',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (v) =>
                    (v ?? '').replaceAll(RegExp(r'[^0-9]'), '').length < 8
                    ? 'Indiquez un numéro où vous joindre.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _message,
                minLines: 2,
                maxLines: 4,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Message (optionnel)',
                  alignLabelWithHint: true,
                ),
              ),
              EncadreMontant(
                libelle: estimation?.libelle,
                vide: complet
                    ? 'Aucune chambre libre sur ces dates.'
                    : 'Choisissez vos dates pour voir le montant.',
              ),
              const SizedBox(height: 12),
              if (_erreur != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    _erreur!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Config.couleurErreur,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              FilledButton(
                onPressed: _envoi || complet
                    ? null
                    : () => _envoyer(
                        adultes: adultes,
                        enfants: enfants,
                        unites: unites,
                        disponibles: disponibles,
                      ),
                child: _envoi
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Envoyer la réservation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// « Du 10/11/2026 au 13/11/2026 · 3 nuits ».
  static String _libelleSejour(DateTimeRange plage) {
    final du = formatDateCourte(formatDateIso(plage.start));
    final au = formatDateCourte(formatDateIso(plage.end));
    final nuits = nombreNuits(plage.start, plage.end);
    return nuits == 0 ? 'Le $du' : 'Du $du au $au · ${pluriel(nuits, 'nuit')}';
  }
}

/// « 3 chambres disponibles », « Complet sur ces dates », ou la
/// vérification en cours.
class _Disponibilite extends StatelessWidget {
  const _Disponibilite({required this.etat});

  final AsyncValue<int> etat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (icone, texte, couleur) = switch (etat) {
      AsyncData(:final value) when value <= 0 => (
        Icons.event_busy_outlined,
        libelleDisponibilite(value),
        Config.couleurErreur,
      ),
      AsyncData(:final value) => (
        Icons.check_circle_outline,
        libelleDisponibilite(value),
        Colors.green.shade700,
      ),
      // Échec (même pendant une nouvelle tentative automatique).
      _ when etat.hasError => (
        Icons.info_outline,
        "Disponibilité non vérifiée : l'établissement confirmera.",
        Config.couleurTexteSecondaire,
      ),
      _ => (
        Icons.hourglass_empty,
        'Vérification de la disponibilité…',
        Config.couleurTexteSecondaire,
      ),
    };
    return Row(
      children: [
        Icon(icone, size: 18, color: couleur),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            texte,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: couleur,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// Compteur « − n + » plafonné.
class Compteur extends StatelessWidget {
  const Compteur({
    super.key,
    required this.libelle,
    required this.valeur,
    required this.min,
    required this.max,
    required this.onChanged,
    this.actif = true,
  });

  final String libelle;
  final int valeur;
  final int min;
  final int max;
  final bool actif;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(libelle, style: Theme.of(context).textTheme.bodyLarge),
        ),
        IconButton(
          tooltip: '$libelle : un de moins',
          onPressed: actif && valeur > min ? () => onChanged(valeur - 1) : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$valeur',
            key: ValueKey('compteur-$libelle'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          tooltip: '$libelle : un de plus',
          onPressed: actif && valeur < max ? () => onChanged(valeur + 1) : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
