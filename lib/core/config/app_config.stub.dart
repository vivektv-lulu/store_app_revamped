/// Stub file for when app_config.local.dart doesn't exist
/// This provides default/development configuration

import 'app_config.dart';

AppConfig getAppConfig() {
  return const AppConfig(
    restBaseUrl: 'https://your-rest-backend.example.com',
    soapBaseUrl: 'https://your-sap-soap-endpoint.example.com',
    soapUsername: 'your-username',
    soapPassword: 'your-password',
    endpoints: {
      // Add your endpoint names here when you create app_config.local.dart
      // Example:
      // 'getHomeItems': '/api/v1/home-items',
      // 'getHomeItemById': '/api/v1/home-items/{id}',
      // 'soapGetHomeItems': 'GetHomeItems',
    },
  );
}
