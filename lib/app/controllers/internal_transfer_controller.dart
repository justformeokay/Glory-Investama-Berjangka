import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/trading_account.dart';

class InternalTransferController extends GetxController {
  final selectedFromAccount = Rxn<TradingAccount>();
  final selectedToAccount = Rxn<TradingAccount>();
  final transferAmount = RxDouble(0.0);
  final isLoading = false.obs;

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
    const TradingAccount(
      id: '3',
      accountNumber: 'MT5-345678',
      accountType: 'Demo',
      balance: 50000.00,
      currency: 'USD',
    ),
    const TradingAccount(
      id: '4',
      accountNumber: 'MT5-654321',
      accountType: 'Standard',
      balance: 8950.25,
      currency: 'USD',
    ),
    const TradingAccount(
      id: '5',
      accountNumber: 'MT5-901234',
      accountType: 'Pro',
      balance: 25000.00,
      currency: 'USD',
    ),
    const TradingAccount(
      id: '6',
      accountNumber: 'MT5-567890',
      accountType: 'Demo',
      balance: 100000.00,
      currency: 'USD',
    ),
  ];

  // Get real accounts only (non-demo)
  List<TradingAccount> get realAccounts {
    return accounts.where((acc) => acc.accountType != 'Demo').toList();
  }

  // Get demo accounts only
  List<TradingAccount> get demoAccounts {
    return accounts.where((acc) => acc.accountType == 'Demo').toList();
  }

  // Check if internal transfer is available (minimum 2 real accounts)
  bool get canTransferReal {
    return realAccounts.length >= 2;
  }

  // Check if demo transfer is available (minimum 2 demo accounts)
  bool get canTransferDemo {
    return demoAccounts.length >= 2;
  }

  // Get available accounts to transfer to (excluding the source account)
  List<TradingAccount> getAvailableToAccounts() {
    if (selectedFromAccount.value == null) return [];
    
    final fromAccountType = selectedFromAccount.value!.accountType;
    return accounts
        .where((acc) =>
            acc.id != selectedFromAccount.value!.id &&
            acc.accountType == fromAccountType)
        .toList();
  }

  void selectFromAccount(TradingAccount account) {
    selectedFromAccount.value = account;
    selectedToAccount.value = null; // Reset target account
    transferAmount.value = 0.0; // Reset amount
  }

  void selectToAccount(TradingAccount account) {
    selectedToAccount.value = account;
  }

  void setAmount(double amount) {
    transferAmount.value = amount;
  }

  void transferAll() {
    if (selectedFromAccount.value != null) {
      transferAmount.value = selectedFromAccount.value!.balance;
    }
  }

  void addQuickAmount(double amount) {
    transferAmount.value += amount;
  }

  bool get isValidTransfer {
    if (selectedFromAccount.value == null || selectedToAccount.value == null) {
      return false;
    }
    return transferAmount.value > 0 &&
           transferAmount.value <= selectedFromAccount.value!.balance;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silakan masukkan jumlah';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Jumlah tidak valid';
    }

    if (selectedFromAccount.value == null) {
      return 'Pilih akun sumber terlebih dahulu';
    }

    if (amount <= 0) {
      return 'Jumlah harus lebih dari 0';
    }

    if (amount > selectedFromAccount.value!.balance) {
      return 'Saldo tidak cukup';
    }

    return null;
  }

  // Show unavailable dialog when less than 2 real accounts
  void showUnavailableDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with animated background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.information_outline,
                  color: Color(0xFFFF9500),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Transfer Internal Tidak Tersedia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                'Anda memerlukan minimal 2 akun real untuk melakukan transfer internal. Saat ini Anda hanya memiliki ${realAccounts.length} akun real.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Info box dengan tips
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1976D2).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.info_circle_outline,
                        color: Color(0xFF1976D2),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cara Mengatasi:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Buka akun real tambahan untuk memulai transfer internal',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF666666),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Primary button - Open new account
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    // TODO: Navigate to open account page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buka Akun Baru',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Secondary button - Cancel
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> processTransfer() async {
    if (!isValidTransfer) return;

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
                  'Transfer Berhasil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${transferAmount.value.toStringAsFixed(2)} telah ditransfer ke akun ${selectedToAccount.value!.accountNumber}',
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
                    child: const Text('Selesai'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Reset form
      transferAmount.value = 0.0;
      selectedFromAccount.value = null;
      selectedToAccount.value = null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memproses transfer. Silakan coba lagi.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
