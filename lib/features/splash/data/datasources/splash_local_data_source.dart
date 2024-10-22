import 'package:masaj/core/data/clients/cache_manager.dart';

abstract class SplashLocalDataSource {
  Future<bool> isFirstLaunch();

  Future<bool> isLanguageSet();

  Future<bool> isCountrySet();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final CacheManager _cacheService;

  SplashLocalDataSourceImpl(this._cacheService);

  @override
  Future<bool> isFirstLaunch() => _cacheService.getIsFirstLaunch();

  @override
  Future<bool> isLanguageSet() async {
    final languageCode = await _cacheService.getLanguageCode();

    return languageCode != null;
  }

  @override
  Future<bool> isCountrySet() async {
    final countryCode = await _cacheService.getCountryCode();

    return countryCode != null;
  }
}
