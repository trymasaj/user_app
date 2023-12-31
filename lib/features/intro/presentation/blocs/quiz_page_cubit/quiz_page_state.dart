part of 'quiz_page_cubit.dart';

enum QuizSubmitResult { initial, skip, success, failed }

@immutable
class QuizPageState {
  final Questions questions;
  final int questionIndex;
  final QuizSubmitResult result;
  Question get currentQuestion => questions.questions[questionIndex];
  const QuizPageState({
    required this.questions,
    required this.questionIndex,
    required this.result,
  });
  factory QuizPageState.initial() => QuizPageState(
      result: QuizSubmitResult.initial,
      questions: Questions.getQuestions(),
      questionIndex: 0);
  QuizPageState copyWith(
      {int? questionIndex, Questions? questions, QuizSubmitResult? result}) {
    return QuizPageState(
      result: result ?? this.result,
      questions: questions ?? this.questions,
      questionIndex: questionIndex ?? this.questionIndex,
    );
  }
}
