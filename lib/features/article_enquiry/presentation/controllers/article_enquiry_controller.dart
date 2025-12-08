import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/article_enquiry_mode.dart';
import '../../domain/entities/article_info.dart';
import '../../domain/usecases/search_article.dart';

enum ArticleEnquiryState { initial, loading, loaded, error }

class ArticleEnquiryController extends GetxController {
  final SearchArticle searchArticle;

  ArticleEnquiryController({
    required this.searchArticle,
  });

  final Rx<ArticleEnquiryState> state = ArticleEnquiryState.initial.obs;
  final Rx<ArticleEnquiryMode> selectedMode = ArticleEnquiryMode.ean.obs;
  final RxString searchNumber = ''.obs;
  final Rxn<ArticleInfo> articleInfo = Rxn<ArticleInfo>();
  final RxnString errorMessage = RxnString();
  
  // Stock check fields
  final RxString siteCode = ''.obs;
  final RxBool isStockLoading = false.obs;
  final RxnString siteName = RxnString();
  final RxnString quantity = RxnString();
  final RxnString stockErrorMessage = RxnString();

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
      errorMessage.value = 'Please enter a ${selectedMode.value.fullName} number';
      return;
    }

    // Dismiss keyboard when search is initiated
    FocusScope.of(Get.context!).unfocus();

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

