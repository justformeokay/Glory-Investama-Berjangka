import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

enum TextFieldType { email, password, number, descriptive }
enum CurrencyFormat { IDR, USD }

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
  final CurrencyFormat? currencyFormat;
  final double borderRadius;

  // Horizontal layout mode (like Date, Time fields)
  final bool isHorizontal;
  final double horizontalLabelWidth;

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
    this.currencyFormat,
    this.borderRadius = 8,
    this.isHorizontal = false,
    this.horizontalLabelWidth = 80,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  String? _errorText;
  late TextEditingController _controller;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
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
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.isHorizontal) {
      return _buildHorizontalLayout(isDark);
    }

    return _buildVerticalLayout(isDark);
  }

  Widget _buildHorizontalLayout(bool isDark) {
    final borderColor = isDark ? Colors.grey[600] : Colors.grey[300];
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _errorText != null ? AppColors.errorRed : borderColor!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: widget.horizontalLabelWidth,
            child: Text(
              widget.label,
              style: AppTextStyles.bodySmall.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
              maxLength: widget.maxLength > 0 ? widget.maxLength : null,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              inputFormatters: [
                if (widget.type == TextFieldType.number &&
                    widget.currencyFormat != null)
                  CurrencyInputFormatter(currencyFormat: widget.currencyFormat!)
                else if (widget.type == TextFieldType.number)
                  FilteringTextInputFormatter.digitsOnly
                else if (widget.type == TextFieldType.email)
                  FilteringTextInputFormatter.deny(' '),
              ],
              decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                counterText: '',
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: hintColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.bodySmall.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          if (widget.type == TextFieldType.password) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                size: 18,
                color: hintColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(bool isDark) {
    final borderColor = isDark ? Colors.grey[600] : Colors.grey[300];
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final backgroundColor = isDark ? Colors.grey[900] : Colors.grey[50];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodySmall.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.enabled ? backgroundColor : Colors.grey[200],
            border: Border.all(
              color: _errorText != null ? AppColors.errorRed : borderColor!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                Icon(
                  _getIconData(widget.prefixIcon!),
                  size: 18,
                  color: hintColor,
                ),
                const SizedBox(width: 10),
              ],
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
                  maxLength: widget.maxLength > 0 ? widget.maxLength : null,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  inputFormatters: [
                    if (widget.type == TextFieldType.number &&
                        widget.currencyFormat != null)
                      CurrencyInputFormatter(
                          currencyFormat: widget.currencyFormat!)
                    else if (widget.type == TextFieldType.number)
                      FilteringTextInputFormatter.digitsOnly
                    else if (widget.type == TextFieldType.email)
                      FilteringTextInputFormatter.deny(' '),
                  ],
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    counterText: '',
                    hintStyle: AppTextStyles.bodySmall.copyWith(
                      color: hintColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
              if (widget.type == TextFieldType.password) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                    color: hintColor,
                  ),
                ),
              ] else if (widget.suffixIcon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  _getIconData(widget.suffixIcon!),
                  size: 18,
                  color: hintColor,
                ),
              ],
            ],
          ),
        ),
        if (_errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            _errorText!,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.errorRed,
              fontSize: 8,
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
        return Icons.lock_outlined;
      case 'person':
        return Icons.person_outlined;
      case 'phone':
        return Icons.phone_outlined;
      case 'location':
        return Icons.location_on_outlined;
      default:
        return Icons.info_outlined;
    }
  }
}

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

    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final formatted = _formatCurrency(digits);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCurrency(String digits) {
    final buffer = StringBuffer();
    final length = digits.length;

    if (currencyFormat == CurrencyFormat.IDR) {
      for (int i = 0; i < length; i++) {
        if (i > 0 && (length - i) % 3 == 0) {
          buffer.write('.');
        }
        buffer.write(digits[i]);
      }
    } else {
      for (int i = 0; i < length; i++) {
        if (i > 0 && (length - i) % 3 == 0) {
          buffer.write(',');
        }
        buffer.write(digits[i]);
      }
    }

    return buffer.toString();
  }
}
