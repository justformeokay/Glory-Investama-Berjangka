import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class FundamentalsDetailPage extends StatefulWidget {
  const FundamentalsDetailPage({super.key});

  @override
  State<FundamentalsDetailPage> createState() => _FundamentalsDetailPageState();
}

class _FundamentalsDetailPageState extends State<FundamentalsDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        title: const Text('Economic Fundamentals'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left_outline),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar
            Container(
              color: AppColors.bgLight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primaryGold,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primaryGold,
                tabs: const [
                  Tab(text: 'Major Pairs'),
                  Tab(text: 'Calendar'),
                  Tab(text: 'Forecasts'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMajorPairsTab(),
                  _buildCalendarTab(),
                  _buildForecastsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMajorPairsTab() {
    final fundamentals = [
      {
        'country': 'United States',
        'flag': '🇺🇸',
        'indicators': [
          {'name': 'CPI Inflation', 'current': '3.2%', 'previous': '3.4%', 'forecast': '3.1%', 'status': 'Lower'},
          {'name': 'GDP Growth', 'current': '2.5%', 'previous': '2.3%', 'forecast': '2.4%', 'status': 'Higher'},
          {'name': 'Unemployment', 'current': '3.7%', 'previous': '3.8%', 'forecast': '3.6%', 'status': 'Lower'},
          {'name': 'Fed Rate', 'current': '4.50%', 'previous': '4.25%', 'forecast': '4.50%', 'status': 'Higher'},
        ],
      },
      {
        'country': 'Eurozone',
        'flag': '🇪🇺',
        'indicators': [
          {'name': 'Inflation Rate', 'current': '2.4%', 'previous': '2.6%', 'forecast': '2.2%', 'status': 'Lower'},
          {'name': 'GDP Growth', 'current': '0.9%', 'previous': '0.8%', 'forecast': '1.0%', 'status': 'Higher'},
          {'name': 'Unemployment', 'current': '6.2%', 'previous': '6.1%', 'forecast': '6.1%', 'status': 'Stable'},
          {'name': 'ECB Rate', 'current': '4.50%', 'previous': '4.25%', 'forecast': '4.50%', 'status': 'Stable'},
        ],
      },
      {
        'country': 'United Kingdom',
        'flag': '🇬🇧',
        'indicators': [
          {'name': 'Inflation Rate', 'current': '2.0%', 'previous': '2.2%', 'forecast': '2.1%', 'status': 'Lower'},
          {'name': 'GDP Growth', 'current': '1.1%', 'previous': '1.0%', 'forecast': '1.2%', 'status': 'Higher'},
          {'name': 'Unemployment', 'current': '4.0%', 'previous': '3.9%', 'forecast': '4.1%', 'status': 'Higher'},
          {'name': 'BoE Rate', 'current': '5.25%', 'previous': '5.00%', 'forecast': '5.25%', 'status': 'Stable'},
        ],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: fundamentals.length,
      itemBuilder: (context, index) {
        final fund = fundamentals[index];
        return Column(
          children: [
            _buildCountrySection(context, fund),
            if (index < fundamentals.length - 1) const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildCountrySection(BuildContext context, Map<String, dynamic> fund) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primaryGold.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                fund['flag'],
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Text(
                fund['country'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Indicators
        Column(
          children: List.generate(
            (fund['indicators'] as List).length,
            (idx) {
              final indicator = (fund['indicators'] as List)[idx];
              return Column(
                children: [
                  _buildIndicatorRow(context, indicator),
                  if (idx < (fund['indicators'] as List).length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: 1,
                        color: AppColors.secondaryGrey.withOpacity(0.1),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorRow(BuildContext context, Map<String, String> indicator) {
    final isLower = indicator['status'] == 'Lower';
    final isHigher = indicator['status'] == 'Higher';
    final statusColor = isLower
        ? AppColors.successGreen
        : isHigher
            ? AppColors.errorRed
            : AppColors.infoBlue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            indicator['name']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          child: _buildIndicatorValue(context, 'Current', indicator['current']!),
        ),
        Expanded(
          child: _buildIndicatorValue(context, 'Prev', indicator['previous']!),
        ),
        Expanded(
          child: _buildIndicatorValue(context, 'Forecast', indicator['forecast']!),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isLower
                    ? Iconsax.arrow_down_outline
                    : isHigher
                        ? Iconsax.arrow_up_outline
                        : Iconsax.minus_outline,
                size: 12,
                color: statusColor,
              ),
              const SizedBox(width: 2),
              Text(
                indicator['status']!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorValue(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
        ),
      ],
    );
  }

  Widget _buildCalendarTab() {
    final events = [
      {
        'date': 'Jan 15, 2026',
        'time': '14:00 GMT',
        'country': '🇺🇸',
        'event': 'US Producer Price Index',
        'importance': 'High',
        'forecast': '2.3%',
        'previous': '2.4%',
      },
      {
        'date': 'Jan 16, 2026',
        'time': '10:00 GMT',
        'country': '🇪🇺',
        'event': 'Eurozone Retail Sales',
        'importance': 'Medium',
        'forecast': '1.2%',
        'previous': '0.8%',
      },
      {
        'date': 'Jan 17, 2026',
        'time': '13:30 GMT',
        'country': '🇬🇧',
        'event': 'UK CPI Inflation Rate',
        'importance': 'High',
        'forecast': '2.0%',
        'previous': '2.1%',
      },
      {
        'date': 'Jan 18, 2026',
        'time': '22:00 GMT',
        'country': '🇯🇵',
        'event': 'Japan Trade Balance',
        'importance': 'Medium',
        'forecast': '500M',
        'previous': '400M',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Column(
          children: [
            _buildCalendarEvent(context, event),
            if (index < events.length - 1) const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildCalendarEvent(BuildContext context, Map<String, String> event) {
    final isHigh = event['importance'] == 'High';
    final importance = isHigh ? AppColors.errorRed : AppColors.infoBlue;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: importance.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: importance.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['date']!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    event['time']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: importance.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event['importance']!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: importance,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                event['country']!,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event['event']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
            ],
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
              _buildEventData(context, 'Forecast', event['forecast']!),
              _buildEventData(context, 'Previous', event['previous']!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventData(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
    );
  }

  Widget _buildForecastsTab() {
    final forecasts = [
      {
        'pair': 'EUR/USD',
        'quarter': 'Q1 2026',
        'current': '1.0845',
        'forecast': '1.1050',
        'change': '+1.89%',
        'sentiment': 'Bullish',
        'confidence': 78,
      },
      {
        'pair': 'GBP/USD',
        'quarter': 'Q1 2026',
        'current': '1.2634',
        'forecast': '1.2850',
        'change': '+1.71%',
        'sentiment': 'Bullish',
        'confidence': 72,
      },
      {
        'pair': 'USD/JPY',
        'quarter': 'Q1 2026',
        'current': '148.52',
        'forecast': '145.00',
        'change': '-2.37%',
        'sentiment': 'Bearish',
        'confidence': 68,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: forecasts.length,
      itemBuilder: (context, index) {
        final forecast = forecasts[index];
        return Column(
          children: [
            _buildForecastCard(context, forecast),
            if (index < forecasts.length - 1) const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildForecastCard(BuildContext context, Map<String, dynamic> forecast) {
    final isBullish = forecast['sentiment'] == 'Bullish';
    final color = isBullish ? AppColors.successGreen : AppColors.errorRed;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryWhite,
            AppColors.secondaryWhite.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecast['pair'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    forecast['quarter'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  forecast['sentiment'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriceColumn(context, 'Current', forecast['current'] as String),
              _buildPriceColumn(context, 'Target', forecast['forecast'] as String),
              _buildPriceColumn(context, 'Change', forecast['change'] as String, isChange: true),
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
              Text(
                'Confidence Level',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              Text(
                '${forecast['confidence']}%',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (forecast['confidence'] as int) / 100,
              minHeight: 6,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceColumn(BuildContext context, String label, String value, {bool isChange = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isChange
                    ? (value.contains('+') ? AppColors.successGreen : AppColors.errorRed)
                    : AppColors.textPrimary,
              ),
        ),
      ],
    );
  }
}
