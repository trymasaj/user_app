import '../../../../core/service/network_service.dart';

abstract class SettingsTabRemoteDataSource {
 
}

class SettingsTabRemoteDataSourceImpl implements SettingsTabRemoteDataSource {
  final NetworkService _networkService;
  SettingsTabRemoteDataSourceImpl(this._networkService);
 
}
