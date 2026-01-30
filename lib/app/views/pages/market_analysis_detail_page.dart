import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';

class MarketAnalysisDetailPage extends StatefulWidget {
  final String? analystName;
  final String? analysisTitle;
  final Color? color;

  const MarketAnalysisDetailPage({
    super.key,
    this.analystName,
    this.analysisTitle,
    this.color,
  });

  @override
  State<MarketAnalysisDetailPage> createState() => _MarketAnalysisDetailPageState();
}

class _MarketAnalysisDetailPageState extends State<MarketAnalysisDetailPage> {
  late bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.successGreen;
    final analystName = widget.analystName ?? 'Sarah Mitchell';
    final analysisTitle = widget.analysisTitle ?? 'EUR/USD Bullish Pattern';

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
          'Market Analysis',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Analyst Profile Header
              _buildAnalystHeader(context, analystName, color),
              const SizedBox(height: 24),

              // Analysis Title & Recommendation
              _buildAnalysisTitle(context, analysisTitle, color),
              const SizedBox(height: 24),

              // Key Levels
              _buildKeyLevels(context, color),
              const SizedBox(height: 24),

              // Risk Analysis
              _buildRiskAnalysis(context, color),
              const SizedBox(height: 24),

              // Technical Indicators
              _buildTechnicalIndicators(context, color),
              const SizedBox(height: 24),

              // Analysis Details
              _buildAnalysisDetails(context, color),
              const SizedBox(height: 24),

              // Call to Action
              _buildFollowButton(context, color),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalystHeader(BuildContext context, String analystName, Color color) {
    return Container(
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
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.6)],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Iconsax.user_outline,
                    color: AppColors.secondaryWhite,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Analyst Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      analystName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Senior Market Analyst',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Iconsax.star_1_outline,
                                  color: color, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                '4.8 (126 reviews)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Iconsax.people_outline,
                                  color: AppColors.primaryGold, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                '2.3K followers',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGold,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTitle(BuildContext context, String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.arrow_up_3_outline,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'STRONG BUY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Strong support at 1.0820, expect breakout soon. Price action suggests bullish continuation pattern with target at 1.0950.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
        ),
      ],
    );
  }

  Widget _buildKeyLevels(BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Levels',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLevelCard(
                context,
                label: 'RESISTANCE',
                value: '1.0950',
                change: '+1.26%',
                icon: Iconsax.arrow_up_outline,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildLevelCard(
                context,
                label: 'SUPPORT',
                value: '1.0820',
                change: '-0.29%',
                icon: Iconsax.arrow_down_outline,
                color: AppColors.errorRed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildLevelCard(
                context,
                label: 'ENTRY',
                value: '1.0845',
                change: 'Current',
                icon: Iconsax.tick_circle_outline,
                color: AppColors.infoBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelCard(
    BuildContext context, {
    required String label,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      fontSize: 9,
                    ),
              ),
              Icon(icon, color: color, size: 14),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAnalysis(BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Analysis',
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
          child: Column(
            children: [
              _buildRiskItem(
                context,
                label: 'Risk Reward Ratio',
                value: '1:3.5',
                progress: 0.78,
              ),
              const SizedBox(height: 12),
              _buildRiskItem(
                context,
                label: 'Win Rate',
                value: '72%',
                progress: 0.72,
              ),
              const SizedBox(height: 12),
              _buildRiskItem(
                context,
                label: 'Accuracy',
                value: '78%',
                progress: 0.78,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskItem(
    BuildContext context, {
    required String label,
    required String value,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.secondaryGrey.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 0.7
                  ? AppColors.successGreen
                  : progress > 0.4
                      ? AppColors.primaryGold
                      : AppColors.errorRed,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicalIndicators(BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technical Indicators',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        _buildIndicatorCard(
          context,
          indicator: 'RSI (14)',
          value: '65',
          status: 'Neutral',
          statusColor: AppColors.primaryGold,
        ),
        const SizedBox(height: 8),
        _buildIndicatorCard(
          context,
          indicator: 'MACD',
          value: 'Bullish',
          status: 'Positive Divergence',
          statusColor: color,
        ),
        const SizedBox(height: 8),
        _buildIndicatorCard(
          context,
          indicator: 'Moving Averages',
          value: 'Above MA200',
          status: 'Bullish Signal',
          statusColor: color,
        ),
        const SizedBox(height: 8),
        _buildIndicatorCard(
          context,
          indicator: 'Bollinger Bands',
          value: 'Mid-Upper Band',
          status: 'Consolidation',
          statusColor: AppColors.infoBlue,
        ),
      ],
    );
  }

  Widget _buildIndicatorCard(
    BuildContext context, {
    required String indicator,
    required String value,
    required String status,
    required Color statusColor,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                indicator,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisDetails(BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analysis Details',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(
                context,
                title: 'Technical Setup',
                description:
                    'Formation of higher lows and higher highs with strong volume confirmation. Price breaking above recent resistance suggests continuation of uptrend.',
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: AppColors.secondaryGrey.withOpacity(0.1),
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                context,
                title: 'Market Sentiment',
                description:
                    'Bullish sentiment driven by positive macroeconomic data. Institutional buy orders detected at key support levels.',
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: AppColors.secondaryGrey.withOpacity(0.1),
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                context,
                title: 'Time Frame',
                description: 'Analysis valid on 4H timeframe. Watch for pullback to MA20 as re-entry opportunity.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
        ),
      ],
    );
  }

  Widget _buildFollowButton(BuildContext context, Color color) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isFollowing = !isFollowing;
              });
              Get.showSnackbar(
                GetSnackBar(
                  title: isFollowing ? 'Following' : 'Unfollowed',
                  message: isFollowing
                      ? 'You are now following this analyst'
                      : 'You unfollowed this analyst',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? color : AppColors.secondaryWhite,
              foregroundColor:
                  isFollowing ? AppColors.secondaryWhite : color,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: color,
                  width: 1.5,
                ),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isFollowing ? Iconsax.check_outline : Iconsax.add_outline,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  isFollowing ? 'Following' : 'Follow Analyst',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isFollowing
                            ? AppColors.secondaryWhite
                            : color,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.secondaryGrey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: IconButton(
            onPressed: () {
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Shared',
                  message: 'Analysis shared successfully',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(
              Iconsax.share_outline,
              color: color,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
