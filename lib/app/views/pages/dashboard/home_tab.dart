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

              // Market Analyst
              _buildMarketAnalyst(context),
              const SizedBox(height: 24),

              // News
              _buildNews(context),
              const SizedBox(height: 24),

              // Fundamentals
              _buildFundamentals(context),
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

  Widget _buildMarketAnalyst(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Market Analyst',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/market-analysts'),
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildAnalystCard(
          context,
          analyst: 'Sarah Mitchell',
          title: 'EUR/USD Bullish Pattern',
          description: 'Strong support at 1.0820, expect breakout soon',
          rating: 4.8,
          followers: '2.3K',
          color: AppColors.successGreen,
        ),
        const SizedBox(height: 12),
        _buildAnalystCard(
          context,
          analyst: 'John Premium',
          title: 'GBP/USD Consolidation',
          description: 'Waiting for breakout from range 1.2600-1.2700',
          rating: 4.6,
          followers: '1.8K',
          color: AppColors.infoBlue,
        ),
        const SizedBox(height: 12),
        _buildAnalystCard(
          context,
          analyst: 'Alex Trading',
          title: 'USD/JPY Strong Resistance',
          description: 'Key level at 149.00, watch for reversal signals',
          rating: 4.5,
          followers: '1.5K',
          color: AppColors.errorRed,
        ),
      ],
    );
  }

  Widget _buildAnalystCard(
    BuildContext context, {
    required String analyst,
    required String title,
    required String description,
    required double rating,
    required String followers,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryWhite,
            AppColors.secondaryWhite.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      analyst,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.star_1_outline, color: color, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppColors.secondaryGrey.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.people_outline,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$followers followers',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Follow',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'News',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/news'),
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildNewsCard(
          context,
          title: 'ECB Holds Interest Rates at 4.5%',
          summary: 'European Central Bank maintained its benchmark rate, citing persistent inflation concerns',
          source: 'Reuters',
          time: '2 hours ago',
          category: 'Economic',
          categoryColor: AppColors.infoBlue,
          icon: Iconsax.trend_up_outline,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          context,
          title: 'Fed Minutes Show Hawkish Stance',
          summary: 'Federal Reserve officials signaled potential rate hikes in upcoming meetings',
          source: 'Bloomberg',
          time: '4 hours ago',
          category: 'Policy',
          categoryColor: AppColors.errorRed,
          icon: Iconsax.warning_2_outline,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          context,
          title: 'Bank of Japan Signals Long-Term Changes',
          summary: 'BoJ hints at potential monetary policy adjustments for 2026',
          source: 'Financial Times',
          time: '6 hours ago',
          category: 'Strategy',
          categoryColor: AppColors.successGreen,
          icon: Iconsax.chart_outline,
        ),
      ],
    );
  }

  Widget _buildNewsCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String source,
    required String time,
    required String category,
    required Color categoryColor,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondaryGrey.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryGrey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: categoryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: categoryColor,
                                fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  source,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFundamentals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fundamentals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/fundamentals'),
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.primaryGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildFundamentalCard(
          context,
          country: 'United States',
          indicator: 'Inflation Rate (CPI)',
          current: '3.2%',
          previous: '3.4%',
          forecast: '3.1%',
          change: -0.2,
          isPositive: true,
          icon: Iconsax.percentage_circle_outline,
        ),
        const SizedBox(height: 12),
        _buildFundamentalCard(
          context,
          country: 'Eurozone',
          indicator: 'GDP Growth Rate',
          current: '0.9%',
          previous: '0.8%',
          forecast: '1.0%',
          change: 0.1,
          isPositive: true,
          icon: Iconsax.trend_up_outline,
        ),
        const SizedBox(height: 12),
        _buildFundamentalCard(
          context,
          country: 'United Kingdom',
          indicator: 'Unemployment Rate',
          current: '4.0%',
          previous: '3.9%',
          forecast: '4.1%',
          change: 0.1,
          isPositive: false,
          icon: Iconsax.trend_down_outline,
        ),
      ],
    );
  }

  Widget _buildFundamentalCard(
    BuildContext context, {
    required String country,
    required String indicator,
    required String current,
    required String previous,
    required String forecast,
    required double change,
    required bool isPositive,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryWhite,
            AppColors.secondaryWhite.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (isPositive ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isPositive ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      indicator,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: AppColors.secondaryGrey.withOpacity(0.1),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFundamentalValue(
                context,
                label: 'Current',
                value: current,
              ),
              _buildFundamentalValue(
                context,
                label: 'Previous',
                value: previous,
              ),
              _buildFundamentalValue(
                context,
                label: 'Forecast',
                value: forecast,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: (isPositive ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isPositive ? Iconsax.arrow_up_2_outline : Iconsax.arrow_down_2_outline,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}% vs Previous',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundamentalValue(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
      ],
    );
  }
}
