import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../donnees/locations_providers.dart';

/// « Je suis intéressé » par une annonce à vendre. Un visiteur non inscrit
/// est invité à créer un compte ; sinon la feuille s'ouvre.
void demanderAchat(
  BuildContext context,
  WidgetRef ref, {
  required int objetId,
  required String titre,
  String prix = '',
}) {
  murInscription(context, ref, () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 700),
      builder: (_) =>
          FeuilleDemandeAchat(objetId: objetId, titre: titre, prix: prix),
    );
  });
}

/// Feuille de demande d'achat : téléphone de contact (prérempli,
/// modifiable) et message optionnel. Aucune date.
class FeuilleDemandeAchat extends ConsumerStatefulWidget {
  const FeuilleDemandeAchat({
    super.key,
    required this.objetId,
    required this.titre,
    this.prix = '',
  });

  final int objetId;
  final String titre;

  /// Prix de vente affiché sous le titre (« 12 500 000 FCFA »).
  final String prix;

  @override
  ConsumerState<FeuilleDemandeAchat> createState() =>
      _FeuilleDemandeAchatState();
}

class _FeuilleDemandeAchatState extends ConsumerState<FeuilleDemandeAchat> {
  final _cle = GlobalKey<FormState>();
  late final _telephone = TextEditingController(
    text: ref.read(authProvider).value?.telephone ?? '',
  );
  final _message = TextEditingController();
  bool _envoi = false;

  /// Refus du serveur (annonce vendue…), affiché tel quel.
  String? _erreur;

  @override
  void dispose() {
    _telephone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (!_cle.currentState!.validate() || _envoi) return;
    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref
          .read(locationsRepositoryProvider)
          .demanderAchat(
            objetId: widget.objetId,
            telephone: _telephone.text.trim(),
            message: _message.text.trim(),
          );
      ref.invalidate(mesDemandesReservationProvider);
      navigator.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Notificateur.snackSucces(
            'Votre demande a été envoyée. Le vendeur vous recontacte '
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
                'Je suis intéressé',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
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
              if (widget.prix.isNotEmpty)
                Text(
                  widget.prix,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 16),
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
                  hintText: 'Une question, une visite, une offre…',
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
