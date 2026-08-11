import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Affiche une banniere systeme quand un message FCM arrive alors que
/// l'app est au PREMIER PLAN (Android n'affiche rien automatiquement dans
/// ce cas ; il faut creer la notification nous-memes).
///
/// App en arriere-plan ou fermee : Android affiche la notif tout seul a
/// partir du bloc `notification` du message.
class NotificationsLocales {
  NotificationsLocales._();
  static final NotificationsLocales instance = NotificationsLocales._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _canalId = 'poufiret_messages';
  static const _canalNom = 'Notifications Poufiret';
  static const _canalDescription =
      'Messages, commandes et interventions Poufiret';

  bool _pret = false;

  Future<void> initialiser() async {
    if (_pret) return;

    const paramAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const params = InitializationSettings(android: paramAndroid);
    await _plugin.initialize(params);

    const canal = AndroidNotificationChannel(
      _canalId,
      _canalNom,
      description: _canalDescription,
      importance: Importance.high,
    );

    final impl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await impl?.createNotificationChannel(canal);

    _pret = true;
  }

  Future<void> afficherDepuisMessage(RemoteMessage message) async {
    await initialiser();

    final notif = message.notification;
    final titre = notif?.title ?? message.data['titre'] ?? 'Poufiret';
    final corps = notif?.body ?? message.data['corps'] ?? '';
    if (corps.isEmpty && notif == null) return;

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _canalId,
        _canalNom,
        channelDescription: _canalDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _plugin.show(id, titre, corps, details);
  }
}
