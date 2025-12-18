import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/otp_controller.dart';
import 'package:gifx/app/views/widgets/theme_annotated_region.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with SingleTickerProviderStateMixin {
  late OtpController _controller;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<OtpController>();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    isDark ? Colors.grey[800] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.grey[700]!
                                      : Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 16,
                                color:
                                    isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Enter OTP',
                            style: AppTextStyles.displayLarge.copyWith(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Text(
                              'We\'ve sent a code to ${_controller.email.value}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isDark ? Colors.white54 : Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // OTP Input Display
                    Obx(
                      () => Column(
                        children: [
                          // OTP Dots
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 24,
                              ),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey[900] : Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _controller.otpError.value.isNotEmpty
                                      ? const Color(0xFFFF6B6B)
                                      : (isDark
                                          ? Colors.grey[800]!
                                          : Colors.grey[300]!),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  6,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index <
                                                _controller.otpInput.value
                                                    .length
                                            ? AppColors.primaryGold
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: index <
                                                  _controller.otpInput.value
                                                      .length
                                              ? AppColors.primaryGold
                                              : Colors.grey,
                                          width: index <
                                                  _controller.otpInput.value
                                                      .length
                                              ? 2
                                              : 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Error Message
                          if (_controller.otpError.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                _controller.otpError.value,
                                style: const TextStyle(
                                  color: Color(0xFFFF6B6B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          // Loading Indicator
                          if (_controller.isLoading.value)
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryGold,
                                      ),
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Verifying OTP...',
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 11,
                                      color: AppColors.primaryGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Number Keypad
                    Obx(
                      () => Opacity(
                        opacity: _controller.isLoading.value ? 0.5 : 1,
                        child: IgnorePointer(
                          ignoring: _controller.isLoading.value,
                          child: Column(
                            children: [
                              // Rows 1-3
                              ..._buildNumberRows(isDark),

                              // Delete Button
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildNumberButton(
                                      '←',
                                      isDark,
                                      isLoading: _controller.isLoading.value,
                                      onPressed: () {
                                        _controller.removeDigit();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Resend OTP
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            if (!_controller.canResend.value)
                              Text(
                                'Resend in ${_controller.resendCountdown.value}s',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: () => _controller.resendOtp(),
                                child: Text(
                                  'Resend OTP',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 12,
                                    color: AppColors.primaryGold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNumberRows(bool isDark) {
    final numbers = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['0'],
    ];

    return [
      for (int i = 0; i < 3; i++)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String num in numbers[i])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildNumberButton(
                    num,
                    isDark,
                    onPressed: () {
                      _controller.addDigit(num);
                      _animateButton();
                    },
                  ),
                ),
            ],
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: _buildNumberButton(
          '0',
          isDark,
          onPressed: () {
            _controller.addDigit('0');
            _animateButton();
          },
        ),
      ),
    ];
  }

  Widget _buildNumberButton(
    String number,
    bool isDark, {
    bool isLoading = false,
    required VoidCallback onPressed,
  }) {
    final isDeleteButton = number == '←';

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isDeleteButton ? 60 : 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDeleteButton ? Colors.transparent : (isDark ? Colors.grey[800] : Colors.grey[150]),
          border: Border.all(
            color: isDeleteButton
                ? Colors.transparent
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 0.7,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            customBorder: const CircleBorder(),
            child: Center(
              child: isDeleteButton
                  ? Icon(
                      Icons.backspace_outlined,
                      color: isLoading
                          ? (isDark ? Colors.white30 : Colors.black12)
                          : (isDark ? Colors.white70 : Colors.black54),
                      size: 24,
                    )
                  : Text(
                      number,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _animateButton() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }
}
