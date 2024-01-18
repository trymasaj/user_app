
import 'package:masaj/features/intro/data/datasources/intro_local_data_source.dart';

abstract class IntroRepository {
  Future<void> setFirstLaunchToFalse();
  Future<void> setLanguageCode(String languageCode);
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

}
