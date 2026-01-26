import 'package:get/get.dart';

class MarketDetailController extends GetxController {
  final lotSize = 0.01.obs;
  final lotIncrement = 0.01.obs;

  void incrementLot() {
    lotSize.value += lotIncrement.value;
  }

  void decrementLot() {
    if (lotSize.value > lotIncrement.value) {
      lotSize.value -= lotIncrement.value;
    } else if (lotSize.value > 0.01) {
      lotSize.value = 0.01;
    }
  }

  void setLotSize(double value) {
    lotSize.value = value;
    lotIncrement.value = value;
  }

  void resetLotSize() {
    lotSize.value = 0.01;
    lotIncrement.value = 0.01;
  }
}
