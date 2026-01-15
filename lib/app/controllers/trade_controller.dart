import 'package:get/get.dart';

class TradeController extends GetxController {
  final selectedSymbol = 'EURUSD'.obs;
  final orderType = 'market'.obs; // market or limit
  final tradeType = 'buy'.obs; // buy or sell
  final selectedLots = 1.0.obs;
  final entryPrice = ''.obs;
  final stopLoss = ''.obs;
  final takeProfit = ''.obs;
  final leverage = 1.obs;

  // Mock market data
  final Map<String, MarketPrice> marketPrices = {
    'EURUSD': MarketPrice(bid: 1.0850, ask: 1.0851, change: 0.52),
    'GBPUSD': MarketPrice(bid: 1.2750, ask: 1.2751, change: -0.23),
    'USDJPY': MarketPrice(bid: 149.85, ask: 149.86, change: 1.15),
    'AUDUSD': MarketPrice(bid: 0.6540, ask: 0.6541, change: -0.67),
    'NZDUSD': MarketPrice(bid: 0.6020, ask: 0.6021, change: 0.34),
    'USDCAD': MarketPrice(bid: 1.3650, ask: 1.3651, change: 0.89),
  };

  final List<String> symbols = ['EURUSD', 'GBPUSD', 'USDJPY', 'AUDUSD', 'NZDUSD', 'USDCAD'];
  final List<double> lotSizes = [0.1, 0.5, 1.0, 2.0, 5.0];

  double get currentPrice {
    final market = marketPrices[selectedSymbol.value];
    if (tradeType.value == 'buy') {
      return market?.ask ?? 0;
    } else {
      return market?.bid ?? 0;
    }
  }

  MarketPrice? get currentMarket => marketPrices[selectedSymbol.value];

  double get pipValue {
    // Rough calculation for pip value (0.0001 for most pairs)
    final symbol = selectedSymbol.value;
    if (symbol.endsWith('JPY')) {
      return selectedLots.value * 100; // 0.01 for JPY pairs
    }
    return selectedLots.value * 10; // 0.0001 for others
  }

  double calculateProfit(double sl, double tp) {
    if (sl == 0 || tp == 0) return 0;
    final priceDiff = (tp - sl).abs();
    return priceDiff * pipValue;
  }

  double calculateLoss(double sl) {
    if (sl == 0) return 0;
    final priceDiff = (currentPrice - sl).abs();
    return priceDiff * pipValue;
  }

  void executeOrder() {
    if (selectedSymbol.value.isEmpty ||
        (orderType.value == 'limit' && entryPrice.value.isEmpty)) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    Get.snackbar(
      'Order Submitted',
      '${tradeType.value.toUpperCase()} ${selectedLots.value} lot(s) of ${selectedSymbol.value}',
      duration: const Duration(seconds: 2),
    );

    Get.back();
  }

  void setSymbol(String symbol) {
    selectedSymbol.value = symbol;
    entryPrice.value = '';
  }

  void setLots(double lots) {
    selectedLots.value = lots;
  }

  void toggleTradeType() {
    tradeType.value = tradeType.value == 'buy' ? 'sell' : 'buy';
  }

  void setOrderType(String type) {
    orderType.value = type;
    if (type == 'market') {
      entryPrice.value = currentPrice.toStringAsFixed(4);
    }
  }
}

class MarketPrice {
  final double bid;
  final double ask;
  final double change;

  MarketPrice({
    required this.bid,
    required this.ask,
    required this.change,
  });
}
