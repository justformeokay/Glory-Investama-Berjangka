import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';

class SignalsTab extends StatelessWidget {
  const SignalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trading Signals',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Expert recommendations',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Show notifications
                    },
                    icon: Icon(Iconsax.notification_outline),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondaryWhite,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),

            // Signal Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.chart_success_outline,
                      label: 'Success Rate',
                      value: '87.5%',
                      color: AppColors.successGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.chart_21_outline,
                      label: 'Active Signals',
                      value: '12',
                      color: AppColors.infoBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(context, 'All', isSelected: true),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Buy'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Sell'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Pending'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Closed'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Signals List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final signals = [
                    {
                      'pair': 'EUR/USD',
                      'type': 'BUY',
                      'entry': '1.0845',
                      'target': '1.0920',
                      'stopLoss': '1.0800',
                      'confidence': 'High',
                      'time': '2 hours ago',
                      'isBuy': true,
                    },
                    {
                      'pair': 'GBP/USD',
                      'type': 'SELL',
                      'entry': '1.2634',
                      'target': '1.2560',
                      'stopLoss': '1.2680',
                      'confidence': 'Medium',
                      'time': '4 hours ago',
                      'isBuy': false,
                    },
                    {
                      'pair': 'USD/JPY',
                      'type': 'BUY',
                      'entry': '148.52',
                      'target': '149.20',
                      'stopLoss': '148.00',
                      'confidence': 'High',
                      'time': '6 hours ago',
                      'isBuy': true,
                    },
                    {
                      'pair': 'AUD/USD',
                      'type': 'BUY',
                      'entry': '0.6425',
                      'target': '0.6500',
                      'stopLoss': '0.6380',
                      'confidence': 'Medium',
                      'time': '8 hours ago',
                      'isBuy': true,
                    },
                    {
                      'pair': 'USD/CAD',
                      'type': 'SELL',
                      'entry': '1.3425',
                      'target': '1.3350',
                      'stopLoss': '1.3480',
                      'confidence': 'Low',
                      'time': '10 hours ago',
                      'isBuy': false,
                    },
                    {
                      'pair': 'NZD/USD',
                      'type': 'BUY',
                      'entry': '0.5980',
                      'target': '0.6050',
                      'stopLoss': '0.5940',
                      'confidence': 'High',
                      'time': '12 hours ago',
                      'isBuy': true,
                    },
                    {
                      'pair': 'EUR/GBP',
                      'type': 'SELL',
                      'entry': '0.8580',
                      'target': '0.8520',
                      'stopLoss': '0.8620',
                      'confidence': 'Medium',
                      'time': '14 hours ago',
                      'isBuy': false,
                    },
                    {
                      'pair': 'EUR/JPY',
                      'type': 'BUY',
                      'entry': '161.05',
                      'target': '162.00',
                      'stopLoss': '160.50',
                      'confidence': 'High',
                      'time': '16 hours ago',
                      'isBuy': true,
                    },
                  ];

                  final signal = signals[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildSignalCard(
                      context,
                      pair: signal['pair'] as String,
                      type: signal['type'] as String,
                      entry: signal['entry'] as String,
                      target: signal['target'] as String,
                      stopLoss: signal['stopLoss'] as String,
                      confidence: signal['confidence'] as String,
                      time: signal['time'] as String,
                      isBuy: signal['isBuy'] as bool,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
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
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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

  Widget _buildFilterChip(BuildContext context, String label, {bool isSelected = false}) {
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

  Widget _buildSignalCard(
    BuildContext context, {
    required String pair,
    required String type,
    required String entry,
    required String target,
    required String stopLoss,
    required String confidence,
    required String time,
    required bool isBuy,
  }) {
    final signalColor = isBuy ? AppColors.successGreen : AppColors.errorRed;
    final confidenceColor = confidence == 'High'
        ? AppColors.successGreen
        : confidence == 'Medium'
            ? AppColors.warningOrange
            : AppColors.errorRed;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: signalColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: signalColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pair,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: signalColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      type,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: signalColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: confidenceColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      confidence,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: confidenceColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Signal Details
          Row(
            children: [
              Expanded(
                child: _buildSignalDetail(context, 'Entry', entry),
              ),
              Expanded(
                child: _buildSignalDetail(context, 'Target', target),
              ),
              Expanded(
                child: _buildSignalDetail(context, 'Stop Loss', stopLoss),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Execute trade
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: signalColor,
                foregroundColor: AppColors.secondaryWhite,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Execute Trade',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryWhite,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignalDetail(BuildContext context, String label, String value) {
    return Column(
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
              ),
        ),
      ],
    );
  }
}
