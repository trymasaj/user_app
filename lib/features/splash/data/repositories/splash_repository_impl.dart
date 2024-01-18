import 'package:masaj/features/splash/data/datasources/splash_local_data_source.dart';

abstract class SplashRepository {
  Future<bool> isFirstLaunch();
  Future<bool> isLanguageSet();
}

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource _splashLocalDataSource;

  SplashRepositoryImpl(this._splashLocalDataSource);

  @override
  Future<bool> isFirstLaunch() => _splashLocalDataSource.isFirstLaunch();

  @override
  Future<bool> isLanguageSet() => _splashLocalDataSource.isLanguageSet();
}
