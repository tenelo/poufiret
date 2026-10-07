import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'notificateur.dart';

/// Indicatif ajouté aux numéros locaux pour WhatsApp (Côte d'Ivoire).
const _indicatif = '225';

/// Lien d'appel téléphonique.
Uri uriAppel(String numero) => Uri(scheme: 'tel', path: numero.trim());

/// Lien WhatsApp : un numéro local (10 chiffres) reçoit l'indicatif du pays.
Uri uriWhatsapp(String numero) {
  final chiffres = numero.replaceAll(RegExp(r'[^0-9]'), '');
  final complet = numero.trim().startsWith('+') || chiffres.length > 10
      ? chiffres
      : '$_indicatif$chiffres';
  return Uri.parse('https://wa.me/$complet');
}

/// Itinéraire vers un point, dans l'application de cartes du téléphone.
Uri uriItineraire(double latitude, double longitude) => Uri.parse(
  'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
);

/// Ouvre [uri] hors de l'app ; notifie si le téléphone ne sait pas l'ouvrir.
Future<void> ouvrirLien(BuildContext context, Uri uri) async {
  final messenger = ScaffoldMessenger.of(context);
  var ok = false;
  try {
    ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    ok = false;
  }
  if (!ok) {
    messenger.showSnackBar(
      Notificateur.snackErreur("Impossible d'ouvrir ce lien."),
    );
  }
}
