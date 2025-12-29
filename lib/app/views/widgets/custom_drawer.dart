import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBlack.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(-5, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Profile Section
              _buildProfileSection(context),

              // Deposit & Withdrawal Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Iconsax.wallet_add_outline,
                        label: 'Deposit',
                        color: AppColors.successGreen,
                        onTap: () {
                          // Handle deposit
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Iconsax.wallet_minus_outline,
                        label: 'Withdraw',
                        color: AppColors.errorRed,
                        onTap: () {
                          // Handle withdrawal
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 0.3, color: Colors.grey.shade300),

              // Trade Section
              _buildSectionHeader(context, 'Trade'),
              _buildMenuItem(
                context,
                icon: Iconsax.setting_2_outline,
                title: 'Lot Settings',
                onTap: () {
                  // Navigate to lot settings
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.wallet_3_outline,
                title: 'Trading Accounts List',
                onTap: () {
                  // Navigate to trading accounts
                },
              ),

              Divider(height: 0.3, color: Colors.grey.shade300),

              // Profile Section
              _buildSectionHeader(context, 'Profile'),
              _buildMenuItem(
                context,
                icon: Iconsax.security_outline,
                title: 'Security',
                onTap: () {
                  // Navigate to security
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.finger_scan_outline,
                title: 'Biometrics',
                onTap: () {
                  // Navigate to biometrics
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.user_edit_outline,
                title: 'Profile Settings',
                onTap: () {
                  // Navigate to profile settings
                },
              ),

              Divider(height: 0.3, color: Colors.grey.shade300),

              // General Section
              _buildSectionHeader(context, 'General'),
              _buildMenuItem(
                context,
                icon: Iconsax.info_circle_outline,
                title: 'About App',
                onTap: () {
                  // Show about app
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.code_outline,
                title: 'App Version',
                trailing: Text(
                  'v1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                onTap: null,
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.shield_tick_outline,
                title: 'Privacy Policy',
                onTap: () {
                  // Show privacy policy
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.message_question_outline,
                title: 'FAQ',
                onTap: () {
                  // Show FAQ
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.document_text_outline,
                title: 'Terms & Conditions',
                onTap: () {
                  // Show terms
                },
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.logout_outline,
                title: 'Sign Out',
                textColor: AppColors.errorRed,
                onTap: () {
                  _showSignOutDialog(context);
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGold.withOpacity(0.15),
            AppColors.primaryGoldLight.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Profile Photo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryGold,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGold.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryGoldLight,
                child: Icon(
                  Iconsax.user_bold,
                  size: 40,
                  color: AppColors.secondaryWhite,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),

            // Email
            Text(
              'john.doe@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 16),

            // Account Balance
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.wallet_outline,
                    size: 18,
                    color: AppColors.primaryGoldDark,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$124,580.50',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGoldDark,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (textColor ?? AppColors.primaryGold).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: textColor ?? AppColors.primaryGold,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.textPrimary,
            ),
      ),
      trailing: trailing ??
          Icon(
            Iconsax.arrow_right_3_outline,
            size: 18,
            color: AppColors.textSecondary,
          ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Sign Out',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle sign out
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorRed,
              foregroundColor: AppColors.secondaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
