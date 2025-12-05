/// Application configuration
///
/// INSTRUCTIONS FOR ADDING YOUR ENDPOINTS:
/// 1. Copy app_config.local.dart.example to app_config.local.dart
/// 2. Edit app_config.local.dart with your actual endpoints and credentials
/// 3. The .local.dart file is gitignored for security
///
/// IMPORTANT: After creating app_config.local.dart, uncomment the import below
/// and comment out the getAppConfig() function in this file.

// Uncomment this line after creating app_config.local.dart:
// import 'app_config.local.dart' as local_config;

class AppConfig {
  // REST API Configuration
  final String restBaseUrl;

  // SOAP API Configuration
  final String soapBaseUrl;
  final String soapUsername;
  final String soapPassword;

  // Network Timeouts (in milliseconds)
  final int connectTimeoutMs;
  final int receiveTimeoutMs;

  // API Endpoints (add your specific endpoints here)
  final Map<String, String> endpoints;

  const AppConfig({
    required this.restBaseUrl,
    required this.soapBaseUrl,
    required this.soapUsername,
    required this.soapPassword,
    this.connectTimeoutMs = 15000,
    this.receiveTimeoutMs = 20000,
    this.endpoints = const {},
  });

  // Get endpoint by name (supports path parameters)
  String getEndpoint(String name, {Map<String, String>? pathParams}) {
    final endpoint = endpoints[name] ?? '';
    if (pathParams != null && pathParams.isNotEmpty) {
      var result = endpoint;
      pathParams.forEach((key, value) {
        result = result.replaceAll('{$key}', value);
      });
      return result;
    }
    return endpoint;
  }
}

// Default configuration (used when app_config.local.dart doesn't exist)
// After creating app_config.local.dart, comment this out and use: local_config.getAppConfig()
AppConfig getAppConfig() {
  return const AppConfig(
    restBaseUrl: 'https://your-rest-backend.example.com',
    soapBaseUrl: 'https://your-sap-soap-endpoint.example.com',
    soapUsername: 'your-username',
    soapPassword: 'your-password',
    endpoints: {
      // Add your endpoint names here when you create app_config.local.dart
      // Example REST endpoints:
      // 'getHomeItems': '/api/v1/home-items',
      // 'getHomeItemById': '/api/v1/home-items/{id}',

      // Example SOAP operations (each module needs its own):
      // 'soapCreateDelivery': 'CreateDelivery',
      // 'soapCreateSTO': 'CreateStockTransportOrder',
      // 'soapSearchArticle': 'SearchArticle',
      // See app_config.local.dart.example for all module operations
    },
  );
}

AppConfig get appConfig => getAppConfig();
