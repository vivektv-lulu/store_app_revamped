# SOAP Operations Guide

Each module in your app requires different SOAP operations. This guide shows you how to configure and use them.

## Configuration

In `app_config.local.dart`, define SOAP operations for each module:

```dart
endpoints: {
  // Delivery Creation Module
  'soapCreateDelivery': 'CreateDelivery',
  'soapUpdateDelivery': 'UpdateDelivery',
  
  // Stock Transport Order (STO) Module
  'soapCreateSTO': 'CreateStockTransportOrder',
  'soapUpdateSTO': 'UpdateStockTransportOrder',
  
  // Article Enquiry Module
  'soapSearchArticle': 'SearchArticle',
  'soapGetArticleDetails': 'GetArticleDetails',
  
  // ... and so on for all modules
}
```

## Usage Examples

### Using SoapOperationHelper (Recommended)

```dart
final helper = SoapOperationHelper();

// Create a delivery
final response = await helper.createDelivery((builder) {
  builder.element('CreateDelivery', nest: () {
    builder.element('DeliveryNumber', nest: '12345');
    builder.element('Plant', nest: '1000');
    builder.element('ShippingPoint', nest: '1001');
  });
});

// Create an STO
final stoResponse = await helper.createSTO((builder) {
  builder.element('CreateStockTransportOrder', nest: () {
    builder.element('Material', nest: 'MAT001');
    builder.element('Quantity', nest: '100');
  });
});
```

### Using Generic callOperation

```dart
final helper = SoapOperationHelper();

// Call any operation by name
final response = await helper.callOperation(
  'soapCreateDelivery',  // Operation name from config
  (builder) {
    builder.element('CreateDelivery', nest: () {
      // Build your SOAP body here
    });
  },
);
```

### Direct SoapClient Usage

```dart
final soapClient = SoapClient();
final envelope = SoapEnvelopeBuilder.buildEnvelope((builder) {
  builder.element('CreateDelivery', nest: () {
    builder.element('DeliveryNumber', nest: '12345');
  });
});

final response = await soapClient.postSoap(
  envelope: envelope,
  soapAction: NetworkConfig.getEndpoint('soapCreateDelivery'),
);
```

## Module-Specific Operations

Based on your 10 modules, you'll need SOAP operations for:

1. **Article Enquiry** - Search, Get Details
2. **In Store Operation** - Create, Update
3. **Label Print** - Generate, Print
4. **Delivery Creation** - Create, Update, Get
5. **Goods Receipt Local PO** - Create, Process
6. **Stock Transport Order** - Create, Update, Get
7. **Reservation** - Create, Update, Cancel
8. **Fresh Food PO** - Create, Update
9. **Return PO** - Create, Process
10. **Goods Receipt Delivery** - Create, Process

Each operation should be configured in your `app_config.local.dart` file.
