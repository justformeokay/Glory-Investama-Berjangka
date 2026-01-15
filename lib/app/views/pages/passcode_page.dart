import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/passcode_controller.dart';
import 'package:gifx/app/views/widgets/theme_annotated_region.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';
import 'package:icons_plus/icons_plus.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage>
    with SingleTickerProviderStateMixin {
  late PasscodeController _controller;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<PasscodeController>();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.1))
        .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );

    // Listen for success and show bottom sheet
    ever(_controller.showSuccess, (bool success) {
      if (success) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _showSuccessBottomSheet();
        });
      }
    });
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
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Text(
                        'Set Your Passcode',
                        style: AppTextStyles.displayLarge.copyWith(
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a 6-digit passcode for security',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Passcode Display with Animation
                Obx(
                  () => Column(
                    children: [
                      // Passcode Dots
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 24,
                            ),
                            decoration: BoxDecoration(
                              color: _getPasscodeBackgroundColor(isDark),
                              borderRadius: BorderRadius.circular(16),
                              // border: Border.all(
                              //   color: _getPasscodeBorderColor(isDark),
                              //   width: 1.5,
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: _buildPasscodeDot(
                                    index < _controller.passcodeInput.value.length,
                                    isDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Error Message
                      if (_controller.showError.value)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            _controller.errorMessage.value,
                            style: const TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      // Success Message
                      if (_controller.showSuccess.value)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.primaryGold,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Passcode saved successfully!',
                                style: TextStyle(
                                  color: AppColors.primaryGold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
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

                          // Delete Button Row
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
                                    'Setting your passcode...',
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
                  ),
                ),

                const SizedBox(height: 20),
              ],
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
      // Row 4 (just 0)
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

  Widget _buildPasscodeDot(bool isFilled, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? AppColors.primaryGold : Colors.transparent,
        border: Border.all(
          color: isFilled ? AppColors.primaryGold : Colors.grey,
          width: isFilled ? 2 : 1.5,
        ),
      ),
    );
  }

  Color? _getPasscodeBackgroundColor(bool isDark) {
    if (_controller.showError.value) {
      return const Color(0xFFFF6B6B).withValues(alpha: 0.1);
    }
    if (_controller.showSuccess.value) {
      return AppColors.primaryGold.withValues(alpha: 0.1);
    }
    return isDark ? Colors.grey[900] : Colors.grey[50];
  }

  void _animateButton() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _showSuccessBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: const ColorFilter.mode(Colors.black12, BlendMode.darken),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Success Icon with Animation
                        ScaleTransition(
                          scale: Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryGold.withOpacity(0.15),
                              border: Border.all(
                                color: AppColors.primaryGold,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check_circle,
                                size: 52,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title
                        Text(
                          'Perfect!',
                          style: AppTextStyles.displayLarge.copyWith(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          'Your passcode has been set successfully',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isDark ? Colors.white54 : Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Gradient Button
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryGold,
                                AppColors.primaryGold.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGold.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                _controller.proceedToDashboard();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 32,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Continue to Dashboard',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      OctIcons.arrow_right,
                                      color: Colors.black87,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Secondary button
                        Container(
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[800] : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                child: Center(
                                  child: Text(
                                    'Review Passcode',
                                    style: TextStyle(
                                      color: isDark ? Colors.white70 : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}