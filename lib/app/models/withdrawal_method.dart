import 'package:flutter/material.dart';

class WithdrawalMethod {
  final String id;
  final String name;
  final String accountNumber;
  final String accountName;
  final IconData icon;
  final bool isPrimary;
  final String type; // 'bank', 'ewallet', 'crypto'

  const WithdrawalMethod({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.accountName,
    required this.icon,
    this.isPrimary = false,
    required this.type,
  });

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    final last4 = accountNumber.substring(accountNumber.length - 4);
    return '****$last4';
  }
}
