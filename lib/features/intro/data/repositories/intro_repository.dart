import 'package:masaj/features/intro/data/models/question_model.dart';

import '../datasources/intro_local_data_source.dart';

abstract class IntroRepository {
  Future<void> setFirstLaunchToFalse();
  Future<void> setLanguageCode(String languageCode);
  Future<void> submitQuiz(Questions questions);
  Future<void> skipQuiz();
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
  Future<void> submitQuiz(Questions questions) async {
    print(
        questions.questions.map((e) => e.selectedAnswer.toNullable()?.content));
    await _guideLocalDataSource.setQuizCompletedToTrue();
  }

  @override
  Future<void> skipQuiz() {
    return _guideLocalDataSource.setQuizCompletedToTrue();
  }
}
