import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;
  String _selectedCategory = 'all';
  String _searchQuery = '';

  final List<SearchShortcut> _shortcuts = [
    SearchShortcut(
      id: 'deposit',
      label: 'Deposit',
      icon: Iconsax.arrow_down_1_bold,
      description: 'Add funds to your account',
      category: 'transactions',
    ),
    SearchShortcut(
      id: 'withdraw',
      label: 'Withdraw',
      icon: Iconsax.arrow_up_1_bold,
      description: 'Withdraw your funds',
      category: 'transactions',
    ),
    SearchShortcut(
      id: 'transfer',
      label: 'Internal Transfer',
      icon: Iconsax.send_1_bold,
      description: 'Transfer between accounts',
      category: 'transactions',
    ),
    SearchShortcut(
      id: 'notifications',
      label: 'Notifications',
      icon: Iconsax.notification_bing_bold,
      description: 'View all notifications',
      category: 'menu',
    ),
    SearchShortcut(
      id: 'settings',
      label: 'Settings',
      icon: Iconsax.setting_2_bold,
      description: 'Manage your account',
      category: 'menu',
    ),
    SearchShortcut(
      id: 'profile',
      label: 'Profile',
      icon: Iconsax.user_bold,
      description: 'View your profile',
      category: 'menu',
    ),
  ];

  final List<MarketItem> _markets = [
    MarketItem(
      symbol: 'EURUSD',
      name: 'Euro / US Dollar',
      price: 1.0850,
      change: 0.52,
      icon: '🇪🇺',
    ),
    MarketItem(
      symbol: 'GBPUSD',
      name: 'British Pound / US Dollar',
      price: 1.2750,
      change: -0.23,
      icon: '🇬🇧',
    ),
    MarketItem(
      symbol: 'USDJPY',
      name: 'US Dollar / Japanese Yen',
      price: 149.85,
      change: 1.15,
      icon: '🇯🇵',
    ),
    MarketItem(
      symbol: 'AUDUSD',
      name: 'Australian Dollar / US Dollar',
      price: 0.6540,
      change: -0.67,
      icon: '🇦🇺',
    ),
    MarketItem(
      symbol: 'NZDUSD',
      name: 'New Zealand Dollar / US Dollar',
      price: 0.6020,
      change: 0.34,
      icon: '🇳🇿',
    ),
    MarketItem(
      symbol: 'USDCAD',
      name: 'US Dollar / Canadian Dollar',
      price: 1.3650,
      change: 0.89,
      icon: '🇨🇦',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<SearchShortcut> get _filteredShortcuts {
    if (_searchQuery.isEmpty) {
      return _shortcuts;
    }
    return _shortcuts
        .where((item) =>
            item.label.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<MarketItem> get _filteredMarkets {
    if (_searchQuery.isEmpty) {
      return _markets;
    }
    return _markets
        .where((item) =>
            item.symbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _handleShortcutTap(SearchShortcut shortcut) {
    switch (shortcut.id) {
      case 'deposit':
        Get.back();
        Get.toNamed('/deposit');
        break;
      case 'withdraw':
        Get.back();
        Get.toNamed('/withdrawal');
        break;
      case 'transfer':
        Get.back();
        Get.toNamed('/internal-transfer');
        break;
      case 'notifications':
        Get.back();
        Get.toNamed('/notifications');
        break;
      default:
        Get.back();
    }
  }

  void _handleMarketTap(MarketItem market) {
    Get.back();
    Get.toNamed('/markets', arguments: {'symbol': market.symbol});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Iconsax.close_circle_bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Input - Modern Premium Design
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGold.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Search shortcuts, markets...',
                        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Iconsax.search_normal_outline,
                            color: AppColors.primaryGold,
                            size: 22,
                          ),
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                  child: Icon(
                                    Iconsax.close_circle_bold,
                                    color: AppColors.primaryGold,
                                    size: 22,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Modern Pill-shaped Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondaryGrey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryGold,
                      width: 1.5,
                    ),
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.primaryGold,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  unselectedLabelColor: AppColors.textSecondary,
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                  tabs: const [
                    Tab(text: 'Shortcuts'),
                    Tab(text: 'Markets'),
                  ],
                ),
              ),
            ),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Shortcuts Tab
                  _buildShortcutsTab(),
                  // Markets Tab
                  _buildMarketsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutsTab() {
    return _filteredShortcuts.isEmpty
        ? _buildEmptyState('No shortcuts found', 'Try a different search term')
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _filteredShortcuts.length,
            itemBuilder: (context, index) {
              final shortcut = _filteredShortcuts[index];
              return GestureDetector(
                onTap: () => _handleShortcutTap(shortcut),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.secondaryGrey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            shortcut.icon,
                            color: AppColors.primaryGold,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shortcut.label,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              shortcut.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Iconsax.arrow_right_1_outline,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildMarketsTab() {
    return _filteredMarkets.isEmpty
        ? _buildEmptyState('No markets found', 'Try a different search term')
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _filteredMarkets.length,
            itemBuilder: (context, index) {
              final market = _filteredMarkets[index];
              final isPositive = market.change >= 0;
              return GestureDetector(
                onTap: () => _handleMarketTap(market),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.secondaryGrey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            market.icon,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              market.symbol,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              market.name,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            market.price.toStringAsFixed(4),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? AppColors.successGreen.withOpacity(0.15)
                                  : AppColors.errorRed.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? Iconsax.arrow_up_1_outline
                                      : Iconsax.arrow_down_1_outline,
                                  size: 12,
                                  color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${isPositive ? '+' : ''}${market.change.toStringAsFixed(2)}%',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: isPositive ? AppColors.successGreen : AppColors.errorRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Iconsax.search_normal_outline,
                  size: 40,
                  color: AppColors.primaryGold.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchShortcut {
  final String id;
  final String label;
  final IconData icon;
  final String description;
  final String category;

  SearchShortcut({
    required this.id,
    required this.label,
    required this.icon,
    required this.description,
    required this.category,
  });
}

class MarketItem {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final String icon;

  MarketItem({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.icon,
  });
}
