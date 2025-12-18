import 'package:flutter/material.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final EdgeInsets padding;
  final double borderRadius;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius = 14,
    this.width,
    this.height,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _pressAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _pressController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _pressController.reverse();
  }

  void _onTapCancel() {
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = widget.backgroundColor ?? AppColors.primaryGold;
    final textColor = widget.textColor ?? (isDark ? AppColors.secondaryBlack : const Color.fromARGB(255, 63, 61, 61));

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ScaleTransition(
        scale: _pressAnimation,
        child: GestureDetector(
          onTapDown: widget.isDisabled || widget.isLoading ? null : _onTapDown,
          onTapUp: widget.isDisabled || widget.isLoading ? null : _onTapUp,
          onTapCancel: widget.isDisabled || widget.isLoading ? null : _onTapCancel,
          onTap: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.isDisabled
                  ? []
                  : [
                      // Bottom shadow for 3D effect
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(0, 6),
                        blurRadius: 3
                        ,
                        spreadRadius: 0,
                      ),
                      // Inner shadow bottom
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        offset: const Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                    ],
            ),
            child: Stack(
              children: [
                // Main button
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: widget.isDisabled ? AppColors.disabledColor : bgColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: widget.isDisabled
                        ? null
                        : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              bgColor.withOpacity(1.0),
                              bgColor.withOpacity(0.85),
                            ],
                          ),
                  ),
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.foregroundColor ?? textColor,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.icon != null) ...[
                                Icon(
                                  widget.icon,
                                  size: 18,
                                  color: widget.isDisabled
                                      ? AppColors.disabledTextColor
                                      : textColor,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                widget.label,
                                style: AppTextStyles.buttonText.copyWith(
                                  color: widget.isDisabled
                                      ? AppColors.disabledTextColor
                                      : textColor,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                // Shine/glossy effect overlay (top)
                if (!widget.isDisabled)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(widget.borderRadius),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Border highlight (top edge)
                if (!widget.isDisabled)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(widget.borderRadius),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.6),
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
