import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/article_enquiry_mode.dart';
import '../../domain/entities/article_info.dart';
import '../../domain/usecases/search_article.dart';
import '../services/zebra_scanner_service.dart';

enum ArticleEnquiryState { initial, loading, loaded, error }

class ArticleEnquiryController extends GetxController {
  final SearchArticle searchArticle;
  ZebraScannerService? _scannerService;
  final TextEditingController searchTextController = TextEditingController();
  Timer? _initializationTimer;
  Timer? _profileCreationTimer;

  ArticleEnquiryController({required this.searchArticle});

  final Rx<ArticleEnquiryState> state = ArticleEnquiryState.initial.obs;
  final Rx<ArticleEnquiryMode> selectedMode = ArticleEnquiryMode.ean.obs;
  final RxString searchNumber = ''.obs;
  final Rxn<ArticleInfo> articleInfo = Rxn<ArticleInfo>();
  final RxnString errorMessage = RxnString();
  final RxBool isScannerInitializing = true.obs;

  // Stock check fields
  final RxString siteCode = ''.obs;
  final RxBool isStockLoading = false.obs;
  final RxnString siteName = RxnString();
  final RxnString quantity = RxnString();
  final RxnString stockErrorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    // Listen to searchNumber changes and update text controller
    // This ensures UI reflects scanned values
    ever(searchNumber, (String value) {
      if (searchTextController.text != value) {
        searchTextController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
    });
    _initializeScanner();
  }

  @override
  void onClose() {
    // Stop scanning when controller is disposed
    _scannerService?.stopScanning();
    _initializationTimer?.cancel();
    _profileCreationTimer?.cancel();
    searchTextController.dispose();
    super.onClose();
  }

  ZebraScannerService? get scannerService => _scannerService;

  void _initializeScanner() async {
    isScannerInitializing.value = true;
    try {
      _scannerService = Get.find<ZebraScannerService>();
      _scannerService?.onScanReceived = _handleScannedData;

      // Wait for scanner to be initialized
      if (_scannerService != null) {
        // Check if already initialized first
        if (_scannerService!.isInitialized.value) {
          _onScannerReady();
          return;
        }

        // Listen to initialization state changes
        ever(_scannerService!.isInitialized, (bool initialized) {
          if (initialized && isScannerInitializing.value) {
            _onScannerReady();
          }
        });

        // Poll periodically to check initialization status
        // This handles cases where the listener might not fire
        _initializationTimer = Timer.periodic(
          const Duration(milliseconds: 100),
          (timer) {
            if (_scannerService == null || !isScannerInitializing.value) {
              timer.cancel();
              _initializationTimer = null;
              return;
            }

            if (_scannerService!.isInitialized.value) {
              timer.cancel();
              _initializationTimer = null;
              _onScannerReady();
            }
          },
        );

        // Add a timeout fallback in case initialization takes too long
        Future.delayed(const Duration(seconds: 5), () {
          if (isScannerInitializing.value) {
            // Timeout - proceed anyway
            isScannerInitializing.value = false;
          }
        });
      } else {
        isScannerInitializing.value = false;
      }
    } catch (e) {
      // Scanner service not registered, will handle gracefully
      _scannerService = null;
      isScannerInitializing.value = false;
    }
  }

  void _onScannerReady() {
    // Auto-start scanning after initialization
    // This will trigger profile creation if needed
    Future.delayed(const Duration(milliseconds: 300), () async {
      if (_scannerService != null) {
        await _scannerService!.startScanning();
        // Wait for scanning to actually start before hiding loader
        _waitForScanningReady();
      }
    });
  }

  void _waitForScanningReady() {
    if (_scannerService == null) {
      isScannerInitializing.value = false;
      return;
    }

    // Listen to scanning state - wait until scanning is actually active
    ever(_scannerService!.isScanning, (bool isScanning) {
      if (isScanning &&
          !_scannerService!.isCreatingProfile.value &&
          _scannerService!.isInitialized.value &&
          isScannerInitializing.value) {
        // Scanner is ready and actively scanning - hide loader
        Future.delayed(const Duration(milliseconds: 200), () {
          isScannerInitializing.value = false;
        });
      }
    });

    // Also listen to profile creation to ensure it's complete
    ever(_scannerService!.isCreatingProfile, (bool isCreating) {
      if (!isCreating &&
          _scannerService!.isInitialized.value &&
          _scannerService!.isScanning.value &&
          isScannerInitializing.value) {
        // Profile creation done and scanning is active - hide loader
        Future.delayed(const Duration(milliseconds: 200), () {
          isScannerInitializing.value = false;
        });
      }
    });

    // Poll to check if everything is ready
    _profileCreationTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (_scannerService == null || !isScannerInitializing.value) {
        timer.cancel();
        _profileCreationTimer = null;
        return;
      }

      // Hide loader only when:
      // 1. Profile creation is done
      // 2. Scanner is initialized
      // 3. Scanner is actively scanning (ready to receive scans)
      if (!_scannerService!.isCreatingProfile.value &&
          _scannerService!.isInitialized.value &&
          _scannerService!.isScanning.value) {
        timer.cancel();
        _profileCreationTimer = null;
        // Small delay to ensure everything is settled
        Future.delayed(const Duration(milliseconds: 300), () {
          isScannerInitializing.value = false;
        });
      }
    });

    // Timeout fallback - if scanning doesn't start within 10 seconds, proceed anyway
    Future.delayed(const Duration(seconds: 10), () {
      if (isScannerInitializing.value) {
        isScannerInitializing.value = false;
      }
    });
  }

  void _handleScannedData(String scannedData) {
    // Update search number with scanned data
    // The ever() listener will automatically update the text controller
    searchNumber.value = scannedData;

    // Ensure scanner stays active for continuous scanning
    if (_scannerService != null && !_scannerService!.isScanning.value) {
      _scannerService!.startScanning();
    }

    // Auto-trigger search after scan
    performSearch();
  }

  Future<void> toggleScanning() async {
    if (_scannerService == null) {
      Get.snackbar(
        'Scanner Unavailable',
        'Zebra scanner service is not available on this device',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (_scannerService!.isScanning.value) {
      await _scannerService!.stopScanning();
    } else {
      await _scannerService!.startScanning();

      // Show feedback
      Get.snackbar(
        'Scanning',
        'Ready to scan. Point at barcode and press trigger.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue.withOpacity(0.9),
        colorText: Colors.white,
      );
    }
  }

  void selectMode(ArticleEnquiryMode mode) {
    selectedMode.value = mode;
    searchNumber.value = '';
    articleInfo.value = null;
    errorMessage.value = null;
    state.value = ArticleEnquiryState.initial;
  }

  void updateSearchNumber(String value) {
    searchNumber.value = value;
  }

  Future<void> performSearch() async {
    if (searchNumber.value.trim().isEmpty) {
      errorMessage.value =
          'Please enter a ${selectedMode.value.fullName} number';
      return;
    }

    // Dismiss keyboard when search is initiated
    FocusScope.of(Get.context!).unfocus();

    // Store the current search number to ensure we're processing the latest scan
    final currentSearchNumber = searchNumber.value.trim();

    state.value = ArticleEnquiryState.loading;
    errorMessage.value = null;
    articleInfo.value = null;

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data for testing
    final mockInfo = ArticleInfo(
      itemName: 'Premium Coffee Beans 500g',
      amount: '\$24.99',
      articleNumber: 'ART-12345',
      mrp: '\$29.99',
      brand: 'Coffee Masters',
      mc: 'MC001',
      mcText: 'Beverages - Coffee',
      stock: '150 units',
      uom: 'Pack',
      shelfNo: 'A-12-B',
      vendor: 'Global Coffee Suppliers Inc.',
    );

    state.value = ArticleEnquiryState.loaded;
    articleInfo.value = mockInfo;

    // Clear the search field after successful scan
    searchNumber.value = '';
    searchTextController.clear();

    // Uncomment below to use actual API call
    // final result = await searchArticle(SearchArticleParams(
    //   mode: selectedMode.value,
    //   number: searchNumber.value.trim(),
    // ));
    //
    // result.fold(
    //   (failure) {
    //     state.value = ArticleEnquiryState.error;
    //     errorMessage.value = failure.toString();
    //   },
    //   (info) {
    //     state.value = ArticleEnquiryState.loaded;
    //     articleInfo.value = info;
    //     // Clear the search field after successful scan
    //     searchNumber.value = '';
    //     searchTextController.clear();
    //   },
    // );
  }

  void updateSiteCode(String value) {
    siteCode.value = value;

    // Auto-trigger API call when 4 digits are entered
    if (value.length == 4) {
      // Dismiss keyboard when API call is initiated
      FocusScope.of(Get.context!).unfocus();
      checkStock(value);
    } else {
      // Reset stock info if site code changes
      siteName.value = null;
      quantity.value = null;
      stockErrorMessage.value = null;
    }
  }

  Future<void> checkStock(String siteCodeValue) async {
    isStockLoading.value = true;
    stockErrorMessage.value = null;
    siteName.value = null;
    quantity.value = null;

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data
    siteName.value = 'Store Location ${siteCodeValue}';
    quantity.value = '${(int.parse(siteCodeValue) % 100) * 5} units';
    isStockLoading.value = false;

    // TODO: Replace with actual API call
    // final result = await stockCheckUseCase(StockCheckParams(
    //   articleNumber: articleInfo.value?.articleNumber ?? '',
    //   siteCode: siteCodeValue,
    // ));
    //
    // result.fold(
    //   (failure) {
    //     isStockLoading.value = false;
    //     stockErrorMessage.value = failure.toString();
    //   },
    //   (stockInfo) {
    //     isStockLoading.value = false;
    //     siteName.value = stockInfo.siteName;
    //     quantity.value = stockInfo.quantity;
    //   },
    // );
  }
}
