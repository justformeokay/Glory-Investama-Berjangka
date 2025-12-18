import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  final themeController = Get.find();
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
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  GlassmorphicContainer(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Text Field Demo',
                          style: AppTextStyles.headlineLarge.copyWith(
                            color: AppColors.primaryGold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Showcase of all custom text field types with validation',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isDark
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Email Section
                  Text(
                    'Email Field',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 24),

                  // Password Section
                  Text(
                    'Password Field',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 24),

                  // Phone Number Section
                  Text(
                    'Phone Number Field',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 24),

                  // Amount with Currency Section
                  Text(
                    'Amount Field (Currency Format)',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // IDR Format
                  CustomTextField(
                    label: 'Amount (IDR)',
                    hint: 'Enter amount in Rupiah',
                    type: TextFieldType.number,
                    controller: _amountController,
                    prefixIcon: 'money',
                    currencyFormat: CurrencyFormat.idr,
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
                  const SizedBox(height: 24),

                  // Description Section
                  Text(
                    'Descriptive Field',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Description',
                    hint: 'Write your description here (20-500 characters)',
                    type: TextFieldType.descriptive,
                    controller: _descriptionController,
                    prefixIcon: 'description',
                    maxLines: 5,
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
                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Submit',
                          onPressed: _submitForm,
                          height: 48,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Reset',
                          onPressed: _resetForm,
                          height: 48,
                          backgroundColor:
                              isDark ? Colors.grey[800] : Colors.grey[200],
                          foregroundColor: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Info Section
                  GlassmorphicContainer(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features Showcase',
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFeature('✓ Full Animation', 'Smooth focus transitions'),
                        _buildFeature('✓ Validation', 'Real-time error display'),
                        _buildFeature('✓ Currency Format', 'IDR & USD support'),
                        _buildFeature('✓ Password Toggle', 'Show/hide with animation'),
                        _buildFeature('✓ Min/Max Length', 'Character validation'),
                        _buildFeature('✓ Dark/Light Mode', 'Auto theme adapt'),
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

  Widget _buildFeature(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 12,
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
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w300,
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
