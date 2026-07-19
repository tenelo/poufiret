import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/providers.dart';
import '../data/chat_providers.dart';
import '../data/chat_socket.dart';
import '../domain/chat_models.dart';

/// Fil de discussion temps réel d'une conversation.
class EcranDiscussion extends ConsumerStatefulWidget {
  const EcranDiscussion({
    super.key,
    required this.conversationId,
    required this.titre,
  });

  final int conversationId;
  final String titre;

  @override
  ConsumerState<EcranDiscussion> createState() => _EcranDiscussionState();
}

class _EcranDiscussionState extends ConsumerState<EcranDiscussion> {
  ChatSocket? _socket;
  final _messages = <Message>[];
  final _champ = TextEditingController();
  final _scroll = ScrollController();
  EtatSocket _etat = EtatSocket.connexion;
  bool _historiqueCharge = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // 1) Historique REST (une fois).
    try {
      final histo = await ref.read(
        historiqueMessagesProvider(conversationId: widget.conversationId).future,
      );
      _messages.addAll(histo);
    } catch (_) {
      // en cas d'échec on laisse la liste vide ; le socket prendra le relais
    }
    if (mounted) setState(() => _historiqueCharge = true);
    _scrollEnBas();

    // 2) Socket temps réel.
    final tokens = ref.read(tokenStorageProvider);
    final socket = ChatSocket(
      conversationId: widget.conversationId,
      tokens: tokens,
    );
    _socket = socket;

    socket.messages.listen(_surMessage);
    socket.etat.listen((e) {
      if (mounted) setState(() => _etat = e);
    });
    socket.connecter();
  }

  void _surMessage(Message m) {
    if (!mounted) return;
    // Évite les doublons (le mien rediffusé peut déjà être en historique si reconnexion).
    if (_messages.any((x) => x.id == m.id)) return;
    setState(() => _messages.add(m));
    _scrollEnBas();
  }

  void _envoyer() {
    final texte = _champ.text.trim();
    if (texte.isEmpty) return;
    _socket?.envoyer(texte);
    _champ.clear();
  }

  void _scrollEnBas() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _socket?.fermer();
    _champ.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monId = ref.watch(monUtilisateurIdProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.titre)),
      body: Column(
        children: [
          if (_etat == EtatSocket.deconnecte ||
              _etat == EtatSocket.connexion)
            _Bandeau(
              texte: _etat == EtatSocket.connexion
                  ? 'Connexion…'
                  : 'Reconnexion…',
              couleur: Colors.orange.shade100,
            ),
          if (_etat == EtatSocket.refuse)
            _Bandeau(
              texte: 'Connexion impossible à cette conversation.',
              couleur: Colors.red.shade100,
            ),
          Expanded(
            child: !_historiqueCharge
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth > 700
                          ? 700.0
                          : constraints.maxWidth;
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: ListView.builder(
                            controller: _scroll,
                            padding: const EdgeInsets.all(12),
                            itemCount: _messages.length,
                            itemBuilder: (context, i) => _Bulle(
                              message: _messages[i],
                              estDeMoi: monId != null &&
                                  _messages[i].estDeMoi(monId),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          _Saisie(
            controller: _champ,
            onEnvoyer: _envoyer,
            actif: _etat == EtatSocket.connecte,
          ),
        ],
      ),
    );
  }
}

class _Bulle extends StatelessWidget {
  const _Bulle({required this.message, required this.estDeMoi});
  final Message message;
  final bool estDeMoi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleur = estDeMoi
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    return Align(
      alignment: estDeMoi ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: couleur,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!estDeMoi && message.expediteurNom.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  message.expediteurNom,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            Text(message.contenu),
          ],
        ),
      ),
    );
  }
}

class _Saisie extends StatelessWidget {
  const _Saisie({
    required this.controller,
    required this.onEnvoyer,
    required this.actif,
  });
  final TextEditingController controller;
  final VoidCallback onEnvoyer;
  final bool actif;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => actif ? onEnvoyer() : null,
                decoration: InputDecoration(
                  hintText: actif ? 'Votre message…' : 'Connexion…',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: actif ? onEnvoyer : null,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bandeau extends StatelessWidget {
  const _Bandeau({required this.texte, required this.couleur});
  final String texte;
  final Color couleur;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: couleur,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(texte, textAlign: TextAlign.center),
    );
  }
}
