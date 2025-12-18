import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';
import 'dart:ui';

enum TextFieldType { email, password, number, descriptive }

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextFieldType type;
  final TextEditingController? controller;
  final int minLength;
  final int maxLength;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscureText;
  final CurrencyFormat? currencyFormat;
  final EdgeInsets padding;
  final double borderRadius;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.type,
    this.controller,
    this.minLength = 0,
    this.maxLength = 255,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.currencyFormat,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 14,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _focusAnimationController;
  late AnimationController _borderAnimationController;
  late Animation<double> _focusAnimation;
  late Animation<double> _borderAnimation;
  String? _errorText;
  late TextEditingController _controller;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();

    // Focus animation for scale and color
    _focusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _focusAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _focusAnimationController, curve: Curves.easeOut),
    );

    // Border animation for glow effect
    _borderAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _borderAnimationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);

    // Set initial input formatters
    _setInputFormatters();
  }

  void _setInputFormatters() {
    List<TextInputFormatter> formatters = [];

    switch (widget.type) {
      case TextFieldType.email:
        // Email formatter
        break;
      case TextFieldType.password:
        // No formatter for password
        break;
      case TextFieldType.number:
        if (widget.currencyFormat != null) {
          formatters.add(
            CurrencyInputFormatter(
              currencyFormat: widget.currencyFormat!,
            ),
          );
        } else {
          formatters.add(FilteringTextInputFormatter.digitsOnly);
        }
        break;
      case TextFieldType.descriptive:
        // No formatter for descriptive
        break;
    }

    if (widget.maxLength > 0) {
      // Max length is handled by maxLength parameter in TextField
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _focusAnimationController.forward();
      _borderAnimationController.forward();
    } else {
      _focusAnimationController.reverse();
      _borderAnimationController.reverse();
      _validate();
    }
  }

  void _onTextChange() {
    if (_errorText != null && _controller.text.isNotEmpty) {
      setState(() {
        _errorText = null;
      });
    }
  }

  void _validate() {
    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      setState(() {
        _errorText = error;
      });
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.descriptive:
        return TextInputType.multiline;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _focusAnimationController.dispose();
    _borderAnimationController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with animation
        AnimatedBuilder(
          animation: _focusAnimation,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                widget.label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: _errorText != null
                      ? AppColors.errorRed
                      : _focusNode.hasFocus
                          ? AppColors.primaryGold
                          : accentColor.withAlpha((0.6 * 255).toInt()),
                  fontWeight: _focusNode.hasFocus ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          },
        ),

        // Main TextField Container with animations
        ScaleTransition(
          scale: _focusAnimation,
          child: AnimatedBuilder(
            animation: _borderAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: [
                    // Glow effect when focused
                    if (_focusNode.hasFocus)
                      BoxShadow(
                        color: AppColors.primaryGold.withAlpha(
                          (_borderAnimation.value * 0.3 * 255).toInt(),
                        ),
                        blurRadius: 12 * _borderAnimation.value,
                        spreadRadius: 2 * _borderAnimation.value,
                      ),
                    // Default shadow
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: widget.padding,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withAlpha((0.08 * 255).toInt())
                            : Colors.black.withAlpha((0.05 * 255).toInt()),
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        border: Border.all(
                          color: _errorText != null
                              ? AppColors.errorRed.withAlpha((0.5 * 255).toInt())
                              : _focusNode.hasFocus
                                  ? AppColors.primaryGold
                                  : Colors.white.withAlpha((0.2 * 255).toInt()),
                          width: _focusNode.hasFocus ? 2 : 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Prefix Icon
                          if (widget.prefixIcon != null) ...[
                            Icon(
                              _getIconData(widget.prefixIcon!),
                              size: 18,
                              color: _focusNode.hasFocus
                                  ? AppColors.primaryGold
                                  : accentColor.withAlpha((0.5 * 255).toInt()),
                            ),
                            const SizedBox(width: 8),
                          ],

                          // TextField
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              keyboardType: _getKeyboardType(),
                              obscureText: widget.type == TextFieldType.password
                                  ? !_showPassword
                                  : false,
                              enabled: widget.enabled,
                              maxLines: widget.type == TextFieldType.descriptive
                                  ? widget.maxLines
                                  : 1,
                              maxLength: widget.maxLength > 0
                                  ? widget.maxLength
                                  : null,
                              onChanged: (value) {
                                widget.onChanged?.call(value);
                              },
                              onSubmitted: (value) {
                                widget.onSubmitted?.call(value);
                              },
                              inputFormatters: [
                                if (widget.type == TextFieldType.number &&
                                    widget.currencyFormat != null)
                                  CurrencyInputFormatter(
                                    currencyFormat: widget.currencyFormat!,
                                  )
                                else if (widget.type == TextFieldType.number)
                                  FilteringTextInputFormatter.digitsOnly
                                else if (widget.type == TextFieldType.email)
                                  FilteringTextInputFormatter.deny(' '),
                              ],
                              decoration: InputDecoration(
                                hintText: widget.hint,
                                border: InputBorder.none,
                                counterText: '',
                                hintStyle: AppTextStyles.bodySmall.copyWith(
                                  color: accentColor.withAlpha((0.4 * 255).toInt()),
                                  fontWeight: FontWeight.w300,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // Character count for descriptive
                          if (widget.type == TextFieldType.descriptive &&
                              widget.maxLength > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '${_controller.text.length}/${widget.maxLength}',
                              style: AppTextStyles.caption.copyWith(
                                color: accentColor.withAlpha((0.5 * 255).toInt()),
                              ),
                            ),
                          ],

                          // Suffix Icon (Password toggle or icon)
                          if (widget.type == TextFieldType.password) ...[
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: AnimatedIcon(
                                icon: AnimatedIcons.view_list,
                                progress: AlwaysStoppedAnimation(
                                  _showPassword ? 1.0 : 0.0,
                                ),
                                size: 18,
                                color: _focusNode.hasFocus
                                    ? AppColors.primaryGold
                                    : accentColor.withAlpha((0.5 * 255).toInt()),
                              ),
                            ),
                          ] else if (widget.suffixIcon != null) ...[
                            const SizedBox(width: 8),
                            Icon(
                              _getIconData(widget.suffixIcon!),
                              size: 18,
                              color: _focusNode.hasFocus
                                  ? AppColors.primaryGold
                                  : accentColor.withAlpha((0.5 * 255).toInt()),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Error message with animation
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Text(
              _errorText!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.errorRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        // Helper text
        if (_errorText == null &&
            widget.type == TextFieldType.email) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              'example@email.com',
              style: AppTextStyles.caption.copyWith(
                color: accentColor.withAlpha((0.4 * 255).toInt()),
              ),
            ),
          ),
        ],

        if (_errorText == null &&
            widget.type == TextFieldType.password) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              'Min 8 characters, 1 uppercase, 1 number',
              style: AppTextStyles.caption.copyWith(
                color: accentColor.withAlpha((0.4 * 255).toInt()),
              ),
            ),
          ),
        ],
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'email':
        return Icons.email_outlined;
      case 'lock':
        return Icons.lock_outline;
      case 'phone':
        return Icons.phone_outlined;
      case 'user':
        return Icons.person_outline;
      case 'description':
        return Icons.description_outlined;
      case 'search':
        return Icons.search;
      case 'check':
        return Icons.check_circle_outline;
      default:
        return Icons.edit_outlined;
    }
  }
}

// Currency Format Enum
enum CurrencyFormat { idr, usd }

// Currency Input Formatter
class CurrencyInputFormatter extends TextInputFormatter {
  final CurrencyFormat currencyFormat;

  CurrencyInputFormatter({required this.currencyFormat});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    String formatted = _formatNumber(digits);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatNumber(String digits) {
    if (digits.isEmpty) return '';

    // Format with thousand separator
    final buffer = StringBuffer();
    int count = 0;

    for (int i = digits.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
      count++;
    }

    String reversedNumber = buffer.toString().split('').reversed.join('');
    String prefix = currencyFormat == CurrencyFormat.idr ? 'Rp ' : '\$ ';

    return '$prefix$reversedNumber';
  }
}
