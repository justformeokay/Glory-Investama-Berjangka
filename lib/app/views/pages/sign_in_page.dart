import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/controllers/sign_in_controller.dart';
import 'package:gifx/app/views/widgets/index.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  late SignInController _controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SignInController>();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            child: Column(
              children: [
                // Tab Bar with Premium Style
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  padding: const EdgeInsets.all(3),
                  height: 50,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGold.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black87,
                    unselectedLabelColor: isDark ? Colors.white54 : Colors.black45,
                    dividerColor: Colors.transparent,
                    splashBorderRadius: BorderRadius.circular(28),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: 'Login'),
                      Tab(text: 'Register'),
                    ],
                  ),
                ),

                // Tab Content - No extra padding (handled in tabbar content)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Login Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        child: _buildLoginTab(isDark),
                      ),
                      // Register Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        child: _buildRegisterTab(isDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab(bool isDark) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Welcome Back',
            style: AppTextStyles.displayLarge.copyWith(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to your account',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 28),

          // Email Field
          GetBuilder<SignInController>(
            builder: (controller) {
              return CustomTextField(
                label: 'Email Address',
                hint: 'you@example.com',
                type: TextFieldType.email,
                controller: controller.emailController,
                prefixIcon: 'email',
                validator: (value) => controller.emailError,
                onChanged: (value) {
                  if (controller.emailError != null) {
                    controller.emailError = controller.validateEmail(value);
                    controller.update();
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),

          // Password Field
          GetBuilder<SignInController>(
            builder: (controller) {
              return CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                type: TextFieldType.password,
                controller: controller.passwordController,
                prefixIcon: 'lock',
                minLength: 8,
                validator: (value) => controller.passwordError,
                onChanged: (value) {
                  if (controller.passwordError != null) {
                    controller.passwordError =
                        controller.validatePassword(value);
                    controller.update();
                  }
                },
              );
            },
          ),
          const SizedBox(height: 14),

          // Remember & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppColors.primaryGold,
                  ),
                  Text(
                    'Remember me',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.toNamed('/forgot-password'),
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10,
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sign In Button
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => CustomElevatedButton(
                label: _controller.isLoading.value ? 'Signing In...' : 'Sign In',
                onPressed: _controller.isLoading.value
                    ? null
                    : (){
                      Get.offAllNamed('/passcode');
                    },
                    // : () => _controller.signIn(),
                isLoading: _controller.isLoading.value,
                height: 52,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Or continue with',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 9,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Social Login Buttons
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  isDark,
                  'Google',
                  Icons.account_circle_outlined,
                  () {
                    Get.snackbar(
                      'Google Sign In',
                      'Feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildSocialButton(
                  isDark,
                  'Apple',
                  Icons.apple,
                  () {
                    Get.snackbar(
                      'Apple Sign In',
                      'Feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab(bool isDark) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Create Account',
            style: AppTextStyles.displayLarge.copyWith(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step into the future of shopping',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 28),

          // Full Name Field
          CustomTextField(
            label: 'Full Name',
            hint: 'Your full name',
            type: TextFieldType.email,
            prefixIcon: 'person',
          ),
          const SizedBox(height: 20),

          // Email Field
          CustomTextField(
            label: 'Email Address',
            hint: 'you@example.com',
            type: TextFieldType.email,
            prefixIcon: 'email',
          ),
          const SizedBox(height: 20),

          // Password Field
          CustomTextField(
            label: 'Password',
            hint: 'Create a password',
            type: TextFieldType.password,
            prefixIcon: 'lock',
            minLength: 8,
          ),
          const SizedBox(height: 24),

          // Register Button
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              label: 'Register',
              onPressed: () {
                Get.snackbar(
                  'Register',
                  'Feature coming soon',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              height: 52,
            ),
          ),
          const SizedBox(height: 20),

          // Divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Or continue with',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 9,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Social Login Buttons
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  isDark,
                  'Google',
                  Icons.account_circle_outlined,
                  () {},
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildSocialButton(
                  isDark,
                  'Apple',
                  Icons.apple,
                  () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sign In Link
          Center(
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: AppTextStyles.caption.copyWith(
                  fontSize: 10,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _tabController.animateTo(0);
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    bool isDark,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryGold,
              size: 20,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
