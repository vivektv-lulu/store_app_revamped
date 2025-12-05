# Configuration Setup

This directory contains the application configuration system for managing API endpoints and credentials securely.

## Quick Start

1. **Copy the example file:**
   ```bash
   cp lib/core/config/app_config.local.dart.example lib/core/config/app_config.local.dart
   ```

2. **Edit `app_config.local.dart`** with your actual:
   - REST API base URL
   - SOAP API base URL  
   - SOAP credentials (username/password)
   - All your endpoint names and paths

3. **Uncomment the import in `app_config.dart`:**
   ```dart
   // Change this:
   // import 'app_config.local.dart' as local_config;
   
   // To this:
   import 'app_config.local.dart' as local_config;
   ```

4. **Update `getAppConfig()` in `app_config.dart`:**
   ```dart
   // Comment out the default function and use:
   AppConfig get appConfig => local_config.getAppConfig();
   ```

## Security

- ✅ `app_config.local.dart` is **gitignored** - your credentials won't be committed
- ✅ Only `app_config.local.dart.example` is tracked in git (as a template)
- ✅ Never commit your actual credentials to version control

## Using Endpoints

Once configured, access endpoints through `NetworkConfig`:

```dart
// Get base URLs
String restUrl = NetworkConfig.restBaseUrl;
String soapUrl = NetworkConfig.soapBaseUrl;

// Get specific endpoints by name
String endpoint = NetworkConfig.getEndpoint('getHomeItems');
String endpointWithParams = NetworkConfig.getEndpoint(
  'getHomeItemById', 
  pathParams: {'id': '123'}
);
```

## Example Endpoint Configuration

In `app_config.local.dart`, define your endpoints like this:

```dart
endpoints: {
  // REST endpoints
  'getHomeItems': '/api/v1/home-items',
  'getHomeItemById': '/api/v1/home-items/{id}',
  
  // SOAP operations
  'soapGetHomeItems': 'GetHomeItems',
  'soapGetHomeItemById': 'GetHomeItemById',
}
```

The `{id}` syntax allows path parameter replacement when calling `getEndpoint()`.
