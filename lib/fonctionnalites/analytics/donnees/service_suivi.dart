import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/ui/liens_externes.dart';

import 'analytics_providers.dart';

/// Actions du client que le serveur ne voit pas passer (elles quittent
/// l'app : appel, WhatsApp, partage, itinéraire).
enum TypeEvenement {
  appelPartenaire('appel_partenaire'),
  whatsappPartenaire('whatsapp_partenaire'),
  partageArticle('partage_article'),
  partagePartenaire('partage_partenaire'),
  itinerairePartenaire('itineraire_partenaire');

  const TypeEvenement(this.code);
  final String code;
}

/// Suivi d'usage, envoyé au serveur sans jamais gêner l'interface.
///
/// Les événements attendent dans une file en mémoire et partent par lots
/// (50 au plus) toutes les [intervalle] et quand l'app passe en
/// arrière-plan ([vider]). Un envoi raté est gardé pour le suivant, dans la
/// limite de [_capacite] événements. Aucune erreur ne remonte.
class ServiceSuivi {
  ServiceSuivi({
    required this._envoyerLot,
    required this._envoyerClic,
    Duration intervalle = const Duration(seconds: 30),
    bool minuteur = true,
  }) {
    if (minuteur) _minuteur = Timer.periodic(intervalle, (_) => vider());
  }

  /// Envoie un lot d'événements ; lève en cas d'échec.
  final Future<void> Function(List<Map<String, dynamic>> lot) _envoyerLot;

  /// Envoie un clic (recherche, type et id du résultat) ; lève en cas
  /// d'échec.
  final Future<void> Function(
    int rechercheId,
    String resultatType,
    int resultatId,
  )
  _envoyerClic;
  Timer? _minuteur;

  static const tailleLot = 50;
  static const _capacite = 500;

  final _file = <Map<String, dynamic>>[];
  Future<void>? _envoiEnCours;

  /// Événements en attente d'envoi.
  int get enAttente => _file.length;

  void evenement(
    TypeEvenement type, {
    int? partenaireId,
    String? objetType,
    String? objetId,
    Map<String, dynamic>? donnees,
  }) {
    _file.add({
      'type': type.code,
      'partenaire_id': ?partenaireId,
      'objet_type': ?objetType,
      'objet_id': ?objetId,
      if (donnees != null && donnees.isNotEmpty) 'donnees': donnees,
    });
    // File pleine (longue période hors ligne) : on oublie les plus anciens.
    if (_file.length > _capacite) {
      _file.removeRange(0, _file.length - _capacite);
    }
  }

  /// Résultat touché après une recherche (article ou partenaire). Sans
  /// [rechercheId] (terme trop court, recherche non journalisée) : rien.
  /// Un 409 (clic déjà compté) comme toute autre erreur est ignoré.
  void clicRecherche(int? rechercheId, String resultatType, int resultatId) {
    if (rechercheId == null) return;
    unawaited(
      _envoyerClic(
        rechercheId,
        resultatType,
        resultatId,
      ).catchError((Object _) {}),
    );
  }

  /// Envoie tout ce qui attend, par lots. Un seul envoi à la fois.
  Future<void> vider() =>
      _envoiEnCours ??= _vider().whenComplete(() => _envoiEnCours = null);

  Future<void> _vider() async {
    while (_file.isNotEmpty) {
      final n = _file.length < tailleLot ? _file.length : tailleLot;
      final lot = _file.sublist(0, n);
      _file.removeRange(0, n);
      try {
        await _envoyerLot(lot);
      } catch (_) {
        // Échec (réseau...) : le lot reprend sa place, en tête, pour le
        // prochain envoi.
        _file.insertAll(0, lot);
        return;
      }
    }
  }

  void dispose() {
    _minuteur?.cancel();
    _minuteur = null;
  }
}

/// Service de suivi de l'app (un seul, vivant tant que l'app tourne).
final serviceSuiviProvider = Provider<ServiceSuivi>((ref) {
  final repo = ref.watch(analyticsRepositoryProvider);
  final service = ServiceSuivi(
    envoyerLot: repo.envoyerEvenements,
    envoyerClic: (id, type, resultat) =>
        repo.envoyerClicRecherche(id, resultatType: type, resultatId: resultat),
  );
  ref.onDispose(service.dispose);
  return service;
});

/// Note un événement depuis un widget, sans jamais lever d'erreur (écran
/// hors ProviderScope, en test par exemple).
void suivreEvenement(
  BuildContext context,
  TypeEvenement type, {
  int? partenaireId,
  String? objetType,
  String? objetId,
}) {
  try {
    ProviderScope.containerOf(context, listen: false)
        .read(serviceSuiviProvider)
        .evenement(
          type,
          partenaireId: partenaireId,
          objetType: objetType,
          objetId: objetId,
        );
  } catch (_) {
    // Le suivi ne bloque jamais l'interface.
  }
}

/// Clic sur un résultat de recherche, depuis un widget (voir
/// [ServiceSuivi.clicRecherche]).
void suivreClicRecherche(
  BuildContext context,
  int? rechercheId,
  String resultatType,
  int resultatId,
) {
  try {
    ProviderScope.containerOf(context, listen: false)
        .read(serviceSuiviProvider)
        .clicRecherche(rechercheId, resultatType, resultatId);
  } catch (_) {}
}

/// Appelle un partenaire et note l'appel.
Future<void> appelerPartenaire(
  BuildContext context,
  String numero, {
  int? partenaireId,
}) {
  suivreEvenement(
    context,
    TypeEvenement.appelPartenaire,
    partenaireId: partenaireId,
  );
  return ouvrirLien(context, uriAppel(numero));
}

/// Ouvre WhatsApp vers un partenaire et le note.
Future<void> whatsappPartenaire(
  BuildContext context,
  String numero, {
  int? partenaireId,
}) {
  suivreEvenement(
    context,
    TypeEvenement.whatsappPartenaire,
    partenaireId: partenaireId,
  );
  return ouvrirLien(context, uriWhatsapp(numero));
}

/// Ouvre l'itinéraire vers un partenaire et le note.
Future<void> itinerairePartenaire(
  BuildContext context,
  double latitude,
  double longitude, {
  int? partenaireId,
}) {
  suivreEvenement(
    context,
    TypeEvenement.itinerairePartenaire,
    partenaireId: partenaireId,
  );
  return ouvrirLien(context, uriItineraire(latitude, longitude));
}
