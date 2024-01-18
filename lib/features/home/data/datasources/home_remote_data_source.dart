import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/home/data/models/event.dart';
import 'package:masaj/features/home/data/models/home_data.dart';
import 'package:masaj/features/home/data/models/notification.dart';

abstract class HomeRemoteDataSource {
  Future<HomeData> getHomePageData();

  Future<Events> getHomeSearch({
    required String text,
    int? cursor,
    int pageSize = 10,
  });

  Future<NotificationsModel> getAllNotifications({int? cursor});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeData> getHomePageData() {
    const url = ApiEndPoint.GET_HOME_PAGE_DATA;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return HomeData.fromMap(result['data']);
    });
  }

  @override
  Future<Events> getHomeSearch({
    required String text,
    int? cursor,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.GET_HOME_SEARCH;

    final params = {
      'text': text,
      if (cursor != null) 'cursor': cursor,
      'pageSize': pageSize,
    };
    return _networkService
        .post(url, queryParameters: params)
        .then((response) async {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return Events.fromMap(result['data']);
    });
  }

  @override
  Future<NotificationsModel> getAllNotifications({int? cursor}) {
    const url = ApiEndPoint.GET_HOME_NOTIFICATIONS;

    final params = {
      if (cursor != null) 'cursor': cursor,
    };
    return _networkService
        .get(url, queryParameters: params)
        .then((response) async {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return NotificationsModel.fromMap(result['data']);
    });
  }
}
