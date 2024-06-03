import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/home/data/models/message_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<MessagesModel>> getNotifications(MessageReadType messageReadType);
  Future<void> markAsRead(int messageId);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NetworkService _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<MessagesModel>> getNotifications(
      MessageReadType messageReadType) {
    const url = ApiEndPoint.MESSAGES;
    final params = {
      'messageReadType': messageReadType.name,
    };
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
      final result = response.data;
      return List<MessagesModel>.from(
          result.map((x) => MessagesModel.fromJson(x)));
    });
  }

  @override
  Future<void> markAllAsRead() async {
    const url = ApiEndPoint.MESSAGES;

    await _networkService.get(url);
  }

  @override
  Future<void> markAsRead(int messageId) {
    final url = '${ApiEndPoint.MESSAGES}/$messageId/mark-read';
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException.fromStatusCode(
            statusCode: response.statusCode!, response: response.data);
      }
    });
  }
}
