import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header with filter
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Show filter dialog
                    },
                    icon: Icon(Iconsax.filter_outline),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondaryWhite,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(context, 'All', isSelected: true),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Deposits'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Withdrawals'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Trades'),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, 'Transfers'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Transactions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 15,
                itemBuilder: (context, index) {
                  final transactions = [
                    {
                      'type': 'Deposit',
                      'icon': Iconsax.wallet_add_outline,
                      'date': 'Dec 23, 2025 • 10:30 AM',
                      'amount': '+\$5,000.00',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                    {
                      'type': 'Withdrawal',
                      'icon': Iconsax.wallet_minus_outline,
                      'date': 'Dec 22, 2025 • 03:15 PM',
                      'amount': '-\$2,000.00',
                      'status': 'Completed',
                      'isPositive': false,
                    },
                    {
                      'type': 'Trade EUR/USD',
                      'icon': Iconsax.chart_outline,
                      'date': 'Dec 21, 2025 • 11:45 AM',
                      'amount': '+\$150.00',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                    {
                      'type': 'Trade GBP/USD',
                      'icon': Iconsax.chart_outline,
                      'date': 'Dec 21, 2025 • 09:20 AM',
                      'amount': '-\$75.50',
                      'status': 'Completed',
                      'isPositive': false,
                    },
                    {
                      'type': 'Deposit',
                      'icon': Iconsax.wallet_add_outline,
                      'date': 'Dec 20, 2025 • 02:30 PM',
                      'amount': '+\$10,000.00',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                    {
                      'type': 'Transfer',
                      'icon': Iconsax.convert_outline,
                      'date': 'Dec 19, 2025 • 04:15 PM',
                      'amount': '-\$500.00',
                      'status': 'Pending',
                      'isPositive': false,
                    },
                    {
                      'type': 'Trade USD/JPY',
                      'icon': Iconsax.chart_outline,
                      'date': 'Dec 18, 2025 • 01:10 PM',
                      'amount': '+\$320.75',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                    {
                      'type': 'Withdrawal',
                      'icon': Iconsax.wallet_minus_outline,
                      'date': 'Dec 17, 2025 • 10:00 AM',
                      'amount': '-\$1,500.00',
                      'status': 'Completed',
                      'isPositive': false,
                    },
                    {
                      'type': 'Trade AUD/USD',
                      'icon': Iconsax.chart_outline,
                      'date': 'Dec 16, 2025 • 03:45 PM',
                      'amount': '+\$95.25',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                    {
                      'type': 'Deposit',
                      'icon': Iconsax.wallet_add_outline,
                      'date': 'Dec 15, 2025 • 11:20 AM',
                      'amount': '+\$3,000.00',
                      'status': 'Completed',
                      'isPositive': true,
                    },
                  ];

                  final transaction = transactions[index % transactions.length];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTransactionCard(
                      context,
                      type: transaction['type'] as String,
                      icon: transaction['icon'] as IconData,
                      date: transaction['date'] as String,
                      amount: transaction['amount'] as String,
                      status: transaction['status'] as String,
                      isPositive: transaction['isPositive'] as bool,
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

  Widget _buildTransactionCard(
    BuildContext context, {
    required String type,
    required IconData icon,
    required String date,
    required String amount,
    required String status,
    required bool isPositive,
  }) {
    return InkWell(
      onTap: () {
        // Show transaction details
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
                color: (isPositive ? AppColors.successGreen : AppColors.errorRed)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: status == 'Completed'
                          ? AppColors.successGreen.withOpacity(0.1)
                          : AppColors.warningOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: status == 'Completed'
                                ? AppColors.successGreen
                                : AppColors.warningOrange,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              amount,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
