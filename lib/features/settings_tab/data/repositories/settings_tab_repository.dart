import 'package:masaj/features/settings_tab/data/datasources/settings_tab_remote_data_source.dart';

abstract class SettingsTabRepository {

}

class SettingsTabRepositoryImpl implements SettingsTabRepository {
  final SettingsTabRemoteDataSource _remoteDataSource;

  SettingsTabRepositoryImpl({
    required SettingsTabRemoteDataSource settings_tabRemoteDataSource,
  }) : _remoteDataSource = settings_tabRemoteDataSource;

}
