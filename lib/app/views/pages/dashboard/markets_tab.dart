import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';
import '../markets/market_detail_page.dart';

class MarketsTab extends StatefulWidget {
  const MarketsTab({super.key});

  @override
  State<MarketsTab> createState() => _MarketsTabState();
}

class _MarketsTabState extends State<MarketsTab> {
  String selectedCategory = 'All';

  final markets = [
    {'pair': 'EUR/USD', 'price': '1.0845', 'change': '+0.25%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'GBP/USD', 'price': '1.2634', 'change': '-0.12%', 'isPositive': false, 'category': 'Forex'},
    {'pair': 'USD/JPY', 'price': '148.52', 'change': '+0.45%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'AUD/USD', 'price': '0.6425', 'change': '+0.18%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'USD/CAD', 'price': '1.3425', 'change': '-0.32%', 'isPositive': false, 'category': 'Forex'},
    {'pair': 'NZD/USD', 'price': '0.5980', 'change': '+0.22%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'USD/CHF', 'price': '0.8745', 'change': '-0.15%', 'isPositive': false, 'category': 'Forex'},
    {'pair': 'EUR/GBP', 'price': '0.8580', 'change': '+0.10%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'EUR/JPY', 'price': '161.05', 'change': '+0.68%', 'isPositive': true, 'category': 'Forex'},
    {'pair': 'GBP/JPY', 'price': '187.65', 'change': '-0.20%', 'isPositive': false, 'category': 'Forex'},
    {'pair': 'BTC/USD', 'price': '42850', 'change': '+2.34%', 'isPositive': true, 'category': 'Commodities'},
    {'pair': 'ETH/USD', 'price': '2450', 'change': '+1.12%', 'isPositive': true, 'category': 'Commodities'},
    {'pair': 'GOLD', 'price': '2085.5', 'change': '+0.55%', 'isPositive': true, 'category': 'Commodities'},
    {'pair': 'CRUDE', 'price': '78.45', 'change': '-1.23%', 'isPositive': false, 'category': 'Commodities'},
    {'pair': 'SP500', 'price': '5421.3', 'change': '+0.89%', 'isPositive': true, 'category': 'Indices'},
    {'pair': 'DAX', 'price': '18750', 'change': '+0.34%', 'isPositive': true, 'category': 'Indices'},
  ];

  List<Map<String, dynamic>> get filteredMarkets {
    if (selectedCategory == 'All') {
      return markets;
    }
    return markets.where((m) => m['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search markets...',
                  prefixIcon: Icon(Iconsax.search_normal_outline),
                  filled: true,
                  fillColor: AppColors.secondaryWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),

            // Market Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip(context, 'All', isSelected: selectedCategory == 'All'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Forex', isSelected: selectedCategory == 'Forex'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Commodities', isSelected: selectedCategory == 'Commodities'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Indices', isSelected: selectedCategory == 'Indices'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Markets List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredMarkets.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final market = filteredMarkets[index];
                  return _buildMarketCard(
                    context,
                    pair: market['pair'] as String,
                    price: market['price'] as String,
                    change: market['change'] as String,
                    isPositive: market['isPositive'] as bool,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGold.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.secondaryWhite : AppColors.textPrimary,
              ),
        ),
      ),
    );
  }

  Widget _buildMarketCard(
    BuildContext context, {
    required String pair,
    required String price,
    required String change,
    required bool isPositive,
  }) {
    // MetaTrader-style market data
    final high = '1.0965';
    final low = '1.0725';
    final bid = '1.0845';
    final ask = '1.0848';
    final spread = '0.3';
    
    return InkWell(
      onTap: () {
        // Navigate to market details
        Get.to(
          () => MarketDetailPage(
            marketPair: pair,
            currentPrice: price,
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryGrey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Row 1: Pair, Current Price, Change %
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pair,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: isPositive ? Colors.blue[600] : Colors.red[600],
                          ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPositive
                            ? Colors.blue[50]
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        change,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isPositive ? Colors.blue[700] : Colors.red[700],
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 2: High, Low, Spread
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoPill(
                  context,
                  label: 'H',
                  value: high,
                  isHighLow: true,
                ),
                _buildInfoPill(
                  context,
                  label: 'L',
                  value: low,
                  isHighLow: true,
                ),
                _buildInfoPill(
                  context,
                  label: 'SPD',
                  value: spread,
                  isSpread: true,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 3: Bid, Ask
            Row(
              children: [
                Expanded(
                  child: _buildBidAskPill(
                    context,
                    label: 'BID',
                    value: bid,
                    isBid: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBidAskPill(
                    context,
                    label: 'ASK',
                    value: ask,
                    isBid: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPill(
    BuildContext context, {
    required String label,
    required String value,
    bool isHighLow = false,
    bool isSpread = false,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSpread
                      ? Colors.orange[600]
                      : AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBidAskPill(
    BuildContext context, {
    required String label,
    required String value,
    required bool isBid,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isBid ? Colors.blue[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isBid ? Colors.blue[200]! : Colors.red[200]!,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: isBid ? Colors.blue[600] : Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isBid ? Colors.blue[700] : Colors.red[700],
                ),
          ),
        ],
      ),
    );
  }
}
