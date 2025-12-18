import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final emailError = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> sendResetEmail() async {
    emailError.value = validateEmail(emailController.text) ?? '';
    
    if (emailError.value.isNotEmpty) {
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    isLoading.value = false;

    // Navigate to OTP page
    Get.toNamed('/otp', arguments: {'email': emailController.text.trim()});
  }
}
