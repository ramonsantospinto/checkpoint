class Env {
  // Para produção: baseUrl do backend (proxy), não da Steam diretamente.
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );

  static const authCallbackScheme = 'checkpoint';
}
