import 'package:xml/xml.dart' as xml;

class SoapEnvelopeBuilder {
  /// Builds a simple SOAP 1.1 envelope with a body element.
  /// [bodyBuilder] should add the operation element and its children.
  static String buildEnvelope(void Function(xml.XmlBuilder b) bodyBuilder) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'soapenv:Envelope',
      namespaces: {
        'soapenv': 'http://schemas.xmlsoap.org/soap/envelope/',
        // Add service-specific namespaces as needed.
      },
      nest: () {
        builder.element('soapenv:Header');
        builder.element('soapenv:Body', nest: () => bodyBuilder(builder));
      },
    );
    return builder.buildDocument().toXmlString(pretty: true);
  }
}

