import 'package:flutter/material.dart';

import '../config/config.dart';

/// Nature d'un message express, pour choisir couleur et icone.
enum TypeNotification { succes, info, avertissement, erreur }

/// Presentation unique des notifications express (snackbars) de l'app.
///
/// Toutes les confirmations, informations et erreurs passent par ici pour
/// garder une forme identique (couleur, icone, coins, marge, duree) d'un
/// ecran a l'autre. Deux façons de l'utiliser :
///  - la plupart des ecrans : `Notificateur.succes(context, 'texte')`.
///  - un ecran qui a deja capture un `ScaffoldMessengerState` avant un
///    `await` (pour eviter d'utiliser `context` apres un point d'attente) :
///    `messenger.showSnackBar(Notificateur.snackSucces('texte'))`.
class Notificateur {
  Notificateur._();

  static const Duration _duree = Duration(seconds: 3);

  /// Confirmation d'une action reussie (ex. « Article ajouté au panier »).
  static void succes(BuildContext context, String message, {SnackBarAction? action}) =>
      _afficher(context, message, TypeNotification.succes, action: action);

  /// Information neutre ou incitation, sans echec ni confirmation.
  static void info(BuildContext context, String message, {SnackBarAction? action}) =>
      _afficher(context, message, TypeNotification.info, action: action);

  /// Avertissement : une intervention de l'utilisateur est nécessaire.
  static void avertissement(BuildContext context, String message,
          {SnackBarAction? action}) =>
      _afficher(context, message, TypeNotification.avertissement, action: action);

  /// Echec d'une action, erreur reseau ou serveur.
  static void erreur(BuildContext context, String message, {SnackBarAction? action}) =>
      _afficher(context, message, TypeNotification.erreur, action: action);

  static SnackBar snackSucces(String message, {SnackBarAction? action}) =>
      construire(message, TypeNotification.succes, action: action);
  static SnackBar snackInfo(String message, {SnackBarAction? action}) =>
      construire(message, TypeNotification.info, action: action);
  static SnackBar snackAvertissement(String message, {SnackBarAction? action}) =>
      construire(message, TypeNotification.avertissement, action: action);
  static SnackBar snackErreur(String message, {SnackBarAction? action}) =>
      construire(message, TypeNotification.erreur, action: action);

  static void _afficher(
    BuildContext context,
    String message,
    TypeNotification type, {
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(construire(message, type, action: action));
  }

  /// Construit le SnackBar sans l'afficher : utile quand l'ecran a deja
  /// capture un `ScaffoldMessengerState` avant un `await`.
  static SnackBar construire(
    String message,
    TypeNotification type, {
    SnackBarAction? action,
  }) {
    final (couleur, icone) = switch (type) {
      TypeNotification.succes => (
          Config.couleurSucces,
          Icons.check_circle_outline,
        ),
      TypeNotification.info => (Config.couleurPrimaire, Icons.info_outline),
      TypeNotification.avertissement => (
          Config.couleurAvertissement,
          Icons.warning_amber_outlined,
        ),
      TypeNotification.erreur => (Config.couleurErreur, Icons.error_outline),
    };

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: couleur,
      duration: _duree,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      action: action,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
