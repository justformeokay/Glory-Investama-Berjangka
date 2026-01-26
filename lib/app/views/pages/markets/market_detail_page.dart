import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../constants/colors.dart';
import '../../../controllers/market_detail_controller.dart';

class MarketDetailPage extends StatefulWidget {
  final String marketPair;
  final String currentPrice;

  const MarketDetailPage({
    super.key,
    required this.marketPair,
    required this.currentPrice,
  });

  @override
  State<MarketDetailPage> createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  late final WebViewController _webViewController;
  bool _isLoading = true;
  String _selectedTimeframe = '1H';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final symbol = widget.marketPair.replaceAll('/', '');
    
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://www.tradingview.com/widgetembed/?frameElementId=tradingview_chart'
          '&symbol=FX:$symbol'
          '&interval=60'
          '&hidesidetoolbar=0'
          '&symboledit=1'
          '&saveimage=1'
          '&toolbarbg=f1f3f6'
          '&studies=[]'
          '&theme=light'
          '&style=1'
          '&timezone=Asia/Jakarta'
          '&withdateranges=1'
          '&studies_overrides={}'
          '&overrides={}'
          '&enabled_features=[]'
          '&disabled_features=[]'
          '&locale=en'
          '&utm_source=localhost'
          '&utm_medium=widget_new'
          '&utm_campaign=chart'
          '&utm_term=FX:$symbol',
        ),
      );
  }

  void _showLotSettings() {
    final controller = Get.put(MarketDetailController());
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.secondaryGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Set Lot Size',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.decrementLot();
                    },
                    icon: Icon(Bootstrap.dash_circle_fill),
                    color: AppColors.primaryGold,
                    iconSize: 32,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        controller.lotSize.value.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryGold,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.incrementLot();
                    },
                    icon: Icon(Bootstrap.plus_circle_fill),
                    color: AppColors.primaryGold,
                    iconSize: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildQuickLotButton('0.01', controller),
                const SizedBox(width: 8),
                _buildQuickLotButton('0.10', controller),
                const SizedBox(width: 8),
                _buildQuickLotButton('0.50', controller),
                const SizedBox(width: 8),
                _buildQuickLotButton('1.00', controller),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.secondaryWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLotButton(String value, MarketDetailController controller) {
    return Obx(
      () {
        final isSelected = controller.lotSize.value == double.parse(value);
        return Expanded(
          child: InkWell(
            onTap: () {
              controller.setLotSize(double.parse(value));
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGold : AppColors.bgLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColors.primaryGold : AppColors.secondaryGrey.withOpacity(0.3),
                ),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.secondaryWhite : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.secondaryGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Trade Settings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            _buildSettingItem(
              icon: Bootstrap.shield_check,
              title: 'Stop Loss',
              value: 'Set limit',
              color: AppColors.errorRed,
            ),
            const SizedBox(height: 12),
            _buildSettingItem(
              icon: Bootstrap.trophy,
              title: 'Take Profit',
              value: 'Set target',
              color: AppColors.successGreen,
            ),
            const SizedBox(height: 12),
            _buildSettingItem(
              icon: Bootstrap.clock_history,
              title: 'Expiration',
              value: 'Good till cancel',
              color: AppColors.primaryGold,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.secondaryWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                'Save Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Bootstrap.chevron_right,
            color: AppColors.textSecondary,
            size: 16,
          ),
        ],
      ),
    );
  }

  void _executeTrade(bool isBuy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondaryWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBuy
                    ? AppColors.successGreen.withOpacity(0.1)
                    : AppColors.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isBuy ? Bootstrap.arrow_up_circle_fill : Bootstrap.arrow_down_circle_fill,
                color: isBuy ? AppColors.successGreen : AppColors.errorRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Confirm ${isBuy ? 'Buy' : 'Sell'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmRow('Market', widget.marketPair),
            const SizedBox(height: 12),
            _buildConfirmRow('Price', widget.currentPrice),
            const SizedBox(height: 12),
            Obx(() => _buildConfirmRow('Lot Size', Get.put(MarketDetailController()).lotSize.value.toStringAsFixed(2))),
            const SizedBox(height: 12),
            _buildConfirmRow('Type', isBuy ? 'Market Buy' : 'Market Sell'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.snackbar(
                'Trade Executed',
                '${isBuy ? 'Buy' : 'Sell'} order placed successfully!',
                backgroundColor: isBuy ? AppColors.successGreen : AppColors.errorRed,
                colorText: AppColors.secondaryWhite,
                icon: Icon(
                  Bootstrap.check_circle_fill,
                  color: AppColors.secondaryWhite,
                ),
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
                duration: const Duration(seconds: 3),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isBuy ? AppColors.successGreen : AppColors.errorRed,
              foregroundColor: AppColors.secondaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(isBuy ? 'Buy Now' : 'Sell Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Bootstrap.arrow_left, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Bootstrap.graph_up,
                color: AppColors.primaryGold,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.marketPair,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  widget.currentPrice,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Bootstrap.star, color: AppColors.primaryGold),
            onPressed: () {
              Get.snackbar(
                'Watchlist',
                '${widget.marketPair} added to watchlist',
                backgroundColor: AppColors.primaryGold,
                colorText: AppColors.secondaryWhite,
                icon: Icon(Bootstrap.star_fill, color: AppColors.secondaryWhite),
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
                duration: const Duration(seconds: 2),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Timeframe selector
          Container(
            color: AppColors.secondaryWhite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTimeframeChip('1M'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('5M'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('15M'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('1H'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('4H'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('1D'),
                  const SizedBox(width: 8),
                  _buildTimeframeChip('1W'),
                ],
              ),
            ),
          ),

          // Chart WebView
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryGrey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: WebViewWidget(controller: _webViewController),
                ),
                if (_isLoading)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryGold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Loading Chart...',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Trading buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.secondaryWhite,
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryGrey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Lot Settings Button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _showLotSettings,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold.withOpacity(0.1),
                        foregroundColor: AppColors.primaryGold,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Bootstrap.pie_chart_fill, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            Get.find<MarketDetailController>().lotSize.value.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Settings Button
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _showSettings,
                      icon: Icon(Bootstrap.gear_fill),
                      color: AppColors.primaryGold,
                      iconSize: 24,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Buy Button
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () => _executeTrade(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successGreen,
                        foregroundColor: AppColors.secondaryWhite,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Bootstrap.arrow_up_circle_fill, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'BUY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Sell Button
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () => _executeTrade(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.errorRed,
                        foregroundColor: AppColors.secondaryWhite,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Bootstrap.arrow_down_circle_fill, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'SELL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeChip(String timeframe) {
    final isSelected = _selectedTimeframe == timeframe;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTimeframe = timeframe;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : AppColors.bgLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          timeframe,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isSelected ? AppColors.secondaryWhite : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
