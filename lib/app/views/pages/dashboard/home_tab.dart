import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'John Doe',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // Balance Card
              _buildBalanceCard(context),
              const SizedBox(height: 24),

              // Quick Actions
              _buildQuickActions(context),
              const SizedBox(height: 24),

              // Market Overview
              _buildMarketOverview(context),
              const SizedBox(height: 24),

              // Recent Transactions
              _buildRecentTransactions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    const totalBalance = 124580.50;
    const usedMargin = 2500.00;
    const freeMargin = totalBalance - usedMargin;
    const freeMarginPercent = (freeMargin / totalBalance) * 100;
    const monthlyChange = 12.5;
    const accountType = 'Real Account'; // or 'Demo Account'
    const equity = 125000.00;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGold.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Account Type Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryWhite.withOpacity(0.85),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${totalBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryWhite,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accountType == 'Real Account'
                      ? AppColors.successGreen.withOpacity(0.3)
                      : AppColors.errorRed.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  accountType,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: accountType == 'Real Account'
                            ? Colors.white
                            : AppColors.errorRed,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Monthly Performance
          Row(
            children: [
              Icon(
                monthlyChange >= 0
                    ? Iconsax.arrow_up_outline
                    : Iconsax.arrow_down_outline,
                color: monthlyChange >= 0
                    ? AppColors.successGreen
                    : AppColors.errorRed,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                '${monthlyChange >= 0 ? '+' : ''}${monthlyChange.toStringAsFixed(1)}% this month',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryWhite.withOpacity(0.8),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Divider
          Container(
            height: 1,
            color: AppColors.secondaryWhite.withOpacity(0.15),
          ),
          const SizedBox(height: 16),

          // Info Grid
          Row(
            children: [
              Expanded(
                child: _buildCardInfoItem(
                  context,
                  label: 'Equity',
                  value: '\$${equity.toStringAsFixed(2)}',
                  icon: Iconsax.wallet_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCardInfoItem(
                  context,
                  label: 'Used Margin',
                  value: '\$${usedMargin.toStringAsFixed(2)}',
                  icon: Iconsax.graph_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildCardInfoItem(
                  context,
                  label: 'Free Margin',
                  value: '\$${freeMargin.toStringAsFixed(2)}',
                  icon: Iconsax.empty_wallet_outline,
                  isFreeMargin: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCardInfoItem(
                  context,
                  label: 'Free Margin %',
                  value: '${freeMarginPercent.toStringAsFixed(1)}%',
                  icon: Iconsax.percentage_circle_outline,
                  isPercentage: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfoItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool isFreeMargin = false,
    bool isPercentage = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.secondaryWhite.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: AppColors.secondaryWhite.withOpacity(0.7),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.secondaryWhite.withOpacity(0.7),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryWhite,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: Iconsax.wallet_add_outline,
                label: 'Deposit',
                color: AppColors.successGreen,
                onTap: () => Get.toNamed('/deposit'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Iconsax.wallet_minus_outline,
                label: 'Withdraw',
                color: AppColors.errorRed,
                onTap: () => Get.toNamed('/withdrawal')
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Iconsax.convert_outline,
                label: 'Transfer',
                color: AppColors.infoBlue,
                onTap: () => Get.toNamed('/internal-transfer'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Iconsax.chart_outline,
                label: 'Trade',
                color: AppColors.primaryGold,
                onTap: () => Get.toNamed('/trade'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: .circular(16),
      child: Container(
        padding: const .symmetric(vertical: 16),
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
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Market Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildMarketItem(
          context,
          pair: 'EUR/USD',
          price: '1.0845',
          change: '+0.25%',
          isPositive: true,
        ),
        const SizedBox(height: 12),
        _buildMarketItem(
          context,
          pair: 'GBP/USD',
          price: '1.2634',
          change: '-0.12%',
          isPositive: false,
        ),
        const SizedBox(height: 12),
        _buildMarketItem(
          context,
          pair: 'USD/JPY',
          price: '148.52',
          change: '+0.45%',
          isPositive: true,
        ),
      ],
    );
  }

  Widget _buildMarketItem(
    BuildContext context, {
    required String pair,
    required String price,
    required String change,
    required bool isPositive,
  }) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Iconsax.chart_21_outline,
                  color: AppColors.primaryGold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pair,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (isPositive ? AppColors.successGreen : AppColors.errorRed)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              change,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          context,
          icon: Iconsax.wallet_add_outline,
          title: 'Deposit',
          date: 'Dec 23, 2025',
          amount: '+\$5,000.00',
          isPositive: true,
        ),
        const SizedBox(height: 12),
        _buildTransactionItem(
          context,
          icon: Iconsax.wallet_minus_outline,
          title: 'Withdrawal',
          date: 'Dec 22, 2025',
          amount: '-\$2,000.00',
          isPositive: false,
        ),
        const SizedBox(height: 12),
        _buildTransactionItem(
          context,
          icon: Iconsax.chart_outline,
          title: 'Trade EUR/USD',
          date: 'Dec 21, 2025',
          amount: '+\$150.00',
          isPositive: true,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    required bool isPositive,
  }) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.successGreen : AppColors.errorRed)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                ),
          ),
        ],
      ),
    );
  }
}
