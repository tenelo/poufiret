import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/widgets/message_erreur.dart';
import '../donnees/avis_repository.dart';
import '../metier_domaine/avis.dart';
import '../widgets/widgets_avis.dart';

/// Tous les avis d'un partenaire, page par page (défilement infini).
///
/// [peutRepondre] (espace partenaire, « Avis reçus ») : bouton « Répondre »
/// sous chaque avis encore sans réponse.
class EcranAvisPartenaire extends ConsumerStatefulWidget {
  const EcranAvisPartenaire({
    super.key,
    required this.partenaireId,
    this.titre = 'Avis',
    this.peutRepondre = false,
  });

  final int partenaireId;
  final String titre;
  final bool peutRepondre;

  @override
  ConsumerState<EcranAvisPartenaire> createState() =>
      _EcranAvisPartenaireState();
}

class _EcranAvisPartenaireState extends ConsumerState<EcranAvisPartenaire> {
  final _avis = <Avis>[];
  int _pages = 0;
  bool _suite = true;
  bool _chargement = false;
  Object? _erreur;
  double? _noteMoyenne;
  int _nbAvis = 0;

  @override
  void initState() {
    super.initState();
    _chargerSuite();
  }

  Future<void> _chargerSuite() async {
    if (_chargement || !_suite) return;
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      final page = await ref
          .read(avisRepositoryProvider)
          .avisPartenaire(widget.partenaireId, page: _pages + 1);
      if (!mounted) return;
      setState(() {
        _avis.addAll(page.avis);
        _pages++;
        _suite = page.aSuite;
        _noteMoyenne = page.noteMoyenne;
        _nbAvis = page.nbAvis;
      });
    } catch (e) {
      if (mounted) setState(() => _erreur = e);
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  Future<void> _rafraichir() async {
    setState(() {
      _avis.clear();
      _pages = 0;
      _suite = true;
    });
    ref.invalidate(avisPartenaireProvider(widget.partenaireId));
    await _chargerSuite();
  }

  Future<void> _repondre(Avis avis) async {
    final maj = await showDialog<Avis>(
      context: context,
      builder: (_) => _DialogueReponse(avis: avis),
    );
    if (maj == null || !mounted) return;
    setState(() {
      final i = _avis.indexWhere((a) => a.id == avis.id);
      if (i >= 0) _avis[i] = maj;
    });
    ref.invalidate(avisPartenaireProvider(widget.partenaireId));
    Notificateur.succes(context, 'Réponse publiée.');
  }

  @override
  Widget build(BuildContext context) {
    Widget corps;
    if (_avis.isEmpty && _erreur != null) {
      corps = MessageErreur(
        message: messageErreurApi(
          _erreur!,
          repli: 'Impossible de charger les avis.',
        ),
        onReessayer: _chargerSuite,
      );
    } else if (_avis.isEmpty && _chargement) {
      corps = const Center(child: CircularProgressIndicator());
    } else if (_avis.isEmpty) {
      corps = const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Aucun avis pour le moment.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      corps = RefreshIndicator(
        onRefresh: _rafraichir,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          itemCount: _avis.length + 2,
          separatorBuilder: (_, i) =>
              i == 0 ? const SizedBox.shrink() : const Divider(height: 1),
          itemBuilder: (context, i) {
            if (i == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ResumeNote(
                  noteMoyenne: _noteMoyenne,
                  nbAvis: _nbAvis,
                  taille: 16,
                ),
              );
            }
            if (i == _avis.length + 1) {
              // Bas de liste : page suivante, ou erreur.
              if (_suite && _erreur == null) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _chargerSuite(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: _erreur != null
                      ? TextButton(
                          onPressed: _chargerSuite,
                          child: const Text('Réessayer'),
                        )
                      : _suite
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                ),
              );
            }
            final avis = _avis[i - 1];
            return TuileAvis(
              avis: avis,
              action: widget.peutRepondre && avis.reponsePartenaire == null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => _repondre(avis),
                        icon: const Icon(Icons.reply_rounded, size: 18),
                        label: const Text('Répondre'),
                      ),
                    )
                  : null,
            );
          },
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.titre)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: corps,
        ),
      ),
    );
  }
}

/// Réponse du partenaire à un avis (une seule fois, 1000 caractères).
class _DialogueReponse extends ConsumerStatefulWidget {
  const _DialogueReponse({required this.avis});
  final Avis avis;

  @override
  ConsumerState<_DialogueReponse> createState() => _DialogueReponseState();
}

class _DialogueReponseState extends ConsumerState<_DialogueReponse> {
  final _texte = TextEditingController();
  bool _envoi = false;
  String? _erreur;

  @override
  void dispose() {
    _texte.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (_texte.text.trim().isEmpty || _envoi) return;
    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final navigateur = Navigator.of(context);
    try {
      final maj = await ref
          .read(avisRepositoryProvider)
          .repondre(widget.avis.id, _texte.text);
      navigateur.pop(maj);
    } catch (e) {
      if (mounted) {
        setState(
          () => _erreur = messageErreurApi(e, repli: 'Envoi impossible.'),
        );
      }
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Répondre à l\'avis'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _texte,
            enabled: !_envoi,
            autofocus: true,
            maxLength: 1000,
            minLines: 3,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Votre réponse (publique, une seule fois)',
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (_erreur != null)
            Text(
              _erreur!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _envoi ? null : () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: _envoi || _texte.text.trim().isEmpty ? null : _envoyer,
          child: const Text('Publier'),
        ),
      ],
    );
  }
}
