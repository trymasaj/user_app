import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/home/data/models/event.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<Event>> getFavorites({
    int take = 10,
    int skip = 0,
  });

  Future<void> addToFav(int id);

  Future<void> removeFromFav(int id);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final NetworkService _networkService;

  FavoritesRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<Event>> getFavorites({
    int take = 10,
    int skip = 0,
  }) {
    const url = ApiEndPoint.FAVORITES;

    final params = {'take': take, 'skip': skip};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode)) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      final data = result['data'] as List;
      return data.map((e) => Event.fromMap(e)).toList();
    });
  }

  @override
  Future<void> addToFav(int id) {
    return _addOrRemove(id);
  }

  @override
  Future<void> removeFromFav(int id) {
    return _addOrRemove(id);
  }

  Future<void> _addOrRemove(int id) {
    const url = ApiEndPoint.ADD_OR_REMOVE_FAV;
    final params = {'eventId': id};
    return _networkService.post(url, queryParameters: params).then((response) {
      if (response.statusCode != 200)
        throw RequestException(message: response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
    });
  }
}
