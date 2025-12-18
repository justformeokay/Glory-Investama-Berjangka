import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/forgot_password_controller.dart';
import 'package:gifx/app/views/widgets/custom_text_field.dart';
import 'package:gifx/app/views/widgets/custom_elevated_button.dart';
import 'package:gifx/app/views/widgets/theme_annotated_region.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ForgotPasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ForgotPasswordController>();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Header
                  Text(
                    'Forgot Password?',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Enter your email to receive a password reset link',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? Colors.white54 : Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email Field
                  GetBuilder<ForgotPasswordController>(
                    builder: (controller) {
                      return CustomTextField(
                        label: 'Email Address',
                        hint: 'you@example.com',
                        type: TextFieldType.email,
                        controller: controller.emailController,
                        prefixIcon: 'email',
                        validator: (value) =>
                            controller.emailError.value.isEmpty
                                ? null
                                : controller.emailError.value,
                        onChanged: (value) {
                          controller.emailError.value = '';
                          controller.update();
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Info Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primaryGold.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: AppColors.primaryGold,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'We\'ll send you a code to reset your password',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11,
                              color: AppColors.primaryGold,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Send Reset Email Button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => CustomElevatedButton(
                        label: _controller.isLoading.value
                            ? 'Sending...'
                            : 'Send Reset Code',
                        onPressed: _controller.isLoading.value
                            ? null
                            : () => _controller.sendResetEmail(),
                        isLoading: _controller.isLoading.value,
                        height: 52,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Back to Login Link
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Back to Login',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
