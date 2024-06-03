import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masaj/features/home/data/models/message_model.dart';
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
  final List<MessagesModel> notifications ;

  const NotificationsState({
    this.status = NotificationsStateStatus.initial,
    this.message,
    this.allNotification,
    this.notifications = const [],
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationsState &&
        other.status == status &&
        other.message == message &&
        other.allNotification == allNotification
        && other.notifications == notifications;
  }

  @override
  int get hashCode =>
      status.hashCode ^ message.hashCode ^ allNotification.hashCode
      ^ notifications.hashCode;

  NotificationsState copyWith({
    NotificationsStateStatus? status,
    String? message,
    NotificationsModel? allNotification,
    List<MessagesModel>? notifications,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      message: message ?? this.message,
      allNotification: allNotification ?? this.allNotification,
      notifications: notifications ?? this.notifications,
    );
  }
}
