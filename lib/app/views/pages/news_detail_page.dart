import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        title: const Text('Market News'),
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
              // Search and Category Filter
              _buildSearchCategory(context),
              const SizedBox(height: 24),

              // News List
              _buildNewsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCategory(BuildContext context) {
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
                    hintText: 'Search news...',
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

        // Category Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryChip('All', isActive: true, color: AppColors.primaryGold),
              const SizedBox(width: 12),
              _buildCategoryChip('Economic', color: AppColors.infoBlue),
              const SizedBox(width: 12),
              _buildCategoryChip('Policy', color: AppColors.errorRed),
              const SizedBox(width: 12),
              _buildCategoryChip('Strategy', color: AppColors.successGreen),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, {bool isActive = false, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? color : AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? color : color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.secondaryWhite : color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildNewsList(BuildContext context) {
    final newsList = [
      {
        'title': 'ECB Holds Interest Rates at 4.5%',
        'summary':
            'European Central Bank maintained its benchmark rate, citing persistent inflation concerns and stable employment data.',
        'content':
            'The ECB governing council unanimously voted to keep rates unchanged at 4.5%, maintaining its hawkish stance. Policymakers noted that while inflation has decreased from peak levels, core inflation remains above their 2% target.',
        'source': 'Reuters',
        'author': 'Michael Chen',
        'date': '2 hours ago',
        'category': 'Economic',
        'categoryColor': AppColors.infoBlue,
        'image': 'https://via.placeholder.com/400x200',
        'views': 2450,
        'shares': 340,
        'icon': Iconsax.trend_up_outline,
      },
      {
        'title': 'Fed Minutes Show Hawkish Stance',
        'summary':
            'Federal Reserve officials signaled potential rate hikes in upcoming meetings amid persistent inflation.',
        'content':
            'The latest FOMC minutes reveal that several officials expressed concerns about premature rate cuts. The discussion centered on the resilience of inflation and its potential implications for monetary policy moving forward.',
        'source': 'Bloomberg',
        'author': 'Sarah Williams',
        'date': '4 hours ago',
        'category': 'Policy',
        'categoryColor': AppColors.errorRed,
        'image': 'https://via.placeholder.com/400x200',
        'views': 3120,
        'shares': 520,
        'icon': Iconsax.warning_2_outline,
      },
      {
        'title': 'Bank of Japan Signals Long-Term Changes',
        'summary':
            'BoJ hints at potential monetary policy adjustments for 2026, considering exit strategy from ultra-loose policies.',
        'content':
            'Governor Ueda suggested that the bank would gradually normalize its monetary policy stance. Market participants are closely watching for any signals about timeline and pace of potential interest rate increases.',
        'source': 'Financial Times',
        'author': 'James Robertson',
        'date': '6 hours ago',
        'category': 'Strategy',
        'categoryColor': AppColors.successGreen,
        'image': 'https://via.placeholder.com/400x200',
        'views': 1890,
        'shares': 280,
        'icon': Iconsax.chart_outline,
      },
      {
        'title': 'USD Strengthens on Robust Jobs Report',
        'summary':
            'U.S. added 250,000 new jobs in December, beating expectations and supporting dollar strength.',
        'content':
            'The employment data exceeded analyst forecasts with robust job creation across multiple sectors. Unemployment remained at historic lows, reinforcing the Fed\'s cautious approach to interest rate policy.',
        'source': 'CNBC',
        'author': 'Emma Thompson',
        'date': '8 hours ago',
        'category': 'Economic',
        'categoryColor': AppColors.infoBlue,
        'image': 'https://via.placeholder.com/400x200',
        'views': 4520,
        'shares': 650,
        'icon': Iconsax.trend_up_outline,
      },
    ];

    return Column(
      children: List.generate(
        newsList.length,
        (index) => Column(
          children: [
            _buildNewsCard(context, newsList[index]),
            if (index < newsList.length - 1) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, Map<String, dynamic> news) {
    return InkWell(
      onTap: () => Get.toNamed('/news-article', arguments: news),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryGrey.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Overlay
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        news['categoryColor'],
                        news['categoryColor'].withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      news['icon'],
                      size: 60,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: news['categoryColor'],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: news['categoryColor'].withOpacity(0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      news['category'],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondaryWhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    news['title'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Summary
                  Text(
                    news['summary'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Container(
                    height: 1,
                    color: AppColors.secondaryGrey.withOpacity(0.1),
                  ),
                  const SizedBox(height: 12),

                  // Footer Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news['source'],
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: news['categoryColor'],
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            news['date'],
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.eye_outline,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${news['views']}',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(
                                Iconsax.share_outline,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${news['shares']}',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
