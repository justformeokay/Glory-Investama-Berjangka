import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isDrawerOpen = false.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize dashboard data
  }

  @override
  void onReady() {
    super.onReady();
    // Fetch dashboard data
  }

  @override
  void onClose() {
    super.onClose();
  }
}
