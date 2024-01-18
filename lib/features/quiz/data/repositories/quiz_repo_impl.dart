import 'package:injectable/injectable.dart';
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/features/quiz/domain/entities/question.dart';
import 'package:masaj/features/quiz/domain/repositories/quiz_repo.dart';

@LazySingleton(as: QuizRepo)
class QuizRepoImpl implements QuizRepo {
  final NetworkService _networkService;
  final CacheService _cacheService;

  QuizRepoImpl(this._networkService, this._cacheService);

  @override
  Future<void> submitQuiz(Questions questions) async {
/*
    final result = await _networkService.post(ApiEndPoint.SUBMIT_QUIZ,
        data: {'userId': '0', ...questions.toMap()});
*/
    await markQuizAsCompleted();
  }

  Future<bool> markQuizAsCompleted() {
    return _cacheService.setIsQuizCompleted(true);
  }

  @override
  Future<void> skipQuiz() {
    return markQuizAsCompleted();
  }
}
