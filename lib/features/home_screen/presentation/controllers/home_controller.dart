import 'package:get/get.dart';
import '../../domain/entities/home_item.dart';
import '../widgets/reservation_category_dialog.dart';
import '../widgets/in_store_operation_category_dialog.dart';

enum HomeState { initial, loading, loaded, error }

class HomeController extends GetxController {
  final Rx<HomeState> state = HomeState.initial.obs;
  final RxList<HomeItem> items = <HomeItem>[].obs;
  final RxnString errorMessage = RxnString();

  // User information
  final RxString loggedInUser = 'John Doe'.obs; // TODO: Get from auth service
  final RxString userRole =
      'Price Integrator'.obs; // TODO: Get from auth service

  // Expandable sections state - track which categories are expanded
  final RxMap<String, bool> expandedCategories = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeItems();
  }

  Future<void> loadHomeItems() async {
    state.value = HomeState.loading;
    errorMessage.value = null;

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data for 10 modules grouped by category
    items.assignAll([
      // Operations
      const HomeItem(
        id: '1',
        title: 'Article Enquiry',
        description: 'Search and view article information',
        category: 'Operations',
      ),
      const HomeItem(
        id: '2',
        title: 'In Store Operation',
        description: 'Manage in-store operations',
        category: 'Operations',
      ),
      const HomeItem(
        id: '3',
        title: 'Label Print',
        description: 'Print labels for products',
        category: 'Operations',
      ),
      const HomeItem(
        id: '7',
        title: 'Reservation',
        description: 'Handle product reservations',
        category: 'Operations',
      ),
      // Purchase Orders
      const HomeItem(
        id: '5',
        title: 'Goods Receipt Local PO',
        description: 'Process local purchase orders',
        category: 'Purchase Orders',
      ),
      const HomeItem(
        id: '8',
        title: 'Fresh Food PO',
        description: 'Manage fresh food purchase orders',
        category: 'Purchase Orders',
      ),
      const HomeItem(
        id: '9',
        title: 'Return PO',
        description: 'Process return purchase orders',
        category: 'Purchase Orders',
      ),
      // Delivery & Stock
      const HomeItem(
        id: '4',
        title: 'Delivery Creation',
        description: 'Create and manage deliveries',
        category: 'Delivery & Stock',
      ),
      const HomeItem(
        id: '10',
        title: 'Goods Receipt Delivery',
        description: 'Receive goods from deliveries',
        category: 'Delivery & Stock',
      ),
      const HomeItem(
        id: '6',
        title: 'Stock Transport Order',
        description: 'Manage stock transport orders',
        category: 'Delivery & Stock',
      ),
    ]);

    state.value = HomeState.loaded;

    // Initialize first category as expanded by default, others collapsed
    final categories = items.map((item) => item.category).toSet().toList();
    for (var i = 0; i < categories.length; i++) {
      expandedCategories[categories[i]] =
          i == 0; // Only first category expanded
    }
  }

  void toggleCategory(String category) {
    final isCurrentlyExpanded = expandedCategories[category] ?? false;

    if (isCurrentlyExpanded) {
      // If clicking an already expanded category, collapse it
      expandedCategories[category] = false;
    } else {
      // Collapse all categories first
      for (var cat in expandedCategories.keys) {
        expandedCategories[cat] = false;
      }
      // Then expand the selected category
      expandedCategories[category] = true;
    }
  }

  bool isCategoryExpanded(String category) {
    return expandedCategories[category] ?? false;
  }

  void navigateToModule(String moduleId, String moduleTitle) {
    // Navigate to specific module screens
    switch (moduleId) {
      case '1': // Article Enquiry
        Get.toNamed('/article-enquiry');
        break;
      case '2': // In Store Operation - show category selection dialog
        Get.dialog(
          const InStoreOperationCategoryDialog(),
          barrierDismissible: true,
        );
        break;
      case '3': // Label Print
        Get.toNamed('/label-print');
        break;
      case '7': // Reservation - show category selection dialog
        Get.dialog(const ReservationCategoryDialog(), barrierDismissible: true);
        break;
      default:
        Get.toNamed(
          '/module-detail',
          arguments: {'id': moduleId, 'title': moduleTitle},
        );
    }
  }
}
