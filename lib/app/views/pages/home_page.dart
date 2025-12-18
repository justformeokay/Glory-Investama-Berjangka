import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../../config/localization/localization_service.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/colors.dart';
import '../widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final ThemeController themeController = Get.put(ThemeController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'app_title'.tr,
        actions: [
          // Theme Toggle Button
          Obx(
            () => CustomIconButton(
              icon: themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              onPressed: themeController.toggleTheme,
              tooltip: 'theme'.tr,
              iconColor: isDark ? AppColors.primaryGold : AppColors.secondaryBlack,
            ),
          ),
          // Language Menu
          PopupMenuButton(
            onSelected: (String language) {
              LocalizationService.changeLocale(language);
            },
            itemBuilder: (BuildContext context) {
              return LocalizationService.getSupportedLanguages().map((lang) {
                return PopupMenuItem(
                  value: lang['code'],
                  child: Text(lang['name'] ?? ''),
                );
              }).toList();
            },
            tooltip: 'language'.tr,
            icon: const Icon(Icons.language),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Welcome Section
              GlassmorphicContainer(
                padding: const EdgeInsets.all(20),
                borderRadius: 20,
                child: Column(
                  children: [
                    Text(
                      'hello'.tr,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: isDark ? AppColors.secondaryWhite : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'welcome'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark ? AppColors.secondaryWhite : AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Counter Section
              GlassmorphicContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: 20,
                child: Column(
                  children: [
                    Text(
                      'loading'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark ? const Color(0xFFC0C0C0) : AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        '${controller.counter}',
                        style: AppTextStyles.displayLarge.copyWith(
                          color: AppColors.primaryGold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Buttons Section
              Text(
                'Button Variants',
                style: AppTextStyles.titleLarge.copyWith(
                  color: isDark ? AppColors.secondaryWhite : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // Elevated Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      label: 'previous'.tr,
                      icon: Icons.remove,
                      onPressed: controller.decrementCounter,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      label: 'next'.tr,
                      icon: Icons.add,
                      onPressed: controller.incrementCounter,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Outlined Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: controller.resetCounter,
                  icon: const Icon(Icons.refresh),
                  label: Text('cancel'.tr),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Social Login Buttons
              Text(
                'Social Login',
                style: AppTextStyles.titleLarge.copyWith(
                  color: isDark ? AppColors.secondaryWhite : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              SocialLoginButton(
                label: 'Login with Google',
                icon: Icons.flutter_dash,
                onPressed: () {},
              ),
              const SizedBox(height: 12),

              SocialLoginButton(
                label: 'Login with Facebook',
                icon: Icons.facebook,
                onPressed: () {},
                iconColor: const Color(0xFF1877F2),
              ),
              const SizedBox(height: 12),

              SocialLoginButton(
                label: 'Login with Apple',
                icon: Icons.apple,
                onPressed: () {},
                iconColor: isDark ? AppColors.secondaryWhite : AppColors.secondaryBlack,
              ),
              const SizedBox(height: 32),

              // Icon Buttons
              Text(
                'Icon Buttons',
                style: AppTextStyles.titleLarge.copyWith(
                  color: isDark ? AppColors.secondaryWhite : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    icon: Icons.favorite_border,
                    onPressed: () {},
                    tooltip: 'Like',
                  ),
                  CustomIconButton(
                    icon: Icons.share,
                    onPressed: () {},
                    tooltip: 'Share',
                  ),
                  CustomIconButton(
                    icon: Icons.comment,
                    onPressed: () {},
                    tooltip: 'Comment',
                  ),
                  CustomIconButton(
                    icon: Icons.more_horiz,
                    onPressed: () {},
                    tooltip: 'More',
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'add'.tr,
        child: const Icon(Icons.add),
      ),
    );
  }
}
