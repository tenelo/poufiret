import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poufiret/global/network/dio_client.dart';
import 'package:poufiret/global/network/jwt.dart';
import 'package:poufiret/global/storage/token_storage.dart';

/// JWT factice : seul le `exp` du payload compte pour l'app.
String _jwt(DateTime exp, {String id = 'a'}) {
  String b64(Map<String, Object?> m) =>
      base64Url.encode(utf8.encode(jsonEncode(m))).replaceAll('=', '');
  return '${b64({'alg': 'none'})}.'
      '${b64({'exp': exp.millisecondsSinceEpoch ~/ 1000, 'jti': id})}.sig';
}

/// Faux serveur : rotation stricte des refresh tokens (un refresh déjà
/// consommé est refusé), 401 sur les access périmés.
class _FauxServeur implements HttpClientAdapter {
  _FauxServeur({required this.refreshValide});

  String? refreshValide; // null => tout refresh est refusé (401)
  bool refreshEnPanne = false; // 500 sur /rafraichir/
  final Set<String> accessRefuses = {}; // 401 même si exp est dans le futur
  final List<String?> autorisations = []; // header de chaque requête métier
  int appelsRefresh = 0;
  int compteur = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 30));

    if (options.path.contains('/auth/rafraichir/')) {
      appelsRefresh++;
      if (refreshEnPanne) return _reponse(500, {'detail': 'panne'});
      final envoye = (options.data as Map)['refresh'];
      if (refreshValide == null || envoye != refreshValide) {
        return _reponse(401, {'detail': 'Token is blacklisted'});
      }
      compteur++;
      refreshValide = 'refresh_$compteur'; // rotation
      return _reponse(200, {
        'access': _jwt(
          DateTime.now().add(const Duration(minutes: 30)),
          id: 'acc_$compteur',
        ),
        'refresh': refreshValide,
      });
    }

    final auth = options.headers['Authorization'] as String?;
    autorisations.add(auth);
    if (options.path.contains('/auth/')) return _reponse(200, {'ok': true});
    if (auth == null) return _reponse(401, {'detail': 'pas de token'});
    final access = auth.substring('Bearer '.length);
    if (accessRefuses.contains(access) ||
        expireBientot(access, marge: Duration.zero)) {
      return _reponse(401, {'detail': 'token expiré'});
    }
    return _reponse(200, {'ok': true});
  }

  ResponseBody _reponse(int code, Map<String, Object?> corps) =>
      ResponseBody.fromString(
        jsonEncode(corps),
        code,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}

void main() {
  late TokenStorage tokens;
  late _FauxServeur serveur;
  late Dio dio;
  late int deconnexions;

  final expire = DateTime.now().subtract(const Duration(minutes: 5));
  final valide = DateTime.now().add(const Duration(minutes: 30));

  Future<void> preparer({
    required String access,
    String refresh = 'refresh_0',
    String? refreshServeur = 'refresh_0',
  }) async {
    FlutterSecureStorage.setMockInitialValues({
      'poufiret_access': access,
      'poufiret_refresh': refresh,
    });
    tokens = TokenStorage();
    serveur = _FauxServeur(refreshValide: refreshServeur);
    deconnexions = 0;
    dio = DioClient.creer(
      tokens: tokens,
      onSessionExpiree: () => deconnexions++,
      adaptateur: serveur,
    );
  }

  test('jwt : lecture de exp et marge de 60 s', () {
    final t = _jwt(DateTime.now().add(const Duration(seconds: 30)));
    expect(expirationJwt(t), isNotNull);
    expect(expireBientot(t), isTrue); // < 60 s
    expect(expireBientot(_jwt(valide)), isFalse);
    expect(expireBientot('pas-un-jwt'), isFalse);
  });

  test('token valide : aucun refresh, token en mémoire envoyé', () async {
    final access = _jwt(valide);
    await preparer(access: access);

    final r = await Future.wait([
      dio.get('/api/v1/x/'),
      dio.get('/api/v1/y/'),
    ]);

    expect(r.map((e) => e.statusCode), everyElement(200));
    expect(serveur.appelsRefresh, 0);
    expect(serveur.autorisations, everyElement('Bearer $access'));
    expect(deconnexions, 0);
  });

  test('token expiré au lancement : refresh proactif, jamais envoyé périmé',
      () async {
    final ancien = _jwt(expire);
    await preparer(access: ancien);

    final r = await dio.get('/api/v1/moi/');

    expect(r.statusCode, 200);
    expect(serveur.appelsRefresh, 1);
    // Zéro requête métier partie avec le token périmé => zéro 401.
    expect(serveur.autorisations.contains('Bearer $ancien'), isFalse);
    expect(await tokens.refreshToken, 'refresh_1'); // rotation persistée
  });

  test('5 requêtes simultanées, token expiré : UN seul rafraichir', () async {
    await preparer(access: _jwt(expire));

    final r = await Future.wait([
      for (var i = 0; i < 5; i++) dio.get('/api/v1/r$i/'),
    ]);

    expect(r.map((e) => e.statusCode), everyElement(200));
    expect(serveur.appelsRefresh, 1);
    expect(deconnexions, 0);
    expect(await tokens.refreshToken, 'refresh_1');
  });

  test('5 requêtes qui reçoivent un 401 : UN seul rafraichir, toutes rejouées',
      () async {
    // exp dans le futur (pas de refresh proactif) mais refusé par le serveur.
    final revoque = _jwt(valide, id: 'revoque');
    await preparer(access: revoque);
    serveur.accessRefuses.add(revoque);

    final r = await Future.wait([
      for (var i = 0; i < 5; i++) dio.get('/api/v1/r$i/'),
    ]);

    expect(r.map((e) => e.statusCode), everyElement(200));
    expect(serveur.appelsRefresh, 1);
    expect(deconnexions, 0);
  });

  test('refresh token invalide : UNE seule déconnexion propre', () async {
    await preparer(access: _jwt(expire), refreshServeur: null);

    final resultats = await Future.wait([
      for (var i = 0; i < 5; i++)
        dio
            .get('/api/v1/r$i/')
            .then<Object?>((r) => r)
            .catchError((Object e) => e),
    ]);

    expect(resultats.every((e) => e is DioException), isTrue);
    expect(serveur.appelsRefresh, 1);
    expect(deconnexions, 1);
    expect(await tokens.aSession, isFalse); // tokens effacés
  });

  test('refresh en panne (5xx) : pas de déconnexion, session conservée',
      () async {
    await preparer(access: _jwt(expire));
    serveur.refreshEnPanne = true;

    await dio.get('/api/v1/r/').then<Object?>((r) => r).catchError((Object e) => e);

    expect(deconnexions, 0);
    expect(await tokens.aSession, isTrue);
  });

  test('routes publiques : aucun token envoyé, aucun refresh', () async {
    await preparer(access: _jwt(expire));

    await dio.post('/api/v1/auth/connexion/', data: {'telephone': '1'});

    expect(serveur.autorisations.single, isNull);
    expect(serveur.appelsRefresh, 0);
  });

  test('visiteur sans session : pas de token, 401 laissé passer sans logout',
      () async {
    FlutterSecureStorage.setMockInitialValues({});
    tokens = TokenStorage();
    serveur = _FauxServeur(refreshValide: null);
    deconnexions = 0;
    dio = DioClient.creer(
      tokens: tokens,
      onSessionExpiree: () => deconnexions++,
      adaptateur: serveur,
    );

    final res = await dio
        .get('/api/v1/protege/')
        .then<Object?>((r) => r)
        .catchError((Object e) => e);

    expect(res, isA<DioException>());
    expect(serveur.appelsRefresh, 0);
    expect(deconnexions, 0);
  });
}
