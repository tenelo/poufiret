import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../global/config/env.dart';
import '../../../global/storage/token_storage.dart';
import '../metier_domaine/chat_models.dart';
import 'package:web_socket_channel/io.dart';

/// État de connexion du socket, exposé à l'UI.
enum EtatSocket { connexion, connecte, deconnecte, refuse }

/// Service WebSocket d'une conversation.
///
/// Responsabilités :
/// - se connecter avec le token d'accès COURANT (relu à chaque tentative) ;
/// - exposer les messages entrants via [messages] ;
/// - exposer l'état de connexion via [etat] ;
/// - se reconnecter avec back-off sur coupure réseau ;
/// - NE PAS se reconnecter sur refus d'accès (4001 / 4003).
class ChatSocket {
  ChatSocket({required this.conversationId, required TokenStorage tokens})
    : _tokens = tokens;

  final int conversationId;
  final TokenStorage _tokens;

  WebSocketChannel? _canal;
  StreamSubscription? _sub;
  Timer? _reconnexionTimer;
  int _tentatives = 0;
  bool _fermeManuellement = false;

  final _messagesCtrl = StreamController<Message>.broadcast();
  final _lusCtrl = StreamController<List<int>>.broadcast();
  final _etatCtrl = StreamController<EtatSocket>.broadcast();

  /// Messages reçus (le mien rediffusé par le serveur + ceux des autres).
  Stream<Message> get messages => _messagesCtrl.stream;

  /// Ids de mes messages passes au statut lu (accuses de lecture).
  Stream<List<int>> get messagesLus => _lusCtrl.stream;

  /// État courant de la connexion, pour un bandeau d'info dans l'UI.
  Stream<EtatSocket> get etat => _etatCtrl.stream;

  /// Construit wss://host/ws/chat/<id>/?token=<access>

  Future<String?> _url() async {
    final access = await _tokens.accessToken;
    if (access == null) return null;
    final base = Uri.parse(Env.apiBaseUrl);
    final wsScheme = base.scheme == 'https' ? 'wss' : 'ws';
    final ws = base.replace(
      scheme: wsScheme,
      path: '/ws/chat/$conversationId/',
      queryParameters: {'token': access},
    );
    return ws.toString();
  }

  /// Ouvre la connexion. Idempotent tant qu'un canal est actif.
  Future<void> connecter() async {
    _fermeManuellement = false;
    _etatCtrl.add(EtatSocket.connexion);

    final url = await _url();
    // ignore: avoid_print
    print('[ChatSocket] url=$url');
    if (url == null) {
      _etatCtrl.add(EtatSocket.refuse); // pas de token → session morte
      return;
    }

    try {
      _canal = IOWebSocketChannel.connect(
        url,
        headers: {'Origin': Env.apiBaseUrl},
      );
      await _canal!.ready;
    } catch (e) {
      print('[ChatSocket] echec connexion: $e');
      _planifierReconnexion();
      return;
    }

    _etatCtrl.add(EtatSocket.connecte);
    _tentatives = 0; // succès → réinitialise le back-off

    _sub = _canal!.stream.listen(
      (data) {
        try {
          final json = jsonDecode(data as String) as Map<String, dynamic>;
          if (json['type'] == 'messages_lus') {
            _lusCtrl.add((json['message_ids'] as List).cast<int>());
          } else {
            _messagesCtrl.add(Message.fromJson(json));
          }
        } catch (_) {
          // trame non-JSON ou inattendue : on ignore
        }
      },
      onDone: _surFermeture,
      onError: (_) => _surFermeture(),
      cancelOnError: true,
    );
  }

  void _surFermeture() {
    final code = _canal?.closeCode;
    // ignore: avoid_print
    print('[ChatSocket] fermeture code=$code');
    // 4001 = non authentifié, 4003 = pas membre : reconnecter est inutile.
    if (code == 4001 || code == 4003) {
      _etatCtrl.add(EtatSocket.refuse);
      return;
    }
    if (_fermeManuellement) {
      _etatCtrl.add(EtatSocket.deconnecte);
      return;
    }
    _planifierReconnexion();
  }

  void _planifierReconnexion() {
    // ignore: avoid_print
    print('[ChatSocket] reconnexion planifiee, tentative=$_tentatives');
    _etatCtrl.add(EtatSocket.deconnecte);
    _reconnexionTimer?.cancel();
    // Back-off : 1, 2, 4, 8… plafonné à 30 s.
    final delaiSec = (1 << _tentatives).clamp(1, 30);
    _tentatives = (_tentatives + 1).clamp(0, 5);
    _reconnexionTimer = Timer(Duration(seconds: delaiSec), connecter);
  }

  /// Envoie un message. Le serveur le persiste et le rediffuse (y compris à moi).
  void envoyer(String contenu) {
    final texte = contenu.trim();
    if (texte.isEmpty || _canal == null) return;
    _canal!.sink.add(jsonEncode({'contenu': texte}));
  }

  /// Signale au serveur que j'ai lu les messages de cette conversation.
  void marquerLu() {
    if (_canal == null) return;
    _canal!.sink.add(jsonEncode({'type': 'marquer_lu'}));
  }

  /// Fermeture propre (quand on quitte l'écran).
  Future<void> fermer() async {
    _fermeManuellement = true;
    _reconnexionTimer?.cancel();
    await _sub?.cancel();
    await _canal?.sink.close();
    await _messagesCtrl.close();
    await _lusCtrl.close();
    await _etatCtrl.close();
  }
}
