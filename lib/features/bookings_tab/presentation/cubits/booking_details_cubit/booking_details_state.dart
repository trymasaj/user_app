part of 'booking_details_cubit.dart';

enum BookingDetailsStatus {
  intial,
  loading,
  success,
  error,
}

extension BookingDetailsStatusX on BookingDetailsState {
  bool get isInitial => status == BookingDetailsStatus.intial;
  bool get isLoading => status == BookingDetailsStatus.loading;
  bool get isSuccess => status == BookingDetailsStatus.success;
  bool get isError => status == BookingDetailsStatus.error;
}

class BookingDetailsState {
  final BookingDetailsStatus status;
  final BookingModel? booking;
  final String? error;

  const BookingDetailsState({
    required this.status,
    this.booking,
    this.error,
  });

  factory BookingDetailsState.initial() {
    return const BookingDetailsState(
      status: BookingDetailsStatus.loading,
    );
  }

  BookingDetailsState copyWith({
    BookingDetailsStatus? status,
    BookingModel? booking,
    String? error,
  }) {
    return BookingDetailsState(
      status: status ?? this.status,
      booking: booking ?? this.booking,
      error: error ?? this.error,
    );
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookingDetailsState &&
      other.status == status &&
      other.booking == booking &&
      other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ booking.hashCode ^ error.hashCode;

  @override
  String toString() => 'BookingDetailsState(status: $status, booking: $booking, error: $error)';
}
