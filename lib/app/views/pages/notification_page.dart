import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../controllers/notification_controller.dart';
import '../../models/notification.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_outline),
          onPressed: () => Get.back(),
          color: AppColors.textPrimary,
        ),
        title: Text(
          'Notifikasi',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            final unreadCount = controller.getUnreadCount(null);
            if (unreadCount == 0) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PopupMenuButton<String>(
                icon: const Icon(Iconsax.more_outline),
                iconColor: AppColors.textPrimary,
                onSelected: (value) {
                  if (value == 'mark_all_read') {
                    controller.markAllAsRead();
                    Get.snackbar(
                      'Sukses',
                      'Semua notifikasi sudah ditandai sebagai terbaca',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else if (value == 'delete_all') {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text('Hapus Semua?'),
                        content: const Text(
                          'Apakah Anda yakin ingin menghapus semua notifikasi?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteAllNotifications();
                              Get.back();
                              Get.snackbar(
                                'Sukses',
                                'Semua notifikasi telah dihapus',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            },
                            child: const Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'mark_all_read',
                    child: Row(
                      children: [
                        Icon(Iconsax.tick_square_outline, size: 18),
                        SizedBox(width: 12),
                        Text('Tandai Semua Terbaca'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete_all',
                    child: Row(
                      children: [
                        Icon(Iconsax.trash_outline, size: 18, color: Colors.red),
                        SizedBox(width: 12),
                        Text(
                          'Hapus Semua',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          // Custom Tab Bar with Glassmorphic Design
          Container(
            color: AppColors.secondaryWhite,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.tabs.length,
                  (index) => Obx(() {
                    final isSelected = controller.selectedTab.value == index;
                    int unreadCount = 0;

                    if (index == 0) {
                      unreadCount = controller.getUnreadCount(null);
                    } else {
                      final types = [
                        NotificationType.promotion,
                        NotificationType.accountVerification,
                        NotificationType.security,
                        NotificationType.trading,
                        NotificationType.system,
                      ];
                      unreadCount =
                          controller.getUnreadCount(types[index - 1]);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          controller.tabController.animateTo(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryGold
                                : AppColors.secondaryLightGrey,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryGold
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                controller.tabs[index],
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (unreadCount > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primaryGold,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    unreadCount.toString(),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: isSelected
                                          ? AppColors.primaryGold
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: List.generate(
                controller.tabs.length,
                (index) => _buildNotificationList(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(NotificationController controller) {
    return Obx(() {
      final filteredNotifications =
          controller.getFilteredNotifications();

      if (filteredNotifications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.notification_bing_outline,
                size: 64,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak Ada Notifikasi',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Semua notifikasi akan muncul di sini',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredNotifications.length,
        itemBuilder: (context, index) {
          final notification = filteredNotifications[index];
          return _buildNotificationCard(notification, controller);
        },
      );
    });
  }

  Widget _buildNotificationCard(
    AppNotification notification,
    NotificationController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          if (!notification.isRead) {
            controller.markAsRead(notification.id);
          }
          if (notification.onAction != null) {
            notification.onAction!();
          }
        },
        child: Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    // Mengganti opacity dan backgroundColor dari Glassmorphic ke BoxDecoration
    color: (notification.isRead ? AppColors.secondaryGrey : const Color(0xFFD4AF37))
        .withOpacity(notification.isRead ? 0.05 : 0.12),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: notification.isRead
          ? Colors.white.withOpacity(0.2)
          : AppColors.primaryGold.withOpacity(0.5),
      width: 1.5,
    ),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Icon
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: notification.iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          notification.icon,
          color: notification.iconColor,
          size: 24,
        ),
      ),
      const SizedBox(width: 12),

      // Content
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Unread Indicator
            Row(
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!notification.isRead) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),

            // Message
            Text(
              notification.message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Time and Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.timeAgo,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                if (notification.actionLabel != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.actionLabel!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),

      // Delete Button
      GestureDetector(
        onTap: () {
          controller.deleteNotification(notification.id);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Iconsax.close_square_outline,
            color: AppColors.textTertiary,
            size: 20,
          ),
        ),
      ),
    ],
  ),
),
      ),
    );
  }
}
