import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final String? tooltip;
  final bool isLoading;
  final bool isDisabled;
  final double borderRadius;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 44,
    this.iconSize = 24,
    this.tooltip,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor ?? 
                  (isDark ? AppColors.secondaryWhite.withAlpha((0.1 * 255).toInt()) : AppColors.secondaryBlack.withAlpha((0.1 * 255).toInt())),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          iconColor ?? (isDark ? AppColors.secondaryWhite : AppColors.secondaryBlack),
                        ),
                      ),
                    )
                  : Icon(
                      icon,
                      size: iconSize,
                      color: isDisabled 
                          ? AppColors.disabledTextColor 
                          : (iconColor ?? (isDark ? AppColors.primaryGold : AppColors.secondaryBlack)),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
