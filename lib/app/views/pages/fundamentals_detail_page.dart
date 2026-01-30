import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class FundamentalsDetailPage extends StatefulWidget {
  final String? companyName;
  final String? ticker;
  final Color? categoryColor;
  final String? sector;

  const FundamentalsDetailPage({
    super.key,
    this.companyName,
    this.ticker,
    this.categoryColor,
    this.sector,
  });

  @override
  State<FundamentalsDetailPage> createState() => _FundamentalsDetailPageState();
}

class _FundamentalsDetailPageState extends State<FundamentalsDetailPage> {
  bool isWatchlist = false;

  @override
  Widget build(BuildContext context) {
    final categoryColor = widget.categoryColor ?? AppColors.successGreen;
    final companyName = widget.companyName ?? 'Apple Inc.';
    final ticker = widget.ticker ?? 'AAPL';
    final sector = widget.sector ?? 'Technology';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_1_outline,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Fundamentals',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              isWatchlist ? Icons.star : Icons.star_border,
              color: isWatchlist ? AppColors.primaryGold : AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() {
                isWatchlist = !isWatchlist;
              });
              Get.showSnackbar(
                GetSnackBar(
                  title: isWatchlist ? 'Added' : 'Removed',
                  message: isWatchlist
                      ? 'Added to watchlist'
                      : 'Removed from watchlist',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Header
              _buildCompanyHeader(context, companyName, ticker, sector, categoryColor),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Key Metrics
                    _buildKeyMetrics(context, categoryColor),
                    const SizedBox(height: 24),

                    // Earnings & Revenue
                    _buildEarningsRevenue(context, categoryColor),
                    const SizedBox(height: 24),

                    // Financial Ratios
                    _buildFinancialRatios(context, categoryColor),
                    const SizedBox(height: 24),

                    // Dividend Analysis
                    _buildDividendAnalysis(context, categoryColor),
                    const SizedBox(height: 24),

                    // Balance Sheet Highlights
                    _buildBalanceSheet(context, categoryColor),
                    const SizedBox(height: 24),

                    // Industry Comparison
                    _buildIndustryComparison(context, categoryColor),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyHeader(
    BuildContext context,
    String companyName,
    String ticker,
    String sector,
    Color categoryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withOpacity(0.2),
            categoryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo & Name
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Iconsax.chart_outline,
                    size: 32,
                    color: categoryColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: categoryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            ticker,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: categoryColor,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            sector,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: categoryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Current Price & Change
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Price',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$185.92',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.arrow_up_outline,
                      size: 14,
                      color: AppColors.successGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+2.45% YTD',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.successGreen,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetrics(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context,
                label: 'Market Cap',
                value: '2.8T',
                unit: 'USD',
                icon: Iconsax.money_outline,
                categoryColor: categoryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                context,
                label: 'P/E Ratio',
                value: '28.5',
                unit: 'x',
                icon: Iconsax.chart_1_outline,
                categoryColor: categoryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context,
                label: 'Dividend Yield',
                value: '0.48%',
                unit: 'Annual',
                icon: Iconsax.gift_outline,
                categoryColor: categoryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                context,
                label: 'Beta',
                value: '1.25',
                unit: 'vs Market',
                icon: Iconsax.activity_outline,
                categoryColor: categoryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color categoryColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: categoryColor, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsRevenue(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Earnings & Revenue (TTM)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEarningsRow(
                context,
                'Revenue',
                '\$383.3B',
                '+10.2% YoY',
                categoryColor,
              ),
              const SizedBox(height: 12),
              Divider(
                color: AppColors.secondaryGrey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _buildEarningsRow(
                context,
                'Net Income',
                '\$96.9B',
                '+4.7% YoY',
                categoryColor,
              ),
              const SizedBox(height: 12),
              Divider(
                color: AppColors.secondaryGrey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _buildEarningsRow(
                context,
                'EPS (Diluted)',
                '\$6.05',
                '+1.8% YoY',
                categoryColor,
              ),
              const SizedBox(height: 12),
              Divider(
                color: AppColors.secondaryGrey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _buildEarningsRow(
                context,
                'Gross Margin',
                '46.2%',
                '-0.5pp YoY',
                categoryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsRow(
    BuildContext context,
    String label,
    String value,
    String change,
    Color categoryColor,
  ) {
    final isPositive = change.contains('+');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (isPositive ? AppColors.successGreen : AppColors.errorRed)
                .withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            change,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialRatios(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Ratios',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
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
              _buildRatioRow(
                context,
                'Current Ratio',
                '0.95',
                'Liquidity',
                categoryColor,
              ),
              const SizedBox(height: 12),
              _buildRatioRow(
                context,
                'Debt-to-Equity',
                '0.38',
                'Solvency',
                categoryColor,
              ),
              const SizedBox(height: 12),
              _buildRatioRow(
                context,
                'ROE',
                '94.6%',
                'Profitability',
                categoryColor,
              ),
              const SizedBox(height: 12),
              _buildRatioRow(
                context,
                'ROA',
                '27.8%',
                'Efficiency',
                categoryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatioRow(
    BuildContext context,
    String ratioName,
    String value,
    String category,
    Color categoryColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ratioName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              category,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: categoryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildDividendAnalysis(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dividend Analysis',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: categoryColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDividendItem(context, 'Last Dividend', '\$0.24 / share'),
              const SizedBox(height: 12),
              _buildDividendItem(
                context,
                'Dividend Frequency',
                'Quarterly',
              ),
              const SizedBox(height: 12),
              _buildDividendItem(
                context,
                'Payout Ratio',
                '14.2%',
              ),
              const SizedBox(height: 12),
              _buildDividendItem(
                context,
                'Next Ex-Dividend',
                'Feb 12, 2026',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDividendItem(
    BuildContext context,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
      ],
    );
  }

  Widget _buildBalanceSheet(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Balance Sheet Highlights',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBalanceCard(
                context,
                'Total Assets',
                '\$346.9B',
                categoryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                context,
                'Total Liabilities',
                '\$253.5B',
                categoryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBalanceCard(
                context,
                'Cash & Equivalents',
                '\$29.9B',
                categoryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                context,
                'Total Equity',
                '\$93.4B',
                categoryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    String label,
    String value,
    Color categoryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryComparison(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Industry Comparison',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
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
              _buildComparisonItem(
                context,
                'P/E Ratio',
                'AAPL: 28.5',
                'Industry: 25.2',
                categoryColor,
              ),
              const SizedBox(height: 12),
              Divider(
                color: AppColors.secondaryGrey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _buildComparisonItem(
                context,
                'Dividend Yield',
                'AAPL: 0.48%',
                'Industry: 1.8%',
                categoryColor,
              ),
              const SizedBox(height: 12),
              Divider(
                color: AppColors.secondaryGrey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _buildComparisonItem(
                context,
                'Net Margin',
                'AAPL: 25.3%',
                'Industry: 12.5%',
                categoryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonItem(
    BuildContext context,
    String metric,
    String company,
    String industry,
    Color categoryColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          metric,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              company,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              industry,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
