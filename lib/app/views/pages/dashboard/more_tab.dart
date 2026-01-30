import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../constants/colors.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'More',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // Account Section
              _buildSectionTitle(context, 'Account'),
              const SizedBox(height: 12),
              _buildMenuGrid(context, [
                _buildMenuItem(
                  icon: Iconsax.user_outline,
                  title: 'Profile',
                  subtitle: 'View & Edit Profile',
                  onTap: () => Get.toNamed('/profile'),
                  color: AppColors.infoBlue,
                ),
                _buildMenuItem(
                  icon: Iconsax.security_outline,
                  title: 'Security',
                  subtitle: 'Password & 2FA',
                  onTap: () => Get.toNamed('/security'),
                  color: AppColors.successGreen,
                ),
              ]),
              const SizedBox(height: 24),

              // Trading Section
              _buildSectionTitle(context, 'Trading'),
              const SizedBox(height: 12),
              _buildMenuGrid(context, [
                _buildMenuItem(
                  icon: Iconsax.chart_outline,
                  title: 'Portfolio',
                  subtitle: 'View Holdings',
                  onTap: () => Get.showSnackbar(
                    GetSnackBar(
                      title: 'Portfolio',
                      message: 'Portfolio feature coming soon',
                      duration: const Duration(seconds: 2),
                    ),
                  ),
                  color: AppColors.primaryGold,
                ),
                _buildMenuItem(
                  icon: Iconsax.trend_up_outline,
                  title: 'History',
                  subtitle: 'Trade History',
                  onTap: () => Get.showSnackbar(
                    GetSnackBar(
                      title: 'Trade History',
                      message: 'Trade history coming soon',
                      duration: const Duration(seconds: 2),
                    ),
                  ),
                  color: AppColors.errorRed,
                ),
              ]),
              const SizedBox(height: 24),

              // Financial Section
              _buildSectionTitle(context, 'Financial'),
              const SizedBox(height: 12),
              _buildMenuList(context, [
                _buildListItem(
                  icon: Iconsax.wallet_outline,
                  title: 'Deposit',
                  subtitle: 'Add funds to account',
                  onTap: () => Get.toNamed('/deposit'),
                ),
                _buildListItem(
                  icon: Iconsax.wallet_minus_outline,
                  title: 'Withdrawal',
                  subtitle: 'Withdraw funds',
                  onTap: () => Get.toNamed('/withdrawal'),
                ),
                _buildListItem(
                  icon: Iconsax.send_outline,
                  title: 'Internal Transfer',
                  subtitle: 'Transfer between accounts',
                  onTap: () => Get.toNamed('/internal-transfer'),
                ),
              ]),
              const SizedBox(height: 24),

              // Support Section
              _buildSectionTitle(context, 'Support'),
              const SizedBox(height: 12),
              _buildMenuList(context, [
                _buildListItem(
                  icon: Iconsax.message_question_outline,
                  title: 'Help Center',
                  subtitle: 'FAQs & Support',
                  onTap: () {},
                ),
                _buildListItem(
                  icon: Iconsax.call_outline,
                  title: 'Contact Us',
                  subtitle: 'Get in touch',
                  onTap: () {},
                ),
                _buildListItem(
                  icon: Iconsax.document_outline,
                  title: 'Terms & Conditions',
                  subtitle: 'Legal information',
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 24),

              // Settings Section
              _buildSectionTitle(context, 'Settings'),
              const SizedBox(height: 12),
              _buildMenuList(context, [
                _buildListItem(
                  icon: Iconsax.setting_outline,
                  title: 'Preferences',
                  subtitle: 'App settings',
                  onTap: () {},
                  isLast: false,
                ),
                _buildListItem(
                  icon: Iconsax.notification_outline,
                  title: 'Notifications',
                  subtitle: 'Manage alerts',
                  onTap: () {},
                  isLast: true,
                ),
              ]),
              const SizedBox(height: 24),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.errorRed,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.logout_1_outline,
                        color: AppColors.errorRed,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.errorRed,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Version Info
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
    );
  }

  Widget _buildMenuGrid(BuildContext context, List<Widget> items) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1,
      children: items,
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryGrey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.secondaryGrey.withOpacity(0.1),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryGold,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_1_outline,
              color: AppColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
