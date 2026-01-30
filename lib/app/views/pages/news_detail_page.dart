import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class NewsDetailPage extends StatefulWidget {
  final String? title;
  final String? summary;
  final String? source;
  final String? time;
  final Color? categoryColor;
  final String? category;

  const NewsDetailPage({
    super.key,
    this.title,
    this.summary,
    this.source,
    this.time,
    this.categoryColor,
    this.category,
  });

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final categoryColor = widget.categoryColor ?? AppColors.infoBlue;
    final title = widget.title ?? 'ECB Holds Interest Rates at 4.5%';
    final source = widget.source ?? 'Reuters';
    final category = widget.category ?? 'Economic';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_1_outline,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Market News',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.favorite : Icons.favorite_border,
              color: isBookmarked ? AppColors.errorRed : AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
              Get.showSnackbar(
                GetSnackBar(
                  title: isBookmarked ? 'Liked' : 'Removed',
                  message: isBookmarked
                      ? 'Article added to favorites'
                      : 'Article removed from favorites',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              _buildHeroImage(context, categoryColor),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Article Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Article Meta Info
                    _buildArticleMeta(context, source, categoryColor),
                    const SizedBox(height: 24),

                    // Key Highlights
                    _buildKeyHighlights(context, categoryColor),
                    const SizedBox(height: 24),

                    // Article Body
                    _buildArticleBody(context),
                    const SizedBox(height: 24),

                    // Impact Analysis
                    _buildImpactAnalysis(context, categoryColor),
                    const SizedBox(height: 24),

                    // Market Reaction
                    _buildMarketReaction(context, categoryColor),
                    const SizedBox(height: 24),

                    // Related News
                    _buildRelatedNews(context, categoryColor),
                    const SizedBox(height: 24),

                    // Share Actions
                    _buildShareActions(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, Color categoryColor) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withOpacity(0.3),
            categoryColor.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Iconsax.document_outline,
            size: 80,
            color: categoryColor.withOpacity(0.5),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.eye_outline,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '2.5K views',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleMeta(
    BuildContext context,
    String source,
    Color categoryColor,
  ) {
    return Row(
      children: [
        // Source Avatar
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [categoryColor, categoryColor.withOpacity(0.6)],
            ),
          ),
          child: Center(
            child: Icon(
              Iconsax.global_outline,
              color: AppColors.secondaryWhite,
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
                source,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Iconsax.clock_outline,
                    size: 12,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '2 hours ago',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Iconsax.document_outline,
                    size: 12,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '5 min read',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyHighlights(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Highlights',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        _buildHighlightItem(
          context,
          'ECB maintains current monetary policy stance at 4.5%',
          categoryColor,
        ),
        const SizedBox(height: 8),
        _buildHighlightItem(
          context,
          'Persistent inflation concerns continue to impact decision',
          categoryColor,
        ),
        const SizedBox(height: 8),
        _buildHighlightItem(
          context,
          'Euro strengthens against major currencies following announcement',
          categoryColor,
        ),
      ],
    );
  }

  Widget _buildHighlightItem(
    BuildContext context,
    String text,
    Color categoryColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: categoryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildArticleBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Story',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.secondaryGrey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Text(
            'The European Central Bank announced its latest monetary policy decision today, maintaining the benchmark interest rate at 4.5%. This decision reflects the ECB\'s cautious approach to inflation management while supporting economic growth.\n\nMarket analysts suggest this pause in rate adjustments indicates the ECB may be reaching its peak rates cycle. However, future decisions will depend on incoming economic data and inflation trends.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Widget _buildImpactAnalysis(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Impact Analysis',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        _buildImpactCard(
          context,
          title: 'EUR/USD',
          impact: '+0.45%',
          trend: 'Positive',
          icon: Iconsax.arrow_up_outline,
          color: AppColors.successGreen,
        ),
        const SizedBox(height: 8),
        _buildImpactCard(
          context,
          title: 'European Banks',
          impact: '-0.32%',
          trend: 'Negative',
          icon: Iconsax.arrow_down_outline,
          color: AppColors.errorRed,
        ),
        const SizedBox(height: 8),
        _buildImpactCard(
          context,
          title: 'DAX Index',
          impact: '+0.18%',
          trend: 'Neutral',
          icon: Iconsax.arrow_up_outline,
          color: AppColors.infoBlue,
        ),
      ],
    );
  }

  Widget _buildImpactCard(
    BuildContext context, {
    required String title,
    required String impact,
    required String trend,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  trend,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              impact,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketReaction(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Market Reaction',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: categoryColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReactionItem(context, 'Bullish Sentiment', '62%'),
              const SizedBox(height: 12),
              _buildReactionItem(context, 'Neutral', '25%'),
              const SizedBox(height: 12),
              _buildReactionItem(context, 'Bearish Sentiment', '13%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReactionItem(
    BuildContext context,
    String reaction,
    String percentage,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            reaction,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryGold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            percentage,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGold,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedNews(BuildContext context, Color categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related News',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        _buildRelatedNewsCard(
          context,
          title: 'Fed Minutes Show Hawkish Stance',
          time: '4 hours ago',
          color: AppColors.errorRed,
        ),
        const SizedBox(height: 8),
        _buildRelatedNewsCard(
          context,
          title: 'Bank of Japan Signals Long-Term Changes',
          time: '6 hours ago',
          color: AppColors.successGreen,
        ),
        const SizedBox(height: 8),
        _buildRelatedNewsCard(
          context,
          title: 'UK Inflation Data Beats Forecast',
          time: '8 hours ago',
          color: AppColors.infoBlue,
        ),
      ],
    );
  }

  Widget _buildRelatedNewsCard(
    BuildContext context, {
    required String title,
    required String time,
    required Color color,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_1_outline,
              size: 14,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context,
            icon: Iconsax.share_outline,
            label: 'Share',
            onTap: () {
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Shared',
                  message: 'Article shared successfully',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            context,
            icon: Iconsax.copy_outline,
            label: 'Copy Link',
            onTap: () {
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Copied',
                  message: 'Link copied to clipboard',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            context,
            icon: Iconsax.message_outline,
            label: 'Comment',
            onTap: () {
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Comments',
                  message: 'Comments feature coming soon',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.secondaryGrey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryGold, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
