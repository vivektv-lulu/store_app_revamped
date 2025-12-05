import 'package:get/get.dart';
import '../../domain/entities/home_item.dart';

enum HomeState { initial, loading, loaded, error }

class HomeController extends GetxController {
  final Rx<HomeState> state = HomeState.initial.obs;
  final RxList<HomeItem> items = <HomeItem>[].obs;
  final RxnString errorMessage = RxnString();
  
  // User information
  final RxString loggedInUser = 'John Doe'.obs; // TODO: Get from auth service
  final RxString userRole = 'Price Integrator'.obs; // TODO: Get from auth service

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

    // Mock data for 10 modules
    items.assignAll([
      const HomeItem(
        id: '1',
        title: 'Article Enquiry',
        description: 'Search and view article information',
      ),
      const HomeItem(
        id: '2',
        title: 'In Store Operation',
        description: 'Manage in-store operations',
      ),
      const HomeItem(
        id: '3',
        title: 'Label Print',
        description: 'Print labels for products',
      ),
      const HomeItem(
        id: '4',
        title: 'Delivery Creation',
        description: 'Create and manage deliveries',
      ),
      const HomeItem(
        id: '5',
        title: 'Goods Receipt Local PO',
        description: 'Process local purchase orders',
      ),
      const HomeItem(
        id: '6',
        title: 'Stock Transport Order',
        description: 'Manage stock transport orders',
      ),
      const HomeItem(
        id: '7',
        title: 'Reservation',
        description: 'Handle product reservations',
      ),
      const HomeItem(
        id: '8',
        title: 'Fresh Food PO',
        description: 'Manage fresh food purchase orders',
      ),
      const HomeItem(
        id: '9',
        title: 'Return PO',
        description: 'Process return purchase orders',
      ),
      const HomeItem(
        id: '10',
        title: 'Goods Receipt Delivery',
        description: 'Receive goods from deliveries',
      ),
    ]);

    state.value = HomeState.loaded;
  }

  void navigateToModule(String moduleId, String moduleTitle) {
    Get.toNamed('/module-detail', arguments: {
      'id': moduleId,
      'title': moduleTitle,
    });
  }
}

