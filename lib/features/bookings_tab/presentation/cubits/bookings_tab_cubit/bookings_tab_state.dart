part of 'bookings_tab_cubit.dart';

enum BookingsTabStateStatus {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
  isRefreshing
}

// enum BookingsTabStateType {
//   upComaing('upcoming'),
//   completed('completed');

//   final String name;

//   const BookingsTabStateType(this.name);
// }

extension BookingsTabStateX on BookingsTabState {
  bool get isInitial => status == BookingsTabStateStatus.initial;

  bool get isLoading => status == BookingsTabStateStatus.loading;

  bool get isLoaded => status == BookingsTabStateStatus.loaded;

  bool get isError => status == BookingsTabStateStatus.error;
  bool get isLoadingMore => status == BookingsTabStateStatus.loadingMore;
  bool get isRefreshing => status == BookingsTabStateStatus.isRefreshing;
}

@immutable
class BookingsTabState {
  final BookingsTabStateStatus status;
  final String? errorMessage;
  final BookingQueryStatus type;
  final int? page;
  final int? pageSize;
  final List<SessionModel> sessions;
  const BookingsTabState(
      {this.status = BookingsTabStateStatus.initial,
      this.errorMessage,
      this.page,
      this.sessions = const [],
      this.pageSize = 10,
      this.type = BookingQueryStatus.completed});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BookingsTabState).status == status &&
        other.type == type &&
        other.errorMessage == errorMessage &&
        other.sessions == sessions &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      type.hashCode ^
      page.hashCode ^
      pageSize.hashCode ^
      sessions.hashCode;

  BookingsTabState copyWith({
    BookingsTabStateStatus? status,
    String? errorMessage,
    BookingQueryStatus? type,
    int? page,
    int? pageSize,
    List<SessionModel>? sessions,
  }) {
    return BookingsTabState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      type: type ?? this.type,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sessions: sessions ?? this.sessions,
    );
  }
}
