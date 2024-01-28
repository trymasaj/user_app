import 'package:masaj/core/data/clients/cache_service.dart';

abstract class IntroLocalDataSource {
  Future<void> setFirstLaunchToFalse();

  Future<void> setLanguageCode(String languageCode);
}

class IntroLocalDataSourceImpl implements IntroLocalDataSource {
  final CacheService _cacheService;

  IntroLocalDataSourceImpl(this._cacheService);

  @override
  Future<void> setFirstLaunchToFalse() => _cacheService.setIsFirstLaunch(false);

  @override
  Future<void> setLanguageCode(String languageCode) =>
      _cacheService.setLanguageCode(languageCode);
}
