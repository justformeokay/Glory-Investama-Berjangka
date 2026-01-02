import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../controllers/internal_transfer_controller.dart';
import '../../models/trading_account.dart';
import '../widgets/custom_elevated_button.dart';

class InternalTransferPage extends StatelessWidget {
  const InternalTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InternalTransferController());

    // Check if transfer is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.canTransferReal) {
        controller.showUnavailableDialog();
      }
    });

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
          'Transfer Internal',
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
              'Transfer saldo antar akun Anda dengan mudah',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Info Card
            _buildInfoCard(),
            const SizedBox(height: 24),

            // From Account Section
            _buildSectionTitle('Akun Sumber'),
            const SizedBox(height: 12),
            _buildFromAccountSelection(controller),
            const SizedBox(height: 24),

            // To Account Section
            Obx(() {
              if (controller.selectedFromAccount.value == null) {
                return const SizedBox.shrink();
              }

              final availableAccounts =
                  controller.getAvailableToAccounts();

              if (availableAccounts.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Akun Tujuan'),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.secondaryWhite,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.information_outline,
                            color: AppColors.warningOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tidak ada akun lain dengan tipe yang sama',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Akun Tujuan'),
                  const SizedBox(height: 12),
                  _buildToAccountSelection(controller, availableAccounts),
                  const SizedBox(height: 24),
                ],
              );
            }),

            // Amount Input Section
            Obx(() {
              if (controller.selectedFromAccount.value == null ||
                  controller.selectedToAccount.value == null) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Jumlah Transfer'),
                  const SizedBox(height: 12),
                  _buildAmountInput(controller),
                  const SizedBox(height: 24),
                  _buildQuickAmountButtons(controller),
                  const SizedBox(height: 24),
                  _buildConfirmationSummary(controller),
                  const SizedBox(height: 24),
                  Obx(() => CustomElevatedButton(
                        label: controller.isLoading.value
                            ? 'Memproses...'
                            : 'Konfirmasi Transfer',
                        onPressed: controller.isValidTransfer &&
                                !controller.isLoading.value
                            ? () => controller.processTransfer()
                            : null,
                        isLoading: controller.isLoading.value,
                        isDisabled: !controller.isValidTransfer,
                        width: double.infinity,
                        icon: Iconsax.arrow_right_outline,
                      )),
                ]
              );
            }),
            const SizedBox(height: 40),
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

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.secondaryWhite,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Iconsax.information_outline,
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
                  'Transfer Instan',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tidak ada biaya untuk transfer antar akun Anda',
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

  Widget _buildFromAccountSelection(InternalTransferController controller) {
    return Obx(() {
      return Column(
        children: controller.accounts.map((account) {
          final isSelected =
              controller.selectedFromAccount.value?.id == account.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildAccountCard(
              controller,
              account,
              isSelected,
              isFrom: true,
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildToAccountSelection(
    InternalTransferController controller,
    List<TradingAccount> accounts,
  ) {
    return Obx(() {
      return Column(
        children: accounts.map((account) {
          final isSelected =
              controller.selectedToAccount.value?.id == account.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildAccountCard(
              controller,
              account,
              isSelected,
              isFrom: false,
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildAccountCard(
    InternalTransferController controller,
    TradingAccount account,
    bool isSelected, {
    required bool isFrom,
  }) {
    return GestureDetector(
      onTap: () {
        if (isFrom) {
          controller.selectFromAccount(account);
        } else {
          controller.selectToAccount(account);
        }
      },
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
                : Colors.black12,
            width: isSelected ? 2 : 1,
          ),),
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
                  Iconsax.wallet_2_outline,
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
                          account.accountNumber,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getAccountTypeColor(account.accountType)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            account.accountType,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: _getAccountTypeColor(account.accountType),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Saldo: ${account.formattedBalance}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.w600,
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

  Color _getAccountTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'standard':
        return const Color(0xFF1976D2);
      case 'pro':
        return const Color(0xFF388E3C);
      case 'demo':
        return const Color(0xFFF57C00);
      default:
        return AppColors.secondaryGrey;
    }
  }

  Widget _buildAmountInput(InternalTransferController controller) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jumlah',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () => controller.transferAll(),
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
                    'Transfer Semua',
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
              prefixText: 'Rp ',
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
              Obx(() {
                final maxAmount =
                    controller.selectedFromAccount.value?.balance ?? 0;
                return Text(
                  'Max: Rp ${maxAmount.toStringAsFixed(2)}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons(InternalTransferController controller) {
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
                  '+Rp${amount.toInt()}',
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

  Widget _buildConfirmationSummary(InternalTransferController controller) {
    return Obx(() {
      if (!controller.isValidTransfer) return const SizedBox.shrink();

      final amount = controller.transferAmount.value;
      final from = controller.selectedFromAccount.value!;
      final to = controller.selectedToAccount.value!;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryGold.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('Dari', from.accountNumber),
            const SizedBox(height: 12),
            _buildSummaryRow('Ke', to.accountNumber),
            const SizedBox(height: 12),
            _buildSummaryRow('Biaya', 'Gratis'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildSummaryRow(
              'Jumlah Transfer',
              'Rp ${amount.toStringAsFixed(2)}',
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
