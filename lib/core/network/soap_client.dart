import 'dart:convert';
import 'package:dio/dio.dart';
import 'network_config.dart';

/// Basic SOAP client using Dio.
class SoapClient {
  SoapClient({
    Dio? dio,
    this.defaultSoapAction,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: NetworkConfig.soapBaseUrl,
                connectTimeout: const Duration(milliseconds: NetworkConfig.connectTimeoutMs),
                receiveTimeout: const Duration(milliseconds: NetworkConfig.receiveTimeoutMs),
              ),
            );

  final Dio _dio;
  final String? defaultSoapAction;

  /// Sends a SOAP request with Basic Auth.
  ///
  /// [soapAction] is required for SOAP 1.1 (`text/xml`); for SOAP 1.2 you can omit it.
  /// [envelope] should be a complete SOAP envelope string.
  Future<Response<String>> postSoap({
    required String envelope,
    String? soapAction,
  }) async {
    final auth = _basicAuthHeader(
      NetworkConfig.soapUsername,
      NetworkConfig.soapPassword,
    );

    final headers = <String, dynamic>{
      'Content-Type': 'text/xml; charset=utf-8',
      if ((soapAction ?? defaultSoapAction) != null)
        'SOAPAction': soapAction ?? defaultSoapAction,
      'Authorization': 'Basic $auth',
    };

    return _dio.post<String>(
      '',
      data: envelope,
      options: Options(
        headers: headers,
        responseType: ResponseType.plain, // SOAP responses are XML text
      ),
    );
  }

  String _basicAuthHeader(String username, String password) {
    final creds = utf8.encode('$username:$password');
    return base64Encode(creds);
  }
}

