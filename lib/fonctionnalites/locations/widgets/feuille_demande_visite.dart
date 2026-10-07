import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';

/// « Demander une visite » d'un logement. Un visiteur non inscrit est invité
/// à créer un compte (mur d'inscription) ; sinon la feuille s'ouvre.
void demanderVisite(
  BuildContext context,
  WidgetRef ref, {
  required int logementId,
  required String titre,
}) {
  murInscription(context, ref, () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) =>
          FeuilleDemandeVisite(logementId: logementId, titre: titre),
    );
  });
}

/// Feuille de demande de visite : date souhaitée, téléphone de contact
/// (prérempli, modifiable), message optionnel.
class FeuilleDemandeVisite extends ConsumerStatefulWidget {
  const FeuilleDemandeVisite({
    super.key,
    required this.logementId,
    required this.titre,
  });

  final int logementId;
  final String titre;

  @override
  ConsumerState<FeuilleDemandeVisite> createState() =>
      _FeuilleDemandeVisiteState();
}

class _FeuilleDemandeVisiteState extends ConsumerState<FeuilleDemandeVisite> {
  final _cle = GlobalKey<FormState>();
  late final _telephone = TextEditingController(
    text: ref.read(authProvider).value?.telephone ?? '',
  );
  final _message = TextEditingController();
  DateTime? _date;
  bool _dateManquante = false;
  bool _envoi = false;

  /// Refus du serveur (ex. logement non disponible), affiché tel quel.
  String? _erreur;

  @override
  void dispose() {
    _telephone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _choisirDate() async {
    final aujourdhui = DateUtils.dateOnly(DateTime.now());
    final date = await showDatePicker(
      context: context,
      initialDate: _date ?? aujourdhui,
      firstDate: aujourdhui,
      lastDate: aujourdhui.add(const Duration(days: 365)),
      helpText: 'Date de visite souhaitée',
    );
    if (date != null) {
      setState(() {
        _date = date;
        _dateManquante = false;
      });
    }
  }

  Future<void> _envoyer() async {
    final formulaireValide = _cle.currentState!.validate();
    setState(() => _dateManquante = _date == null);
    if (!formulaireValide || _date == null || _envoi) return;

    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref
          .read(locationsRepositoryProvider)
          .demanderVisite(
            logementId: widget.logementId,
            date: _date!,
            telephone: _telephone.text.trim(),
            message: _message.text.trim(),
          );
      ref.invalidate(mesDemandesReservationProvider);
      navigator.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Notificateur.snackSucces(
            'Votre demande a été envoyée. Nous vous recontactons rapidement.',
          ),
        );
    } catch (e) {
      if (!mounted) return;
      setState(
        () => _erreur = messageErreurApi(
          e,
          repli: "Envoi impossible. Vérifiez votre connexion et réessayez.",
        ),
      );
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                'Demander une visite',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.titre.isNotEmpty)
                Text(
                  widget.titre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  ),
                ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _envoi ? null : _choisirDate,
                borderRadius: BorderRadius.circular(8),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date souhaitée *',
                    prefixIcon: const Icon(Icons.event_outlined),
                    errorText: _dateManquante ? 'Choisissez une date.' : null,
                  ),
                  child: Text(
                    _date == null
                        ? 'Choisir une date'
                        : formatDateCourte(formatDateIso(_date!)),
                  ),
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
                    : const Text('Envoyer la demande'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
