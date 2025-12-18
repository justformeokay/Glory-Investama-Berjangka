import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final email = ''.obs;
  
  final isLoading = false.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;
  
  final passwordError = ''.obs;
  
  // Regex checks
  final hasMinLength = false.obs;
  final hasUppercase = false.obs;
  final hasLowercase = false.obs;
  final hasNumber = false.obs;
  final hasSymbol = false.obs;
  final passwordsMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments?['email'] ?? '';
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void validatePassword(String value) {
    hasMinLength.value = value.length >= 6;
    hasUppercase.value = RegExp(r'[A-Z]').hasMatch(value);
    hasLowercase.value = RegExp(r'[a-z]').hasMatch(value);
    hasNumber.value = RegExp(r'[0-9]').hasMatch(value);
    hasSymbol.value = RegExp(r'[!@#$%^&*()\-=\[\]{};:,./<>?\\|`~]').hasMatch(value);
    
    _checkPasswordsMatch();
  }

  void validateConfirmPassword(String value) {
    _checkPasswordsMatch();
  }

  void _checkPasswordsMatch() {
    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      passwordsMatch.value = false;
    } else {
      passwordsMatch.value = passwordController.text == confirmPasswordController.text;
    }
  }

  bool get isPasswordValid {
    return hasMinLength.value &&
        hasUppercase.value &&
        hasLowercase.value &&
        hasNumber.value &&
        hasSymbol.value;
  }

  Future<void> setPassword() async {
    if (!isPasswordValid) {
      passwordError.value = 'Password does not meet all requirements';
      return;
    }

    if (!passwordsMatch.value) {
      passwordError.value = 'Passwords do not match';
      return;
    }

    isLoading.value = true;
    passwordError.value = '';

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // Show success and navigate to login
    Get.offAllNamed('/sign-in');
    
    Get.snackbar(
      'Success',
      'Your password has been reset successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }
}
