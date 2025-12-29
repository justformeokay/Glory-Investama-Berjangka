import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/deposit_method.dart';
import '../models/trading_account.dart';

class DepositController extends GetxController {
  final selectedAccount = Rxn<TradingAccount>();
  final selectedMethod = Rxn<DepositMethod>();
  final depositAmount = RxDouble(0.0);
  final isLoading = false.obs;

  final List<DepositMethod> depositMethods = [
    const DepositMethod(
      id: 'bank_transfer',
      name: 'Bank Transfer',
      description: 'Direct transfer from your bank',
      icon: Iconsax.bank_outline,
      minAmount: 10.0,
      maxAmount: 50000.0,
      processingTime: '1-3 business days',
      fee: 0.0,
    ),
    const DepositMethod(
      id: 'credit_card',
      name: 'Credit/Debit Card',
      description: 'Instant deposit via card',
      icon: Iconsax.card_outline,
      minAmount: 10.0,
      maxAmount: 10000.0,
      processingTime: 'Instant',
      fee: 2.5,
    ),
    const DepositMethod(
      id: 'ewallet',
      name: 'E-Wallet',
      description: 'PayPal, Skrill, Neteller',
      icon: Iconsax.wallet_outline,
      minAmount: 5.0,
      maxAmount: 25000.0,
      processingTime: 'Instant',
      fee: 1.5,
    ),
    const DepositMethod(
      id: 'crypto',
      name: 'Cryptocurrency',
      description: 'BTC, ETH, USDT',
      icon: Iconsax.bitcoin_card_outline,
      minAmount: 20.0,
      maxAmount: 100000.0,
      processingTime: '15-30 minutes',
      fee: 0.5,
    ),
  ];

  final List<TradingAccount> accounts = [
    const TradingAccount(
      id: '1',
      accountNumber: 'MT5-123456',
      accountType: 'Standard',
      balance: 5420.50,
      currency: 'USD',
    ),
    const TradingAccount(
      id: '2',
      accountNumber: 'MT5-789012',
      accountType: 'Pro',
      balance: 15230.75,
      currency: 'USD',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Set default account
    if (accounts.isNotEmpty) {
      selectedAccount.value = accounts.first;
    }
  }

  void selectMethod(DepositMethod method) {
    selectedMethod.value = method;
    // Reset amount if it's outside the new method's range
    if (depositAmount.value < method.minAmount || 
        depositAmount.value > method.maxAmount) {
      depositAmount.value = 0.0;
    }
  }

  void selectAccount(TradingAccount account) {
    selectedAccount.value = account;
  }

  void setAmount(double amount) {
    depositAmount.value = amount;
  }

  void addQuickAmount(double amount) {
    depositAmount.value += amount;
  }

  bool get isValidAmount {
    if (selectedMethod.value == null) return false;
    return depositAmount.value >= selectedMethod.value!.minAmount &&
           depositAmount.value <= selectedMethod.value!.maxAmount;
  }

  double get totalFee {
    if (selectedMethod.value == null) return 0.0;
    return (depositAmount.value * selectedMethod.value!.fee / 100);
  }

  double get totalAmount {
    return depositAmount.value + totalFee;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Invalid amount';
    }

    if (selectedMethod.value == null) {
      return 'Please select a deposit method first';
    }

    if (amount < selectedMethod.value!.minAmount) {
      return 'Minimum: \$${selectedMethod.value!.minAmount}';
    }

    if (amount > selectedMethod.value!.maxAmount) {
      return 'Maximum: \$${selectedMethod.value!.maxAmount}';
    }

    return null;
  }

  Future<void> processDeposit() async {
    if (!isValidAmount) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success dialog
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Deposit Initiated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your deposit of \$${depositAmount.value.toStringAsFixed(2)} is being processed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                      Get.back(); // Return to previous page
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Reset form
      depositAmount.value = 0.0;
      selectedMethod.value = null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process deposit. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
