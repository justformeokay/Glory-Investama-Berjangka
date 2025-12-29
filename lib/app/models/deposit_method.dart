import 'package:flutter/material.dart';

class DepositMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final double minAmount;
  final double maxAmount;
  final String processingTime;
  final double fee;
  final bool isAvailable;

  const DepositMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.minAmount,
    required this.maxAmount,
    required this.processingTime,
    this.fee = 0.0,
    this.isAvailable = true,
  });
}
