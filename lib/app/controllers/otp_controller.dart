import 'dart:async';

import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpInput = ''.obs;
  final isLoading = false.obs;
  final otpError = ''.obs;
  final email = ''.obs;
  final resendCountdown = 60.obs;
  final canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments?['email'] ?? '';
    _startResendTimer();
  }

  void addDigit(String digit) {
    if (otpInput.value.length < 6 && !isLoading.value) {
      otpInput.value += digit;

      // Auto verify when 6 digits complete
      if (otpInput.value.length == 6) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _verifyOtp();
        });
      }
    }
  }

  void removeDigit() {
    if (otpInput.value.isNotEmpty && !isLoading.value) {
      otpInput.value = otpInput.value.substring(0, otpInput.value.length - 1);
      otpError.value = '';
    }
  }

  Future<void> _verifyOtp() async {
    if (otpInput.value.length != 6) return;

    isLoading.value = true;
    otpError.value = '';

    // Simulate API verification (in real app, any 6 digits work for demo)
    await Future.delayed(const Duration(seconds: 2));

    // For demo, any 6 digits is valid
    if (otpInput.value.length == 6) {
      isLoading.value = false;
      // Navigate to set password page
      Get.toNamed('/set-password', arguments: {'email': email.value});
    } else {
      isLoading.value = false;
      otpError.value = 'Invalid OTP. Please try again.';

      // Clear after error
      Future.delayed(const Duration(milliseconds: 1500), () {
        otpInput.value = '';
        otpError.value = '';
      });
    }
  }

  void _startResendTimer() {
    canResend.value = false;
    resendCountdown.value = 60;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      resendCountdown.value--;

      if (resendCountdown.value == 0) {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    isLoading.value = false;
    _startResendTimer();

    Get.snackbar(
      'OTP Resent',
      'A new OTP has been sent to $email',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
