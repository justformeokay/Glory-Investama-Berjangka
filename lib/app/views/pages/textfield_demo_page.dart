import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/theme_controller.dart';
import 'package:gifx/app/views/widgets/index.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

class TextFieldDemoPage extends StatefulWidget {
  const TextFieldDemoPage({super.key});

  @override
  State<TextFieldDemoPage> createState() => _TextFieldDemoPageState();
}

class _TextFieldDemoPageState extends State<TextFieldDemoPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Success',
        'All fields are valid!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryGold,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        'Please fix errors in the form',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _amountController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'TextField Components',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Obx(() {
                  final themeController = Get.find<ThemeController>();
                  return CustomIconButton(
                    icon: themeController.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    onPressed: () => themeController.toggleTheme(),
                  );
                }),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TextField Demo',
                        style: AppTextStyles.displayLarge.copyWith(
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All input types with full validation',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Email Section
                  _buildFieldSection(
                    isDark,
                    'Email Field',
                    Icons.email_outlined,
                    CustomTextField(
                      label: 'Email Address',
                      hint: 'Enter your email address',
                      type: TextFieldType.email,
                      controller: _emailController,
                      prefixIcon: 'email',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Password Section
                  _buildFieldSection(
                    isDark,
                    'Password Field',
                    Icons.lock_outline,
                    CustomTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      type: TextFieldType.password,
                      controller: _passwordController,
                      prefixIcon: 'lock',
                      minLength: 8,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Password is required';
                        }
                        if (value!.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Must contain at least 1 uppercase letter';
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Must contain at least 1 number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Phone Section
                  _buildFieldSection(
                    isDark,
                    'Phone Number Field',
                    Icons.phone_outlined,
                    CustomTextField(
                      label: 'Phone Number',
                      hint: 'Enter phone number (10-13 digits)',
                      type: TextFieldType.number,
                      controller: _phoneController,
                      prefixIcon: 'phone',
                      minLength: 10,
                      maxLength: 13,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Phone number is required';
                        }
                        String digits = value!.replaceAll(RegExp(r'[^0-9]'), '');
                        if (digits.length < 10) {
                          return 'Phone must have at least 10 digits';
                        }
                        if (digits.length > 13) {
                          return 'Phone must not exceed 13 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Amount Section
                  _buildFieldSection(
                    isDark,
                    'Amount Field (IDR)',
                    Icons.attach_money_outlined,
                    CustomTextField(
                      label: 'Amount',
                      hint: 'Enter amount in Rupiah',
                      type: TextFieldType.number,
                      controller: _amountController,
                      prefixIcon: 'attach_money',
                      currencyFormat: CurrencyFormat.IDR,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Amount is required';
                        }
                        String digits = value!.replaceAll(RegExp(r'[^0-9]'), '');
                        if (int.tryParse(digits) == null || int.parse(digits) <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Description Section
                  _buildFieldSection(
                    isDark,
                    'Description Field',
                    Icons.description_outlined,
                    CustomTextField(
                      label: 'Description',
                      hint: 'Write your description here (20-500 characters)',
                      type: TextFieldType.descriptive,
                      controller: _descriptionController,
                      prefixIcon: 'description',
                      maxLines: 4,
                      maxLength: 500,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Description is required';
                        }
                        if (value!.length < 20) {
                          return 'Description must be at least 20 characters';
                        }
                        if (value.length > 500) {
                          return 'Description must not exceed 500 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Submit',
                          onPressed: _submitForm,
                          height: 52,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Reset',
                          onPressed: _resetForm,
                          height: 52,
                          backgroundColor:
                              isDark ? Colors.grey[800] : Colors.grey[150],
                          textColor: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // Features Section
                  GlassmorphicContainer(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.zero,
                    borderRadius: 16,
                    opacity: 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureItem(isDark, '✨ Smooth Animations', 'Focus & error state transitions'),
                        _buildFeatureItem(isDark, '✅ Real-time Validation', 'Instant error feedback'),
                        _buildFeatureItem(isDark, '💰 Currency Formatting', 'IDR & USD with thousand separator'),
                        _buildFeatureItem(isDark, '🔐 Password Toggle', 'Animated show/hide icon'),
                        _buildFeatureItem(isDark, '📏 Length Validation', 'Min/max character checks'),
                        _buildFeatureItem(isDark, '🌓 Theme Support', 'Auto dark/light mode'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldSection(
    bool isDark,
    String title,
    IconData icon,
    Widget field,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.primaryGold,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryGold,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        GlassmorphicContainer(
          padding: const EdgeInsets.all(16),
          borderRadius: 16,
          opacity: 0.08,
          child: field,
        ),
      ],
    );
  }

  Widget _buildFeatureItem(bool isDark, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.primaryGold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark ? Colors.white54 : Colors.black45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
