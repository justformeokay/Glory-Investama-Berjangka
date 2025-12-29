import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gifx/app/views/pages/sign_in_page.dart';
import 'package:gifx/utils/routes.dart';
import 'app/controllers/theme_controller.dart';
import 'config/theme/app_theme.dart';
import 'config/localization/localization_service.dart';
import 'utils/system_ui_helper.dart';
import 'constants/colors.dart';

void main() {
  Get.put(ThemeController());
  SystemUIHelper.setSystemUIOverlayStyle(ThemeMode.light);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GIFX App',
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

      // Default Transition
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),

      // Routes
      initialRoute: '/sign-in',
      getPages: Routes.getPages,
    );
  }
}