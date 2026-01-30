import 'package:get/get.dart';
import '../controllers/market_detail_controller.dart';

class MarketDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MarketDetailController>(MarketDetailController());
  }
}
