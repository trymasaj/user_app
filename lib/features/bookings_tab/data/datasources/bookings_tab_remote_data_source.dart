import '../../../../core/service/network_service.dart';

abstract class BookingsTabRemoteDataSource {
 
}

class BookingsTabRemoteDataSourceImpl implements BookingsTabRemoteDataSource {
  final NetworkService _networkService;
  BookingsTabRemoteDataSourceImpl(this._networkService);
 
}
