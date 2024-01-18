part of 'bookings_tab_cubit.dart';

enum BookingsTabStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension BookingsTabStateX on BookingsTabState {
  bool get isInitial => status == BookingsTabStateStatus.initial;

  bool get isLoading => status == BookingsTabStateStatus.loading;

  bool get isLoaded => status == BookingsTabStateStatus.loaded;

  bool get isError => status == BookingsTabStateStatus.error;
}

@immutable
class BookingsTabState {
  final BookingsTabStateStatus status;
  final String? errorMessage;

  const BookingsTabState({
    this.status = BookingsTabStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BookingsTabState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  BookingsTabState copyWith({
    BookingsTabStateStatus? status,
    String? errorMessage,
  }) {
    return BookingsTabState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
