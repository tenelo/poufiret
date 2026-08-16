import 'package:flutter/material.dart';

import '../../fonctionnalites/prestations/screens/ecran_demande_detail.dart';
import '../../fonctionnalites/chat/screens/ecran_discussion.dart';
import '../../fonctionnalites/livraison/screens/ecran_suivi.dart';

/// Cle de navigation globale : permet de naviguer depuis un tap de
/// notification, hors de l'arbre de widgets (handlers FCM top-level).
/// Posee sur le MaterialApp (navigatorKey).
final GlobalKey<NavigatorState> navigatorNotifications =
    GlobalKey<NavigatorState>();

/// Routeur central de navigation par notification.
///
/// Prend le `data` d'un message FCM et ouvre l'ecran pertinent selon `type`.
/// Chaque canal (livraison, chat, ...) ajoute un case ici. Silencieux si le
/// type est inconnu ou l'identifiant manquant (jamais de crash).
class RouteurNotifications {
  RouteurNotifications._();

  /// Ouvre l'ecran correspondant au payload. A appeler apres un tap.
  static Future<void> ouvrirDepuisData(Map<String, dynamic> data) async {
    final nav = navigatorNotifications.currentState;
    if (nav == null) return; // navigateur pas encore pret

    final type = (data['type'] ?? '').toString();

    switch (type) {
      // ── Livraison : notifs de course (transition ou destinataire) ──
      case 'course_transition':
      case 'course_destinataire':
        final id = (data['course_id'] ?? '').toString();
        if (id.isEmpty) return;
        await nav.push(
          MaterialPageRoute(
            builder: (_) => EcranSuivi(courseId: id),
          ),
        );

      // ── Chat : ouvre la conversation exacte ──
      case 'message':
        final cid = int.tryParse((data['conversation_id'] ?? '').toString());
        if (cid == null) return;
        final titre = (data['expediteur_nom'] ?? 'Conversation').toString();
        await nav.push(
          MaterialPageRoute(
            builder: (_) => EcranDiscussion(
              conversationId: cid,
              titre: titre,
            ),
          ),
        );


      // ── Intervention : ouvre le detail de la demande ──
      case 'intervention':
        final did = int.tryParse((data['id'] ?? '').toString());
        if (did == null) return;
        final estArtisan = (data['est_artisan'] ?? '0').toString() == '1';
        await nav.push(
          MaterialPageRoute(
            builder: (_) => EcranDemandeDetail(
              demandeId: did,
              estArtisan: estArtisan,
            ),
          ),
        );

      default:
        // Type inconnu : on ne fait rien (l'app s'ouvre normalement).
        return;
    }
  }

  /// Convertit un payload FCM (`Map` typé lâche) en `Map<String, dynamic>` propre.
  static Map<String, dynamic> normaliser(Map<Object?, Object?> brut) {
    return brut.map((k, v) => MapEntry(k.toString(), v));
  }
}
