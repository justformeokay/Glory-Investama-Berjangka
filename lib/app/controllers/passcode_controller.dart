import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PasscodeController extends GetxController {
  final _storage = GetStorage();
  final passcodeInput = ''.obs;
  final isLoading = false.obs;
  final showError = false.obs;
  final showSuccess = false.obs;
  final errorMessage = ''.obs;

  static const String passcodeKey = 'user_passcode';
  static const int passcodeLength = 6;

  void addDigit(String digit) {
    if (passcodeInput.value.length < passcodeLength && !isLoading.value) {
      passcodeInput.value += digit;
      
      // Auto submit when passcode is complete
      if (passcodeInput.value.length == passcodeLength) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _submitPasscode();
        });
      }
    }
  }

  void removeDigit() {
    if (passcodeInput.value.isNotEmpty && !isLoading.value) {
      passcodeInput.value = passcodeInput.value.substring(0, passcodeInput.value.length - 1);
      showError.value = false;
    }
  }

  void _submitPasscode() {
    if (passcodeInput.value.length != passcodeLength) return;

    isLoading.value = true;
    showError.value = false;
    showSuccess.value = false;

    // Simulate processing for exactly 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        // Save passcode to GetStorage
        await _storage.write(passcodeKey, passcodeInput.value);
        
        showSuccess.value = true;
        // Keep loading state until user confirms
      } catch (e) {
        showError.value = true;
        errorMessage.value = 'Failed to save passcode';
        isLoading.value = false;
        
        // Clear input after error
        Future.delayed(const Duration(milliseconds: 1500), () {
          passcodeInput.value = '';
          showError.value = false;
        });
      }
    });
  }

  void proceedToDashboard() {
    isLoading.value = false;
    Get.offAllNamed('/dashboard');
  }

  void clearPasscode() {
    passcodeInput.value = '';
    showError.value = false;
    showSuccess.value = false;
  }
}
