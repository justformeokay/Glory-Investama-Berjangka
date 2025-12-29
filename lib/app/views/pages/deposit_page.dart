import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../controllers/deposit_controller.dart';
import '../../models/deposit_method.dart';
import '../widgets/glassmorphic_container.dart';
import '../widgets/custom_elevated_button.dart';

class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DepositController());

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_outline),
          onPressed: () => Get.back(),
          color: AppColors.textPrimary,
        ),
        title: Text(
          'Deposit',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Description
            Text(
              'Fund your trading account securely',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Account Selection Card
            _buildAccountCard(controller),
            const SizedBox(height: 24),

            // Deposit Methods Section
            _buildSectionTitle('Select Deposit Method'),
            const SizedBox(height: 12),
            _buildDepositMethods(controller),
            const SizedBox(height: 24),

            // Amount Input Section
            Obx(() {
              if (controller.selectedMethod.value == null) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Enter Amount'),
                  const SizedBox(height: 12),
                  _buildAmountInput(controller),
                  const SizedBox(height: 16),
                  _buildQuickAmountButtons(controller),
                  const SizedBox(height: 24),

                  // Confirmation Summary
                  _buildConfirmationSummary(controller),
                  const SizedBox(height: 24),

                  // Submit Button
                  Obx(() => CustomElevatedButton(
                        label: controller.isLoading.value
                            ? 'Processing...'
                            : 'Confirm Deposit',
                        onPressed: controller.isValidAmount && !controller.isLoading.value
                            ? () => controller.processDeposit()
                            : null,
                        isLoading: controller.isLoading.value,
                        isDisabled: !controller.isValidAmount,
                        width: double.infinity,
                        icon: Iconsax.tick_circle_outline,
                      )),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAccountCard(DepositController controller) {
    return Obx(() {
      final account = controller.selectedAccount.value;
      if (account == null) return const SizedBox.shrink();

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.secondaryWhite,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Iconsax.wallet_2_outline,
                    color: AppColors.primaryGold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.accountType,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        account.accountNumber,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Balance',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    account.formattedBalance,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDepositMethods(DepositController controller) {
    return Obx(() {
      return Column(
        children: controller.depositMethods.map((method) {
          final isSelected = controller.selectedMethod.value?.id == method.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildMethodCard(controller, method, isSelected),
          );
        }).toList(),
      );
    });
  }

  Widget _buildMethodCard(
    DepositController controller,
    DepositMethod method,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: method.isAvailable ? () => controller.selectMethod(method) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: method.isAvailable ? AppColors.secondaryWhite : AppColors.secondaryLightGrey.withOpacity(0.3),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryGold
                  : Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isSelected
                          ? AppColors.primaryGold
                          : AppColors.secondaryGrey)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  method.icon,
                  color: isSelected
                      ? AppColors.primaryGold
                      : AppColors.secondaryGrey,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.name,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      method.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip(
                          Iconsax.clock_outline,
                          method.processingTime,
                        ),
                        const SizedBox(width: 8),
                        if (method.fee > 0)
                          _buildInfoChip(
                            Iconsax.coin_outline,
                            '${method.fee}% fee',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondaryLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(DepositController controller) {
    final method = controller.selectedMethod.value!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryGoldLight.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deposit Amount',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.number,
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: AppTextStyles.displayLarge.copyWith(
                color: AppColors.primaryGold,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              hintText: '0.00',
              hintStyle: AppTextStyles.displayLarge.copyWith(
                color: AppColors.textTertiary,
                fontSize: 24,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              final amount = double.tryParse(value) ?? 0.0;
              controller.setAmount(amount);
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Iconsax.information_outline,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'Min: \$${method.minAmount} • Max: \$${method.maxAmount}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons(DepositController controller) {
    final amounts = [100.0, 500.0, 1000.0, 5000.0];

    return Row(
      children: amounts.map((amount) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => controller.addQuickAmount(amount),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryGold.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '+\$${amount.toInt()}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConfirmationSummary(DepositController controller) {
    return Obx(() {
      if (!controller.isValidAmount) return const SizedBox.shrink();

      final method = controller.selectedMethod.value!;
      final amount = controller.depositAmount.value;
      final fee = controller.totalFee;
      final total = controller.totalAmount;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryGold.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('Deposit Amount', '\$${amount.toStringAsFixed(2)}'),
            if (fee > 0) ...[
              const SizedBox(height: 12),
              _buildSummaryRow('Fee (${method.fee}%)', '\$${fee.toStringAsFixed(2)}'),
            ],
            const SizedBox(height: 12),
            _buildSummaryRow('Processing Time', method.processingTime),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildSummaryRow(
              'Total Amount',
              '\$${total.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isTotal ? AppColors.primaryGold : AppColors.textPrimary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
