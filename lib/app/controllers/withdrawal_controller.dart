import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/withdrawal_method.dart';
import '../models/trading_account.dart';

class WithdrawalController extends GetxController {
  final selectedAccount = Rxn<TradingAccount>();
  final selectedMethod = Rxn<WithdrawalMethod>();
  final withdrawalAmount = RxDouble(0.0);
  final pinCode = ''.obs;
  final isLoading = false.obs;
  final showPinConfirmation = false.obs;

  final double withdrawalFee = 2.0; // Flat fee
  final double minWithdrawal = 10.0;

  final List<WithdrawalMethod> withdrawalMethods = [
    const WithdrawalMethod(
      id: 'bank_1',
      name: 'Bank of America',
      accountNumber: '1234567890',
      accountName: 'John Doe',
      icon: Iconsax.bank_outline,
      isPrimary: true,
      type: 'bank',
    ),
    const WithdrawalMethod(
      id: 'paypal',
      name: 'PayPal',
      accountNumber: 'john.doe@email.com',
      accountName: 'John Doe',
      icon: Iconsax.wallet_outline,
      type: 'ewallet',
    ),
    const WithdrawalMethod(
      id: 'crypto_1',
      name: 'Bitcoin Wallet',
      accountNumber: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
      accountName: 'BTC Address',
      icon: Iconsax.bitcoin_card_outline,
      type: 'crypto',
    ),
  ];

  final List<TradingAccount> accounts = [
    const TradingAccount(
      id: '1',
      accountNumber: 'MT5-123456',
      accountType: 'Standard',
      balance: 5420.50,
      lockedBalance: 200.0,
      currency: 'USD',
    ),
    const TradingAccount(
      id: '2',
      accountNumber: 'MT5-789012',
      accountType: 'Pro',
      balance: 15230.75,
      lockedBalance: 1000.0,
      currency: 'USD',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    if (accounts.isNotEmpty) {
      selectedAccount.value = accounts.first;
    }
    if (withdrawalMethods.isNotEmpty) {
      selectedMethod.value = withdrawalMethods.first;
    }
  }

  void selectMethod(WithdrawalMethod method) {
    selectedMethod.value = method;
  }

  void selectAccount(TradingAccount account) {
    selectedAccount.value = account;
  }

  void setAmount(double amount) {
    withdrawalAmount.value = amount;
  }

  void withdrawAll() {
    if (selectedAccount.value != null) {
      final maxAmount = selectedAccount.value!.availableBalance - withdrawalFee;
      withdrawalAmount.value = maxAmount > 0 ? maxAmount : 0;
    }
  }

  bool get isValidAmount {
    if (selectedAccount.value == null) return false;
    final available = selectedAccount.value!.availableBalance;
    return withdrawalAmount.value >= minWithdrawal &&
           withdrawalAmount.value <= (available - withdrawalFee);
  }

  double get totalFee {
    return withdrawalFee;
  }

  double get totalDeduction {
    return withdrawalAmount.value + withdrawalFee;
  }

  double get youWillReceive {
    return withdrawalAmount.value;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Invalid amount';
    }

    if (selectedAccount.value == null) {
      return 'Please select an account first';
    }

    if (amount < minWithdrawal) {
      return 'Minimum: \$$minWithdrawal';
    }

    final available = selectedAccount.value!.availableBalance;
    if (amount > (available - withdrawalFee)) {
      return 'Insufficient balance';
    }

    return null;
  }

  void proceedToConfirmation() {
    if (!isValidAmount) return;
    showPinConfirmation.value = true;
  }

  void cancelConfirmation() {
    showPinConfirmation.value = false;
    pinCode.value = '';
  }

  void updatePin(String pin) {
    pinCode.value = pin;
    if (pin.length == 6) {
      processWithdrawal();
    }
  }

  Future<void> processWithdrawal() async {
    if (!isValidAmount || pinCode.value.length != 6) return;

    isLoading.value = true;

    try {
      // Simulate API call and PIN verification
      await Future.delayed(const Duration(seconds: 2));

      // Simulate PIN check (in production, verify with backend)
      if (pinCode.value == '123456') {
        // Success
        Get.back(); // Close PIN sheet if open
        
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
                    'Withdrawal Successful',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your withdrawal of \$${withdrawalAmount.value.toStringAsFixed(2)} is being processed',
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
        withdrawalAmount.value = 0.0;
        pinCode.value = '';
        showPinConfirmation.value = false;
      } else {
        // Wrong PIN
        Get.snackbar(
          'Error',
          'Invalid PIN. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        pinCode.value = '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process withdrawal. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      pinCode.value = '';
    } finally {
      isLoading.value = false;
    }
  }
}
