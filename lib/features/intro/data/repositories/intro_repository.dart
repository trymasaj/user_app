import '../datasources/intro_local_data_source.dart';

abstract class IntroRepository {
  Future<void> setFirstLaunchToFalse();
  Future<void> setLanguageCode(String languageCode);
  Future<void> setQuizCompletedToTrue();
}

class IntroRepositoryImpl implements IntroRepository {
  final IntroLocalDataSource _guideLocalDataSource;
  IntroRepositoryImpl(this._guideLocalDataSource);

  @override
  Future<void> setFirstLaunchToFalse() =>
      _guideLocalDataSource.setFirstLaunchToFalse();

  @override
  Future<void> setLanguageCode(String languageCode) =>
      _guideLocalDataSource.setLanguageCode(languageCode);

  @override
  Future<void> setQuizCompletedToTrue() =>
      _guideLocalDataSource.setQuizCompletedToTrue();
}
