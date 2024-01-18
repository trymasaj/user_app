import 'package:masaj/features/home/data/models/notification.dart';

enum NotificationsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  refreshing,
  error
}

extension NotificationsStatusX on NotificationsState {
  bool get isInitial => status == NotificationsStateStatus.initial;
  bool get isLoading => status == NotificationsStateStatus.loading;
  bool get isLoaded => status == NotificationsStateStatus.loaded;
  bool get isError => status == NotificationsStateStatus.error;
  bool get isLoadingMore => status == NotificationsStateStatus.loadingMore;
  bool get isRefreshing => status == NotificationsStateStatus.refreshing;
}

class NotificationsState {
  final NotificationsStateStatus status;
  final String? message;
  final NotificationsModel? allNotification;

  const NotificationsState({
    this.status = NotificationsStateStatus.initial,
    this.message,
    this.allNotification,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationsState &&
        other.status == status &&
        other.message == message &&
        other.allNotification == allNotification;
  }

  @override
  int get hashCode =>
      status.hashCode ^ message.hashCode ^ allNotification.hashCode;

  NotificationsState copyWith({
    NotificationsStateStatus? status,
    String? message,
    NotificationsModel? allNotification,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      message: message ?? this.message,
      allNotification: allNotification ?? this.allNotification,
    );
  }
}
