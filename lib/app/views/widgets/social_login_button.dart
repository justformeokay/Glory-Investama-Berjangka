import 'package:flutter/material.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/colors.dart';
import 'glassmorphic_container.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final bool isDisabled;
  final double height;
  final String? imagePath;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = 50,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassmorphicContainer(
      borderRadius: 12,
      opacity: isDark ? 0.15 : 0.08,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath!,
                    width: 20,
                    height: 20,
                  )
                else
                  Icon(
                    icon,
                    size: 20,
                    color: isDisabled 
                        ? AppColors.disabledTextColor 
                        : (iconColor ?? (isDark ? AppColors.primaryGold : AppColors.secondaryBlack)),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.buttonText.copyWith(
                      color: isDisabled 
                          ? AppColors.disabledTextColor 
                          : (isDark ? AppColors.secondaryWhite : AppColors.secondaryBlack),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark ? AppColors.primaryGold : AppColors.secondaryBlack,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
