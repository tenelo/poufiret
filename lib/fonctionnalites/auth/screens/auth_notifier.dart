import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/cache/cache_providers.dart';
import '../../../global/network/providers.dart';
import '../../../global/reseau/etat_reseau.dart';
import '../donnees/auth_providers.dart';
import '../metier_domaine/utilisateur.dart';

part 'auth_notifier.g.dart';

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
///
/// Session robuste : seul un VRAI échec d'authentification (refresh refusé,
/// 401/403 après renouvellement) déconnecte. Un timeout, une coupure réseau
/// ou un 5xx gardent la session : l'app démarre avec le dernier utilisateur
/// connu (cache disque) et `moi` est revalidé en arrière-plan.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  /// Portée disque du dernier profil connu (indépendante de l'id, qu'on ne
  /// connaît pas encore au lancement).
  static const porteeSession = 'session';
  static const _cleMoi = 'moi';

  int? _idCourant;
  // Opérations disque exécutées l'une après l'autre : une écriture du profil
  // ne peut pas « doubler » la purge d'une déconnexion.
  Future<void> _serieDisque = Future.value();
  Timer? _reessai;
  Timer? _demarrage;
  int _echecs = 0;
  bool _revalidationEnCours = false;
  // Vrai tant que le profil affiché n'a pas été confirmé par le serveur.
  bool _aRevalider = false;

  @override
  Future<Utilisateur?> build() async {
    final tokens = ref.watch(tokenStorageProvider);
    ref.onDispose(() {
      _reessai?.cancel();
      _demarrage?.cancel();
    });
    listenSelf(_suivreEtat);
    // Le réseau revient : on revalide le profil sans attendre le prochain essai.
    ref.listen(etatReseauProvider, (avant, apres) {
      if (avant == true && apres == false && _aRevalider) revalider();
    });

    // Au démarrage : s'il y a un refresh stocké, on récupère le profil.
    if (!await tokens.aSession) return null;

    // Démarrage optimiste : dernier profil connu, affiché immédiatement,
    // revalidé en arrière-plan.
    final memorise = await _lireMemorise();
    if (memorise != null) {
      _aRevalider = true;
      _demarrage = Timer(Duration.zero, revalider);
      return memorise;
    }

    // Aucun profil en cache : il faut attendre le serveur.
    try {
      return await ref.read(authRepositoryProvider).moi();
    } catch (e) {
      if (_estRefusAuth(e)) {
        // Token invalide/expiré sans refresh possible → session morte.
        await tokens.effacer();
        return null;
      }
      // Réseau, timeout, 5xx : la session est conservée. En attendant, on est
      // visiteur ; la revalidation reprend la main dès que le réseau revient.
      _aRevalider = true;
      _planifierReessai();
      return null;
    }
  }

  /// Vrai si l'erreur est un refus d'authentification définitif.
  static bool _estRefusAuth(Object e) {
    if (e is! DioException) return false;
    final code = e.response?.statusCode;
    return code == 401 || code == 403;
  }

  Future<Utilisateur?> _lireMemorise() async {
    final entree = await ref
        .read(cacheDisqueProvider)
        .lire(porteeSession, _cleMoi);
    final donnees = entree?.donnees;
    if (donnees is! Map) return null;
    try {
      return Utilisateur.fromJson(Map<String, dynamic>.from(donnees));
    } catch (_) {
      return null;
    }
  }

  /// Garde le cache disque cohérent avec l'état : profil mémorisé à chaque
  /// connexion / mise à jour ; purge des données de l'utilisateur à la
  /// déconnexion, à l'expiration de session ou au changement de compte.
  void _suivreEtat(
    AsyncValue<Utilisateur?>? avant,
    AsyncValue<Utilisateur?> apres,
  ) {
    if (apres.isLoading || apres.hasError) return;
    final u = apres.value;
    final disque = ref.read(cacheDisqueProvider);
    final api = ref.read(cacheApiProvider);
    final ancien = _idCourant;
    if (ancien != null && ancien != u?.id) {
      _enSerie(() => api.purgerUtilisateur(ancien));
    }
    if (u == null) {
      _idCourant = null;
      _enSerie(() => disque.purgerPortee(porteeSession));
    } else {
      _idCourant = u.id;
      final profil = u.toJson();
      _enSerie(() => disque.ecrire(porteeSession, _cleMoi, profil));
    }
  }

  void _enSerie(Future<void> Function() operation) {
    _serieDisque = _serieDisque.then((_) => operation()).catchError((_) {});
  }

  void _planifierReessai() {
    _echecs++;
    _reessai?.cancel();
    final secondes = math.min(60, 10 * (1 << math.min(_echecs - 1, 3)));
    _reessai = Timer(Duration(seconds: secondes), revalider);
  }

  /// Revalide le profil auprès du serveur (sans jamais passer par un état
  /// de chargement : l'écran garde le profil affiché). Sans effet si le
  /// profil est déjà confirmé, sauf [forcer].
  Future<void> revalider({bool forcer = false}) async {
    if (!ref.mounted || _revalidationEnCours || (!_aRevalider && !forcer)) {
      return;
    }
    // Etat pas encore pose (build ou connexion en cours) : l'identite de
    // depart serait inconnue. On repasse dans un instant.
    if (state.isLoading) {
      _demarrage?.cancel();
      _demarrage = Timer(const Duration(milliseconds: 100), revalider);
      return;
    }
    _revalidationEnCours = true;
    _reessai?.cancel();
    final tokens = ref.read(tokenStorageProvider);
    // Identité au départ : si l'utilisateur se déconnecte ou change de compte
    // pendant l'appel, la réponse (ou le 401) de l'ancienne session ne doit
    // ni écraser le nouveau profil, ni effacer les nouveaux tokens.
    final idAuDepart = state.value?.id;
    try {
      final refreshAuDepart = await tokens.refreshToken;
      Future<bool> memeSession() async =>
          ref.mounted &&
          state.value?.id == idAuDepart &&
          await tokens.refreshToken == refreshAuDepart;

      try {
        final u = await ref.read(authRepositoryProvider).moi();
        if (!await memeSession()) return;
        _aRevalider = false;
        _echecs = 0;
        if (state.value != u) {
          state = AsyncData(u);
        } else {
          // Inchangé : on rafraîchit seulement l'horodatage du cache.
          final disque = ref.read(cacheDisqueProvider);
          final profil = u.toJson();
          _enSerie(() => disque.ecrire(porteeSession, _cleMoi, profil));
        }
      } catch (e) {
        if (!await memeSession()) return;
        if (_estRefusAuth(e)) {
          await tokens.effacer();
          state = const AsyncData(null);
        } else {
          _planifierReessai();
        }
      }
    } finally {
      _revalidationEnCours = false;
    }
  }

  /// Connexion par téléphone + code PIN.
  Future<void> connexion({
    required String telephone,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .connexion(telephone: telephone, password: password);
    });
  }


/// Inscription : crée le compte puis connecte directement (tokens renvoyés).
  Future<void> inscription({
    required String prenom,
    required String nom,
    required String telephone,
    required String password,
    int? departement,
    String? trancheAge,
    String? sexe,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .inscription(
            prenom: prenom,
            nom: nom,
            telephone: telephone,
            password: password,
            departement: departement,
            trancheAge: trancheAge,
            sexe: sexe,
          );
    });
  }

  
  /// Déconnexion : blackliste côté serveur + efface localement.
  Future<void> deconnexion() async {
    await ref.read(authRepositoryProvider).deconnexion();
    state = const AsyncData(null);
  }

  // ── Flux OTP + PIN ───────────────────────────────────────────────────────

  /// Étape intermédiaire : demande un OTP. Ne modifie pas l'état d'auth
  /// (l'écran gère son propre indicateur de chargement).
  /// Renvoie {deja_verifie, compte_existe, otp_envoye}.
  Future<Map<String, dynamic>> demanderOtp({
    required String telephone,
    required String but,
  }) {
    return ref
        .read(authRepositoryProvider)
        .demanderOtp(telephone: telephone, but: but);
  }

  /// Étape intermédiaire : vérifie l'OTP. Ne modifie pas l'état d'auth.
  /// Lève si le code est incorrect/expiré.
  Future<void> verifierOtp({
    required String telephone,
    required String code,
    required String but,
  }) {
    return ref
        .read(authRepositoryProvider)
        .verifierOtp(telephone: telephone, code: code, but: but);
  }

  /// Étape finale : définit/réinitialise le PIN et CONNECTE l'utilisateur.
  /// Fait basculer l'état en connecté (comme connexion()).
  /// [but] : 'inscription' ou 'reinit_pin'.
  Future<void> definirPin({
    required String telephone,
    required String password,
    required String but,
    String? prenom,
    String? nom,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .definirPin(
            telephone: telephone,
            password: password,
            but: but,
            prenom: prenom,
            nom: nom,
          );
    });
  }

  // ── Firebase Phone Auth (Option A) ──────────────────────────────────────

  /// Étape finale (inscription via Firebase Phone Auth) : crée le compte à
  /// partir de l'idToken Firebase (numéro déjà prouvé) + PIN, et CONNECTE
  /// l'utilisateur. Fait basculer l'état en connecté (comme connexion()).
  Future<void> inscriptionFirebase({
    required String idToken,
    required String password,
    String? prenom,
    String? nom,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .inscriptionFirebase(
            idToken: idToken,
            password: password,
            prenom: prenom,
            nom: nom,
          );
    });
  }

  /// Étape finale (réinitialisation de PIN via Firebase Phone Auth) :
  /// réinitialise le PIN à partir de l'idToken Firebase + nouveau PIN, et
  /// RECONNECTE l'utilisateur.
  Future<void> reinitPinFirebase({
    required String idToken,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .reinitPinFirebase(idToken: idToken, password: password);
    });
  }

  /// Déverrouillage par empreinte : lit le téléphone + PIN mémorisés et
  /// rejoue la connexion serveur (JWT frais). L'empreinte a déjà été
  /// validée par l'appelant (ServiceBiometrie). Échoue si aucun PIN
  /// mémorisé (ex. compte jamais connecté sur cet appareil).
  Future<void> deverrouillerParEmpreinte() async {
    final tokens = ref.read(tokenStorageProvider);
    final telephone = await tokens.telephone;
    final pin = await tokens.pin;
    if (telephone == null || pin == null) {
      throw StateError('Aucune identité mémorisée pour le déverrouillage.');
    }
    await connexion(telephone: telephone, password: pin);
  }

  /// Met à jour le profil (PATCH /auth/moi/) et rafraîchit l'état connecté.
  /// Utilisé après inscription pour enregistrer département/tranche/sexe.
  Future<void> modifierProfil(Map<String, dynamic> donnees) async {
    if (donnees.isEmpty) return;
    final maj = await ref.read(authRepositoryProvider).modifierProfil(donnees);
    state = AsyncData(maj);
  }

  /// Change le PIN (utilisateur connecté). Met à jour l'état avec le profil
  /// renvoyé (pin_par_defaut repassé à false).
  Future<void> changerPin({
    required String ancienPin,
    required String nouveauPin,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).changerPin(
            ancienPin: ancienPin,
            nouveauPin: nouveauPin,
          );
    });
  }
}
