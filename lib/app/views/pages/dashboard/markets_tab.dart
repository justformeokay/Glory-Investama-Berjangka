import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';
import '../markets/market_detail_page.dart';

class MarketsTab extends StatelessWidget {
  const MarketsTab({super.key});

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
                    _buildCategoryChip(context, 'All', isSelected: true),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Forex'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Crypto'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Commodities'),
                    const SizedBox(width: 8),
                    _buildCategoryChip(context, 'Indices'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Markets List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final markets = [
                    {'pair': 'EUR/USD', 'price': '1.0845', 'change': '+0.25%', 'isPositive': true},
                    {'pair': 'GBP/USD', 'price': '1.2634', 'change': '-0.12%', 'isPositive': false},
                    {'pair': 'USD/JPY', 'price': '148.52', 'change': '+0.45%', 'isPositive': true},
                    {'pair': 'AUD/USD', 'price': '0.6425', 'change': '+0.18%', 'isPositive': true},
                    {'pair': 'USD/CAD', 'price': '1.3425', 'change': '-0.32%', 'isPositive': false},
                    {'pair': 'NZD/USD', 'price': '0.5980', 'change': '+0.22%', 'isPositive': true},
                    {'pair': 'USD/CHF', 'price': '0.8745', 'change': '-0.15%', 'isPositive': false},
                    {'pair': 'EUR/GBP', 'price': '0.8580', 'change': '+0.10%', 'isPositive': true},
                    {'pair': 'EUR/JPY', 'price': '161.05', 'change': '+0.68%', 'isPositive': true},
                    {'pair': 'GBP/JPY', 'price': '187.65', 'change': '-0.20%', 'isPositive': false},
                  ];

                  final market = markets[index];
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
    return Container(
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
    );
  }

  Widget _buildMarketCard(
    BuildContext context, {
    required String pair,
    required String price,
    required String change,
    required bool isPositive,
  }) {
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.chart_21_outline,
                color: AppColors.primaryGold,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Pair and Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pair,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            // Mini Chart Placeholder
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: MiniChartPainter(isPositive: isPositive),
              ),
            ),
            const SizedBox(width: 16),

            // Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  isPositive ? Iconsax.arrow_up_outline : Iconsax.arrow_down_outline,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                  size: 16,
                ),
                const SizedBox(height: 4),
                Text(
                  change,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Simple mini chart painter
class MiniChartPainter extends CustomPainter {
  final bool isPositive;

  MiniChartPainter({required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isPositive ? AppColors.successGreen : AppColors.errorRed
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.25, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.6);
    path.lineTo(size.width * 0.75, size.height * 0.3);
    path.lineTo(size.width, isPositive ? size.height * 0.2 : size.height * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
