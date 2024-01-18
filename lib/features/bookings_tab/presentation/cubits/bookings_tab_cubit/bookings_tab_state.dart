part of 'bookings_tab_cubit.dart';

enum BookingsTabStateStatus {
  initial,
  loading,
  loaded,
  error,
}

enum BookingsTabStateType {
  upComaing('upcoming'),
  completed('completed');

  final String name;

  const BookingsTabStateType(this.name);
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
  final BookingsTabStateType type;

  const BookingsTabState(
      {this.status = BookingsTabStateStatus.initial,
      this.errorMessage,
      th,
      this.type = BookingsTabStateType.upComaing});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BookingsTabState).status == status &&
        other.type == type &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  BookingsTabState copyWith({
    BookingsTabStateStatus? status,
    String? errorMessage,
    BookingsTabStateType? type,
  }) {
    return BookingsTabState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      type: type ?? this.type,
    );
  }
}
