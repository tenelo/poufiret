class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'POUFIRET_API_URL',
    defaultValue: 'https://poufiret.tenelo.cloud',
  );

  static const String apiPrefix = '/api/v1';
}
