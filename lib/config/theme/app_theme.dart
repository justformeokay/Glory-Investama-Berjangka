import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryGold,
      secondary: AppColors.secondaryBlack,
      surface: AppColors.bgLight,
      error: AppColors.errorRed,
      outline: AppColors.secondaryGrey,
    ),
    scaffoldBackgroundColor: AppColors.bgLight,
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryGold.withAlpha((0.7 * 255).toInt()),
      foregroundColor: AppColors.secondaryBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: AppColors.secondaryBlack,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppColors.textPrimary,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.textPrimary,
      ),
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textSecondary,
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textPrimary,
      ),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGold.withAlpha((0.8 * 255).toInt()),
        foregroundColor: AppColors.secondaryBlack,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: AppTextStyles.buttonText,
        shadowColor: AppColors.primaryGold.withAlpha((0.3 * 255).toInt()),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryGold,
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGold,
        side: BorderSide(color: AppColors.primaryGold.withAlpha((0.6 * 255).toInt()), width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // InputDecoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondaryWhite.withAlpha((0.7 * 255).toInt()),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.secondaryGrey.withAlpha((0.3 * 255).toInt())),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.secondaryGrey.withAlpha((0.3 * 255).toInt()), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primaryGold, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryGold,
      foregroundColor: AppColors.secondaryBlack,
      elevation: 2,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.secondaryWhite.withAlpha((0.7 * 255).toInt()),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryGold,
      secondary: AppColors.secondaryWhite,
      surface: AppColors.bgDark,
      error: AppColors.errorRed,
      outline: AppColors.secondaryLightGrey,
    ),
    scaffoldBackgroundColor: AppColors.bgDark,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1F1F1F).withAlpha((0.7 * 255).toInt()),
      foregroundColor: AppColors.primaryGold,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: AppColors.primaryGold,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.secondaryWhite,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.secondaryWhite,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppColors.secondaryWhite,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.secondaryWhite,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.secondaryWhite,
      ),
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.secondaryWhite,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.secondaryWhite,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: const Color(0xFFC0C0C0),
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: const Color(0xFF808080),
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.secondaryWhite,
      ),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGold.withAlpha((0.8 * 255).toInt()),
        foregroundColor: AppColors.secondaryBlack,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: AppTextStyles.buttonText,
        shadowColor: AppColors.primaryGold.withAlpha((0.3 * 255).toInt()),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryGold,
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGold,
        side: BorderSide(color: AppColors.primaryGold.withAlpha((0.6 * 255).toInt()), width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // InputDecoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A).withAlpha((0.7 * 255).toInt()),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: const Color(0xFF505050).withAlpha((0.3 * 255).toInt())),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: const Color(0xFF505050).withAlpha((0.3 * 255).toInt()), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primaryGold, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFF808080)),
      hintStyle: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF606060)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryGold,
      foregroundColor: AppColors.secondaryBlack,
      elevation: 2,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: const Color(0xFF1F1F1F).withAlpha((0.7 * 255).toInt()),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}