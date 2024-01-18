import 'package:masaj/core/data/clients/cache_service.dart';

abstract class SplashLocalDataSource {
  Future<bool> isFirstLaunch();

  Future<bool> isLanguageSet();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final CacheService _cacheService;

  SplashLocalDataSourceImpl(this._cacheService);

  @override
  Future<bool> isFirstLaunch() => _cacheService.getIsFirstLaunch();

  @override
  Future<bool> isLanguageSet() async {
    final languageCode = await _cacheService.getLanguageCode();
    return languageCode != null;
  }
}
