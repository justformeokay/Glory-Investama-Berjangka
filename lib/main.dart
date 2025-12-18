import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gifx/app/views/pages/textfield_demo_page.dart';
import 'app/controllers/theme_controller.dart';
import 'config/theme/app_theme.dart';
import 'config/localization/localization_service.dart';
import 'utils/system_ui_helper.dart';
import 'constants/colors.dart';

void main() {
  // Initialize Get controllers
  Get.put(ThemeController());
  // Set system UI overlay style
  SystemUIHelper.setSystemUIOverlayStyle(ThemeMode.light);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GifX',
      debugShowCheckedModeBanner: false,
      
      // Localization Settings
      translations: LocalizationService(),
      locale: LocalizationService.fallbackLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      supportedLocales: LocalizationService.supportedLocales,

      // Theme Settings
      themeMode: Get.find<ThemeController>().themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Home Page
      home: Obx(
        () {
          final themeMode = Get.find<ThemeController>().themeMode;
          final isDark = themeMode == ThemeMode.dark;
          
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // Status bar settings
              statusBarColor: isDark 
                  ? const Color(0xFF1F1F1F).withAlpha((0.7 * 255).toInt())
                  : AppColors.primaryGold.withAlpha((0.7 * 255).toInt()),
              statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
              
              // Navigation bar settings
              systemNavigationBarColor: isDark 
                  ? const Color(0xFF121212)
                  : AppColors.bgLight,
              systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              
              // System navigation bar divider color
              systemNavigationBarDividerColor: isDark
                  ? Colors.white.withAlpha((0.1 * 255).toInt())
                  : Colors.black.withAlpha((0.1 * 255).toInt()),
            ),
            child: TextFieldDemoPage(),
          );
        },
      ),
    );
  }
}
