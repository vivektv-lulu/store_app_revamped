import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_enquiry_mode.dart';
import '../controllers/article_enquiry_controller.dart';
import '../widgets/mode_button_widget.dart';
import '../widgets/article_details_page_view.dart';

class ArticleEnquiryHomePage extends StatelessWidget {
  const ArticleEnquiryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleEnquiryController controller =
        Get.find<ArticleEnquiryController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Article Enquiry',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF0FFF4), AppColors.surface],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              // Dismiss keyboard when tapping outside
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.translucent,
            child: Column(
              children: [
                // Mode buttons and search field in single row
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Mode selection buttons
                      Obx(
                        () => ModeButtonWidget(
                          mode: ArticleEnquiryMode.ean,
                          isSelected:
                              controller.selectedMode.value ==
                              ArticleEnquiryMode.ean,
                          onTap: () =>
                              controller.selectMode(ArticleEnquiryMode.ean),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Obx(
                        () => ModeButtonWidget(
                          mode: ArticleEnquiryMode.article,
                          isSelected:
                              controller.selectedMode.value ==
                              ArticleEnquiryMode.article,
                          onTap: () =>
                              controller.selectMode(ArticleEnquiryMode.article),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Obx(
                        () => ModeButtonWidget(
                          mode: ArticleEnquiryMode.plu,
                          isSelected:
                              controller.selectedMode.value ==
                              ArticleEnquiryMode.plu,
                          onTap: () =>
                              controller.selectMode(ArticleEnquiryMode.plu),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Search field - takes maximum space
                      Expanded(
                        child: Obx(
                          () => TextField(
                            onChanged: controller.updateSearchNumber,
                            decoration: InputDecoration(
                              hintText:
                                  'Enter ${controller.selectedMode.value.fullName} number',
                              filled: true,
                              fillColor: AppColors.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  color: AppColors.primary,
                                ),
                                onPressed: controller.performSearch,
                              ),
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) => controller.performSearch(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Results
                Expanded(
                  child: Obx(() {
                    switch (controller.state.value) {
                      case ArticleEnquiryState.initial:
                        return const Center(
                          child: Text(
                            'Enter a number to search',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                        );
                      case ArticleEnquiryState.loading:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      case ArticleEnquiryState.loaded:
                        return controller.articleInfo.value != null
                            ? ArticleDetailsPageView(
                                articleInfo: controller.articleInfo.value!,
                              )
                            : const SizedBox();
                      case ArticleEnquiryState.error:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: AppColors.error,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller.errorMessage.value ??
                                    'An error occurred',
                                style: const TextStyle(
                                  color: AppColors.error,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
