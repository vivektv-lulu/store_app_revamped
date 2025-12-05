import 'package:dio/dio.dart';
import 'network_config.dart';

class RestClient {
  RestClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: NetworkConfig.restBaseUrl,
          connectTimeout: Duration(
            milliseconds: NetworkConfig.connectTimeoutMs,
          ),
          receiveTimeout: Duration(
            milliseconds: NetworkConfig.receiveTimeoutMs,
          ),
          contentType: 'application/json',
        ),
      ) {
    // Add interceptors here (auth, logging) if needed.
  }

  final Dio _dio;

  Dio get client => _dio;
}
