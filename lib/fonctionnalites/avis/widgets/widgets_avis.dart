import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../donnees/avis_repository.dart';
import '../metier_domaine/avis.dart';
import '../screens/ecran_avis_partenaire.dart';

/// « ★ 4,5 (12) ». Rien sans avis.
class ResumeNote extends StatelessWidget {
  const ResumeNote({
    super.key,
    required this.noteMoyenne,
    required this.nbAvis,
    this.taille = 13,
  });

  final double? noteMoyenne;
  final int nbAvis;
  final double taille;

  @override
  Widget build(BuildContext context) {
    final note = noteMoyenne;
    if (nbAvis <= 0 || note == null) return const SizedBox.shrink();
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
      fontSize: taille,
      color: Config.couleurTexte,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: taille + 3, color: Config.couleurSoleil),
        const SizedBox(width: 2),
        Text('${formatNote(note)} ($nbAvis)', style: style),
      ],
    );
  }
}

/// Cinq étoiles : affichage, ou choix de la note si [onChoisir].
class EtoilesNote extends StatelessWidget {
  const EtoilesNote({
    super.key,
    required this.note,
    this.taille = 16,
    this.onChoisir,
  });

  final int note;
  final double taille;
  final ValueChanged<int>? onChoisir;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          onChoisir == null
              ? Icon(
                  i <= note ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: taille,
                  color: Config.couleurSoleil,
                )
              : IconButton(
                  tooltip: '$i sur 5',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onChoisir!(i),
                  icon: Icon(
                    i <= note ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: taille,
                    color: Config.couleurSoleil,
                  ),
                ),
      ],
    );
  }
}

/// Feuille de notation : 5 étoiles et un commentaire facultatif. Crée l'avis
/// (ou modifie [existant]) et renvoie l'avis enregistré, null si fermée.
Future<Avis?> ouvrirFeuilleNotation(
  BuildContext context, {
  required ObjetAvis objet,
  required String objetId,
  Avis? existant,
}) {
  return showModalBottomSheet<Avis>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: 560),
    builder: (_) =>
        FeuilleNotation(objet: objet, objetId: objetId, existant: existant),
  );
}

class FeuilleNotation extends ConsumerStatefulWidget {
  const FeuilleNotation({
    super.key,
    required this.objet,
    required this.objetId,
    this.existant,
  });

  final ObjetAvis objet;
  final String objetId;
  final Avis? existant;

  static const longueurMax = 1000;

  @override
  ConsumerState<FeuilleNotation> createState() => _FeuilleNotationState();
}

class _FeuilleNotationState extends ConsumerState<FeuilleNotation> {
  late int _note = widget.existant?.note ?? 0;
  late final _commentaire = TextEditingController(
    text: widget.existant?.commentaire ?? '',
  );
  bool _envoi = false;

  /// Refus du serveur (400 / 403 / 409), affiché tel quel.
  String? _erreur;

  @override
  void dispose() {
    _commentaire.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (_note == 0 || _envoi) return;
    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final repo = ref.read(avisRepositoryProvider);
    final navigateur = Navigator.of(context);
    try {
      final existant = widget.existant;
      final avis = existant == null
          ? await repo.creer(
              objet: widget.objet,
              objetId: widget.objetId,
              note: _note,
              commentaire: _commentaire.text,
            )
          : await repo.modifier(
              existant.id,
              note: _note,
              commentaire: _commentaire.text,
            );
      ref.invalidate(mesAvisProvider);
      navigateur.pop(avis);
    } catch (e) {
      if (!mounted) return;
      setState(
        () => _erreur = messageErreurApi(
          e,
          repli: 'Envoi impossible. Réessayez.',
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
      // Le champ reste visible au-dessus du clavier.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.existant == null ? 'Votre avis' : 'Modifier votre avis',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Touchez une étoile pour noter.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Center(
              child: EtoilesNote(
                note: _note,
                taille: 36,
                onChoisir: _envoi
                    ? null
                    : (n) => setState(() {
                        _note = n;
                        _erreur = null;
                      }),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentaire,
              enabled: !_envoi,
              maxLength: FeuilleNotation.longueurMax,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Un commentaire ? (facultatif)',
              ),
            ),
            if (_erreur != null) ...[
              const SizedBox(height: 4),
              Text(
                _erreur!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _note == 0 || _envoi ? null : _envoyer,
              child: _envoi
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.existant == null ? 'Envoyer' : 'Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sur le détail d'un objet reçu : « Noter » s'il peut l'être, sinon
/// « Votre avis » (modifiable pendant 7 jours). Rien dans les autres cas.
/// [onModifie] : rafraîchit le détail après un nouvel avis.
class BlocNotation extends ConsumerWidget {
  const BlocNotation({
    super.key,
    required this.objet,
    required this.objetId,
    required this.etat,
    this.onModifie,
    this.compact = false,
  });

  final ObjetAvis objet;
  final String objetId;
  final EtatNotation etat;
  final VoidCallback? onModifie;

  /// Ligne d'une liste : bouton seul, sans titre.
  final bool compact;

  Future<void> _noter(BuildContext context, {Avis? existant}) async {
    final avis = await ouvrirFeuilleNotation(
      context,
      objet: objet,
      objetId: objetId,
      existant: existant,
    );
    if (avis != null && context.mounted) {
      Notificateur.succes(context, 'Merci pour votre avis.');
      onModifie?.call();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (etat.proposerNote) {
      final bouton = FilledButton.tonalIcon(
        onPressed: () => _noter(context),
        icon: const Icon(Icons.star_outline_rounded),
        label: const Text('Noter'),
      );
      return compact
          ? Align(alignment: Alignment.centerLeft, child: bouton)
          : bouton;
    }
    final id = etat.monAvis;
    if (id == null) return const SizedBox.shrink();
    final avis = ref
        .watch(mesAvisProvider)
        .value
        ?.where((a) => a.id == id)
        .firstOrNull;
    final theme = Theme.of(context);
    return Row(
      children: [
        Text('Votre avis', style: theme.textTheme.labelLarge),
        const SizedBox(width: 8),
        if (avis != null) EtoilesNote(note: avis.note),
        const Spacer(),
        if (avis != null && avis.modifiable(DateTime.now()))
          TextButton(
            onPressed: () => _noter(context, existant: avis),
            child: const Text('Modifier'),
          ),
      ],
    );
  }
}

const _mois = [
  'janv.',
  'févr.',
  'mars',
  'avr.',
  'mai',
  'juin',
  'juil.',
  'août',
  'sept.',
  'oct.',
  'nov.',
  'déc.',
];

String _jour(DateTime d) => '${d.day} ${_mois[d.month - 1]} ${d.year}';

/// Un avis : auteur, étoiles, date, commentaire, réponse du partenaire.
class TuileAvis extends StatelessWidget {
  const TuileAvis({super.key, required this.avis, this.action});

  final Avis avis;

  /// Sous l'avis (bouton « Répondre » de l'espace partenaire).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaire = theme.textTheme.bodySmall?.copyWith(
      color: Config.couleurTexteSecondaire,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  avis.auteurNom.isEmpty ? 'Client' : avis.auteurNom,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              if (avis.creeLe != null)
                Text(_jour(avis.creeLe!), style: secondaire),
            ],
          ),
          const SizedBox(height: 2),
          EtoilesNote(note: avis.note, taille: 15),
          if (avis.commentaire.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(avis.commentaire, style: theme.textTheme.bodyMedium),
          ],
          if (avis.reponsePartenaire != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Réponse du partenaire',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    avis.reponsePartenaire!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ?action,
        ],
      ),
    );
  }
}

/// Vitrine d'un partenaire : les 3 derniers avis et « Voir tout ». Rien
/// tant qu'il n'a aucun avis.
class SectionAvisPartenaire extends ConsumerWidget {
  const SectionAvisPartenaire({
    super.key,
    required this.partenaireId,
    this.nomPartenaire = '',
  });

  final int partenaireId;
  final String nomPartenaire;

  static const nbApercu = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(avisPartenaireProvider(partenaireId)).value;
    if (page == null || page.avis.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Avis', style: theme.textTheme.titleMedium),
            const SizedBox(width: 8),
            ResumeNote(noteMoyenne: page.noteMoyenne, nbAvis: page.nbAvis),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EcranAvisPartenaire(
                    partenaireId: partenaireId,
                    titre: nomPartenaire.isEmpty
                        ? 'Avis'
                        : 'Avis · $nomPartenaire',
                  ),
                ),
              ),
              child: const Text('Voir tout'),
            ),
          ],
        ),
        for (final (i, a) in page.avis.take(nbApercu).indexed) ...[
          if (i > 0) const Divider(height: 1),
          TuileAvis(avis: a),
        ],
      ],
    );
  }
}
