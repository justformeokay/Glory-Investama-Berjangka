import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final Rx<int> _counter = 0.obs;

  int get counter => _counter.value;

  void incrementCounter() {
    _counter.value++;
  }

  void decrementCounter() {
    _counter.value--;
  }

  void resetCounter() {
    _counter.value = 0;
  }
}
