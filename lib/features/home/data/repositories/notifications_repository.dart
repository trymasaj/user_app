import 'package:masaj/features/home/data/datasources/notifications_remote_datasource.dart';
import 'package:masaj/features/home/data/models/message_model.dart';

abstract class NotificationsRepository {
  final NotificationsRemoteDataSource _notificationsDataSource;

  NotificationsRepository(this._notificationsDataSource);
  Future<List<MessagesModel>> getNotifications(MessageReadType messageReadType);
  Future<void> markAsRead(int messageId);
  Future<void> markAllAsRead();
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _notificationsDataSource;

  NotificationsRepositoryImpl(this._notificationsDataSource);

  @override
  Future<List<MessagesModel>> getNotifications(
      MessageReadType messageReadType) {
    return _notificationsDataSource.getNotifications(messageReadType);
  }

  @override
  Future<void> markAllAsRead() {
    return _notificationsDataSource.markAllAsRead();
  }

  @override
  Future<void> markAsRead(int messageId) {
    return _notificationsDataSource.markAsRead(messageId);
  }
}
