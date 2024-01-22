import 'package:masaj/features/quiz/domain/entities/question.dart';

abstract class QuizRepo {
  Future<void> submitQuiz(String userId,Questions questions);

  Future<void> skipQuiz();
}
