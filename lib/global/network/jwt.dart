import 'dart:convert';

/// Lit la date d'expiration (`exp`) d'un JWT, SANS vérifier la signature :
/// seul le serveur fait foi, on veut juste savoir s'il est utile de
/// renouveler le token avant d'envoyer une requête.
///
/// Renvoie null si le token n'est pas un JWT lisible (dans ce cas on
/// n'anticipe pas : le 401 éventuel déclenchera le refresh classique).
DateTime? expirationJwt(String token) {
  try {
    final morceaux = token.split('.');
    if (morceaux.length != 3) return null;
    final charge = utf8.decode(
      base64Url.decode(base64Url.normalize(morceaux[1])),
    );
    final json = jsonDecode(charge);
    final exp = json is Map ? json['exp'] : null;
    if (exp is! num) return null;
    return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000, isUtc: true);
  } catch (_) {
    return null;
  }
}

/// Vrai si le token expire dans moins de [marge] (ou est déjà expiré).
bool expireBientot(
  String token, {
  Duration marge = const Duration(seconds: 60),
  DateTime? maintenant,
}) {
  final exp = expirationJwt(token);
  if (exp == null) return false;
  final now = (maintenant ?? DateTime.now()).toUtc();
  return exp.difference(now) < marge;
}
