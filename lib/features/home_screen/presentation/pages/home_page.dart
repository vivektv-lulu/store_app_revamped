import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../di/home_injection.dart';
import '../controllers/home_controller.dart';
import '../../domain/entities/home_item.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/home_loading_widget.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/module_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeInjection.homeController);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Store Operations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: AppColors.textPrimary,
            onPressed: () {
              // TODO: Implement logout functionality
              Get.dialog(
                AlertDialog(
                  title: const Text('Logout'),
                  content: const Text(
                    'Are you sure you want to logit initgout?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        // TODO: Add logout logic here
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
        child: Obx(() {
          switch (controller.state.value) {
            case HomeState.initial:
            case HomeState.loading:
              return const HomeLoadingWidget();
            case HomeState.loaded:
              return Column(
                children: [
                  // User info section - extension of app bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appBarBg,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            size: 18,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.loggedInUser.value,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 16,
                            width: 1,
                            color: AppColors.textMuted.withOpacity(0.3),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.badge_outlined,
                            size: 16,
                            color: AppColors.textPrimary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            controller.userRole.value,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Modules grid with categories
                  Expanded(
                    child: HomeModuleGridWidget(
                      items: controller.items,
                      controller: controller,
                    ),
                  ),
                ],
              );
            case HomeState.error:
              return HomeErrorWidget(
                message: controller.errorMessage.value ?? 'An error occurred',
                onRetry: controller.loadHomeItems,
              );
          }
        }),
      ),
    );
  }
}

class HomeModuleGridWidget extends StatelessWidget {
  final List<HomeItem> items;
  final HomeController controller;

  const HomeModuleGridWidget({
    super.key,
    required this.items,
    required this.controller,
  });

  // Group items by category
  Map<String, List<HomeItem>> _groupItemsByCategory() {
    final Map<String, List<HomeItem>> grouped = {};
    for (var item in items) {
      if (!grouped.containsKey(item.category)) {
        grouped[item.category] = [];
      }
      grouped[item.category]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = _groupItemsByCategory();
    final categories = groupedItems.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      itemCount: categories.length,
      itemBuilder: (context, categoryIndex) {
        final category = categories[categoryIndex];
        final categoryItems = groupedItems[category]!;

        return Obx(() {
          final isExpanded = controller.isCategoryExpanded(category);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expandable category header
              InkWell(
                onTap: () => controller.toggleCategory(category),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  margin: EdgeInsets.only(top: categoryIndex > 0 ? 16 : 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: isExpanded
                        ? Border(
                            left: BorderSide(
                              color: AppColors.primary,
                              width: 4,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isExpanded
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: isExpanded
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        color: isExpanded
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              // Grid for this category - animated expand/collapse
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: categoryItems.length,
                          itemBuilder: (context, index) {
                            return ModuleCardWidget(
                              item: categoryItems[index],
                              onTap: () => controller.navigateToModule(
                                categoryItems[index].id,
                                categoryItems[index].title,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        });
      },
    );
  }
}
