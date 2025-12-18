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
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Components Demo',
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== TEXT FIELDS SECTION =====
                  _buildSectionHeader(isDark, 'Text Fields'),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    type: TextFieldType.email,
                    controller: _emailController,
                    prefixIcon: 'email',
                    validator: (v) => v?.isEmpty ?? true ? 'Email required' : null,
                  ),
                  const SizedBox(height: 16),
        
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    type: TextFieldType.password,
                    controller: _passwordController,
                    prefixIcon: 'lock',
                    minLength: 8,
                    validator: (v) => v?.isEmpty ?? true ? 'Password required' : null,
                  ),
                  const SizedBox(height: 16),
        
                  CustomTextField(
                    label: 'Amount',
                    hint: '0',
                    type: TextFieldType.number,
                    controller: _numberController,
                    prefixIcon: 'person',
                    currencyFormat: CurrencyFormat.IDR,
                  ),
                  const SizedBox(height: 32),
        
                  // ===== CONTAINERS SECTION =====
                  _buildSectionHeader(isDark, 'Container Variants'),
                  const SizedBox(height: 16),
        
                  // Basic Container
                  CustomContainer(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: isDark ? Colors.grey[800] : Colors.blue[50],
                    borderColor: AppColors.primaryGold,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Container',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is a basic container with custom styling, perfect for displaying content like QR codes, cards, or any grouped information.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
        
                  // Elevated Container
                  CustomContainer(
                    padding: const EdgeInsets.all(14),
                    elevation: 4,
                    backgroundColor: isDark ? Colors.grey[850] : Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.qr_code_2,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QR Code',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Elevated container with shadow',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
        
                  // Outlined Container
                  OutlinedContainer(
                    padding: const EdgeInsets.all(14),
                    borderColor: AppColors.primaryGold,
                    borderWidth: 1,
                    child: Row(
                      children: [
                        Icon(Icons.info, color: AppColors.primaryGold, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Outlined container - no background, just border',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
        
                  // Card Container
                  CustomCardContainer(
                    header: Text(
                      'Invite Users',
                      style: AppTextStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    body: TextField(
                      decoration: InputDecoration(
                        hintText: 'user@example.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    footer: Align(
                      alignment: Alignment.centerRight,
                      child: CustomElevatedButton(
                        label: 'Send Invite',
                        onPressed: () {
                          Get.snackbar('Success', 'Invite sent!',
                              snackPosition: SnackPosition.BOTTOM);
                        },
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
        
                  // ===== BUTTONS SECTION =====
                  _buildSectionHeader(isDark, 'Buttons'),
                  const SizedBox(height: 16),
        
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Primary Button',
                          onPressed: () {
                            Get.snackbar('Clicked', 'Primary button pressed');
                          },
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
        
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Secondary',
                          onPressed: () {},
                          backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
                          foregroundColor: isDark ? Colors.white : Colors.black,
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
        
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'Disabled',
                          onPressed: () {},
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
        
                  // Text Button
                  Center(
                    child: Text(
                      'Text Button',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
        
                  // ===== FIELD WITH BUTTON SECTION =====
                  _buildSectionHeader(isDark, 'Field with Button Combination'),
                  const SizedBox(height: 16),
        
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomElevatedButton(
                        label: 'Search',
                        onPressed: () {
                          Get.snackbar('Searching...', 'Search initiated');
                        },
                        height: 48,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
        
                  // ===== DISABLED FIELD SECTION =====
                  _buildSectionHeader(isDark, 'Disabled Field'),
                  const SizedBox(height: 16),
        
                  CustomTextField(
                    label: 'Disabled Email',
                    hint: 'user@example.com',
                    type: TextFieldType.email,
                    enabled: false,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryGold,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          height: 3,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryGold,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
