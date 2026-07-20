import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/env.dart';
import '../network/providers.dart';

part 'fcm_service.g.dart';

/// Handler des messages recus quand l'app est totalement fermee ou en fond.
/// DOIT etre une fonction top-level (exigence Android).
@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Les notifications (title/body) sont affichees automatiquement par
  // Android quand l'app est en fond : rien d'autre a faire ici pour le MVP.
}

/// Service FCM : permission, token, envoi au backend, ecoute des messages.
class FcmService {
  FcmService(this._dio);

  final Dio _dio;
  StreamSubscription<String>? _subToken;
  StreamSubscription<RemoteMessage>? _subMessages;

  /// Notifications recues app OUVERTE (a ecouter dans l'UI si besoin).
  final ValueNotifier<RemoteMessage?> dernierMessage = ValueNotifier(null);

  /// A appeler apres connexion de l'utilisateur.
  Future<void> initialiser() async {
    final fcm = FirebaseMessaging.instance;

    // 1. Permission (Android 13+ affiche une vraie boite de dialogue).
    final autorisation = await fcm.requestPermission();
    if (autorisation.authorizationStatus == AuthorizationStatus.denied) {
      return; // refus : on n'insiste pas, l'app fonctionne sans push
    }

    // 2. Token de l'appareil -> backend.
    final token = await fcm.getToken();
    if (token != null) {
      await _envoyerToken(token);
    }

    // 3. Rotation du token (Firebase peut le renouveler a tout moment).
    _subToken = fcm.onTokenRefresh.listen(_envoyerToken);

    // 4. Messages recus app ouverte (pas de banniere systeme dans ce cas).
    _subMessages = FirebaseMessaging.onMessage.listen((m) {
      dernierMessage.value = m;
    });
  }

  Future<void> _envoyerToken(String token) async {
    try {
      await _dio.post('${Env.apiPrefix}/notifications/token/', data: {'token_fcm': token});
    } catch (e) {
      // Reseau indisponible : le token repartira au prochain demarrage.
    }
  }

  Future<void> disposer() async {
    await _subToken?.cancel();
    await _subMessages?.cancel();
  }
}

@Riverpod(keepAlive: true)
FcmService fcmService(Ref ref) => FcmService(ref.watch(dioProvider));
