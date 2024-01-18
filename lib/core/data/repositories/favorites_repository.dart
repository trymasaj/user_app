import 'package:masaj/core/data/datasources/favorites_remote_data_source.dart';
import 'package:masaj/features/home/data/models/event.dart';

abstract class FavoritesRepository {
  Future<List<Event>> getFavorites({int take = 10, int skip = 0});

  Future<void> addToFav(int id);

  Future<void> removeFromFav(int id);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  }) : _remoteDataSource = favoritesRemoteDataSource;

  @override
  Future<List<Event>> getFavorites({int take = 10, int skip = 0}) =>
      _remoteDataSource.getFavorites(
        take: take,
        skip: skip,
      );

  @override
  Future<void> addToFav(int id) => _remoteDataSource.addToFav(id);

  @override
  Future<void> removeFromFav(int id) => _remoteDataSource.removeFromFav(id);
}
