import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../global/notifications/routeur_notifications.dart';
import '../metier_domaine/parcours_decouverte.dart';
import '../screens/ecran_decouvrir_poufiret.dart';
import 'publicites_providers.dart';

/// Parcours « Découvrir Poufiret » du serveur, lu une fois par lancement.
/// Sert à l'affichage automatique et à l'entrée du menu.
final parcoursDecouverteProvider = FutureProvider<ParcoursDecouverte>(
  (ref) => ref.watch(publicitesRepositoryProvider).decouvrir(),
);

/// Vrai si le parcours doit s'ouvrir tout seul : actif, avec des écrans, et
/// d'une version différente de la dernière vue sur cet appareil.
bool doitProposerDecouverte(ParcoursDecouverte parcours, String? versionVue) =>
    parcours.affichable && versionVue != '${parcours.version}';

/// Affichage automatique du parcours, une fois par version.
///
/// Ouvert seulement quand l'accueil est l'écran visible : jamais par-dessus
/// la connexion ou une autre fenêtre. Aucune erreur ne remonte : sans
/// réseau, il sera reproposé au prochain lancement.
class PropositionDecouverte {
  PropositionDecouverte(this._lireParcours, this._navigateur);

  final Future<ParcoursDecouverte> Function() _lireParcours;

  /// Navigateur racine de l'app.
  final GlobalKey<NavigatorState> _navigateur;

  /// Dernière version vue, mémorisée sur l'appareil.
  static const _cle = 'poufiret_decouverte_version_vue';
  static const _stockage = FlutterSecureStorage();

  /// Proposition de ce lancement : la même pour tous les appelants.
  Future<void>? _enCours;

  /// Se termine quand le parcours est fermé, ou tout de suite s'il n'y a
  /// rien à montrer. La demande de consentement attend cette fin.
  Future<void> proposerSiBesoin() => _enCours ??= _proposer();

  Future<void> _proposer() async {
    try {
      final parcours = await _lireParcours();
      final versionVue = await _stockage.read(key: _cle);
      if (!doitProposerDecouverte(parcours, versionVue)) return;
      final etat = await _accueilAffiche();
      if (etat == null || !etat.mounted) return;
      await etat.push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (_) => EcranDecouvrirPoufiret(parcours: parcours),
        ),
      );
      await _stockage.write(key: _cle, value: '${parcours.version}');
    } catch (_) {
      // Reproposé au prochain lancement.
    }
  }

  /// Attend que l'accueil soit l'écran visible (même attente que la demande
  /// de consentement) ; null au bout d'une minute.
  Future<NavigatorState?> _accueilAffiche() async {
    for (var i = 0; i < 120; i++) {
      final etat = _navigateur.currentState;
      if (etat != null && etat.mounted && !etat.canPop()) return etat;
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }
}

/// Proposition du lancement en cours.
final propositionDecouverteProvider = Provider<PropositionDecouverte>(
  (ref) => PropositionDecouverte(
    () => ref.read(parcoursDecouverteProvider.future),
    navigatorNotifications,
  ),
);
