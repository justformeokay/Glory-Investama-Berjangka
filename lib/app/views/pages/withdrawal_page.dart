import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../controllers/withdrawal_controller.dart';
import '../../models/withdrawal_method.dart';
import '../widgets/custom_elevated_button.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawalController());

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
          'Withdrawal',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Description
                Text(
                  'Withdraw your funds safely',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),

                // Available Balance Card
                _buildBalanceCard(controller),
                const SizedBox(height: 24),

                // Withdrawal Method Section
                _buildSectionTitle('Withdrawal Destination'),
                const SizedBox(height: 12),
                _buildWithdrawalMethods(controller),
                const SizedBox(height: 24),

                // Amount Input Section
                _buildSectionTitle('Withdrawal Amount'),
                const SizedBox(height: 12),
                _buildAmountInput(controller),
                const SizedBox(height: 24),

                // Security Notice
                _buildSecurityNotice(),
                const SizedBox(height: 24),

                // Confirmation Summary
                Obx(() {
                  if (!controller.isValidAmount) return const SizedBox.shrink();
                  return Column(
                    children: [
                      _buildConfirmationSummary(controller),
                      const SizedBox(height: 24),
                    ],
                  );
                }),

                // Submit Button
                Obx(() => CustomElevatedButton(
                      label: 'Continue',
                      onPressed: controller.isValidAmount && !controller.isLoading.value
                          ? () => controller.proceedToConfirmation()
                          : null,
                      isDisabled: !controller.isValidAmount,
                      width: double.infinity,
                      icon: Iconsax.arrow_right_outline,
                    )),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // PIN Confirmation Bottom Sheet
          Obx(() {
            if (!controller.showPinConfirmation.value) {
              return const SizedBox.shrink();
            }
            return _buildPinConfirmationSheet(controller);
          }),
        ],
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

  Widget _buildBalanceCard(WithdrawalController controller) {
    return Obx(() {
      final account = controller.selectedAccount.value;
      if (account == null) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryGold.withOpacity(0.15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.3),
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
            Row(
              children: [
                Expanded(
                  child: _buildBalanceInfo(
                    'Available Balance',
                    account.formattedAvailableBalance,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.textTertiary.withOpacity(0.2),
                ),
                Expanded(
                  child: _buildBalanceInfo(
                    'Locked Funds',
                    '\$${account.lockedBalance.toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBalanceInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalMethods(WithdrawalController controller) {
    return Obx(() {
      return Column(
        children: controller.withdrawalMethods.map((method) {
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
    WithdrawalController controller,
    WithdrawalMethod method,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => controller.selectMethod(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
            color: isSelected
                ? AppColors.primaryGold
                : Colors.white.withOpacity(0.2),
            width: 1,
          ),
            color: isSelected
                ? AppColors.primaryGold.withOpacity(0.15)
                : AppColors.secondaryWhite,
          ),
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
                    Row(
                      children: [
                        Text(
                          method.name,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (method.isPrimary) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGold.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Primary',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primaryGold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      method.maskedAccountNumber,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
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

  Widget _buildAmountInput(WithdrawalController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryGold.withOpacity(0.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () => controller.withdrawAll(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Withdraw All',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
                'Min: \$${controller.minWithdrawal} • Fee: \$${controller.withdrawalFee}',
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

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.infoBlue,
          width: 0.5,
      ),
      color: AppColors.infoBlue.withOpacity(0.1)),
      child: Row(
        children: [
          Icon(
            Iconsax.shield_tick_outline,
            color: AppColors.infoBlue,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Transaction',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.infoBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'ll need to verify with your 6-digit PIN to complete the withdrawal',
                  style: AppTextStyles.bodySmall.copyWith(
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

  Widget _buildConfirmationSummary(WithdrawalController controller) {
    return Obx(() {
      final amount = controller.withdrawalAmount.value;
      final fee = controller.totalFee;
      final total = controller.totalDeduction;
      final receive = controller.youWillReceive;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryGold.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('Withdrawal Amount', '\$${amount.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Processing Fee', '\$${fee.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Total Deduction', '\$${total.toStringAsFixed(2)}'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildSummaryRow(
              'You Will Receive',
              '\$${receive.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Iconsax.clock_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Estimated arrival: 1-3 business days',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
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

  Widget _buildPinConfirmationSheet(WithdrawalController controller) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => controller.cancelConfirmation(),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {}, // Prevent closing when tapping the sheet
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle bar
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLightGrey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Security Icon
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.shield_tick_outline,
                          color: AppColors.primaryGold,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        'Enter Your PIN',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        'Please enter your 6-digit PIN to confirm the withdrawal',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // PIN Input Display
                      Obx(() => _buildPinDisplay(controller.pinCode.value)),
                      const SizedBox(height: 24),

                      // Number Pad
                      _buildNumberPad(controller),
                      const SizedBox(height: 16),

                      // Cancel Button
                      TextButton(
                        onPressed: () => controller.cancelConfirmation(),
                        child: Text(
                          'Cancel',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinDisplay(String pin) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          final isFilled = index < pin.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isFilled
                    ? AppColors.primaryGold.withOpacity(0.2)
                    : AppColors.secondaryLightGrey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isFilled
                      ? AppColors.primaryGold
                      : AppColors.secondaryLightGrey,
                  width: 2,
                ),
              ),
              child: Center(
                child: isFilled
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNumberPad(WithdrawalController controller) {
    return Column(
      children: [
        _buildNumberRow(['1', '2', '3'], controller),
        const SizedBox(height: 12),
        _buildNumberRow(['4', '5', '6'], controller),
        const SizedBox(height: 12),
        _buildNumberRow(['7', '8', '9'], controller),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildNumberButton('0', controller),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (controller.pinCode.value.isNotEmpty) {
                    controller.updatePin(
                      controller.pinCode.value.substring(
                        0,
                        controller.pinCode.value.length - 1,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 64,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLightGrey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.backward_outline,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberRow(List<String> numbers, WithdrawalController controller) {
    return Row(
      children: numbers.map((number) {
        return _buildNumberButton(number, controller);
      }).toList(),
    );
  }

  Widget _buildNumberButton(String number, WithdrawalController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.pinCode.value.length < 6) {
            controller.updatePin(controller.pinCode.value + number);
          }
        },
        child: Container(
          height: 64,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.secondaryLightGrey,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
