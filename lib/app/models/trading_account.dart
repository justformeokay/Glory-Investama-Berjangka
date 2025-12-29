class TradingAccount {
  final String id;
  final String accountNumber;
  final String accountType;
  final double balance;
  final double lockedBalance;
  final String currency;
  final bool isActive;

  const TradingAccount({
    required this.id,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    this.lockedBalance = 0.0,
    this.currency = 'USD',
    this.isActive = true,
  });

  double get availableBalance => balance - lockedBalance;

  String get formattedBalance {
    return '\$$balance';
  }

  String get formattedAvailableBalance {
    return '\$${availableBalance.toStringAsFixed(2)}';
  }
}
