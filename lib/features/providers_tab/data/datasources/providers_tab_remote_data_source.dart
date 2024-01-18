import 'package:masaj/core/data/clients/network_service.dart';

abstract class ProvidersTabRemoteDataSource {
 
}

class ProvidersTabRemoteDataSourceImpl implements ProvidersTabRemoteDataSource {
  final NetworkService _networkService;
  ProvidersTabRemoteDataSourceImpl(this._networkService);
 
}
