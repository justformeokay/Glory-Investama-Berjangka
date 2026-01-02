import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../widgets/custom_drawer.dart';
import 'dashboard/home_tab.dart';
import 'dashboard/markets_tab.dart';
import 'dashboard/transactions_tab.dart';
import 'dashboard/signals_tab.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _tabs = const [
    HomeTab(),
    MarketsTab(),
    TransactionsTab(),
    SignalsTab(),
  ];

  final List<_NavItem> _navItems = const [
    _NavItem(
      icon: Iconsax.home_2_outline,
      activeIcon: Iconsax.home_2_bold,
      label: 'Home',
    ),
    _NavItem(
      icon: Iconsax.chart_outline,
      activeIcon: Iconsax.chart_bold,
      label: 'Markets',
    ),
    _NavItem(
      icon: Iconsax.document_text_outline,
      activeIcon: Iconsax.document_text_bold,
      label: 'Transactions',
    ),
    _NavItem(
      icon: Iconsax.notification_bing_outline,
      activeIcon: Iconsax.notification_bing_bold,
      label: 'Signals',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgLight,
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryWhite,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(
          Iconsax.menu_outline,
          color: AppColors.textPrimary,
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Iconsax.chart_21_bold,
              color: AppColors.primaryGold,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'GIFX',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // Show search
          },
          icon: Icon(
            Iconsax.search_normal_outline,
            color: AppColors.textPrimary,
          ),
        ),
        IconButton(
          onPressed: () {
            // Show notifications
            Get.toNamed('/notifications');
          },
          icon: Stack(
            children: [
              Icon(
                Iconsax.notification_outline,
                color: AppColors.textPrimary,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.secondaryGrey.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBlack.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
              (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navItems[index];
    final isActive = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 20 : 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive 
              ? AppColors.primaryGold.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              color: isActive ? AppColors.primaryGold : AppColors.textSecondary,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGold,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
