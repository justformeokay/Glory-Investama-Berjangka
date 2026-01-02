import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/notification.dart';

class NotificationController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  final notifications = <AppNotification>[].obs;
  final selectedTab = 0.obs;

  final List<String> tabs = [
    'Semua',
    'Promosi',
    'Verifikasi',
    'Keamanan',
    'Trading',
    'Sistem',
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      selectedTab.value = tabController.index;
    });
    _initializeNotifications();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void _initializeNotifications() {
    notifications.value = [
      // Promotion Notifications
      AppNotification(
        id: '1',
        title: 'Dapatkan Bonus 100% untuk Deposit Pertama',
        message: 'Setiap deposit Anda akan kami berikan bonus 100% hingga \$500. Promo berlaku hingga akhir bulan.',
        type: NotificationType.promotion,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
        icon: Iconsax.gift_outline,
        iconColor: const Color(0xFFFF6B6B),
        actionLabel: 'Lihat Promo',
      ),
      AppNotification(
        id: '2',
        title: 'Kontes Trading Dengan Hadiah Total \$10,000',
        message: 'Ikuti kontes trading bulan ini dan menangkan hadiah menarik. Total hadiah mencapai \$10,000 untuk top 10 trader.',
        type: NotificationType.promotion,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
        icon: Iconsax.medal_outline,
        iconColor: const Color(0xFFFFD93D),
      ),

      // Account Verification Notifications
      AppNotification(
        id: '3',
        title: 'Akun Real Anda Telah Diverifikasi',
        message: 'Selamat! Akun real MT5-654321 Anda telah berhasil diverifikasi. Anda sekarang dapat melakukan trading dengan deposit nyata.',
        type: NotificationType.accountVerification,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        icon: Iconsax.verify_outline,
        iconColor: const Color(0xFF00D084),
        actionLabel: 'Lihat Akun',
      ),
      AppNotification(
        id: '4',
        title: 'Demo Account Anda Telah Aktif',
        message: 'Demo account MT5-567890 telah berhasil dibuat dengan saldo awal \$100,000. Mulai latihan trading sekarang.',
        type: NotificationType.accountVerification,
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isRead: true,
        icon: Iconsax.book_outline,
        iconColor: const Color(0xFF1976D2),
      ),
      AppNotification(
        id: '5',
        title: 'Verifikasi KYC Diperlukan',
        message: 'Untuk meningkatkan limit trading, lengkapi verifikasi KYC Anda. Proses hanya membutuhkan waktu 5 menit.',
        type: NotificationType.accountVerification,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        icon: Iconsax.document_favorite_outline,
        iconColor: const Color(0xFFF57C00),
        actionLabel: 'Verifikasi Sekarang',
      ),

      // Security Notifications
      AppNotification(
        id: '6',
        title: 'Login Baru Terdeteksi',
        message: 'Akun Anda baru saja login dari iPhone di Jakarta pada pukul 14:30. Jika bukan Anda, segera ubah password.',
        type: NotificationType.security,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
        icon: Iconsax.shield_tick_outline,
        iconColor: const Color(0xFFFF6B6B),
        actionLabel: 'Ubah Password',
      ),
      AppNotification(
        id: '7',
        title: 'Aktifkan Two-Factor Authentication',
        message: '2FA meningkatkan keamanan akun Anda hingga 99%. Aktifkan sekarang untuk melindungi investasi Anda.',
        type: NotificationType.security,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
        icon: Iconsax.lock_1_outline,
        iconColor: const Color(0xFF1976D2),
        actionLabel: 'Aktifkan 2FA',
      ),

      // Trading Notifications
      AppNotification(
        id: '8',
        title: 'Signal Trading: BUY EURUSD',
        message: 'Signal strong untuk BUY EURUSD di level 1.0850. Target: 1.0920, Stop Loss: 1.0780',
        type: NotificationType.trading,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
        icon: Iconsax.chart_2_outline,
        iconColor: const Color(0xFF00D084),
      ),
      AppNotification(
        id: '9',
        title: 'Berita Pasar Penting: Fed Meeting',
        message: 'Federal Reserve akan mengumumkan keputusan suku bunga hari ini pukul 20:00 GMT. Bersiaplah untuk volatilitas.',
        type: NotificationType.trading,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
        icon: Iconsax.book_outline,
        iconColor: const Color(0xFFF57C00),
      ),
      AppNotification(
        id: '10',
        title: 'Trade Anda Closed dengan Profit',
        message: 'Posisi BUY GBPUSD Anda telah ditutup dengan profit \$245.50. Total balance sekarang \$8,665.75',
        type: NotificationType.trading,
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
        isRead: true,
        icon: Iconsax.chart_success_outline,
        iconColor: const Color(0xFF00D084),
      ),

      // System Notifications
      AppNotification(
        id: '11',
        title: 'Pembaruan Aplikasi Tersedia',
        message: 'Versi terbaru aplikasi GIFX (v2.5.0) sekarang tersedia. Dapatkan fitur baru dan perbaikan keamanan.',
        type: NotificationType.system,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        icon: Iconsax.refresh_circle_outline,
        iconColor: const Color(0xFF1976D2),
        actionLabel: 'Update Sekarang',
      ),
      AppNotification(
        id: '12',
        title: 'Maintenance Server Dijadwalkan',
        message: 'Server maintenance akan dilakukan pada 22:00 - 23:30 WIB. Anda tidak dapat trading selama periode ini.',
        type: NotificationType.system,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
        icon: Iconsax.setting_2_outline,
        iconColor: const Color(0xFFF57C00),
      ),
    ];
  }

  List<AppNotification> getFilteredNotifications() {
    if (selectedTab.value == 0) {
      return notifications;
    }

    final typeIndex = selectedTab.value - 1;
    final types = [
      NotificationType.promotion,
      NotificationType.accountVerification,
      NotificationType.security,
      NotificationType.trading,
      NotificationType.system,
    ];

    return notifications
        .where((n) => n.type == types[typeIndex])
        .toList();
  }

  int getUnreadCount(NotificationType? type) {
    if (type == null) {
      return notifications.where((n) => !n.isRead).length;
    }
    return notifications
        .where((n) => n.type == type && !n.isRead)
        .length;
  }

  void markAsRead(String notificationId) {
    final index =
        notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final notification = notifications[index];
      notifications[index] = AppNotification(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        type: notification.type,
        timestamp: notification.timestamp,
        isRead: true,
        icon: notification.icon,
        iconColor: notification.iconColor,
        actionLabel: notification.actionLabel,
        onAction: notification.onAction,
        imageUrl: notification.imageUrl,
      );
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    final updatedNotifications = notifications.map((n) {
      return AppNotification(
        id: n.id,
        title: n.title,
        message: n.message,
        type: n.type,
        timestamp: n.timestamp,
        isRead: true,
        icon: n.icon,
        iconColor: n.iconColor,
        actionLabel: n.actionLabel,
        onAction: n.onAction,
        imageUrl: n.imageUrl,
      );
    }).toList();
    notifications.value = updatedNotifications;
  }

  void deleteNotification(String notificationId) {
    notifications.removeWhere((n) => n.id == notificationId);
  }

  void deleteAllNotifications() {
    notifications.clear();
  }
}
