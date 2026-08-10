import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import '../data/auth_providers.dart';
import '../domain/utilisateur.dart';

part 'auth_notifier.g.dart';

/// État d'authentification de l'app.
/// - data(null)        → déconnecté
/// - data(Utilisateur) → connecté
/// - loading           → vérification/connexion en cours
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<Utilisateur?> build() async {
    // Au démarrage : s'il y a un refresh stocké, on tente de récupérer le profil.
    final tokens = ref.watch(tokenStorageProvider);
    if (!await tokens.aSession) return null;

    try {
      return await ref.read(authRepositoryProvider).moi();
    } catch (_) {
      // Token invalide/expiré sans refresh possible → session morte.
      await tokens.effacer();
      return null;
    }
  }

  /// Connexion par téléphone + mot de passe.
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
}
