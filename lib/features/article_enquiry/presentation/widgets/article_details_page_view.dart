import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_info.dart';
import 'article_details_page.dart';
import 'stock_check_page.dart';
import 'ean_list_page.dart';
import 'storage_location_stock_page.dart';

class ArticleDetailsPageView extends StatefulWidget {
  final ArticleInfo articleInfo;

  const ArticleDetailsPageView({super.key, required this.articleInfo});

  @override
  State<ArticleDetailsPageView> createState() => _ArticleDetailsPageViewState();
}

class _ArticleDetailsPageViewState extends State<ArticleDetailsPageView> {
  late PageController _pageController;
  final RxInt _currentPage = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _currentPage.value = index;
            },
            children: [
              // Page 1: Details
              ArticleDetailsPage(articleInfo: widget.articleInfo),
              // Page 2: Stock Check
              StockCheckPage(articleInfo: widget.articleInfo),
              // Page 3: EAN List with Conversions
              EanListPage(articleInfo: widget.articleInfo),
              // Page 4: Storage Location Wise Stock
              StorageLocationStockPage(articleInfo: widget.articleInfo),
            ],
          ),
        ),
        // Page indicator
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentPage.value
                        ? AppColors.primary
                        : AppColors.textMuted.withOpacity(0.3),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
