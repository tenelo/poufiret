import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';

/// « Réserver » un véhicule. Un visiteur non inscrit est invité à créer un
/// compte (mur d'inscription) ; sinon la feuille s'ouvre.
void reserverVehicule(
  BuildContext context,
  WidgetRef ref, {
  required Vehicule vehicule,
}) {
  murInscription(context, ref, () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) => FeuilleReservationVehicule(vehicule: vehicule),
    );
  });
}

/// Feuille de réservation : plage de dates (jours réservés grisés, durée
/// minimale), chauffeur, lieu de prise en charge, téléphone (prérempli),
/// message, et le montant estimé recalculé à chaque changement.
class FeuilleReservationVehicule extends ConsumerStatefulWidget {
  const FeuilleReservationVehicule({
    super.key,
    required this.vehicule,
    this.plageInitiale,
  });

  final Vehicule vehicule;

  /// Dates déjà choisies à l'ouverture (sinon le client les choisit).
  final DateTimeRange? plageInitiale;

  @override
  ConsumerState<FeuilleReservationVehicule> createState() =>
      _FeuilleReservationVehiculeState();
}

class _FeuilleReservationVehiculeState
    extends ConsumerState<FeuilleReservationVehicule> {
  final _cle = GlobalKey<FormState>();
  late final _telephone = TextEditingController(
    text: ref.read(authProvider).value?.telephone ?? '',
  );
  final _lieu = TextEditingController();
  final _message = TextEditingController();
  late DateTimeRange? _plage = widget.plageInitiale;
  bool _avecChauffeur = false;
  bool _datesManquantes = false;
  bool _envoi = false;

  /// Refus du serveur (chevauchement, durée minimale...), affiché tel quel.
  String? _erreur;

  Vehicule get _v => widget.vehicule;

  /// Chauffeur retenu : imposé s'il est obligatoire, impossible s'il n'est
  /// pas proposé, sinon au choix du client.
  bool get _chauffeur =>
      _v.chauffeurObligatoire || (_v.chauffeurDisponible && _avecChauffeur);

  /// Problème des dates choisies (null si elles conviennent ou manquent).
  String? get _erreurPlage =>
      _plage == null ? null : _v.erreurPlage(_plage!.start, _plage!.end);

  @override
  void dispose() {
    _telephone.dispose();
    _lieu.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _choisirDates() async {
    final aujourdhui = jourSeul(DateTime.now());
    final dernier = aujourdhui.add(const Duration(days: 365));
    final actuelle = _plage;
    // Plage reprise seulement si elle reste choisissable (le calendrier
    // refuse une plage initiale contenant un jour grisé).
    final reprise =
        actuelle != null &&
            !actuelle.start.isBefore(aujourdhui) &&
            !actuelle.end.isAfter(dernier) &&
            _v.erreurPlage(actuelle.start, actuelle.end) == null
        ? actuelle
        : null;
    final plage = await showDateRangePicker(
      context: context,
      firstDate: aujourdhui,
      lastDate: dernier,
      initialDateRange: reprise,
      selectableDayPredicate: _v.jourSelectionnable,
      helpText: 'Dates de location',
    );
    if (plage != null && mounted) {
      setState(() {
        _plage = plage;
        _datesManquantes = false;
        _erreur = null;
      });
    }
  }

  Future<void> _envoyer() async {
    final formulaireValide = _cle.currentState!.validate();
    setState(() => _datesManquantes = _plage == null);
    if (!formulaireValide || _plage == null || _erreurPlage != null || _envoi) {
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
          .reserverVehicule(
            vehiculeId: _v.id,
            du: _plage!.start,
            au: _plage!.end,
            avecChauffeur: _chauffeur,
            lieuPriseEnCharge: _lieu.text.trim(),
            telephone: _telephone.text.trim(),
            message: _message.text.trim(),
          );
      ref.invalidate(mesDemandesReservationProvider);
      // Les jours réservés changent : la fiche se met à jour.
      ref.invalidate(vehiculeDetailProvider(id: _v.id));
      navigator.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Notificateur.snackSucces(
            'Votre réservation a été envoyée. Le loueur vous recontacte '
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
    final erreurPlage = _erreurPlage;
    final estimation = plage == null || erreurPlage != null
        ? null
        : EstimationLocation.pour(
            _v,
            du: plage.start,
            au: plage.end,
            avecChauffeur: _chauffeur,
          );
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
                'Réserver ce véhicule',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _v.nomComplet,
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
                    labelText: 'Dates de location *',
                    prefixIcon: const Icon(Icons.date_range_outlined),
                    helperText: _v.dureeMin > 1
                        ? 'Durée minimale : ${pluriel(_v.dureeMin, 'jour')}'
                        : null,
                    errorText: _datesManquantes
                        ? 'Choisissez vos dates.'
                        : erreurPlage,
                    errorMaxLines: 2,
                  ),
                  child: Text(
                    plage == null ? 'Choisir les dates' : _libellePlage(plage),
                  ),
                ),
              ),
              if (_v.chauffeurDisponible || _v.chauffeurObligatoire)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Avec chauffeur'),
                  subtitle: _v.chauffeurObligatoire
                      ? const Text('Chauffeur obligatoire pour ce véhicule')
                      : null,
                  value: _chauffeur,
                  onChanged: _v.chauffeurObligatoire || _envoi
                      ? null
                      : (v) => setState(() => _avecChauffeur = v),
                )
              else
                const SizedBox(height: 12),
              TextFormField(
                controller: _lieu,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Lieu de prise en charge',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
              ),
              const SizedBox(height: 12),
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
              _MontantEstime(estimation: estimation),
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
                onPressed: _envoi ? null : _envoyer,
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

  /// « Du 20/10/2026 au 22/10/2026 · 3 jours ».
  static String _libellePlage(DateTimeRange plage) {
    final du = formatDateCourte(formatDateIso(plage.start));
    final au = formatDateCourte(formatDateIso(plage.end));
    final jours = pluriel(nombreJours(plage.start, plage.end), 'jour');
    return du == au ? 'Le $du · $jours' : 'Du $du au $au · $jours';
  }
}

/// Encadré du montant estimé : « 3 jours × 25 000 F = 75 000 F ».
class _MontantEstime extends StatelessWidget {
  const _MontantEstime({required this.estimation});

  final EstimationLocation? estimation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final e = estimation;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Config.couleurFond,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Config.couleurBordure),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Montant estimé', style: theme.textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(
            e == null
                ? 'Choisissez vos dates pour voir le montant.'
                : e.libelle,
            style: e == null
                ? theme.textTheme.bodyMedium?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  )
                : theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
          ),
          if (e != null)
            Text(
              'Hors caution et frais éventuels ; le loueur confirme le prix.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
        ],
      ),
    );
  }
}
