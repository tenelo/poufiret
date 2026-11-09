import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/notifications/routeur_notifications.dart';

import '../metier_domaine/consentements.dart';
import '../widgets/choix_consentements.dart';
import 'consentements_repository.dart';

/// Après connexion : demande les choix de confidentialité une seule fois
/// (version absente ou ancienne). Fermer la feuille sans choisir enregistre
/// « non » aux deux. Aucune erreur ne remonte : sans réseau, la question
/// sera reposée à la prochaine ouverture de l'app.
class DemandeConsentement {
  DemandeConsentement(this._repo, this._navigateur);

  final ConsentementsRepository _repo;

  /// Navigateur racine de l'app.
  final GlobalKey<NavigatorState> _navigateur;

  /// Déjà proposé pendant cette exécution de l'app.
  bool _fait = false;

  Future<void> proposerSiBesoin() async {
    if (_fait) return;
    _fait = true;
    try {
      final actuels = await _repo.lire();
      if (!doitDemanderConsentement(actuels.version)) return;
      final contexte = await _accueilAffiche();
      if (contexte == null || !contexte.mounted) return;
      final choix = await ouvrirFeuilleConsentement(contexte);
      await _repo.enregistrer(
        statistiques: choix?.$1 ?? false,
        ia: choix?.$2 ?? false,
      );
    } catch (_) {
      _fait = false; // reproposé à la prochaine occasion
    }
  }

  /// Attend que l'accueil soit l'écran visible (pas d'écran de connexion ni
  /// de fenêtre par-dessus), pour ne pas se mêler au parcours en cours.
  Future<BuildContext?> _accueilAffiche() async {
    for (var i = 0; i < 120; i++) {
      final etat = _navigateur.currentState;
      if (etat != null && etat.mounted && !etat.canPop()) return etat.context;
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }
}

/// Demande de consentement de la session (recréée à la déconnexion).
final demandeConsentementProvider = Provider<DemandeConsentement>(
  (ref) => DemandeConsentement(
    ref.watch(consentementsRepositoryProvider),
    navigatorNotifications,
  ),
);
