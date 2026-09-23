import 'package:firebase_auth/firebase_auth.dart';

/// Erreur de vérification téléphonique Firebase, message déjà en français.
class ServiceAuthFirebaseException implements Exception {
  const ServiceAuthFirebaseException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Encapsule Firebase Phone Authentication : Firebase envoie et vérifie le
/// SMS, l'app récupère seulement un idToken à échanger contre une session
/// backend (POST /auth/firebase/inscription/ ou /auth/firebase/reinit-pin/).
///
/// Une instance = une tentative de vérification (elle retient
/// verificationId/resendToken) : en créer une nouvelle par écran/flux,
/// ne pas la partager entre l'inscription et la réinitialisation de PIN.
class ServiceAuthFirebase {
  ServiceAuthFirebase([FirebaseAuth? auth]) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  String? _verificationId;
  int? _resendToken;

  /// Envoie (ou renvoie, si [renvoi]) le code SMS à [telephone] (format
  /// +225XXXXXXXXXX).
  ///
  /// - [onCodeEnvoye] : le SMS est parti, on peut passer à la saisie manuelle.
  /// - [onVerifieAuto] : vérification automatique (auto-retrieval Android) —
  ///   l'idToken est déjà prêt, la saisie manuelle du code peut être sautée.
  /// - [onErreur] : échec Firebase (numéro invalide, quota, réseau…),
  ///   message déjà traduit.
  Future<void> demanderCode({
    required String telephone,
    required void Function() onCodeEnvoye,
    required void Function(String idToken) onVerifieAuto,
    required void Function(String message) onErreur,
    bool renvoi = false,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: telephone,
        forceResendingToken: renvoi ? _resendToken : null,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (credential) async {
          try {
            final idToken = await _connecter(credential);
            onVerifieAuto(idToken);
          } catch (_) {
            onErreur(
              'Vérification automatique impossible. Entrez le code reçu par SMS.',
            );
          }
        },
        verificationFailed: (e) => onErreur(_messageErreur(e)),
        codeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          onCodeEnvoye();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      onErreur(_messageErreur(e));
    } catch (_) {
      onErreur('Envoi du code impossible. Vérifiez votre connexion.');
    }
  }

  /// Confirme le code SMS saisi manuellement et renvoie l'idToken Firebase.
  /// Lève [ServiceAuthFirebaseException] (message lisible) si le code est
  /// invalide/expiré ou si la session de vérification n'existe plus.
  Future<String> confirmerCode(String code) async {
    final verificationId = _verificationId;
    if (verificationId == null) {
      throw const ServiceAuthFirebaseException(
        'Session de vérification expirée. Redemandez un code.',
      );
    }
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      return await _connecter(credential);
    } on FirebaseAuthException catch (e) {
      throw ServiceAuthFirebaseException(_messageErreur(e));
    }
  }

  Future<String> _connecter(PhoneAuthCredential credential) async {
    final result = await _auth.signInWithCredential(credential);
    final idToken = await result.user?.getIdToken();
    if (idToken == null) {
      throw const ServiceAuthFirebaseException(
        'Vérification impossible. Réessayez.',
      );
    }
    return idToken;
  }

  String _messageErreur(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return 'Code invalide. Vérifiez et réessayez.';
      case 'session-expired':
        return 'Code expiré. Redemandez un code.';
      case 'invalid-phone-number':
        return 'Numéro de téléphone invalide.';
      case 'too-many-requests':
      case 'quota-exceeded':
        return 'Trop de tentatives. Réessayez plus tard.';
      case 'network-request-failed':
        return 'Pas de connexion. Vérifiez votre réseau.';
      default:
        return 'Vérification impossible. Réessayez.';
    }
  }
}
