enum PaymentStatus {
  Initiated,
  Pending,
  Authorized,
  Captured,
  Failed,
  Timeout,
}

extension PaymentStatusExtension on PaymentStatus {
  String get name {
    switch (this) {
      case PaymentStatus.Initiated:
        return 'initiated';
      case PaymentStatus.Pending:
        return 'pending';
      case PaymentStatus.Authorized:
        return 'Authorized';
      case PaymentStatus.Captured:
        return 'success';
      case PaymentStatus.Failed:
        return 'failed';
      case PaymentStatus.Timeout:
        return 'timeout';
      default:
        return '';
    }
  }
}
