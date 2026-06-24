import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/auth/screens/auth_notifier.dart';
import 'package:poufiret/features/social/data/social_providers.dart';
import 'package:poufiret/features/social/data/social_repository.dart';
import 'package:poufiret/features/social/domain/commentaire.dart';
import 'package:poufiret/features/social/widgets/bouton_social.dart';

class SectionCommentaires extends ConsumerStatefulWidget {
  final int articleId;
  const SectionCommentaires({super.key, required this.articleId});

  @override
  ConsumerState<SectionCommentaires> createState() =>
      _SectionCommentairesState();
}

class _SectionCommentairesState extends ConsumerState<SectionCommentaires> {
  final _champ = TextEditingController();
  int? _repondA; // id du commentaire auquel on répond (null = nouveau)
  String _repondAQui = '';
  bool _envoiEnCours = false;

  @override
  void dispose() {
    _champ.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    final texte = _champ.text.trim();
    if (texte.isEmpty) return;
    setState(() => _envoiEnCours = true);
    try {
      await ref
          .read(socialRepositoryProvider)
          .posterCommentaire(
            articleId: widget.articleId,
            contenu: texte,
            parentId: _repondA,
          );
      _champ.clear();
      setState(() {
        _repondA = null;
        _repondAQui = '';
      });
      // Recharge la liste pour voir le nouveau commentaire.
      ref.invalidate(commentairesArticleProvider(articleId: widget.articleId));
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.messageLisible)));
      }
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  Future<void> _supprimer(int id) async {
    try {
      await ref.read(socialRepositoryProvider).supprimerCommentaire(id);
      ref.invalidate(commentairesArticleProvider(articleId: widget.articleId));
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.messageLisible)));
      }
    }
  }

  void _prepererReponse(Commentaire c) {
    setState(() {
      _repondA = c.id;
      _repondAQui = c.userNom;
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentairesAsync = ref.watch(
      commentairesArticleProvider(articleId: widget.articleId),
    );
    // id de l'utilisateur connecté, pour savoir quels commentaires sont les siens.
    final monId = ref.watch(authProvider).value?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Commentaires', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        commentairesAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, _) => Text(
            err is ApiException ? err.messageLisible : 'Erreur de chargement.',
          ),
          data: (commentaires) {
            if (commentaires.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Sois le premier à commenter.'),
              );
            }
            return Column(
              children: commentaires
                  .map(
                    (c) => _Commentaire(
                      commentaire: c,
                      monId: monId,
                      onRepondre: () => _prepererReponse(c),
                      onSupprimer: () => _supprimer(c.id),
                      onSupprimerReponse: _supprimer,
                      articleId: widget.articleId,
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 12),
        // Zone de saisie.
        if (_repondA != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'En réponse à $_repondAQui',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _repondA = null;
                    _repondAQui = '';
                  }),
                  child: const Text('Annuler'),
                ),
              ],
            ),
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _champ,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: _repondA != null
                      ? 'Ta réponse...'
                      : 'Ajoute un commentaire...',
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _envoiEnCours ? null : _envoyer,
              icon: _envoiEnCours
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}

class _Commentaire extends StatelessWidget {
  final Commentaire commentaire;
  final int? monId;
  final int articleId;
  final VoidCallback onRepondre;
  final VoidCallback onSupprimer;
  final void Function(int id) onSupprimerReponse;

  const _Commentaire({
    required this.commentaire,
    required this.monId,
    required this.articleId,
    required this.onRepondre,
    required this.onSupprimer,
    required this.onSupprimerReponse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Ligne(
          commentaire: commentaire,
          estLeMien: monId != null && commentaire.user == monId,
          onRepondre: onRepondre,
          onSupprimer: onSupprimer,
        ),
        // Réponses, légèrement indentées.
        if (commentaire.reponses.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              children: commentaire.reponses
                  .map(
                    (r) => _Ligne(
                      commentaire: r,
                      estLeMien: monId != null && r.user == monId,
                      onRepondre: null, // pas de réponse à une réponse
                      onSupprimer: () => onSupprimerReponse(r.id),
                    ),
                  )
                  .toList(),
            ),
          ),
        const Divider(),
      ],
    );
  }
}

class _Ligne extends ConsumerWidget {
  final Commentaire commentaire;
  final bool estLeMien;
  final VoidCallback? onRepondre;
  final VoidCallback onSupprimer;

  const _Ligne({
    required this.commentaire,
    required this.estLeMien,
    required this.onRepondre,
    required this.onSupprimer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commentaire.userNom,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(commentaire.contenu),
          const SizedBox(height: 4),
          Row(
            children: [
              // Like de commentaire — cœur marron.
              BoutonSocial(
                actifInitial: commentaire.estLikeParMoi,
                totalInitial: commentaire.nbLikes,
                iconeActive: Icons.favorite,
                iconeInactive: Icons.favorite_border,
                couleurActive: Colors.brown,
                onToggle: () async {
                  final res = await ref
                      .read(socialRepositoryProvider)
                      .toggleLikeCommentaire(commentaire.id);
                  return (actif: res.actif, total: res.total);
                },
              ),
              if (onRepondre != null)
                TextButton(
                  onPressed: onRepondre,
                  child: const Text('Répondre'),
                ),
              if (estLeMien)
                TextButton(
                  onPressed: onSupprimer,
                  child: const Text('Supprimer'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
