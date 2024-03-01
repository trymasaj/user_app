import 'package:masaj/features/home/data/datasources/home_local_data_source.dart';
import 'package:masaj/features/home/data/datasources/home_remote_data_source.dart';
import 'package:masaj/features/home/data/models/event.dart';
import 'package:masaj/features/home/data/models/home_data.dart';
import 'package:masaj/features/home/data/models/home_search_reponse.dart';
import 'package:masaj/features/home/data/models/notification.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

abstract class HomeRepository {
  Future<HomeSearchResponse> search({required String keyWord});

  Future<HomeData> getHomePageData();
  Future<bool> saveRecentService(ServiceModel service);
  Future<List<ServiceModel>> getRecentServices();
  Future<bool> removeRecentService(ServiceModel service);

  Future<Events> getHomeSearch({
    required String text,
    int? cursor,
    int pageSize = 10,
  });

  Future<NotificationsModel> getAllNotifications({
    int? cursor,
  });
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDatasource _homeLocalDatasource;

  HomeRepositoryImpl(
      {required HomeRemoteDataSource homeRemoteDataSource,
      required HomeLocalDatasource homeLocalDatasource})
      : _homeRemoteDataSource = homeRemoteDataSource,
        _homeLocalDatasource = homeLocalDatasource;

  @override
  Future<HomeData> getHomePageData() => _homeRemoteDataSource.getHomePageData();

  @override
  Future<Events> getHomeSearch({
    required String text,
    int? cursor,
    int pageSize = 10,
  }) =>
      _homeRemoteDataSource.getHomeSearch(
        text: text,
        cursor: cursor,
        pageSize: pageSize,
      );

  @override
  Future<NotificationsModel> getAllNotifications({
    int? cursor,
  }) =>
      _homeRemoteDataSource.getAllNotifications(
        cursor: cursor,
      );

  @override
  Future<HomeSearchResponse> search({required String keyWord}) async {
    return await _homeRemoteDataSource.search(keyWord: keyWord);
  }

  @override
  Future<List<ServiceModel>> getRecentServices() async {
    return await _homeLocalDatasource.getRecentServices();
  }

  @override
  Future<bool> saveRecentService(ServiceModel service) async {
    return await _homeLocalDatasource.saveRecentService(service);
  }

  @override
  Future<bool> removeRecentService(ServiceModel service) async {
    return await _homeLocalDatasource.removeRecentService(service);
  }
}
