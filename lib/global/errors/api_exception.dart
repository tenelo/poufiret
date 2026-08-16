/// Exception applicative. Gère trois formats d'erreur backend :
/// 1. Format maison  : { "erreur": true, "code": .., "message": .., "details": {..} }
/// 2. Format DRF par champ : { "nouveau_pin": ["..."], "telephone": ["..."] }
/// 3. Format DRF simple    : { "detail": "..." }
class ApiException implements Exception {
  final int code;
  final String message;
  final Map<String, dynamic> details;

  const ApiException({
    required this.code,
    required this.message,
    this.details = const {},
  });

  /// Construit depuis le corps JSON renvoyé par le backend.
  factory ApiException.fromResponse(int? statusCode, dynamic data) {
    final statut = statusCode ?? 0;

    if (data is Map<String, dynamic>) {
      // 1. Format maison explicite.
      if (data['erreur'] == true) {
        return ApiException(
          code: data['code'] as int? ?? statut,
          message: data['message'] as String? ?? 'Erreur inconnue',
          details: (data['details'] as Map<String, dynamic>?) ?? const {},
        );
      }

      // 3. Format DRF simple { "detail": "..." }.
      if (data['detail'] is String) {
        return ApiException(
          code: statut,
          message: data['detail'] as String,
        );
      }

      // 2. Format DRF par champ { "champ": ["msg"], ... }.
      // On garde toute la map dans details ; messageLisible la concatène.
      if (data.isNotEmpty) {
        return ApiException(
          code: statut,
          message: 'Erreur de validation.',
          details: data,
        );
      }
    }

    // Réponse hors format (502, HTML, corps vide…).
    return ApiException(
      code: statut,
      message: 'Une erreur est survenue. Réessaie.',
    );
  }

  /// Cas réseau pur (pas de réponse HTTP du tout).
  factory ApiException.reseau() => const ApiException(
    code: 0,
    message: 'Pas de connexion. Vérifie ton réseau.',
  );

  bool get estAuth => code == 401;

  /// Message lisible pour l'utilisateur : si le backend a renvoyé des erreurs
  /// par champ (details), on les concatène ; sinon on retombe sur message.
  String get messageLisible {
    if (details.isNotEmpty) {
      final morceaux = <String>[];
      details.forEach((champ, valeur) {
        if (valeur is List && valeur.isNotEmpty) {
          morceaux.add(valeur.first.toString());
        } else if (valeur is String) {
          morceaux.add(valeur);
        }
      });
      if (morceaux.isNotEmpty) return morceaux.join('\n');
    }
    return message;
  }

  @override
  String toString() => 'ApiException($code): $message';
}
