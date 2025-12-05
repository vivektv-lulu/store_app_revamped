import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;
import 'network_config.dart';
import 'soap_client.dart';
import 'soap_envelope_builder.dart';

/// Helper class for making SOAP operations easier
///
/// This class provides convenience methods for calling different SOAP operations
/// by name, automatically retrieving the SOAP action from configuration.
class SoapOperationHelper {
  final SoapClient _soapClient;

  SoapOperationHelper({SoapClient? soapClient})
    : _soapClient = soapClient ?? SoapClient();

  /// Calls a SOAP operation by endpoint name
  ///
  /// [operationName] - The name of the operation from your config (e.g., 'soapCreateDelivery')
  /// [bodyBuilder] - Function that builds the SOAP body XML for this operation
  /// [soapAction] - Optional SOAP action (if not provided, uses the endpoint name from config)
  ///
  /// Example:
  /// ```dart
  /// final response = await helper.callOperation(
  ///   'soapCreateDelivery',
  ///   (builder) {
  ///     builder.element('CreateDelivery', nest: () {
  ///       builder.element('DeliveryNumber', nest: '12345');
  ///     });
  ///   },
  /// );
  /// ```
  Future<Response<String>> callOperation(
    String operationName,
    void Function(xml.XmlBuilder b) bodyBuilder, {
    String? soapAction,
  }) async {
    // Get SOAP action from config, or use provided one
    final action = soapAction ?? NetworkConfig.getEndpoint(operationName);

    // Build the SOAP envelope
    final envelope = SoapEnvelopeBuilder.buildEnvelope(bodyBuilder);

    // Make the SOAP request
    return _soapClient.postSoap(
      envelope: envelope,
      soapAction: action.isNotEmpty ? action : null,
    );
  }

  /// Convenience method for Delivery Creation operations
  Future<Response<String>> createDelivery(
    void Function(xml.XmlBuilder b) bodyBuilder,
  ) {
    return callOperation('soapCreateDelivery', bodyBuilder);
  }

  /// Convenience method for STO (Stock Transport Order) operations
  Future<Response<String>> createSTO(
    void Function(xml.XmlBuilder b) bodyBuilder,
  ) {
    return callOperation('soapCreateSTO', bodyBuilder);
  }

  /// Convenience method for Article Enquiry operations
  Future<Response<String>> searchArticle(
    void Function(xml.XmlBuilder b) bodyBuilder,
  ) {
    return callOperation('soapSearchArticle', bodyBuilder);
  }

  /// Convenience method for Goods Receipt operations
  Future<Response<String>> processGoodsReceipt(
    void Function(xml.XmlBuilder b) bodyBuilder,
  ) {
    return callOperation('soapProcessGoodsReceiptPO', bodyBuilder);
  }

  /// Convenience method for Reservation operations
  Future<Response<String>> createReservation(
    void Function(xml.XmlBuilder b) bodyBuilder,
  ) {
    return callOperation('soapCreateReservation', bodyBuilder);
  }
}
