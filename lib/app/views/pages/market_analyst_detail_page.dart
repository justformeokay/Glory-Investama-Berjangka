import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class MarketAnalystDetailPage extends StatelessWidget {
  const MarketAnalystDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        title: const Text('Market Analysts'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left_outline),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Filter
              _buildSearchFilter(context),
              const SizedBox(height: 24),

              // Analysts List
              _buildAnalystsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.secondaryGrey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal_outline,
                color: AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search analyst or market pair',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('All', isActive: true),
              const SizedBox(width: 12),
              _buildFilterChip('Forex'),
              const SizedBox(width: 12),
              _buildFilterChip('Trending'),
              const SizedBox(width: 12),
              _buildFilterChip('Top Rated'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGold : AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? AppColors.primaryGold : AppColors.secondaryGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.secondaryWhite : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAnalystsList(BuildContext context) {
    final analysts = [
      {
        'name': 'Sarah Mitchell',
        'title': 'Senior Forex Analyst',
        'bio': 'Specializing in EUR/USD and GBP/USD pairs with 8+ years of experience',
        'rating': 4.8,
        'followers': 2300,
        'posts': 156,
        'accuracy': 78,
        'color': AppColors.successGreen,
        'status': 'Active Now',
        'latest': 'EUR/USD Bullish Pattern - Strong support at 1.0820',
      },
      {
        'name': 'John Premium',
        'title': 'Technical Analyst',
        'bio': 'Expert in chart patterns and technical indicators, focus on Asian pairs',
        'rating': 4.6,
        'followers': 1800,
        'posts': 134,
        'accuracy': 76,
        'color': AppColors.infoBlue,
        'status': '2 hours ago',
        'latest': 'GBP/USD consolidation between key levels',
      },
      {
        'name': 'Alex Trading',
        'title': 'Fundamental Analyst',
        'bio': 'Economic data interpretation specialist, macro market insights',
        'rating': 4.5,
        'followers': 1500,
        'posts': 98,
        'accuracy': 74,
        'color': AppColors.errorRed,
        'status': '5 hours ago',
        'latest': 'USD/JPY testing key resistance at 149.00',
      },
      {
        'name': 'Emma Roberts',
        'title': 'Swing Trader',
        'bio': 'Medium-term trading strategies and market psychology expert',
        'rating': 4.7,
        'followers': 2100,
        'posts': 167,
        'accuracy': 79,
        'color': Color(0xFFAB47BC),
        'status': 'Active Now',
        'latest': 'Breakout trade setup on EUR/GBP 4H timeframe',
      },
    ];

    return Column(
      children: List.generate(
        analysts.length,
        (index) => Column(
          children: [
            _buildAnalystDetailCard(context, analysts[index]),
            if (index < analysts.length - 1) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalystDetailCard(BuildContext context, Map<String, dynamic> analyst) {
    return InkWell(
      onTap: () => Get.toNamed('/analyst-profile', arguments: analyst),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryWhite,
              AppColors.secondaryWhite.withOpacity(0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: analyst['color'].withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: analyst['color'].withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        analyst['color'],
                        analyst['color'].withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      analyst['name'].toString().substring(0, 1),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  analyst['name'],
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  analyst['title'],
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: analyst['color'].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '⭐ ${analyst['rating']}',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: analyst['color'],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          analyst['status'],
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bio
            Text(
              analyst['bio'],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: 'Followers',
                    value: '${analyst['followers']}',
                    icon: Iconsax.people_outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: 'Posts',
                    value: '${analyst['posts']}',
                    icon: Iconsax.document_outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: 'Accuracy',
                    value: '${analyst['accuracy']}%',
                    icon: Iconsax.percentage_circle_outline,
                    isAccuracy: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            Container(
              height: 1,
              color: AppColors.secondaryGrey.withOpacity(0.1),
            ),
            const SizedBox(height: 16),

            // Latest Post Preview
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest Analysis',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: analyst['color'].withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: analyst['color'].withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.chart_outline,
                        size: 16,
                        color: analyst['color'],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          analyst['latest'],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textPrimary,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Follow Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: analyst['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: analyst['color'],
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Follow',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: analyst['color'],
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: analyst['color'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Iconsax.message_outline,
                    color: AppColors.secondaryWhite,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool isAccuracy = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: isAccuracy ? AppColors.successGreen : AppColors.primaryGold,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
