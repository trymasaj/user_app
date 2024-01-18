import 'package:masaj/features/home/data/datasources/home_remote_data_source.dart';
import 'package:masaj/features/home/data/models/event.dart';
import 'package:masaj/features/home/data/models/home_data.dart';
import 'package:masaj/features/home/data/models/notification.dart';

abstract class HomeRepository {
  Future<HomeData> getHomePageData();
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
  HomeRepositoryImpl({required HomeRemoteDataSource homeRemoteDataSource})
      : _homeRemoteDataSource = homeRemoteDataSource;

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
}
