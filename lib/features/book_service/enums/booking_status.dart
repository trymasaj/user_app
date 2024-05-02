enum BookingStatus {
  Pending ('pending'),
  Scheduled ('pcheduled'),
  Rescheduled ('Rescheduled'),
  InProgress ('inProgress'),
  Completed ('completed'),
  Cancelled ('cancelled'),
  Confirmed ('confirmed');
  final String name;
  const BookingStatus(this.name);
}

extension BookingStatusExtension on BookingStatus {
  String get name {
    switch (this) {
      case BookingStatus.Pending:
        return 'Pending';
      case BookingStatus.Scheduled:
        return 'Scheduled';
      case BookingStatus.Rescheduled:
        return 'Rescheduled';
      case BookingStatus.InProgress:
        return 'In Progress';
      case BookingStatus.Completed:
        return 'Completed';
      case BookingStatus.Cancelled:
        return 'Cancelled';
      case BookingStatus.Confirmed:
        return 'Confirmed';
      default:
        return '';
    }
  }

  bool get isPending => this == BookingStatus.Pending;
  bool get isScheduled => this == BookingStatus.Scheduled;
  bool get isRescheduled => this == BookingStatus.Rescheduled;
  bool get isInProgress => this == BookingStatus.InProgress;
  bool get isCompleted => this == BookingStatus.Completed;
  bool get isCancelled => this == BookingStatus.Cancelled;
  bool get isConfirmed => this == BookingStatus.Confirmed;
}
