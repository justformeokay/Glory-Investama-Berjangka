import 'package:flutter/material.dart';

enum NotificationType {
  promotion,
  accountVerification,
  security,
  trading,
  system,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final IconData icon;
  final Color iconColor;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? imageUrl;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    required this.icon,
    required this.iconColor,
    this.actionLabel,
    this.onAction,
    this.imageUrl,
  });

  String get typeLabel {
    switch (type) {
      case NotificationType.promotion:
        return 'Promosi';
      case NotificationType.accountVerification:
        return 'Verifikasi Akun';
      case NotificationType.security:
        return 'Keamanan';
      case NotificationType.trading:
        return 'Trading';
      case NotificationType.system:
        return 'Sistem';
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h yang lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d yang lalu';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
