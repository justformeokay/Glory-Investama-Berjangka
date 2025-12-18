import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants/colors.dart';

class ThemeAnnotatedRegion extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final Color? customStatusBarColor;
  final Color? customNavBarColor;

  const ThemeAnnotatedRegion({
    super.key,
    required this.child,
    required this.isDarkMode,
    this.customStatusBarColor,
    this.customNavBarColor,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarColor = customStatusBarColor ?? (isDarkMode
        ? const Color(0xFF1F1F1F).withAlpha((0.7 * 255).toInt())
        : AppColors.primaryGold.withAlpha((0.7 * 255).toInt()));

    final navBarColor = customNavBarColor ?? (isDarkMode
        ? const Color(0xFF121212)
        : AppColors.bgLight);

    final dividerColor = isDarkMode
        ? Colors.white.withAlpha((0.1 * 255).toInt())
        : Colors.black.withAlpha((0.1 * 255).toInt());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: statusBarColor,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,

        // Navigation bar
        systemNavigationBarColor: navBarColor,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,

        // Navigation bar divider
        systemNavigationBarDividerColor: dividerColor,
      ),
      child: child,
    );
  }
}
