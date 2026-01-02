class InternalTransfer {
  final String id;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final DateTime timestamp;
  final String status; // 'pending', 'completed', 'failed'
  final String? description;

  const InternalTransfer({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.timestamp,
    this.status = 'pending',
    this.description,
  });
}
