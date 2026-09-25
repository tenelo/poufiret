import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global/navigation/app_shell.dart';
import 'global/notifications/fcm_service.dart';
import 'global/notifications/routeur_notifications.dart';
import 'global/carte/services_google.dart';
import 'global/reseau/etat_reseau.dart';
import 'global/ui/theme_poufiret.dart';
import 'fonctionnalites/analytics/donnees/analytics_providers.dart';
import 'fonctionnalites/auth/screens/auth_notifier.dart';
import 'fonctionnalites/auth/screens/ecran_connexion.dart';
import 'fonctionnalites/auth/screens/ecran_changer_pin.dart';
import 'fonctionnalites/publicites/widgets/couche_publicites.dart';
import 'fonctionnalites/publicites/widgets/observateur_interstitiel.dart';
import 'fonctionnalites/version/donnees/version_providers.dart';
import 'fonctionnalites/version/donnees/version_repository.dart';
import 'fonctionnalites/version/widgets/couche_mise_a_jour.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Préchauffage : le contrôle de version part tout de suite (ouvre la
  // connexion TLS du pool partagé) pendant que Firebase s'initialise.
  final controleVersion = VersionRepository().verifier();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
  runApp(
    ProviderScope(
      overrides: [
        controleVersionProvider.overrideWith((ref) => controleVersion),
      ],
      child: const PoufiretApp(),
    ),
  );
}

class PoufiretApp extends StatelessWidget {
  const PoufiretApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poufiret',
      navigatorKey: navigatorNotifications,
      theme: ThemePoufiret.clair,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [observateurNavigation],
      builder: (context, enfant) => _AvecBandeauHorsLigne(enfant: enfant!),
      home: const CoucheMiseAJour(enfant: _Racine()),
    );
  }
}

/// Affiche le bandeau « Hors connexion » sous toute l'app.
///
/// La structure (Column > Expanded > MediaQuery > enfant) est constante : seul
/// le bandeau apparait/disparait, le Navigator n'est jamais remonte.
class _AvecBandeauHorsLigne extends ConsumerWidget {
  const _AvecBandeauHorsLigne({required this.enfant});
  final Widget enfant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horsLigne = ref.watch(etatReseauProvider);
    return Column(
      children: [
        Expanded(
          // Le bandeau occupe le bas de l'ecran : l'app n'a plus a reserver
          // la zone de geste systeme tant qu'il est la.
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: horsLigne,
            child: enfant,
          ),
        ),
        const BandeauHorsLigne(),
      ],
    );
  }
}

/// Aiguille selon l'etat d'authentification et pilote le suivi de session.
class _Racine extends ConsumerStatefulWidget {
  const _Racine();

  @override
  ConsumerState<_Racine> createState() => _RacineState();
}

class _RacineState extends ConsumerState<_Racine> with WidgetsBindingObserver {
  // Vrai des que la coquille d'accueil a ete construite une premiere fois.
  bool _accueilAffiche = false;
  // Vrai tant que FCM + session analytics sont lances pour l'utilisateur
  // connecte courant (remis a faux a la deconnexion).
  bool _servicesLances = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Detection des services Google (carte Google ou OpenStreetMap) : lancee
    // au demarrage, sans attente ; le resultat reste en memoire.
    ref.read(servicesGoogleProvider);
  }

  /// Notifications push + session analytics : hors du chemin critique. Lances
  /// sans attente, APRES le premier rendu de l'accueil (jamais avant, pour ne
  /// pas concurrencer les requetes qui remplissent la grille).
  void _lancerServicesDifferes() {
    if (_servicesLances || ref.read(authProvider).value == null) return;
    _servicesLances = true;
    ref.read(fcmServiceProvider).initialiser();
    ref.read(sessionAnalyticsProvider.notifier).demarrer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Le heartbeat ne tourne que quand l'app est reellement au premier plan :
  /// une session mise en pause s'arrete au dernier ping recu par le serveur.
  @override
  void didChangeAppLifecycleState(AppLifecycleState etat) {
    // Retour au premier plan : si le profil n'a pas encore ete confirme par
    // le serveur (demarrage hors connexion), on retente tout de suite.
    if (etat == AppLifecycleState.resumed) {
      ref.read(authProvider.notifier).revalider();
    }
    final connecte = ref.read(authProvider).value != null;
    if (!connecte) return;
    final session = ref.read(sessionAnalyticsProvider.notifier);
    switch (etat) {
      case AppLifecycleState.resumed:
        session.reprendre();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        session.arreter();
      case AppLifecycleState.inactive:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen(authProvider, (avant, apres) {
      final user = apres.value;
      final etaitConnecte = avant?.value != null;
      if (user != null && !etaitConnecte) {
        // Connexion : notifications push + ouverture de la session analytics.
        // Au lancement (session restauree), l'accueil n'est pas encore
        // affiche : le lancement est alors differe a son premier rendu.
        if (_accueilAffiche) _lancerServicesDifferes();
      } else if (user == null && etaitConnecte) {
        _servicesLances = false;
        ref.read(sessionAnalyticsProvider.notifier).arreter();
        // Deconnexion : on retire le token FCM de cet appareil.
        ref.read(fcmServiceProvider).desenregistrer();
      }
    });

    // Premier chargement uniquement (aucune valeur encore) : spinner.
    if (auth.isLoading && !auth.hasValue) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // Erreur au tout premier chargement (jamais eu de valeur) : login.
    if (auth.hasError && !auth.hasValue) {
      return const EcranConnexion();
    }
    // On s'appuie sur la valeur (preservee pendant loading/error transitoires),
    // pour ne PAS demonter l'ecran courant pendant un changement de PIN.
    final user = auth.value;
    if (user != null && user.pinParDefaut) {
      return const EcranChangerPin(bloquant: true);
    }
    if (!_accueilAffiche) {
      _accueilAffiche = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _lancerServicesDifferes(),
      );
    }
    return const ObservateurInterstitiel(
      enfant: CouchePublicites(enfant: AppShell()),
    );
  }
}
