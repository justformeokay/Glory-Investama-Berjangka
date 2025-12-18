import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gifx/app/services/auth_service.dart';

class SignInController extends GetxController {
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  String? emailError;
  String? passwordError;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least 1 number';
    }
    return null;
  }

  Future<void> signIn() async {
    // Validate inputs
    emailError = validateEmail(emailController.text);
    passwordError = validatePassword(passwordController.text);

    if (emailError != null || passwordError != null) {
      update();
      return;
    }

    isLoading.value = true;

    try {
      final response = await authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Success - save token and navigate to passcode page
      // await storage.write(key: 'auth_token', value: response.token);
      // await storage.write(key: 'user_id', value: response.userId);

      Get.offAllNamed('/passcode'); // Navigate to passcode setup
    } on AuthException catch (e) {
      Get.dialog(
        _buildErrorDialog(e.message),
        barrierDismissible: false,
      );
    } catch (e) {
      Get.dialog(
        _buildErrorDialog('An unexpected error occurred. Please try again.'),
        barrierDismissible: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Widget _buildErrorDialog(String message) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              color: Color(0xFFFF6B6B),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Sign In Failed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            'Try Again',
            style: TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
}
