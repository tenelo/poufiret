/// Exception applicative, calée sur le format d'erreur uniforme du backend :
/// { "erreur": true, "code": 401, "message": "...", "details": {...} }
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
    if (data is Map<String, dynamic> && data['erreur'] == true) {
      return ApiException(
        code: data['code'] as int? ?? statusCode ?? 0,
        message: data['message'] as String? ?? 'Erreur inconnue',
        details: (data['details'] as Map<String, dynamic>?) ?? const {},
      );
    }
    // Réponse hors format (timeout, 502, pas de connexion…)
    return ApiException(
      code: statusCode ?? 0,
      message: 'Une erreur est survenue. Réessaie.',
    );
  }

  /// Cas réseau pur (pas de réponse HTTP du tout).
  factory ApiException.reseau() => const ApiException(
    code: 0,
    message: 'Pas de connexion. Vérifie ton réseau.',
  );

  bool get estAuth => code == 401;

  @override
  String toString() => 'ApiException($code): $message';
}
