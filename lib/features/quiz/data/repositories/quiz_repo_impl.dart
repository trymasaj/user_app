
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/features/quiz/domain/entities/question.dart';
import 'package:masaj/features/quiz/domain/repositories/quiz_repo.dart';


class QuizRepoImpl implements QuizRepo {
  final NetworkService _networkService;
  final CacheService _cacheService;

  QuizRepoImpl(this._networkService, this._cacheService);

  @override
  Future<void> submitQuiz(
    String userId,
    Questions questions,
  ) async {
    final result = await _networkService.post(ApiEndPoint.SUBMIT_QUIZ,
        data: {'userId': userId, ...questions.toMap()});
    print('result.data ${result.data}');
  }

  @override
  Future<void> skipQuiz(String userId) async {
    await _networkService.post(ApiEndPoint.SUBMIT_QUIZ, data: {
      'userId': userId,
      'quizAnswers': [{}],
    });
  }
}
