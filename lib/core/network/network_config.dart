class NetworkConfig {
  // REST
  static const String restBaseUrl = 'https://your-rest-backend.example.com';

  // SOAP
  static const String soapBaseUrl = 'https://your-sap-soap-endpoint.example.com';
  static const String soapUsername = 'your-username'; // TODO: move to secure storage/env
  static const String soapPassword = 'your-password'; // TODO: move to secure storage/env

  // Timeouts (in milliseconds)
  static const int connectTimeoutMs = 15000;
  static const int receiveTimeoutMs = 20000;
}

