import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import '../../../global/config/env.dart';
import '../../../global/storage/token_storage.dart';

/// Etat de connexion du socket position, expose a l'UI.
enum EtatPositionSocket { connexion, connecte, deconnecte, refuse }

/// Position recue du livreur (temps reel).
class PositionLivreur {
  const PositionLivreur(this.latitude, this.longitude, this.majLe);
  final double latitude;
  final double longitude;
  final String? majLe;
}

/// Service WebSocket du positionnement livreur d'une course.
///
/// - Le livreur EMET sa position via [envoyerPosition].
/// - Le client/partenaire RECOIT via [positions].
/// - Se reconnecte avec back-off ; ne se reconnecte pas sur refus (4001/4003).
/// Calque sur ChatSocket.
class PositionSocket {
  PositionSocket({required this.courseId, required TokenStorage tokens})
    : _tokens = tokens;

  final String courseId;
  final TokenStorage _tokens;

  WebSocketChannel? _canal;
  StreamSubscription? _sub;
  Timer? _reconnexionTimer;
  int _tentatives = 0;
  bool _fermeManuellement = false;

  final _positionsCtrl = StreamController<PositionLivreur>.broadcast();
  final _etatCtrl = StreamController<EtatPositionSocket>.broadcast();

  /// Positions du livreur recues en temps reel.
  Stream<PositionLivreur> get positions => _positionsCtrl.stream;

  /// Etat courant de la connexion.
  Stream<EtatPositionSocket> get etat => _etatCtrl.stream;

  Future<String?> _url() async {
    final access = await _tokens.accessToken;
    if (access == null) return null;
    final base = Uri.parse(Env.apiBaseUrl);
    final wsScheme = base.scheme == 'https' ? 'wss' : 'ws';
    final ws = base.replace(
      scheme: wsScheme,
      path: '/ws/course/$courseId/position/',
      queryParameters: {'token': access},
    );
    return ws.toString();
  }

  Future<void> connecter() async {
    _fermeManuellement = false;
    _etatCtrl.add(EtatPositionSocket.connexion);

    final url = await _url();
    if (url == null) {
      _etatCtrl.add(EtatPositionSocket.refuse);
      return;
    }

    try {
      _canal = IOWebSocketChannel.connect(
        url,
        headers: {'Origin': Env.apiBaseUrl},
      );
      await _canal!.ready;
    } catch (_) {
      _planifierReconnexion();
      return;
    }

    _etatCtrl.add(EtatPositionSocket.connecte);
    _tentatives = 0;

    _sub = _canal!.stream.listen(
      (data) {
        try {
          final json = jsonDecode(data as String) as Map<String, dynamic>;
          if (json['type'] == 'position') {
            _positionsCtrl.add(PositionLivreur(
              (json['latitude'] as num).toDouble(),
              (json['longitude'] as num).toDouble(),
              json['maj_le'] as String?,
            ));
          }
        } catch (_) {
          // trame inattendue : on ignore
        }
      },
      onDone: _surFermeture,
      onError: (_) => _surFermeture(),
      cancelOnError: true,
    );
  }

  void _surFermeture() {
    final code = _canal?.closeCode;
    if (code == 4001 || code == 4003) {
      _etatCtrl.add(EtatPositionSocket.refuse);
      return;
    }
    if (_fermeManuellement) {
      _etatCtrl.add(EtatPositionSocket.deconnecte);
      return;
    }
    _planifierReconnexion();
  }

  void _planifierReconnexion() {
    _etatCtrl.add(EtatPositionSocket.deconnecte);
    _reconnexionTimer?.cancel();
    final delaiSec = (1 << _tentatives).clamp(1, 30);
    _tentatives = (_tentatives + 1).clamp(0, 5);
    _reconnexionTimer = Timer(Duration(seconds: delaiSec), connecter);
  }

  /// Emet la position courante (reserve au livreur cote serveur).
  void envoyerPosition(double latitude, double longitude) {
    if (_canal == null) return;
    _canal!.sink.add(jsonEncode({
      'latitude': latitude,
      'longitude': longitude,
    }));
  }

  Future<void> fermer() async {
    _fermeManuellement = true;
    _reconnexionTimer?.cancel();
    await _sub?.cancel();
    await _canal?.sink.close();
    await _positionsCtrl.close();
    await _etatCtrl.close();
  }
}
