import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/colors.dart';

class SystemUIHelper {
  /// Set system UI overlay style based on theme
  static void setSystemUIOverlayStyle(ThemeMode themeMode) {
    final isDark = themeMode == ThemeMode.dark;
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
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
    );
  }

  /// Set light system UI overlay style
  static void setLightSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryGold.withAlpha((0.7 * 255).toInt()),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.bgLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black.withAlpha((0.1 * 255).toInt()),
      ),
    );
  }

  /// Set dark system UI overlay style
  static void setDarkSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: const Color(0xFF1F1F1F).withAlpha((0.7 * 255).toInt()),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: const Color(0xFF121212),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.white.withAlpha((0.1 * 255).toInt()),
      ),
    );
  }
}
