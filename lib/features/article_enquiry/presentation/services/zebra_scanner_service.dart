import 'dart:async';
import 'package:get/get.dart';
import 'package:scanwedge/scanwedge.dart';

class ZebraScannerService extends GetxService {
  Scanwedge? _scanwedge;
  StreamSubscription<ScanResult>? _scanSubscription;

  final RxBool isScanning = false.obs;
  final RxBool isInitialized = false.obs;
  final RxBool isCreatingProfile = false.obs;
  final RxnString scanError = RxnString();

  // Callback for when scan is received
  Function(String scannedData)? onScanReceived;

  @override
  void onInit() {
    super.onInit();
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    try {
      _scanwedge = await Scanwedge.initialize();
      _setupScanListener();
      isInitialized.value = true;
    } catch (e) {
      scanError.value = 'Failed to initialize scanner: $e';
      // Mark as initialized even on error so UI can proceed
      isInitialized.value = true;
    }
  }

  void _setupScanListener() {
    _scanSubscription = _scanwedge?.stream.listen(
      (ScanResult result) {
        if (result.barcode.isNotEmpty) {
          // Keep scanning active for continuous scanning
          // Notify listener with scanned data
          onScanReceived?.call(result.barcode);
        }
      },
      onError: (error) {
        scanError.value = 'Scan error: $error';
        // Only stop on error, not on successful scan
        stopScanning();
      },
    );
  }

  Future<void> startScanning() async {
    if (_scanwedge == null) {
      await _initializeScanner();
    }

    if (_scanwedge == null) {
      scanError.value = 'Scanner not available';
      return;
    }

    try {
      // Create or get the profile
      isCreatingProfile.value = true;
      await _ensureProfile();
      isCreatingProfile.value = false;

      // Small delay to ensure profile is fully applied
      await Future.delayed(const Duration(milliseconds: 200));

      // Enable the scanner
      await _scanwedge!.enableScanner();

      // Ensure scanner is actually enabled and ready
      // Add a small delay to ensure the scanner hardware is ready
      await Future.delayed(const Duration(milliseconds: 300));

      isScanning.value = true;
      scanError.value = null;
    } catch (e) {
      isCreatingProfile.value = false;
      scanError.value = 'Failed to start scanning: $e';
      isScanning.value = false;
    }
  }

  Future<void> stopScanning() async {
    try {
      if (_scanwedge != null) {
        await _scanwedge!.disableScanner();
      }
      isScanning.value = false;
    } catch (e) {
      scanError.value = 'Failed to stop scanning: $e';
    }
  }

  Future<void> _ensureProfile() async {
    if (_scanwedge == null) return;

    try {
      // Create a profile for the app if it doesn't exist
      const profileName = 'StoreAppProfile';

      // Use ZebraProfileModel for Zebra devices
      await _scanwedge!.createScanProfile(
        ZebraProfileModel(
          profileName: profileName,
          enabledBarcodes: [
            // Enable common barcode types
            BarcodeTypes.code128.create(),
            BarcodeTypes.code39.create(),
            BarcodeTypes.ean13.create(),
            BarcodeTypes.ean8.create(),
            BarcodeTypes.upca.create(),
            BarcodeTypes.upce0.create(),
            BarcodeTypes.qrCode.create(),
          ],
          aimType: AimType.trigger,
          enableKeyStroke: false, // We'll use intent delivery instead
        ),
      );
    } catch (e) {
      // Profile might already exist, which is fine
      // You can add more specific error handling if needed
    }
  }

  @override
  void onClose() {
    _scanSubscription?.cancel();
    stopScanning();
    super.onClose();
  }
}
