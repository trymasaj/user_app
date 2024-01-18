import 'package:masaj/features/providers_tab/data/datasources/providers_tab_remote_data_source.dart';

abstract class ProvidersTabRepository {

}

class ProvidersTabRepositoryImpl implements ProvidersTabRepository {
  final ProvidersTabRemoteDataSource _remoteDataSource;

  ProvidersTabRepositoryImpl({
    required ProvidersTabRemoteDataSource providers_tabRemoteDataSource,
  }) : _remoteDataSource = providers_tabRemoteDataSource;

}
