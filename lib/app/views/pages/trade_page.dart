import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/trade_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class TradePage extends StatelessWidget {
  TradePage({super.key});

  final TradeController controller = Get.put(TradeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.secondaryWhite,
          title: Text(
            'Trade',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.arrow_left_1_outline,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symbol Selector
              _buildSymbolSelector(context),
              const SizedBox(height: 24),

              // Market Info Card
              _buildMarketInfoCard(context),
              const SizedBox(height: 24),

              // Buy/Sell Toggle
              _buildBuySellToggle(context),
              const SizedBox(height: 24),

              // Order Type Tabs
              _buildOrderTypeTabs(context),
              const SizedBox(height: 24),

              // Entry Price
              _buildEntryPriceField(context),
              const SizedBox(height: 16),

              // Lot Size Selector
              _buildLotSelector(context),
              const SizedBox(height: 24),

              // Stop Loss & Take Profit
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      context,
                      label: 'Stop Loss',
                      value: controller.stopLoss.value,
                      onChanged: (val) => controller.stopLoss.value = val,
                      icon: Iconsax.arrow_down_1_outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      context,
                      label: 'Take Profit',
                      value: controller.takeProfit.value,
                      onChanged: (val) => controller.takeProfit.value = val,
                      icon: Iconsax.arrow_up_1_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Risk/Reward Summary
              _buildRiskRewardCard(context),
              const SizedBox(height: 24),

              // Execute Button
              _buildExecuteButton(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymbolSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trading Pair',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.secondaryGrey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            value: controller.selectedSymbol.value,
            isExpanded: true,
            underline: const SizedBox(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            items: controller.symbols.map((symbol) {
              final market = controller.marketPrices[symbol];
              return DropdownMenuItem(
                value: symbol,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(symbol),
                    Row(
                      children: [
                        Text(
                          market?.ask.toStringAsFixed(4) ?? '0',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (market?.change ?? 0) >= 0
                                ? AppColors.successGreen.withOpacity(0.1)
                                : AppColors.errorRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${(market?.change ?? 0) >= 0 ? '+' : ''}${market?.change.toStringAsFixed(2)}%',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: (market?.change ?? 0) >= 0
                                      ? AppColors.successGreen
                                      : AppColors.errorRed,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.setSymbol(value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMarketInfoCard(BuildContext context) {
    final market = controller.currentMarket;
    if (market == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bid',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    market.bid.toStringAsFixed(5),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.errorRed,
                        ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.secondaryGrey.withOpacity(0.1),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Ask',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    market.ask.toStringAsFixed(5),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen,
                        ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.secondaryGrey.withOpacity(0.1),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Change',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        market.change >= 0
                            ? Iconsax.arrow_up_1_outline
                            : Iconsax.arrow_down_1_outline,
                        size: 16,
                        color: market.change >= 0
                            ? AppColors.successGreen
                            : AppColors.errorRed,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${market.change >= 0 ? '+' : ''}${market.change.toStringAsFixed(2)}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: market.change >= 0
                                  ? AppColors.successGreen
                                  : AppColors.errorRed,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuySellToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.secondaryGrey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (controller.tradeType.value != 'buy') {
                  controller.toggleTradeType();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.tradeType.value == 'buy'
                      ? AppColors.successGreen
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'BUY',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.tradeType.value == 'buy'
                              ? AppColors.secondaryWhite
                              : AppColors.textSecondary,
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (controller.tradeType.value != 'sell') {
                  controller.toggleTradeType();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.tradeType.value == 'sell'
                      ? AppColors.errorRed
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'SELL',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.tradeType.value == 'sell'
                              ? AppColors.secondaryWhite
                              : AppColors.textSecondary,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.secondaryGrey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType('market'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: controller.orderType.value == 'market'
                      ? AppColors.primaryGold
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Market',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.orderType.value == 'market'
                              ? AppColors.secondaryWhite
                              : AppColors.textSecondary,
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType('limit'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: controller.orderType.value == 'limit'
                      ? AppColors.primaryGold
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Limit',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.orderType.value == 'limit'
                              ? AppColors.secondaryWhite
                              : AppColors.textSecondary,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryPriceField(BuildContext context) {
    return _buildInputField(
      context,
      label: controller.orderType.value == 'market'
          ? 'Current Price'
          : 'Entry Price',
      value: controller.orderType.value == 'market'
          ? controller.currentPrice.toStringAsFixed(5)
          : controller.entryPrice.value,
      onChanged: controller.orderType.value == 'limit'
          ? (val) => controller.entryPrice.value = val
          : null,
      readOnly: controller.orderType.value == 'market',
      icon: Iconsax.trend_up_outline,
    );
  }

  Widget _buildLotSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lot Size',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.lotSizes.map((lot) {
            final isSelected = controller.selectedLots.value == lot;
            return GestureDetector(
              onTap: () => controller.setLots(lot),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryGold : AppColors.secondaryWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryGold
                        : AppColors.secondaryGrey.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  lot.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.secondaryWhite
                            : AppColors.textPrimary,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String value,
    required Function(String)? onChanged,
    IconData? icon,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: readOnly
                ? AppColors.secondaryGrey.withOpacity(0.05)
                : AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondaryGrey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: TextField(
            enabled: !readOnly,
            readOnly: readOnly,
            onChanged: onChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: icon != null
                  ? Icon(icon, color: AppColors.primaryGold, size: 18)
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              hintText: value.isEmpty ? '0.0000' : null,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            controller: TextEditingController(text: value),
          ),
        ),
      ],
    );
  }

  Widget _buildRiskRewardCard(BuildContext context) {
    final sl = double.tryParse(controller.stopLoss.value) ?? 0;
    final tp = double.tryParse(controller.takeProfit.value) ?? 0;
    final profit = controller.calculateProfit(sl, tp);
    final loss = sl > 0 ? (sl - controller.currentPrice).abs() * controller.pipValue : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Potential Profit',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${profit.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen,
                        ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.secondaryGrey.withOpacity(0.1),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Potential Loss',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '-\$${loss.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.errorRed,
                        ),
                  ),
                ],
              ),
            ],
          ),
          if (profit > 0 || loss > 0) ...[
            const SizedBox(height: 12),
            Container(
              height: 1,
              color: AppColors.secondaryGrey.withOpacity(0.1),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Risk/Reward Ratio',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loss > 0 ? '1:${(profit / loss).toStringAsFixed(2)}' : 'N/A',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExecuteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.executeOrder(),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.tradeType.value == 'buy'
              ? AppColors.successGreen
              : AppColors.errorRed,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          '${controller.tradeType.value.toUpperCase()} ${controller.selectedLots.value.toStringAsFixed(1)} LOT',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryWhite,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
