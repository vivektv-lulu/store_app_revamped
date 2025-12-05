import '../config/app_config.dart';

/// Network configuration that reads from AppConfig
///
/// This class provides easy access to network settings from the centralized
/// AppConfig. Update endpoints and credentials in app_config.local.dart
class NetworkConfig {
  static AppConfig get _config => appConfig;

  // REST
  static String get restBaseUrl => _config.restBaseUrl;

  // SOAP
  static String get soapBaseUrl => _config.soapBaseUrl;
  static String get soapUsername => _config.soapUsername;
  static String get soapPassword => _config.soapPassword;

  // Timeouts (in milliseconds)
  static int get connectTimeoutMs => _config.connectTimeoutMs;
  static int get receiveTimeoutMs => _config.receiveTimeoutMs;

  // Helper method to get endpoints by name
  static String getEndpoint(String name, {Map<String, String>? pathParams}) {
    return _config.getEndpoint(name, pathParams: pathParams);
  }
}
